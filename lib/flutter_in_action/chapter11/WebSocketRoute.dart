import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

///
/// Created by dumingwei on 2019/3/31.
/// Desc:使用WebSockets
///
class WebSocketRoute extends StatefulWidget {
  @override
  _WebSocketRouteState createState() => new _WebSocketRouteState();
}

class _WebSocketRouteState extends State<WebSocketRoute> {
  TextEditingController _controller = new TextEditingController();
  late IOWebSocketChannel channel;
  String _text = "";

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("WebSocket(内容回显)"),
      ),
      body: new Padding(
        padding: const EdgeInsets.all(20.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Form(
                child: new TextFormField(
              controller: _controller,
              decoration: new InputDecoration(labelText: 'Send a message'),
            )),
            new StreamBuilder(
                stream: channel.stream,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    _text = "网络不通";
                  } else if (snapshot.hasData) {
                    _text = "echo：" + snapshot.data.toString();
                  }
                  return new Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24.0),
                    child: new Text(_text),
                  );
                }),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _sendMessage,
        tooltip: 'Send message',
        child: new Icon(Icons.send),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    //创建websocket连接
    channel = new IOWebSocketChannel.connect('ws://echo.websocket.org');
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      channel.sink.add(_controller.text);
    }
  }

  @override
  void dispose() {
    channel.sink.close();
    _controller.dispose();
    super.dispose();
  }
}
