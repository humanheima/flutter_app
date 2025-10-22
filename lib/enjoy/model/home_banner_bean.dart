///
/// Created by dumingwei on 2019/4/2.
/// Desc:
///

class HomeBannerBean {
  List<HomeBanner>? data;

  int? errorCode;
  String? errorMsg;

  HomeBannerBean({this.data, this.errorCode, this.errorMsg});

  HomeBannerBean.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <HomeBanner>[];
      json['data'].forEach((v) {
        data!.add(HomeBanner.fromJson(v));
      });
    }
    errorCode = json['errorCode'];
    errorMsg = json['errorMsg'];
  }
}

class HomeBanner {
  String? desc;
  int? id;
  String? imagePath;
  int? isVisible;
  int? order;
  String? title;
  int? type;
  String? url;

  HomeBanner(this.desc, this.id, this.imagePath, this.isVisible, this.order,
      this.title, this.type, this.url);

  HomeBanner.fromJson(Map<String, dynamic> json) {
    desc = json['desc'];
    id = json['id'];
    imagePath = json['imagePath'];
    isVisible = json['isVisible'];
    order = json['order'];
    title = json['title'];
    type = json['type'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['desc'] = this.desc;
    data['id'] = this.id;
    data['imagePath'] = this.imagePath;
    data['isVisible'] = this.isVisible;
    data['order'] = this.order;
    data['title'] = this.title;
    data['type'] = this.type;
    data['url'] = this.url;
    return data;
  }
}
