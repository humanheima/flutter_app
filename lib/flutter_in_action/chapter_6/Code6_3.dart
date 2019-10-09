import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

///
/// Crete by dumingwei on 2019/3/24
/// Desc: ListView
///

class ListViewRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget divier1 = Divider(color: Colors.red);
    Widget divier2 = Divider(color: Colors.green);
    return new Scaffold(
      appBar: new AppBar(
          title: new Text(
        "6.3 ListView",
      )),
      backgroundColor: Colors.white,
      body: Container(
          //child: buildListView(divier1, divier2),
          //child: separatedListView(divier1, divier2),
          child: Column(
        children: <Widget>[
          ListTile(title: Text("固定表头")),
          Expanded(
            child: InfiniteListView(),
          )
        ],
      )),
    );
  }

  ListView buildListView(Widget divier1, Widget divier2) {
    return ListView.builder(
      itemCount: 100,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: <Widget>[
            ListTile(
              title: Text("$index"),
            ),
            getDivider(index, divier1, divier2),
          ],
        );
      },
    );
  }

  Widget getDivider(int index, Widget divider1, Widget divider2) {
    if (index % 2 == 0) {
      return divider1;
    } else {
      return divider2;
    }
  }

  ListView separatedListView(Widget divider1, Widget divider2) {
    return ListView.separated(
      itemCount: 100,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text("$index"),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return index % 2 == 0 ? divider1 : divider2;
      },
    );
  }
}

///实例：无限加载列表
///假设我们要从数据源异步分批拉取一些数据，然后用ListView显示，当我们滑动到列表末尾时，
///判断是否需要再去拉取数据，如果是，则去拉取，拉取过程中在表尾显示一个loading，拉取成功后将数据插入列表；
///如果不需要再去拉取，则在表尾提示"没有更多"。
class InfiniteListView extends StatefulWidget {
  @override
  _InfiniteListViewState createState() => _InfiniteListViewState();
}

class _InfiniteListViewState extends State<InfiniteListView> {
  static const loadingTag = "##loading##";

  var _words = <String>[loadingTag];

  @override
  void initState() {
    super.initState();
    _retriveData();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemCount: _words.length,
        itemBuilder: (BuildContext context, int index) {
          if (_words[index] == loadingTag) {
            //不足一百条继续获取
            if (_words.length - 1 < 100) {
              _retriveData();
              return Container(
                  padding: const EdgeInsets.all(16.0),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(loadingTag),
                      SizedBox(
                        width: 24.0,
                        height: 24.0,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.0,
                        ),
                      ),
                    ],
                  ));
            } else {
              //已经加载了100条数据，不再获取数据。
              return Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "没有更多了",
                  style: TextStyle(color: Colors.grey),
                ),
              );
            }
          }

          return ListTile(
            title: Text(_words[index]),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            height: 0.0,
          );
        });
  }

  void _retriveData() {
    Future.delayed(Duration(seconds: 2)).then((e) {
      _words.insertAll(_words.length - 1,
          generateWordPairs().take(20).map((e) => e.asPascalCase).toList());

      setState(() {
        //重新构建列表
      });
    });
  }
}
