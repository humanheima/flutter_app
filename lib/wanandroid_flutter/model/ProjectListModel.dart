import 'dart:convert' show json;

class ProjectTreeListModel {

  int? errorCode;
  String? errorMsg;
  ProjectTreeListData? data;

  ProjectTreeListModel.fromParams({int? errorCode, String? errorMsg, ProjectTreeListData? data}) {
    this.errorCode = errorCode;
    this.errorMsg = errorMsg;
    this.data = data;
  }

  static ProjectTreeListModel? parse(dynamic jsonStr) {
    if (jsonStr == null) return null;
    if (jsonStr is String) return ProjectTreeListModel.fromJson(json.decode(jsonStr));
    return ProjectTreeListModel.fromJson(jsonStr);
  }

  ProjectTreeListModel.fromJson(dynamic jsonRes) {
    if (jsonRes == null) return;
    errorCode = jsonRes['errorCode'] as int?;
    errorMsg = jsonRes['errorMsg'] as String?;
    data = jsonRes['data'] != null ? ProjectTreeListData.fromJson(jsonRes['data']) : null;
  }

  @override
  String toString() {
    return '{"errorCode": $errorCode,"errorMsg": ${errorMsg != null? '${json.encode(errorMsg)}' : 'null'},"data": $data}';
  }
}

class ProjectTreeListData {

  int? curPage;
  int? offset;
  int? pageCount;
  int? size;
  int? total;
  bool? over;
  List<ProjectTreeListDatas>? datas;

  ProjectTreeListData.fromParams({int? curPage, int? offset, int? pageCount, int? size, int? total, bool? over, List<ProjectTreeListDatas>? datas}) {
    this.curPage = curPage;
    this.offset = offset;
    this.pageCount = pageCount;
    this.size = size;
    this.total = total;
    this.over = over;
    this.datas = datas;
  }

  ProjectTreeListData.fromJson(dynamic jsonRes) {
    if (jsonRes == null) return;
    curPage = jsonRes['curPage'] as int?;
    offset = jsonRes['offset'] as int?;
    pageCount = jsonRes['pageCount'] as int?;
    size = jsonRes['size'] as int?;
    total = jsonRes['total'] as int?;
    over = jsonRes['over'] as bool?;
    if (jsonRes['datas'] != null) {
      datas = <ProjectTreeListDatas>[];
      for (var datasItem in jsonRes['datas']) {
        datas!.add(datasItem == null ? ProjectTreeListDatas.fromParams() : ProjectTreeListDatas.fromJson(datasItem));
      }
    }
  }

  @override
  String toString() {
    return '{"curPage": $curPage,"offset": $offset,"pageCount": $pageCount,"size": $size,"total": $total,"over": $over,"datas": $datas}';
  }
}

class ProjectTreeListDatas {

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
  List<ProjectTreeListTag>? tags;

  ProjectTreeListDatas.fromParams({int? chapterId, int? courseId, int? id, int? publishTime, int? superChapterId, int? type, int? userId, int? visible, int? zan, bool? collect, bool? fresh, String? apkLink, String? author, String? chapterName, String? desc, String? envelopePic, String? link, String? niceDate, String? origin, String? projectLink, String? superChapterName, String? title, List<ProjectTreeListTag>? tags}) {
    this.chapterId = chapterId;
    this.courseId = courseId;
    this.id = id;
    this.publishTime = publishTime;
    this.superChapterId = superChapterId;
    this.type = type;
    this.userId = userId;
    this.visible = visible;
    this.zan = zan;
    this.collect = collect;
    this.fresh = fresh;
    this.apkLink = apkLink;
    this.author = author;
    this.chapterName = chapterName;
    this.desc = desc;
    this.envelopePic = envelopePic;
    this.link = link;
    this.niceDate = niceDate;
    this.origin = origin;
    this.projectLink = projectLink;
    this.superChapterName = superChapterName;
    this.title = title;
    this.tags = tags;
  }

  ProjectTreeListDatas.fromJson(dynamic jsonRes) {
    if (jsonRes == null) return;
    chapterId = jsonRes['chapterId'] as int?;
    courseId = jsonRes['courseId'] as int?;
    id = jsonRes['id'] as int?;
    publishTime = jsonRes['publishTime'] as int?;
    superChapterId = jsonRes['superChapterId'] as int?;
    type = jsonRes['type'] as int?;
    userId = jsonRes['userId'] as int?;
    visible = jsonRes['visible'] as int?;
    zan = jsonRes['zan'] as int?;
    collect = jsonRes['collect'] as bool?;
    fresh = jsonRes['fresh'] as bool?;
    apkLink = jsonRes['apkLink'] as String?;
    author = jsonRes['author'] as String?;
    chapterName = jsonRes['chapterName'] as String?;
    desc = jsonRes['desc'] as String?;
    envelopePic = jsonRes['envelopePic'] as String?;
    link = jsonRes['link'] as String?;
    niceDate = jsonRes['niceDate'] as String?;
    origin = jsonRes['origin'] as String?;
    projectLink = jsonRes['projectLink'] as String?;
    superChapterName = jsonRes['superChapterName'] as String?;
    title = jsonRes['title'] as String?;
    if (jsonRes['tags'] != null) {
      tags = <ProjectTreeListTag>[];
      for (var tagsItem in jsonRes['tags']) {
        tags!.add(tagsItem == null ? ProjectTreeListTag.fromParams() : ProjectTreeListTag.fromJson(tagsItem));
      }
    }
  }

  @override
  String toString() {
    return '{"chapterId": $chapterId,"courseId": $courseId,"id": $id,"publishTime": $publishTime,"superChapterId": $superChapterId,"type": $type,"userId": $userId,"visible": $visible,"zan": $zan,"collect": $collect,"fresh": $fresh,"apkLink": ${apkLink != null?'${json.encode(apkLink)}':'null'},"author": ${author != null?'${json.encode(author)}':'null'},"chapterName": ${chapterName != null?'${json.encode(chapterName)}':'null'},"desc": ${desc != null?'${json.encode(desc)}':'null'},"envelopePic": ${envelopePic != null?'${json.encode(envelopePic)}':'null'},"link": ${link != null?'${json.encode(link)}':'null'},"niceDate": ${niceDate != null?'${json.encode(niceDate)}':'null'},"origin": ${origin != null?'${json.encode(origin)}':'null'},"projectLink": ${projectLink != null?'${json.encode(projectLink)}':'null'},"superChapterName": ${superChapterName != null?'${json.encode(superChapterName)}':'null'},"title": ${title != null?'${json.encode(title)}':'null'},"tags": $tags}';
  }
}

class ProjectTreeListTag {

  String? name;
  String? url;

  ProjectTreeListTag.fromParams({String? name, String? url}) {
    this.name = name;
    this.url = url;
  }

  ProjectTreeListTag.fromJson(dynamic jsonRes) {
    if (jsonRes == null) return;
    name = jsonRes['name'] as String?;
    url = jsonRes['url'] as String?;
  }

  @override
  String toString() {
    return '{"name": ${name != null?'${json.encode(name)}':'null'},"url": ${url != null?'${json.encode(url)}':'null'}}';
  }
}
