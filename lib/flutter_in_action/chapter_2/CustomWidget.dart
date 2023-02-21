import 'package:flutter/cupertino.dart';

///
/// Created by 杜明伟 on 2023/2/20.
/// 测试通过RenderObject定义组件的方式：
///

class CustomWidget extends LeafRenderObjectWidget{


  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderCustomObject();
  }

  @override
  void updateRenderObject(BuildContext context, covariant RenderObject renderObject) {
    // 更新 RenderObject
    super.updateRenderObject(context, renderObject);
  }

}

class RenderCustomObject extends RenderBox{

  @override
  void performLayout() {
    super.performLayout();
    // 实现布局逻辑
  }

}
