import 'package:flutter/material.dart';

class GradientButtonRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('10.2 组合现有组件'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10),
              child: GradientButton(
                colors: [Colors.orange, Colors.red],
                height: 50.0,
                child: Text("Submit"),
                onTap: onTap,
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: GradientButton(
                height: 50.0,
                colors: [Colors.lightGreen, Colors.green[700]],
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: Text("Submit"),
                onTap: onTap,
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: GradientButton(
                height: 50.0,
                colors: [Colors.lightBlue[300], Colors.blueAccent],
                borderRadius: BorderRadius.all(Radius.elliptical(10, 20)),
                child: Text("Submit"),
                onTap: onTap,
              ),
            ),
          ],
        ),
      ),
    );
  }

  onTap() {
    print("button click");
  }
}

class GradientButton extends StatelessWidget {
  final List<Color> colors;

  final double width;
  final double height;

  final Widget child;
  final BorderRadius borderRadius;

  final GestureTapCallback onTap;

  GradientButton({
    this.colors,
    this.width,
    this.height,
    this.borderRadius,
    this.onTap,
    @required this.child,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    //确保colors数组不空
    List<Color> _colors = colors ??
        [theme.primaryColor, theme.primaryColorDark ?? theme.primaryColor];
    return DecoratedBox(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: _colors),
          borderRadius: borderRadius),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          splashColor: _colors.last,
          highlightColor: Colors.transparent,
          onTap: onTap,
          child: ConstrainedBox(
            constraints: BoxConstraints.tightFor(height: height, width: width),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DefaultTextStyle(
                    style: TextStyle(fontWeight: FontWeight.bold),
                    child: child),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
