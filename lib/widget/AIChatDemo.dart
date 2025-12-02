import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class AIChatDemo extends StatefulWidget {
  @override
  _AIChatDemoState createState() => _AIChatDemoState();
}

class _AIChatDemoState extends State<AIChatDemo> with TickerProviderStateMixin {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];

  // 打字机效果相关
  Timer? _typingTimer;
  String _currentTypingText = '';
  int _currentTypingIndex = 0;

  // AI回复预设
  final List<String> _aiResponses = [
    "你好！我是AI助手，很高兴与你聊天。有什么可以帮助你的吗？",
    "这是一个很有趣的问题！让我想想...",
    "根据我的理解，我认为这个问题可以从多个角度来看。首先，我们需要考虑...",
    "感谢你的提问！这让我想到了一个相关的概念。在人工智能领域，我们经常讨论这类问题...",
    "我很乐意帮助你解答这个问题。基于我的知识库，我可以为你提供以下信息...",
    "这确实是一个复杂的话题。让我为你详细分析一下各个方面的考虑因素...",
    "非常好的观点！我完全同意你的看法。这种思维方式在解决问题时确实很有效...",
    "让我换个角度来回答你的问题。从技术实现的角度来看，我们可以这样考虑...",
  ];

  @override
  void initState() {
    super.initState();
    // 添加欢迎消息
    _addWelcomeMessage();
  }

  @override
  void dispose() {
    _typingTimer?.cancel();
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _addWelcomeMessage() {
    setState(() {
      _messages.add(ChatMessage(
        text: "👋 欢迎使用AI聊天助手！",
        isUser: false,
        timestamp: DateTime.now(),
      ));
    });

    // 延迟一点后开始打字机效果显示欢迎词
    Timer(Duration(milliseconds: 500), () {
      _startTypingEffect(_aiResponses[0]);
    });
  }

  void _handleSubmitted(String text) {
    if (text.trim().isEmpty) return;

    _textController.clear();

    // 添加用户消息
    setState(() {
      _messages.add(ChatMessage(
        text: text,
        isUser: true,
        timestamp: DateTime.now(),
      ));
    });

    _scrollToBottom();

    // 模拟AI思考延迟后回复
    Timer(Duration(milliseconds: 800 + Random().nextInt(1000)), () {
      _generateAIResponse();
    });
  }

  void _generateAIResponse() {
    // 随机选择一个AI回复
    String response = _aiResponses[Random().nextInt(_aiResponses.length)];

    // 添加空的AI消息，准备开始打字机效果
    setState(() {
      _messages.add(ChatMessage(
        text: "",
        isUser: false,
        timestamp: DateTime.now(),
        isTyping: true,
      ));
    });

    _scrollToBottom();
    _startTypingEffect(response);
  }

  void _startTypingEffect(String fullText) {
    _currentTypingText = fullText;
    _currentTypingIndex = 0;

    // 取消之前的计时器
    _typingTimer?.cancel();

    // 开始打字机效果
    _typingTimer = Timer.periodic(Duration(milliseconds: 30), (timer) {
      if (_currentTypingIndex < _currentTypingText.length) {
        setState(() {
          // 更新最后一条AI消息的文本
          if (_messages.isNotEmpty && !_messages.last.isUser) {
            _messages.last.text =
                _currentTypingText.substring(0, _currentTypingIndex + 1);
          }
        });
        _currentTypingIndex++;
        _scrollToBottom();
      } else {
        // 打字完成
        timer.cancel();
        setState(() {
          if (_messages.isNotEmpty && !_messages.last.isUser) {
            _messages.last.isTyping = false;
          }
        });
      }
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Widget _buildMessage(ChatMessage message) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Row(
        mainAxisAlignment:
            message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!message.isUser) ...[
            CircleAvatar(
              backgroundColor: Colors.blue[100],
              radius: 16,
              child: Icon(Icons.smart_toy, size: 18, color: Colors.blue[700]),
            ),
            SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: message.isUser ? Colors.blue[500] : Colors.grey[200],
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.text,
                    style: TextStyle(
                      color: message.isUser ? Colors.white : Colors.black87,
                      fontSize: 16,
                    ),
                  ),
                  if (message.isTyping)
                    Container(
                      margin: EdgeInsets.only(top: 4),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 4,
                            height: 16,
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 500),
                              decoration: BoxDecoration(
                                color: Colors.grey[600],
                                borderRadius: BorderRadius.circular(1),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
          if (message.isUser) ...[
            SizedBox(width: 8),
            CircleAvatar(
              backgroundColor: Colors.green[100],
              radius: 16,
              child: Icon(Icons.person, size: 18, color: Colors.green[700]),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey[300]!)),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: '输入消息...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              textInputAction: TextInputAction.send,
              onSubmitted: _handleSubmitted,
            ),
          ),
          SizedBox(width: 8),
          FloatingActionButton(
            mini: true,
            onPressed: () => _handleSubmitted(_textController.text),
            child: Icon(Icons.send),
            backgroundColor: Colors.blue,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.chat_bubble_outline),
            SizedBox(width: 8),
            Text('AI聊天助手'),
          ],
        ),
        backgroundColor: Colors.blue[50],
        elevation: 1,
        actions: [
          IconButton(
            icon: Icon(Icons.clear_all),
            onPressed: () {
              setState(() {
                _messages.clear();
              });
              _addWelcomeMessage();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.grey[50],
              child: ListView.builder(
                controller: _scrollController,
                padding: EdgeInsets.symmetric(vertical: 8),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return _buildMessage(_messages[index]);
                },
              ),
            ),
          ),
          _buildInputArea(),
        ],
      ),
    );
  }
}

class ChatMessage {
  String text;
  final bool isUser;
  final DateTime timestamp;
  bool isTyping;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
    this.isTyping = false,
  });
}
