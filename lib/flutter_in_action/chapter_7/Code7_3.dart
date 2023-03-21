import 'dart:collection';

import 'package:flutter/material.dart';

///
/// Created by dumingwei on 2019-10-08.
/// Desc:
///
class ProviderRoute extends StatefulWidget {
  @override
  State createState() {
    return _ProviderRouteState();
  }
}

class _ProviderRouteState extends State<ProviderRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('7.3 跨组件状态共享（Provider）'),
      ),
      body: Center(
        child: ChangeNotifierProvider<CartModel>(
            //数据
            data: CartModel(),
            //Widget
            child: Builder(builder: (context) {
              return Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 20.0),
                  ),
                  /*Builder(builder: (context) {
                    var cart = ChangeNotifierProvider.of<CartModel>(context);
                    return Text("总价：${cart.totalPrice}");
                  }),*/
                  Consume<CartModel>(
                      builder: (context, cart) =>
                          Text("总价：${cart.totalPrice}")),
                  Builder(builder: (context) {
                    print("ElevatedButton build"); //在后面优化部分会用到
                    return ElevatedButton(
                        child: Text('添加商品'),
                        onPressed: () {
                          ChangeNotifierProvider.of<CartModel>(context,
                                  listen: false)
                              .add(Item(20.0, 1));
                        });
                  })
                ],
              );
            })),
      ),
    );
  }
}

/// 一个通用的InheritedWidget，保存需要跨组件共享的数据，共享数据类型是泛型，使用的时候指定具体要共享的数据类型
class InheritedProvider<T> extends InheritedWidget {
  //共享状态使用泛型
  final T data;

  InheritedProvider({@required this.data, Widget child}) : super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    //在此简单返回true，则每次更新都会调用依赖其的子孙节点的`didChangeDependencies`。
    return true;
  }
}

// 该方法用于在Dart中获取模板类型
Type _typeOf<T>() => T;

///这是一个订阅者，当收到数据改变的通知的时候，重新构建InheritedProvider。
class ChangeNotifierProvider<T extends ChangeNotifier> extends StatefulWidget {
  final Widget child;
  final T data;

  ChangeNotifierProvider({
    Key key,
    this.data,
    this.child,
  });

  //定义一个便捷方法，方便子树中的widget获取共享数据
  // static T of<T>(BuildContext context) {
  //   final type = _typeOf<InheritedProvider<T>>();
  //   final provider =  context.dependOnInheritedWidgetOfExactType<InheritedProvider<T>>();
  //   return provider.data;
  // }

  //定义一个便捷方法，方便子树中的widget获取共享数据
  static T of<T>(BuildContext context, {bool listen = true}) {
    final provider = listen ? context.dependOnInheritedWidgetOfExactType<InheritedProvider<T>>()
        : context
            .getElementForInheritedWidgetOfExactType<InheritedProvider<T>>()
            ?.widget as InheritedProvider<T>;

    return provider.data;
  }

  @override
  _ChangeNotifierProviderState createState() {
    return _ChangeNotifierProviderState<T>();
  }
}

class _ChangeNotifierProviderState<T extends ChangeNotifier>
    extends State<ChangeNotifierProvider<T>> {
  @override
  void initState() {
    //添加监听，当数据发生改变了的时候，构建一个新的 InheritedProvider
    widget.data.addListener(update);
    super.initState();
  }

  void update() {
    //如果数据发生变化（model类调用了notifyListeners），重新构建InheritedProvider
    setState(() {});
  }

  @override
  void didUpdateWidget(ChangeNotifierProvider<T> oldWidget) {
    //当Provider更新时，如果新旧数据不"=="，则解绑旧数据监听，同时添加新数据监听
    if (widget.data != oldWidget.data) {
      oldWidget.data.removeListener(update);
      widget.data.addListener(update);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    widget.data.removeListener(update);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //返回一个InheritedProvider
    return InheritedProvider<T>(data: widget.data, child: widget.child);
  }
}

class Item {
  double price; //商品单价
  int count; // 商品份数
  Item(this.price, this.count);
}

///CartModel即要跨组件共享的model类。
///这是一个被观察者，在这里保存要共享的数据，当数据发生变化时，调用notifyListeners() 来通知订阅者。
class CartModel extends ChangeNotifier {
  final List<Item> _items = [];

  // 禁止改变购物车里的商品信息
  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

  // 购物车中商品的总价
  double get totalPrice =>
      _items.fold(0, (value, item) => value + item.count * item.price);

  void add(Item item) {
    _items.add(item);
    notifyListeners();
  }
}

/// 这是一个便捷类，会获得当前context和指定数据类型的Provider
class Consume<T> extends StatelessWidget {
  final Widget child;

  final Widget Function(BuildContext contex, T value) builder;

  Consume({Key key, @required this.builder, this.child})
      : assert(builder != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    //自动获取Model
    return builder(context, ChangeNotifierProvider.of<T>(context));
  }
}
