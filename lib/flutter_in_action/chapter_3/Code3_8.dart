import 'package:flutter/material.dart';

///
/// Created by dumingwei on 2019-10-07.
/// Desc:3.8 进度指示器
///
class ProgressWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('3.8 进度指示器'),
      ),
      body: new Container(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16.0),
              child: LinearProgressIndicator(
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation(Colors.blue),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: LinearProgressIndicator(
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation(Colors.blue),
                value: 0.5,
              ),
            ),
            SizedBox(
              height: 3,
              child: LinearProgressIndicator(
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation(Colors.cyan),
                value: 0.8,
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 50.0)),
            UnconstrainedBox(
              child: SizedBox(
                  width: 50.0,
                  height: 50.0,
                  child: CircularProgressIndicator(
                    strokeWidth: 4.0,
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation(Colors.brown),
                  )),
            ),
            Padding(padding: EdgeInsets.only(top: 50.0)),
            UnconstrainedBox(
              child: SizedBox(
                width: 40.0,
                height: 40.0,
                child: CircularProgressIndicator(
                  strokeWidth: 8.0,
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation(Colors.blue),
                  value: 0.5,
                ),
              ),
            ),
            AnimateProgressWidget(),
          ],
        ),
      ),
    );
  }
}

class AnimateProgressWidget extends StatefulWidget {
  @override
  _AnimateProgressWidgetState createState() {
    return _AnimateProgressWidgetState();
  }
}

class _AnimateProgressWidgetState extends State<AnimateProgressWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    _animationController =
        new AnimationController(vsync: this, duration: Duration(seconds: 3));
    _animationController.forward();
    _animationController.addListener(() {
      setState(() {
        // do nothing
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(16),
            child: LinearProgressIndicator(
              backgroundColor: Colors.grey[200],
              valueColor: ColorTween(begin: Colors.grey, end: Colors.blue)
                  .animate(_animationController),
              value: _animationController.value,
            ),
          ),
        ],
      ),
    );
  }
}
