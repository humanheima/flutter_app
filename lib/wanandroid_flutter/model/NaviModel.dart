import 'dart:convert';

class NaviModel {
  int? errorCode;
  String? errorMsg;
  List<NaviData>? data;

  NaviModel({this.errorCode, this.errorMsg, this.data});

  factory NaviModel.fromJson(dynamic jsonRes) {
    if (jsonRes == null) return NaviModel();
    final Map<String, dynamic> map = jsonRes is String ? jsonDecode(jsonRes) : Map<String, dynamic>.from(jsonRes as Map);
    return NaviModel(
      errorCode: map['errorCode'] as int?,
      errorMsg: map['errorMsg'] as String?,
      data: (map['data'] as List?)
          ?.where((e) => e != null)
          .map((e) => NaviData.fromJson(e))
          .toList(),
    );
  }

  @override
  String toString() {
    return jsonEncode({
      'errorCode': errorCode,
      'errorMsg': errorMsg,
      'data': data,
    });
  }
}

class NaviData {
  int? cid;
  String? name;
  List<NaviArticle>? articles;

  NaviData({this.cid, this.name, this.articles});

  factory NaviData.fromJson(dynamic jsonRes) {
    if (jsonRes == null) return NaviData();
    final Map<String, dynamic> map = jsonRes is String ? jsonDecode(jsonRes) : Map<String, dynamic>.from(jsonRes as Map);
    return NaviData(
      cid: map['cid'] as int?,
      name: map['name'] as String?,
      articles: (map['articles'] as List?)
          ?.where((e) => e != null)
          .map((e) => NaviArticle.fromJson(e))
          .toList(),
    );
  }

  @override
  String toString() {
    return jsonEncode({'cid': cid, 'name': name, 'articles': articles});
  }
}

class NaviArticle {
  int? chapterId;
  int? courseId;
  int? id;
  int? publishTime;
  int? superChapterId;
  int? type;
  int? userId;
  int? visible;
  int? zan;
  bool? collect;
  bool? fresh;
  String? apkLink;
  String? author;
  String? chapterName;
  String? desc;
  String? envelopePic;
  String? link;
  String? niceDate;
  String? origin;
  String? projectLink;
  String? superChapterName;
  String? title;
  List<dynamic>? tags;

  NaviArticle({
    this.chapterId,
    this.courseId,
    this.id,
    this.publishTime,
    this.superChapterId,
    this.type,
    this.userId,
    this.visible,
    this.zan,
    this.collect,
    this.fresh,
    this.apkLink,
    this.author,
    this.chapterName,
    this.desc,
    this.envelopePic,
    this.link,
    this.niceDate,
    this.origin,
    this.projectLink,
    this.superChapterName,
    this.title,
    this.tags,
  });

  factory NaviArticle.fromJson(dynamic jsonRes) {
    if (jsonRes == null) return NaviArticle();
    final Map<String, dynamic> map = jsonRes is String ? jsonDecode(jsonRes) : Map<String, dynamic>.from(jsonRes as Map);
    return NaviArticle(
      chapterId: map['chapterId'] as int?,
      courseId: map['courseId'] as int?,
      id: map['id'] as int?,
      publishTime: map['publishTime'] as int?,
      superChapterId: map['superChapterId'] as int?,
      type: map['type'] as int?,
      userId: map['userId'] as int?,
      visible: map['visible'] as int?,
      zan: map['zan'] as int?,
      collect: map['collect'] as bool?,
      fresh: map['fresh'] as bool?,
      apkLink: map['apkLink'] as String?,
      author: map['author'] as String?,
      chapterName: map['chapterName'] as String?,
      desc: map['desc'] as String?,
      envelopePic: map['envelopePic'] as String?,
      link: map['link'] as String?,
      niceDate: map['niceDate'] as String?,
      origin: map['origin'] as String?,
      projectLink: map['projectLink'] as String?,
      superChapterName: map['superChapterName'] as String?,
      title: map['title'] as String?,
      tags: (map['tags'] as List?)?.toList(),
    );
  }

  @override
  String toString() {
    return jsonEncode({
      'chapterId': chapterId,
      'courseId': courseId,
      'id': id,
      'publishTime': publishTime,
      'superChapterId': superChapterId,
      'type': type,
      'userId': userId,
      'visible': visible,
      'zan': zan,
      'collect': collect,
      'fresh': fresh,
      'apkLink': apkLink,
      'author': author,
      'chapterName': chapterName,
      'desc': desc,
      'envelopePic': envelopePic,
      'link': link,
      'niceDate': niceDate,
      'origin': origin,
      'projectLink': projectLink,
      'superChapterName': superChapterName,
      'title': title,
      'tags': tags,
    });
  }
}
