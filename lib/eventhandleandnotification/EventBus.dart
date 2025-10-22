///
/// Crete by dumingwei on 2019/3/25
/// Desc: 事件总线
///

//定义一个top-level变量，页面引入该文件后可以直接使用bus
var bus = EventBus();

typedef void EventCallback(arg);

class EventBus {
  EventBus._internal();

  static EventBus _singleton = EventBus._internal();

  factory EventBus() => _singleton;

  // 使用明确的 Map 类型
  final Map<Object, List<EventCallback>> _emap = <Object, List<EventCallback>>{};

  void on(eventName, EventCallback f) {
    if (eventName == null) {
      return;
    }
    _emap[eventName] ??= <EventCallback>[];
    _emap[eventName]!.add(f);
  }

  // 如果传入 f，移除指定回调；否则移除整个事件
  void off(eventName, [EventCallback? f]) {
    var list = _emap[eventName];
    if (list == null || list.isEmpty) {
      return;
    }
    if (f == null) {
      _emap.remove(eventName);
    } else {
      list.remove(f);
      if (list.isEmpty) {
        _emap.remove(eventName);
      }
    }
  }

  void emit(eventName, [arg]) {
    var list = _emap[eventName];
    if (list == null || list.isEmpty) {
      return;
    }
    for (var i = list.length - 1; i > -1; --i) {
      list[i](arg);
    }
  }
}
