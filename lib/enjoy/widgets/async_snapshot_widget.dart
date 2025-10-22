import 'package:flutter/material.dart';

///
/// Created by dumingwei on 2019/4/4.
/// Desc:
///

typedef SuccessWidget = Widget Function(AsyncSnapshot<dynamic> snapshot);

class AsyncSnapshotWidget extends StatelessWidget {
  final AsyncSnapshot<dynamic> snapshot;
  final SuccessWidget successWidget;

  const AsyncSnapshotWidget({Key? key, required this.snapshot, required this.successWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _parseSnap();
  }

  Widget _parseSnap() {
    switch (snapshot.connectionState) {
      case ConnectionState.none:
        print("还没有开始网络请求");
        return Center(
          child: Text(('准备加载..')),
        );

      case ConnectionState.active:
        print('active');
        return Center(
          child: CircularProgressIndicator(),
        );
      case ConnectionState.waiting:
        print('waiting');
        return Center(
          child: CircularProgressIndicator(),
        );
      case ConnectionState.done:
        print('done');
        return successWidget(snapshot);
      default:
        return SizedBox.shrink();
    }
  }
}
