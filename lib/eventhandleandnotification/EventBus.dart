///
/// Crete by dumingwei on 2019/3/25
/// Desc: 事件总线
///

//定义一个top-level变量，页面引入该文件后可以直接使用bus
var bus = new EventBus();

typedef void EventCallback(arg);

class EventBus {
  //私有构造函数
  EventBus._internal();

  //保存单例
  static EventBus _singleton = new EventBus._internal();

  //工厂构造函数
  factory EventBus() => _singleton;

  //保存事件订阅者队列，key:事件名(id)，value: 对应事件的订阅者队列
  var _emap = new Map<Object, List<EventCallback>>();

  //添加订阅者
  void on(eventName, EventCallback f) {
    if (eventName == null || f == null) {
      return;
    }
    //只有当_emap[eventName]为null的时候才把new List<EventCallback>()赋值给_emap[eventName]
    _emap[eventName] ??= new List<EventCallback>();
    _emap[eventName].add(f);
  }

  //移除订阅者

  void off(eventName, [EventCallback f]) {
    var list = _emap[eventName];

    if (list == null || list.isEmpty) {
      return;
    }
    if (f == null) {
      _emap[eventName] = null;
    } else {
      _emap.remove(eventName);
    }
  }

  //触发事件，事件触发后该事件所有订阅者会被调用
  void emit(eventName, [arg]) {
    var list = _emap[eventName];
    if (list == null || list.isEmpty) {
      return;
    }
    int len = list.length - 1;
    //反向遍历，防止在订阅者在回调中移除自身带来的下标错位
    for (var i = len; i > -1; --i) {
      list[i](arg);
    }
  }
}
