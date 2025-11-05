import 'package:flutter/material.dart';
import 'package:flutter_app/wanandroid_flutter/model/BannerModel.dart';
import 'package:flutter_app/wanandroid_flutter/api/CommonService.dart';
import 'package:card_swiper/card_swiper.dart';

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
  List<BannerData> _bannerList = [];

  @override
  void initState() {
    super.initState();
    _getBanner();
  }

  Future<void> _getBanner() async {
    CommonService().getBanner((BannerModel _bean) {
      final list = _bean.data ?? <BannerData>[];
      if (list.isNotEmpty) {
        setState(() {
          _bannerList = list;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshSafeArea(
      child: Swiper(
          itemHeight: 100,
          autoplay: true,
          pagination: SwiperPagination(),
          itemBuilder: (BuildContext context, int index) {
            return buildItemImageWidget(context, index);
          },
          itemCount: _bannerList.length),
    );
  }

  Widget buildItemImageWidget(BuildContext context, int index) {
    final String url = _bannerList[index].imagePath ?? '';
    if (url.isEmpty) {
      return Container(color: Colors.grey.shade200);
    }
    return InkWell(
      onTap: () {
        //RouteUtil.toWebView(context, _bannerList[index].title, _bannerList[index].url);
      },
      child: Container(
        child: Image.network(
          url,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

class RefreshSafeArea extends StatelessWidget {
  final Widget child;

  RefreshSafeArea({Key? key, required this.child}) : super(key: key);

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
