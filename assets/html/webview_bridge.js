// WebView与Flutter双向通信的JavaScript桥接文件

class WebViewBridge {
    constructor() {
        this.logElement = document.getElementById('log');
        this.resultElement = document.getElementById('result');
        this.flutterMessagesElement = document.getElementById('flutterMessages');
        this.messageCountElement = document.getElementById('messageCount');
        this.counterElement = document.getElementById('counterDisplay');
        this.themeElement = document.getElementById('themeDisplay');
        
        this.messageCount = 0;
        this.webViewCounter = 0;
        this.currentTheme = 'light';
        
        this.setupFlutterInterface();
        this.log('🚀 WebView桥接初始化完成');
    }

    // 记录日志
    log(message) {
        const timestamp = new Date().toLocaleTimeString();
        const logDiv = document.createElement('div');
        logDiv.textContent = `[${timestamp}] ${message}`;
        this.logElement.appendChild(logDiv);
        this.logElement.scrollTop = this.logElement.scrollHeight;
        console.log(message);
    }

    // 显示通信结果
    showResult(result) {
        if (typeof result === 'object') {
            result = JSON.stringify(result, null, 2);
        }
        this.resultElement.innerHTML = `<pre style="margin:0; white-space: pre-wrap;">${result}</pre>`;
    }

    // 显示来自Flutter的消息
    showFlutterMessage(message, type = 'MESSAGE') {
        this.messageCount++;
        this.messageCountElement.textContent = this.messageCount;
        
        const timestamp = new Date().toLocaleTimeString();
        const messageDiv = document.createElement('div');
        messageDiv.style.cssText = 'margin-bottom: 8px; padding: 8px; background: rgba(255,255,255,0.1); border-radius: 4px;';
        messageDiv.innerHTML = `
            <div style="font-size: 11px; opacity: 0.8;">[${timestamp}] ${type}</div>
            <div style="font-weight: bold;">${message}</div>
        `;
        
        this.flutterMessagesElement.appendChild(messageDiv);
        this.flutterMessagesElement.scrollTop = this.flutterMessagesElement.scrollHeight;
        
        // 保持最多显示最近5条消息
        while (this.flutterMessagesElement.children.length > 6) {
            this.flutterMessagesElement.removeChild(this.flutterMessagesElement.firstChild);
        }
    }

    // 更新WebView状态显示
    updateStatus(counter, theme) {
        if (counter !== undefined) {
            this.webViewCounter = counter;
            this.counterElement.textContent = `Counter: ${counter}`;
        }
        if (theme !== undefined) {
            this.currentTheme = theme;
            this.themeElement.textContent = `Theme: ${theme}`;
            document.body.className = theme === 'dark' ? 'dark' : '';
        }
    }

    // 设置Flutter接口方法（供Flutter调用）
    setupFlutterInterface() {
        // Flutter调用的WebView方法
        window.updateCounter = (data) => {
            this.log(`Flutter调用: updateCounter, value: ${data.value}`);
            this.updateStatus(data.value, undefined);
            this.showFlutterMessage(`计数器更新为: ${data.value}`, 'COUNTER');
        };

        window.changeTheme = (data) => {
            this.log(`Flutter调用: changeTheme, theme: ${data.theme}`);
            this.updateStatus(undefined, data.theme);
            this.showFlutterMessage(`主题切换为: ${data.theme}`, 'THEME');
        };

        window.showFlutterMessage = (data) => {
            this.log(`Flutter调用: showFlutterMessage, message: ${data.message}`);
            this.showFlutterMessage(data.message, 'MESSAGE');
        };

        window.showNotification = (title, message) => {
            this.log(`Flutter调用: showNotification, title: ${title}, message: ${message}`);
            this.showFlutterMessage(`${title}: ${message}`, 'NOTIFICATION');
            this.showBrowserNotification(title, message);
        };
    }

    // 显示浏览器通知
    showBrowserNotification(title, message) {
        const notification = document.createElement('div');
        notification.style.cssText = `
            position: fixed;
            top: 20px;
            right: 20px;
            background: rgba(33, 150, 243, 0.9);
            color: white;
            padding: 15px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.3);
            z-index: 1000;
            max-width: 300px;
            transform: translateX(100%);
            transition: transform 0.3s ease;
        `;
        
        notification.innerHTML = `
            <div style="font-weight: bold; margin-bottom: 5px;">${title}</div>
            <div>${message}</div>
        `;
        
        document.body.appendChild(notification);
        
        // 动画显示
        setTimeout(() => notification.style.transform = 'translateX(0)', 10);
        
        // 3秒后移除
        setTimeout(() => {
            notification.style.transform = 'translateX(100%)';
            setTimeout(() => {
                if (document.body.contains(notification)) {
                    document.body.removeChild(notification);
                }
            }, 300);
        }, 3000);
    }

    // 调用Flutter方法（无返回值）
    callFlutterMethod(methodName, params = {}) {
        const message = {
            method: methodName,
            params: params,
            timestamp: Date.now()
        };

        this.log(`调用Flutter方法: ${methodName}, 参数: ${JSON.stringify(params)}`);

        try {
            if (typeof flutterMethodChannel !== 'undefined') {
                flutterMethodChannel.postMessage(JSON.stringify(message));
                this.log('✅ 消息已通过JavaScriptChannel发送');
            } else {
                this.log('⚠️ JavaScriptChannel不可用，使用自定义协议');
                const protocolUrl = `flutter://method?data=${encodeURIComponent(JSON.stringify(message))}`;
                window.location.href = protocolUrl;
            }
        } catch (error) {
            this.log(`❌ 发送消息失败: ${error.message}`);
            this.showResult(`发送失败: ${error.message}`);
        }
    }

    // 调用Flutter方法（有返回值）
    async callFlutterMethodWithReturn(methodName, params = {}) {
        this.log(`调用Flutter方法(带返回值): ${methodName}, 参数: ${JSON.stringify(params)}`);

        return new Promise((resolve, reject) => {
            const callbackId = 'callback_' + Date.now() + '_' + Math.random().toString(36).substr(2, 9);
            
            // 设置全局回调函数
            window[callbackId] = (result) => {
                clearTimeout(timeoutId);
                delete window[callbackId];
                this.log(`✅ 收到Flutter返回值: ${JSON.stringify(result)}`);
                resolve(result);
            };

            // 设置超时处理
            const timeoutId = setTimeout(() => {
                if (window[callbackId]) {
                    delete window[callbackId];
                    const error = `调用Flutter方法 ${methodName} 超时(10秒)`;
                    this.log(`❌ ${error}`);
                    reject(new Error(error));
                }
            }, 10000);

            const message = {
                method: methodName,
                params: params,
                callbackId: callbackId,
                timestamp: Date.now()
            };

            try {
                if (typeof flutterMethodChannelWithReturn !== 'undefined') {
                    flutterMethodChannelWithReturn.postMessage(JSON.stringify(message));
                    this.log('✅ 带返回值消息已通过JavaScriptChannel发送');
                } else {
                    this.log('⚠️ JavaScriptChannel不可用，使用自定义协议');
                    const protocolUrl = `flutter://methodWithReturn?data=${encodeURIComponent(JSON.stringify(message))}`;
                    window.location.href = protocolUrl;
                }
            } catch (error) {
                clearTimeout(timeoutId);
                delete window[callbackId];
                const errorMsg = `发送消息失败: ${error.message}`;
                this.log(`❌ ${errorMsg}`);
                reject(new Error(errorMsg));
            }
        });
    }

    // 发送WebView状态给Flutter
    sendStatusToFlutter() {
        this.callFlutterMethod('customMessage', {
            message: `WebView状态报告`,
            sender: 'WebView',
            status: `Counter: ${this.webViewCounter}, Theme: ${this.currentTheme}, Messages: ${this.messageCount}`,
            webViewInfo: {
                counter: this.webViewCounter,
                theme: this.currentTheme,
                messageCount: this.messageCount,
                timestamp: Date.now()
            }
        });
    }
}

// 初始化桥接
let bridge;
document.addEventListener('DOMContentLoaded', () => {
    bridge = new WebViewBridge();
    window.bridge = bridge;
    console.log('双向通信演示WebView已初始化');
});

// 页面加载完成后的全局函数
window.addEventListener('load', () => {
    if (bridge) {
        bridge.log('页面加载完成，双向通信就绪');
    }
});

// ======= 全局函数 - 供HTML按钮调用 =======

function callFlutterWithoutReturn() {
    bridge.log('测试基础调用（无返回值）');
    bridge.callFlutterMethod('showToast', {
        message: '来自WebView的测试消息',
        duration: 2000
    });
    bridge.showResult('基础调用测试完成');
}

function callFlutterWithReturn() {
    bridge.log('测试带返回值调用');
    bridge.callFlutterMethodWithReturn('getUserInfo', { userId: 123 })
        .then(result => {
            bridge.showResult(`获取到用户信息: ${JSON.stringify(result, null, 2)}`);
        })
        .catch(error => {
            bridge.showResult(`调用失败: ${error.message}`);
        });
}

function getDeviceInfo() {
    bridge.log('获取设备信息');
    bridge.callFlutterMethodWithReturn('getDeviceInfo', {})
        .then(result => {
            bridge.showResult(`设备信息: ${JSON.stringify(result, null, 2)}`);
        })
        .catch(error => {
            bridge.showResult(`获取设备信息失败: ${error.message}`);
        });
}

function showToast() {
    bridge.log('显示Toast消息');
    bridge.callFlutterMethod('showToast', {
        message: `WebView Toast消息 ${new Date().getSeconds()}秒`,
        duration: 3000
    });
    bridge.showResult('Toast消息已发送');
}

function sendMessage() {
    const input = document.getElementById('messageInput');
    const message = input.value.trim();
    
    if (!message) {
        bridge.showResult('请输入消息内容');
        return;
    }
    
    bridge.log(`发送自定义消息: ${message}`);
    bridge.callFlutterMethod('customMessage', {
        message: message,
        sender: 'WebView用户',
        timestamp: new Date().toLocaleString()
    });
    
    input.value = '';
    bridge.showResult(`已发送消息: ${message}`);
}

function sendStatusToFlutter() {
    bridge.log('发送WebView状态给Flutter');
    bridge.sendStatusToFlutter();
    bridge.showResult('状态信息已发送给Flutter');
}

function sendInteractiveMessage() {
    const messages = [
        '这是一个互动消息！',
        'WebView向Flutter问好 👋',
        '双向通信测试中...',
        `当前时间: ${new Date().toLocaleTimeString()}`,
        '你好，Flutter！我是WebView！'
    ];
    
    const randomMessage = messages[Math.floor(Math.random() * messages.length)];
    
    bridge.callFlutterMethod('customMessage', {
        message: randomMessage,
        sender: 'WebView',
        type: 'interactive',
        timestamp: Date.now()
    });
    
    bridge.showResult(`已发送互动消息: ${randomMessage}`);
}