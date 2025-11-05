import 'dart:convert';

class HomeResponse {
  final int code;
  final String msg;
  final HomeData data;
  final bool success;

  HomeResponse({
    required this.code,
    required this.msg,
    required this.data,
    required this.success,
  });

  factory HomeResponse.fromJson(Map<String, dynamic> json) {
    return HomeResponse(
      code: json['code'] as int? ?? 0,
      msg: json['msg'] as String? ?? '',
      data: HomeData.fromJson(json['data'] as Map<String, dynamic>? ?? {}),
      success: json['success'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'msg': msg,
      'data': data.toJson(),
      'success': success,
    };
  }

  String toJsonString({bool pretty = false}) {
    if (pretty) return const JsonEncoder.withIndent('  ').convert(toJson());
    return jsonEncode(toJson());
  }

  @override
  String toString() => toJsonString();
}

class HomeData {
  final NoticeInfo? noticeInfo;
  final Notice? notice;
  final dynamic chat;
  final CharacterContainer? character;
  final RecSet? recSet;
  final List<TagInfo> tagInfo;
  final List<CharacterSort> characterSort;
  final Ext? ext;
  final AgreementDialog? agreementDialog;
  final CategoryColumn? categoryColumn;
  final RecommendStoryResponse? recommendStoryResponse;

  HomeData({
    this.noticeInfo,
    this.notice,
    this.chat,
    this.character,
    this.recSet,
    required this.tagInfo,
    required this.characterSort,
    this.ext,
    this.agreementDialog,
    this.categoryColumn,
    this.recommendStoryResponse,
  });

  factory HomeData.fromJson(Map<String, dynamic> json) {
    return HomeData(
      noticeInfo: json['noticeInfo'] != null
          ? NoticeInfo.fromJson(json['noticeInfo'] as Map<String, dynamic>)
          : null,
      notice: json['notice'] != null
          ? Notice.fromJson(json['notice'] as Map<String, dynamic>)
          : null,
      chat: json['chat'],
      character: json['character'] != null
          ? CharacterContainer.fromJson(
              json['character'] as Map<String, dynamic>)
          : null,
      recSet: json['recSet'] != null
          ? RecSet.fromJson(json['recSet'] as Map<String, dynamic>)
          : null,
      tagInfo: (json['tagInfo'] as List<dynamic>?)
              ?.map((e) => TagInfo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      characterSort: (json['characterSort'] as List<dynamic>?)
              ?.map((e) => CharacterSort.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      ext: json['ext'] != null
          ? Ext.fromJson(json['ext'] as Map<String, dynamic>)
          : null,
      agreementDialog: json['agreementDialog'] != null
          ? AgreementDialog.fromJson(
              json['agreementDialog'] as Map<String, dynamic>)
          : null,
      categoryColumn: json['categoryColumn'] != null
          ? CategoryColumn.fromJson(
              json['categoryColumn'] as Map<String, dynamic>)
          : null,
      recommendStoryResponse: json['recommendStoryResponse'] != null
          ? RecommendStoryResponse.fromJson(
              json['recommendStoryResponse'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'noticeInfo': noticeInfo?.toJson(),
      'notice': notice?.toJson(),
      'chat': chat,
      'character': character?.toJson(),
      'recSet': recSet?.toJson(),
      'tagInfo': tagInfo.map((e) => e.toJson()).toList(),
      'characterSort': characterSort.map((e) => e.toJson()).toList(),
      'ext': ext?.toJson(),
      'agreementDialog': agreementDialog?.toJson(),
      'categoryColumn': categoryColumn?.toJson(),
      'recommendStoryResponse': recommendStoryResponse?.toJson(),
    };
  }

  String toJsonString({bool pretty = false}) {
    if (pretty) return const JsonEncoder.withIndent('  ').convert(toJson());
    return jsonEncode(toJson());
  }

  @override
  String toString() => toJsonString();
}

class NoticeInfo {
  final dynamic banner;
  final Ad? ad1;
  final Ad? ad2;
  final dynamic streamerAd;

  NoticeInfo({this.banner, this.ad1, this.ad2, this.streamerAd});

  factory NoticeInfo.fromJson(Map<String, dynamic> json) {
    return NoticeInfo(
      banner: json['banner'],
      ad1: json['ad1'] != null
          ? Ad.fromJson(json['ad1'] as Map<String, dynamic>)
          : null,
      ad2: json['ad2'] != null
          ? Ad.fromJson(json['ad2'] as Map<String, dynamic>)
          : null,
      streamerAd: json['streamerAd'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'banner': banner,
      'ad1': ad1?.toJson(),
      'ad2': ad2?.toJson(),
      'streamerAd': streamerAd,
    };
  }
}

class Ad {
  final String? title;
  final String? desc;
  final String? destUrl;
  final String? icon;
  final String? darkIcon;
  final String? adBackgroundImgUrl;
  final String? darkAdBackgroundImgUrl;

  Ad({
    this.title,
    this.desc,
    this.destUrl,
    this.icon,
    this.darkIcon,
    this.adBackgroundImgUrl,
    this.darkAdBackgroundImgUrl,
  });

  factory Ad.fromJson(Map<String, dynamic> json) {
    return Ad(
      title: json['title'] as String?,
      desc: json['desc'] as String?,
      destUrl: json['destUrl'] as String?,
      icon: json['icon'] as String?,
      darkIcon: json['darkIcon'] as String?,
      adBackgroundImgUrl: json['adBackgroundImgUrl'] as String?,
      darkAdBackgroundImgUrl: json['darkAdBackgroundImgUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'desc': desc,
      'destUrl': destUrl,
      'icon': icon,
      'darkIcon': darkIcon,
      'adBackgroundImgUrl': adBackgroundImgUrl,
      'darkAdBackgroundImgUrl': darkAdBackgroundImgUrl,
    };
  }
}

class Notice {
  final String? resourceUrl;
  final String? destUrl;

  Notice({this.resourceUrl, this.destUrl});

  factory Notice.fromJson(Map<String, dynamic> json) {
    return Notice(
      resourceUrl: json['resourceUrl'] as String?,
      destUrl: json['destUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'resourceUrl': resourceUrl,
      'destUrl': destUrl,
    };
  }
}

class CharacterContainer {
  final int count;
  final List<Character> list;
  final String? listQurl;
  final dynamic recommendStoryResponse;

  CharacterContainer({
    required this.count,
    required this.list,
    this.listQurl,
    this.recommendStoryResponse,
  });

  factory CharacterContainer.fromJson(Map<String, dynamic> json) {
    return CharacterContainer(
      count: json['count'] as int? ?? 0,
      list: (json['list'] as List<dynamic>?)
              ?.map((e) => Character.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      listQurl: json['listQurl'] as String?,
      recommendStoryResponse: json['recommendStoryResponse'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'list': list.map((e) => e.toJson()).toList(),
      'listQurl': listQurl,
      'recommendStoryResponse': recommendStoryResponse,
    };
  }
}

class Character {
  final String characterId;
  final String name;
  final String avatar;
  final int gender;
  final int chatUserCount;
  final String identity;
  final String otherSetting;
  final String qurl;
  final int memoryCount;
  final List<TagInfo> tagList;
  final int storyCount;
  final int taleCount;
  final int confessionCount;
  final int recType;
  final dynamic spark;
  final int recFlag;
  final int recPageNum;

  Character({
    required this.characterId,
    required this.name,
    required this.avatar,
    required this.gender,
    required this.chatUserCount,
    required this.identity,
    required this.otherSetting,
    required this.qurl,
    required this.memoryCount,
    required this.tagList,
    required this.storyCount,
    required this.taleCount,
    required this.confessionCount,
    required this.recType,
    this.spark,
    required this.recFlag,
    required this.recPageNum,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      characterId: (json['characterId'] ?? '').toString(),
      name: json['name'] as String? ?? '',
      avatar: json['avatar'] as String? ?? '',
      gender: json['gender'] as int? ?? 0,
      chatUserCount: json['chatUserCount'] as int? ?? 0,
      identity: json['identity'] as String? ?? '',
      otherSetting: json['otherSetting'] as String? ?? '',
      qurl: json['qurl'] as String? ?? '',
      memoryCount: json['memoryCount'] as int? ?? 0,
      tagList: (json['tagList'] as List<dynamic>?)
              ?.map((e) => TagInfo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      storyCount: json['storyCount'] as int? ?? 0,
      taleCount: json['taleCount'] as int? ?? 0,
      confessionCount: json['confessionCount'] as int? ?? 0,
      recType: json['recType'] as int? ?? 0,
      spark: json['spark'],
      recFlag: json['recFlag'] as int? ?? 0,
      recPageNum: json['recPageNum'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'characterId': characterId,
      'name': name,
      'avatar': avatar,
      'gender': gender,
      'chatUserCount': chatUserCount,
      'identity': identity,
      'otherSetting': otherSetting,
      'qurl': qurl,
      'memoryCount': memoryCount,
      'tagList': tagList.map((e) => e.toJson()).toList(),
      'storyCount': storyCount,
      'taleCount': taleCount,
      'confessionCount': confessionCount,
      'recType': recType,
      'spark': spark,
      'recFlag': recFlag,
      'recPageNum': recPageNum,
    };
  }

  bool isMale() {
    return gender == 1;
  }

}

class TagInfo {
  final String tagName;

  TagInfo({required this.tagName});

  factory TagInfo.fromJson(Map<String, dynamic> json) {
    return TagInfo(tagName: json['tagName'] as String? ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'tagName': tagName};
  }
}

class RecSet {
  final String title;
  final List<SetItem> setList;

  RecSet({required this.title, required this.setList});

  factory RecSet.fromJson(Map<String, dynamic> json) {
    return RecSet(
      title: json['title'] as String? ?? '',
      setList: (json['setList'] as List<dynamic>?)
              ?.map((e) => SetItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'setList': setList.map((e) => e.toJson()).toList(),
    };
  }
}

class SetItem {
  final int collectionId;
  final String title;
  final String backgroundUrl;
  final String nightBackgroundUrl;
  final String destUrl;
  final List<dynamic> vcList;

  SetItem({
    required this.collectionId,
    required this.title,
    required this.backgroundUrl,
    required this.nightBackgroundUrl,
    required this.destUrl,
    required this.vcList,
  });

  factory SetItem.fromJson(Map<String, dynamic> json) {
    return SetItem(
      collectionId: json['collectionId'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      backgroundUrl: json['backgroundUrl'] as String? ?? '',
      nightBackgroundUrl: json['nightBackgroundUrl'] as String? ?? '',
      destUrl: json['destUrl'] as String? ?? '',
      vcList: (json['vcList'] as List<dynamic>?)?.toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'collectionId': collectionId,
      'title': title,
      'backgroundUrl': backgroundUrl,
      'nightBackgroundUrl': nightBackgroundUrl,
      'destUrl': destUrl,
      'vcList': vcList,
    };
  }
}

class CharacterSort {
  final String sortName;
  final String sortDesc;
  final int sortValue;

  CharacterSort(
      {required this.sortName,
      required this.sortDesc,
      required this.sortValue});

  factory CharacterSort.fromJson(Map<String, dynamic> json) {
    return CharacterSort(
      sortName: json['sortName'] as String? ?? '',
      sortDesc: json['sortDesc'] as String? ?? '',
      sortValue: json['sortValue'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sortName': sortName,
      'sortDesc': sortDesc,
      'sortValue': sortValue,
    };
  }
}

class Ext {
  final List<String> currentTagName;
  final int currentSort;

  Ext({required this.currentTagName, required this.currentSort});

  factory Ext.fromJson(Map<String, dynamic> json) {
    return Ext(
      currentTagName: (json['currentTagName'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      currentSort: json['currentSort'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'currentTagName': currentTagName,
      'currentSort': currentSort,
    };
  }
}

class AgreementDialog {
  final bool show;
  final int lastVersion;
  final String content;

  AgreementDialog(
      {required this.show, required this.lastVersion, required this.content});

  factory AgreementDialog.fromJson(Map<String, dynamic> json) {
    return AgreementDialog(
      show: json['show'] as bool? ?? false,
      lastVersion: json['lastVersion'] as int? ?? 0,
      content: json['content'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'show': show, 'lastVersion': lastVersion, 'content': content};
  }
}

class CategoryColumn {
  final List<dynamic> columnList;
  final String categoryQurl;
  final String title;

  CategoryColumn(
      {required this.columnList,
      required this.categoryQurl,
      required this.title});

  factory CategoryColumn.fromJson(Map<String, dynamic> json) {
    return CategoryColumn(
      columnList: (json['columnList'] as List<dynamic>?)?.toList() ?? [],
      categoryQurl: json['categoryQurl'] as String? ?? '',
      title: json['title'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'columnList': columnList,
      'categoryQurl': categoryQurl,
      'title': title
    };
  }
}

class RecommendStoryResponse {
  final String? titleUrl;
  final String? darkTitleUrl;
  final int? showPosition;
  final dynamic recStoryList;

  RecommendStoryResponse(
      {this.titleUrl, this.darkTitleUrl, this.showPosition, this.recStoryList});

  factory RecommendStoryResponse.fromJson(Map<String, dynamic> json) {
    return RecommendStoryResponse(
      titleUrl: json['titleUrl'] as String?,
      darkTitleUrl: json['darkTitleUrl'] as String?,
      showPosition: json['showPosition'] as int?,
      recStoryList: json['recStoryList'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'titleUrl': titleUrl,
      'darkTitleUrl': darkTitleUrl,
      'showPosition': showPosition,
      'recStoryList': recStoryList,
    };
  }
}
