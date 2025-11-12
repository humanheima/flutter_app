import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///
/// Created by dumingwei on 2025/11/12
/// Desc: 登录页面
///
///
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  bool _isAgreed = false;
  bool _canGetCode = true;
  int _countdown = 60;
  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();
    // 初始化晃动动画控制器
    _shakeController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    // 定义晃动动画，从-10到10像素的左右移动
    _shakeAnimation = Tween<double>(
      begin: -10.0,
      end: 10.0,
    ).animate(CurvedAnimation(
      parent: _shakeController,
      curve: Curves.elasticIn,
    ));
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _codeController.dispose();
    _shakeController.dispose();
    super.dispose();
  }

  // 获取验证码
  void _getVerificationCode() {
    if (_phoneController.text.isNotEmpty && _canGetCode) {
      setState(() {
        _canGetCode = false;
      });

      // 开始倒计时
      _startCountdown();

      // 这里应该调用实际的获取验证码API
      print('获取验证码: ${_phoneController.text}');
    }
  }

  // 开始倒计时
  void _startCountdown() {
    setState(() {
      _countdown = 60;
    });

    Future.doWhile(() async {
      await Future.delayed(Duration(seconds: 1));
      if (mounted) {
        setState(() {
          _countdown--;
        });

        if (_countdown <= 0) {
          setState(() {
            _canGetCode = true;
          });
          return false;
        }
        return true;
      }
      return false;
    });
  }

  // 立即登录
  void _login() {
    if (_phoneController.text.isNotEmpty && _codeController.text.isNotEmpty) {
      if (!_isAgreed) {
        // 如果没有勾选协议，触发晃动动画
        _triggerShakeAnimation();
        return;
      }

      // 这里应该调用实际的登录API
      print('登录: 手机号=${_phoneController.text}, 验证码=${_codeController.text}');

      // 显示登录成功提示
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('登录成功'),
          backgroundColor: Color(0xFF976FF5),
        ),
      );
    }
  }

  // 触发晃动动画
  void _triggerShakeAnimation() {
    _shakeController.forward().then((_) {
      _shakeController.reverse();
    });
  }

  // 检查登录按钮是否可用
  bool get _canLogin {
    return _phoneController.text.isNotEmpty && _codeController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF040304),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // 主要输入区域
                      Column(
                        children: [
                          // 手机号输入框
                          Container(
                            height: 48,
                            width: 280,
                            decoration: BoxDecoration(
                              color: Color(0xFF201F20),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Row(
                              children: [
                                // +86 区号
                                Container(
                                  width: 58,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '+86',
                                        style: TextStyle(
                                          color: Color(0xFFF6F5FA),
                                          fontSize: 14,
                                          fontFamily: 'PingFang SC',
                                          fontWeight: FontWeight.w400,
                                          height: 1.43,
                                        ),
                                      ),
                                      SizedBox(width: 4),
                                      Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Color(0xFFF6F5FA),
                                        size: 12,
                                      ),
                                    ],
                                  ),
                                ),
                                // 分隔线
                                Container(
                                  width: 1,
                                  height: 15,
                                  color: Color(0x0FF6F5FA),
                                ),
                                // 手机号输入
                                Expanded(
                                  child: TextField(
                                    controller: _phoneController,
                                    keyboardType: TextInputType.phone,
                                    style: TextStyle(
                                      color: Color(0xFFF6F5FA),
                                      fontSize: 14,
                                      fontFamily: 'PingFang SC',
                                    ),
                                    decoration: InputDecoration(
                                      hintText: '请输入手机号',
                                      hintStyle: TextStyle(
                                        color: Color(0xFF67656B),
                                        fontSize: 14,
                                        fontFamily: 'PingFang SC',
                                      ),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 14,
                                      ),
                                    ),
                                    onChanged: (value) {
                                      setState(() {});
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 16),

                          // 验证码输入框
                          Container(
                            height: 48,
                            width: 280,
                            decoration: BoxDecoration(
                              color: Color(0xFF201F20),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Row(
                              children: [
                                // 验证码输入
                                Expanded(
                                  child: TextField(
                                    controller: _codeController,
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(
                                      color: Color(0xFFF6F5FA),
                                      fontSize: 14,
                                      fontFamily: 'PingFang SC',
                                    ),
                                    decoration: InputDecoration(
                                      hintText: '请输入短信验证码',
                                      hintStyle: TextStyle(
                                        color: Color(0xFF67656B),
                                        fontSize: 14,
                                        fontFamily: 'PingFang SC',
                                      ),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 14,
                                      ),
                                    ),
                                    onChanged: (value) {
                                      setState(() {});
                                    },
                                  ),
                                ),
                                // 分隔线
                                Container(
                                  width: 1,
                                  height: 15,
                                  color: Color(0x0FF6F5FA),
                                ),
                                // 获取验证码按钮
                                GestureDetector(
                                  onTap:
                                      _canGetCode ? _getVerificationCode : null,
                                  child: Container(
                                    width: 83,
                                    height: 48,
                                    child: Center(
                                      child: Text(
                                        _canGetCode
                                            ? '获取验证码'
                                            : '${_countdown}s',
                                        style: TextStyle(
                                          color: _canGetCode
                                              ? Color(0xFF976FF5)
                                              : Color(0xFF67656B),
                                          fontSize: 14,
                                          fontFamily: 'PingFang SC',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 24),

                      // 登录按钮
                      GestureDetector(
                        onTap: _canLogin ? _login : null,
                        child: Container(
                          width: 280,
                          height: 48,
                          decoration: BoxDecoration(
                            color: _canLogin
                                ? Color(0xFF976FF5)
                                : Color(0xFF171617),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Center(
                            child: Text(
                              '立即登录',
                              style: TextStyle(
                                color: _canLogin
                                    ? Colors.white
                                    : Color(0xFF4A484D),
                                fontSize: 14,
                                fontFamily: 'PingFang SC',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // 底部协议条款
            AnimatedBuilder(
              animation: _shakeAnimation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(_shakeAnimation.value, 0),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 复选框
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isAgreed = !_isAgreed;
                            });
                          },
                          child: Container(
                            width: 14,
                            height: 14,
                            margin: EdgeInsets.only(top: 3),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Color(0xFF67656B),
                                width: 1,
                              ),
                              color: _isAgreed
                                  ? Color(0xFF976FF5)
                                  : Colors.transparent,
                            ),
                            child: _isAgreed
                                ? Icon(
                                    Icons.check,
                                    size: 10,
                                    color: Colors.white,
                                  )
                                : null,
                          ),
                        ),

                        SizedBox(width: 8),

                        // 协议文本
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                color: Color(0xFF67656B),
                                fontSize: 10,
                                fontFamily: 'PingFang SC',
                                height: 1.5,
                              ),
                              children: [
                                TextSpan(text: '我已经阅读并同意 '),
                                TextSpan(
                                  text: 'XXXX协议',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                TextSpan(text: ' '),
                                TextSpan(
                                  text: 'XXXX协议',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                TextSpan(text: ' '),
                                TextSpan(
                                  text: 'XXXX协议',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                TextSpan(text: '，未注册手机号登录后将自动创建戏格账号'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
