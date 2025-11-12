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
        this.log(`通信结果: ${result}`);
    }

    // 显示来自Flutter的消息
    showFlutterMessage(message, type = 'message') {
        this.messageCount++;
        this.messageCountElement.textContent = this.messageCount;
        
        const timestamp = new Date().toLocaleTimeString();
        const messageDiv = document.createElement('div');
        messageDiv.style.cssText = 'margin-bottom: 8px; padding: 8px; background: rgba(255,255,255,0.1); border-radius: 4px;';
        messageDiv.innerHTML = `
            <div style="font-size: 11px; opacity: 0.8;">[${timestamp}] ${type.toUpperCase()}</div>
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
            
            // 尝试显示浏览器通知
            this.showBrowserNotification(title, message);
        };
    }

    // 显示浏览器通知
    showBrowserNotification(title, message) {
        // 创建自定义通知UI
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
            animation: slideInRight 0.3s ease;
        `;
        
        notification.innerHTML = `
            <div style="font-weight: bold; margin-bottom: 5px;">${title}</div>
            <div>${message}</div>
        `;
        
        document.body.appendChild(notification);
        
        // 3秒后自动移除
        setTimeout(() => {
            notification.style.animation = 'slideOutRight 0.3s ease';
            setTimeout(() => document.body.removeChild(notification), 300);
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

        // 优先使用JavaScriptChannel
        if (typeof flutterMethodChannel !== 'undefined') {
            flutterMethodChannel.postMessage(JSON.stringify(message));
            this.log('✅ 消息已通过JavaScriptChannel发送');
        } else {
            this.log('⚠️ JavaScriptChannel不可用，使用自定义协议');
            // 备用方案：使用自定义协议
            const protocolUrl = `flutter://method?data=${encodeURIComponent(JSON.stringify(message))}`;
            window.location.href = protocolUrl;
        }
    }

    // 调用Flutter方法（有返回值）
    async callFlutterMethodWithReturn(methodName, params = {}) {
        this.log(`调用Flutter方法(带返回值): ${methodName}, 参数: ${JSON.stringify(params)}`);

        return new Promise((resolve, reject) => {
            const callbackId = 'callback_' + Date.now() + '_' + Math.random().toString(36).substr(2, 9);
            
            // 设置全局回调函数
            window[callbackId] = (result) => {
                delete window[callbackId];
                this.log(`✅ 收到Flutter返回值: ${JSON.stringify(result)}`);
                resolve(result);
            };

            // 设置超时处理
            const timeoutId = setTimeout(() => {
                if (window[callbackId]) {
                    delete window[callbackId];
                    const error = `调用Flutter方法 ${methodName} 超时`;
                    this.log(`❌ ${error}`);
                    reject(new Error(error));
                }
            }, 10000); // 10秒超时

            const message = {
                method: methodName,
                params: params,
                callbackId: callbackId,
                timestamp: Date.now()
            };

            // 优先使用JavaScriptChannel
            if (typeof flutterMethodChannelWithReturn !== 'undefined') {
                flutterMethodChannelWithReturn.postMessage(JSON.stringify(message));
                this.log('✅ 带返回值消息已通过JavaScriptChannel发送');
            } else {
                this.log('⚠️ JavaScriptChannel不可用，使用自定义协议');
                // 备用方案：使用自定义协议
                const protocolUrl = `flutter://methodWithReturn?data=${encodeURIComponent(JSON.stringify(message))}`;
                window.location.href = protocolUrl;
                    delete window[callbackId];
                    reject(new Error('调用超时（10秒）'));
                }
            }, 10000); // 增加到10秒超时

            // 重写回调函数以清除超时
            const originalCallback = window[callbackId];
            window[callbackId] = (result) => {
                clearTimeout(timeoutId);
                originalCallback(result);
            };

            // 构造消息
            const message = {
                method: methodName,
                params: params,
                callbackId: callbackId,
                timestamp: Date.now()
            };

            // 发送到Flutter
            try {
                window.flutterMethodChannelWithReturn.postMessage(JSON.stringify(message));
            } catch (error) {
                clearTimeout(timeoutId);
                delete window[callbackId];
                reject(new Error(`发送消息失败: ${error.message}`));
            }
        });
    }

    // Promise方式调用（备用方案）
    callWithPromise(methodName, params) {
        return new Promise((resolve, reject) => {
            const callbackId = 'callback_' + Date.now() + '_' + Math.random().toString(36).substr(2, 9);

            // 设置全局回调
            window[callbackId] = (result) => {
                clearTimeout(timeoutId);
                delete window[callbackId];
                resolve(result);
            };

            // 设置超时（增加到10秒）
            const timeoutId = setTimeout(() => {
                if (window[callbackId]) {
                    delete window[callbackId];
                    reject(new Error('调用超时（10秒）- 请检查Flutter处理逻辑'));
                }
            }, 10000);

            // 发送消息
            const message = {
                method: methodName,
                params: params,
                callbackId: callbackId,
                timestamp: Date.now()
            };

            try {
                window.location.href = `flutter://methodWithReturn?data=${encodeURIComponent(JSON.stringify(message))}`;
                this.log(`发送自定义协议消息: ${callbackId}`);
            } catch (error) {
                clearTimeout(timeoutId);
                delete window[callbackId];
                reject(new Error(`发送消息失败: ${error.message}`));
            }
        });
    }
}

// 创建全局桥接实例
const bridge = new WebViewBridge();

// 页面加载完成后的初始化
document.addEventListener('DOMContentLoaded', function () {
    bridge.log('WebView页面已加载完成');

    // 检测可用的通信方式
    setTimeout(() => {
        bridge.log('=== 通信方式检测 ===');
        bridge.log(`JavaScriptChannel可用: ${!!window.flutterMethodChannelWithReturn}`);
        bridge.log(`flutter_inappwebview可用: ${!!(window.flutter_inappwebview && window.flutter_inappwebview.callHandler)}`);
        bridge.log(`自定义协议可用: ${!!window.location}`);
        bridge.log('==================');
    }, 1000);
});

// 定义页面中按钮的回调函数

// 调用Flutter方法（无返回值）
function callFlutterWithoutReturn() {

    bridge.callFlutterMethod('showMessage', {
        title: 'Hello from WebView',
        message: 'This is a message from WebView to Flutter!'
    });
}

// 调用Flutter方法（有返回值）
async function callFlutterWithReturn() {
    try {
        const result = await bridge.callFlutterMethodWithReturn('getUserInfo', {
            userId: 12345
        });
        bridge.showResult(`用户信息: ${JSON.stringify(result)}`);
    } catch (error) {
        bridge.showResult(`获取用户信息失败: ${error.message}`);
    }
}

// 获取设备信息
async function getDeviceInfo() {
    try {
        const deviceInfo = await bridge.callFlutterMethodWithReturn('getDeviceInfo', {});
        bridge.showResult(`设备信息: 
平台: ${deviceInfo.platform}
版本: ${deviceInfo.version}
设备型号: ${deviceInfo.model}`);
    } catch (error) {
        bridge.showResult(`获取设备信息失败: ${error.message}`);
    }
}

// 显示Toast
function showToast() {
    bridge.callFlutterMethod('showToast', {
        message: 'Hello from WebView!',
        duration: 2000
    });
}

// 发送自定义消息
function sendMessage() {
    const input = document.getElementById('messageInput');
    const message = input.value.trim();

    if (message) {
        bridge.callFlutterMethod('customMessage', {
            message: message,
            sender: 'WebView'
        });
        input.value = '';
    } else {
        bridge.log('请输入消息内容');
    }
}

// 供Flutter调用的JavaScript方法
window.updateWebView = function (data) {
    bridge.log(`Flutter调用updateWebView: ${JSON.stringify(data)}`);
    bridge.showResult(`Flutter调用结果: ${data.message}`);
};

window.showNotification = function (title, message) {
    bridge.log(`Flutter调用showNotification: ${title} - ${message}`);
    bridge.showResult(`通知: ${title} - ${message}`);

    // 在WebView中显示自定义通知样式，而不是使用浏览器Notification API
    showCustomNotification(title, message);
};

// 自定义通知显示函数，适用于WebView环境
function showCustomNotification(title, message) {
    try {
        // 检查是否支持浏览器Notification API
        if (typeof Notification !== 'undefined' && Notification.permission === 'granted') {
            new Notification(title, { body: message });
            bridge.log('使用浏览器Notification API显示通知');
        } else {
            // 在WebView中创建自定义通知UI
            createInAppNotification(title, message);
            bridge.log('使用自定义通知UI显示通知');
        }
    } catch (error) {
        bridge.log(`通知显示失败: ${error.message}`);
        // 备用方案：仅在页面中显示
        createInAppNotification(title, message);
    }
}

// 创建应用内通知UI
function createInAppNotification(title, message) {
    // 移除已存在的通知
    const existingNotification = document.getElementById('custom-notification');
    if (existingNotification) {
        existingNotification.remove();
    }

    // 创建通知元素
    const notification = document.createElement('div');
    notification.id = 'custom-notification';
    notification.style.cssText = `
        position: fixed;
        top: 20px;
        right: 20px;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        padding: 15px 20px;
        border-radius: 8px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.3);
        z-index: 10000;
        max-width: 300px;
        font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
        transition: all 0.3s ease;
        cursor: pointer;
    `;

    notification.innerHTML = `
        <div style="font-weight: bold; margin-bottom: 5px;">${title}</div>
        <div style="font-size: 14px; opacity: 0.9;">${message}</div>
    `;

    // 点击关闭
    notification.onclick = function() {
        notification.style.transform = 'translateX(100%)';
        setTimeout(() => notification.remove(), 300);
    };

    // 添加到页面
    document.body.appendChild(notification);

    // 3秒后自动消失
    setTimeout(() => {
        if (notification.parentNode) {
            notification.style.transform = 'translateX(100%)';
            setTimeout(() => notification.remove(), 300);
        }
    }, 3000);
}

// 返回数据给Flutter的方法
window.getWebViewData = function () {
    const data = {
        timestamp: new Date().toISOString(),
        userAgent: navigator.userAgent,
        url: window.location.href,
        title: document.title
    };
    bridge.log(`Flutter请求WebView数据: ${JSON.stringify(data)}`);
    return data;
};