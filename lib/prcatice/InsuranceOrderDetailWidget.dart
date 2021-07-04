import 'package:flutter/material.dart';
import 'package:flutter_app/models/index.dart';

///
/// Created by dumingwei on 2019-10-22.
/// Desc:
///
class InsuranceOrderDetailWidget extends StatefulWidget {
  @override
  State createState() => _InsuranceOrderDetailWidgetState();
}

class _InsuranceOrderDetailWidgetState
    extends State<InsuranceOrderDetailWidget> {
  String _tag = "_InsuranceOrderDetailWidgetState";

  ScrollController _controller = ScrollController();

  List<InsuranceOrderDetail> orderList = List();

  //  请求首页文章页码
  int curPage = 0;

  double leftWidth = 70.0;

  @override
  void initState() {
    super.initState();
    print("$_tag,initState");
    getData();

    _controller.addListener(() {
      var maxScroll = _controller.position.maxScrollExtent;
      var pixels = _controller.position.pixels;
      if (maxScroll == pixels) {
        if (curPage < 3) {
          curPage++;
          getData();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print("$_tag,build");
    return Scaffold(
      appBar: AppBar(
        title: Text('保险详情'),
        centerTitle: true,
        actions: <Widget>[Icon(Icons.phone)],
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (orderList.isEmpty) {
      return Center(
        child: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
      );
    } else {
      return ListView.builder(
          itemCount: orderList.length,
          controller: _controller,
          itemBuilder: (BuildContext context, int index) {
            return Card(
                margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Container(
                  margin: EdgeInsets.all(15.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            Text(
                              orderList[index].title,
                              style: TextStyle(
                                  color: Color(0xFF333333), fontSize: 18),
                            ),
                            Expanded(
                                child: Text(
                                    orderList[index].status == 1
                                        ? "已完成"
                                        : "待审核",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        color: orderList[index].status == 1
                                            ? Color(0xFF0B82F1)
                                            : Color(0xFF999999),
                                        fontSize: 14))),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Row(
                          children: <Widget>[
                            Text(
                              '保障期限：',
                              style: TextStyle(
                                  color: Color(0xFF999999), fontSize: 14),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: 5),
                                child: Text(orderList[index].period,
                                    style: TextStyle(
                                        color: Color(0xFF999999),
                                        fontSize: 14)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 15),
                        color: Colors.grey[200],
                        height: 1,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 15),
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Text('被保人：',
                                  style: TextStyle(
                                      color: Color(0xFF999999), fontSize: 14)),
                              width: leftWidth,
                            ),
                            Expanded(
                                child: Text(orderList[index].guardPerson,
                                    style: TextStyle(
                                        color: Color(0xFF999999),
                                        fontSize: 14))),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Text('保单价格：',
                                  style: TextStyle(
                                      color: Color(0xFF999999), fontSize: 14)),
                              width: leftWidth,
                            ),
                            Expanded(
                                child: Text(orderList[index].insurancePrice,
                                    style: TextStyle(
                                        color: Color(0xFF999999),
                                        fontSize: 14))),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Text('保单编号：',
                                  style: TextStyle(
                                      color: Color(0xFF999999), fontSize: 14)),
                              width: leftWidth,
                            ),
                            Expanded(
                                child: Text(orderList[index].orderId,
                                    style: TextStyle(
                                        color: Color(0xFF999999),
                                        fontSize: 14))),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Text('下单时间：',
                                  style: TextStyle(
                                      color: Color(0xFF999999), fontSize: 14)),
                              width: leftWidth,
                            ),
                            Expanded(
                                child: Text(orderList[index].orderGenerateDate,
                                    style: TextStyle(
                                        color: Color(0xFF999999),
                                        fontSize: 14))),
                          ],
                        ),
                      ),
                      Container(
                        height: 10.0,
                      )
                    ],
                  ),
                ));
          });
    }
    ;
  }

  Future<Null> getData() async {
    List<InsuranceOrderDetail> list = await getList();
    print("$_tag,getData,${list.length}");

    setState(() {
      orderList.addAll(list);
    });
  }

  Future<List<InsuranceOrderDetail>> getList() async {
    return Future.delayed(Duration(seconds: 1), () {
      List<InsuranceOrderDetail> list = List();
      var start = curPage * 10;
      var end = start + 10;

      for (int i = start; i < end; i++) {
        InsuranceOrderDetail orderDetail = new InsuranceOrderDetail(
            orderId: "20121022",
            title: "人身保险",
            status: i % 2,
            period: "2018-10-10 至 2019-10-10",
            guardPerson: "杜明伟",
            insurancePrice: "${i}元",
            orderGenerateDate: "2019-01-01");
        list.add(orderDetail);
      }
      return list;
    });
  }
}
