import 'package:flutter/material.dart';
import 'package:flutter_app/wanandroid_flutter/model/BannerModel.dart';
import 'package:flutter_app/wanandroid_flutter/api/CommonService.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

///
/// Created by dumingwei on 2019/4/13.
/// Desc:
///

class BannerWidgetUI extends StatefulWidget {
  @override
  State createState() {
    return BannerWidgetUIState();
  }
}

class BannerWidgetUIState extends State<BannerWidgetUI> {
  List<BannerData> _bannerList = List();

  @override
  void initState() {
    super.initState();
    _bannerList.add(null);
    _getBanner();
  }

  Future<Null> _getBanner() async {
    CommonService().getBanner((BannerModel _bean) {
      if (_bean.data.length > 0) {
        setState(() {
          _bannerList = _bean.data;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshSafeArea(
      child: new Swiper(
          itemHeight: 100,
          autoplay: true,
          pagination: SwiperPagination(),
          itemBuilder: (BuildContext context, int index) {
            if (_bannerList[index] == null ||
                _bannerList[index].imagePath == null) {
              return new Container(
                color: Colors.grey[100],
              );
            } else {
              return buildItemImageWidget(context, index);
            }
          },
          itemCount: _bannerList.length),
    );
  }

  Widget buildItemImageWidget(BuildContext context, int index) {
    return new InkWell(
      onTap: () {
        //RouteUtil.toWebView(context, _bannerList[index].title, _bannerList[index].url);
      },
      child: new Container(
        child: new Image.network(
          _bannerList[index].imagePath,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

class RefreshSafeArea extends StatelessWidget {
  Widget child;

  RefreshSafeArea({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: (ScrollNotification notification) {
        return true;
      },
      child: this.child,
    );
  }
}
