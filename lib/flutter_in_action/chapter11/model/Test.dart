/// code : 0
/// msg : "success"
/// data : {"fileInfo":{"unlockStatus":8,"needPopularityValue":0,"infoList":[{"desc":"姓名","text":"已解锁未上线的"},{"desc":"角色","text":"主角"},{"desc":"别称","text":"茶茶"},{"desc":"身高","text":"188"},{"desc":"体重","text":"70kg"},{"desc":"生日","text":"农历1月1号"}],"extendInfoList":[{"desc":"身份","text":"二级男主"},{"desc":"性格","text":"茶里茶气"},{"desc":"爱好","text":"干饭，打人，怕黑，爱喝酒，睡觉，说大话，爱好1，爱好2，爱好3，爱好4，巴黎巴黎"},{"desc":"技能点","text":"干饭达人，技能超级多，都多大打击的啊，大号的大姐大啊擦办法哈哈，发打卡说大话，阿汉发ships啊是"},{"desc":"外貌特征","text":"已解锁未上线，就是很有特点的外貌，天下难找啊。英俊潇洒，爱着紫衣英俊潇洒，爱着紫衣英俊潇洒，爱着紫衣\n"}]},"roleAudio":{"unlockStatus":8,"needPopularityValue":0,"audioList":[{"text":"那是一个非常重要的日子，天气很好，阳光明媚，似乎代表着有好事发生，因为那天是我去学校领小学最后一份成绩报告单的日子。等了七天，所有人都期待着……","audioUrl":"https://bookcdn.xxsypro.com/audio/roleAudio_1673523611063.mp3","unlockStatus":2,"unlockTime":0,"likeCount":2,"selfLike":false,"ugcId":"830881469353754624","duration":20,"cbid":"22436383000317602","qurl":"unitexxreader://nativepage/client/readepage?bid=22436383000317602&ccid=43960985287375514¶Index=2&noHistory=1","unAudioMsg":"","ccid":"43960985287375514","paraIndex":2,"replyCount":0,"iconUrl":"https://bookcdn.xxsypro.com/roleImage/2fd6c923291e519945e332f5b241bc8e.png","goldShareUrl":"https://oah5.xxsypro.com/share/roleAudio?roleId=49674968438577191&inviterId=813100107257&audioId=21","nickname":"西瓜好可爱","cv":"轻薄的假相","id":21},{"text":"成都市多少","audioUrl":"https://bookcdn.xxsypro.com/audio/roleAudio_1675252997201.mp3","unlockStatus":2,"unlockTime":0,"likeCount":0,"selfLike":false,"ugcId":"838134515310198784","duration":20,"cbid":"22436383000317602","qurl":"unitexxreader://nativepage/client/readepage?bid=22436383000317602&ccid=0¶Index=0&noHistory=1","unAudioMsg":"","ccid":"0","paraIndex":0,"replyCount":0,"iconUrl":"https://bookcdn.xxsypro.com/roleImage/2fd6c923291e519945e332f5b241bc8e.png","goldShareUrl":"https://oah5.xxsypro.com/share/roleAudio?roleId=49674968438577191&inviterId=813100107257&audioId=150","nickname":"西瓜好可爱","cv":"66","id":150}]},"roleImg":{"unlockStatus":4,"needPopularityValue":0,"imgUrl":"https://bookcdn.xxsypro.com/roleImage/b4634c94e746ecd37d2fe2117e00b84c.png","width":1280,"height":1280}}
///使用插件将 json 生成 dart文件。
class Test {
  Test({
    num? code,
    String? msg,
    Data? data,
  }) {
    _code = code;
    _msg = msg;
    _data = data;
  }

  Test.fromJson(dynamic json) {
    _code = json['code'];
    _msg = json['msg'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  num? _code;
  String? _msg;
  Data? _data;

  Test copyWith({
    num? code,
    String? msg,
    Data? data,
  }) =>
      Test(
        code: code ?? _code,
        msg: msg ?? _msg,
        data: data ?? _data,
      );

  num? get code => _code;

  String? get msg => _msg;

  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['msg'] = _msg;
    if (_data != null) {
      map['data'] = _data!.toJson();
    }
    return map;
  }
}

/// fileInfo : {"unlockStatus":8,"needPopularityValue":0,"infoList":[{"desc":"姓名","text":"已解锁未上线的"},{"desc":"角色","text":"主角"},{"desc":"别称","text":"茶茶"},{"desc":"身高","text":"188"},{"desc":"体重","text":"70kg"},{"desc":"生日","text":"农历1月1号"}],"extendInfoList":[{"desc":"身份","text":"二级男主"},{"desc":"性格","text":"茶里茶气"},{"desc":"爱好","text":"干饭，打人，怕黑，爱喝酒，睡觉，说大话，爱好1，爱好2，爱好3，爱好4，巴黎巴黎"},{"desc":"技能点","text":"干饭达人，技能超级多，都多大打击的啊，大号的大姐大啊擦办法哈哈，发打卡说大话，阿汉发ships啊是"},{"desc":"外貌特征","text":"已解锁未上线，就是很有特点的外貌，天下难找啊。英俊潇洒，爱着紫衣英俊潇洒，爱着紫衣英俊潇洒，爱着紫衣\n"}]}
/// roleAudio : {"unlockStatus":8,"needPopularityValue":0,"audioList":[{"text":"那是一个非常重要的日子，天气很好，阳光明媚，似乎代表着有好事发生，因为那天是我去学校领小学最后一份成绩报告单的日子。等了七天，所有人都期待着……","audioUrl":"https://bookcdn.xxsypro.com/audio/roleAudio_1673523611063.mp3","unlockStatus":2,"unlockTime":0,"likeCount":2,"selfLike":false,"ugcId":"830881469353754624","duration":20,"cbid":"22436383000317602","qurl":"unitexxreader://nativepage/client/readepage?bid=22436383000317602&ccid=43960985287375514¶Index=2&noHistory=1","unAudioMsg":"","ccid":"43960985287375514","paraIndex":2,"replyCount":0,"iconUrl":"https://bookcdn.xxsypro.com/roleImage/2fd6c923291e519945e332f5b241bc8e.png","goldShareUrl":"https://oah5.xxsypro.com/share/roleAudio?roleId=49674968438577191&inviterId=813100107257&audioId=21","nickname":"西瓜好可爱","cv":"轻薄的假相","id":21},{"text":"成都市多少","audioUrl":"https://bookcdn.xxsypro.com/audio/roleAudio_1675252997201.mp3","unlockStatus":2,"unlockTime":0,"likeCount":0,"selfLike":false,"ugcId":"838134515310198784","duration":20,"cbid":"22436383000317602","qurl":"unitexxreader://nativepage/client/readepage?bid=22436383000317602&ccid=0¶Index=0&noHistory=1","unAudioMsg":"","ccid":"0","paraIndex":0,"replyCount":0,"iconUrl":"https://bookcdn.xxsypro.com/roleImage/2fd6c923291e519945e332f5b241bc8e.png","goldShareUrl":"https://oah5.xxsypro.com/share/roleAudio?roleId=49674968438577191&inviterId=813100107257&audioId=150","nickname":"西瓜好可爱","cv":"66","id":150}]}
/// roleImg : {"unlockStatus":4,"needPopularityValue":0,"imgUrl":"https://bookcdn.xxsypro.com/roleImage/b4634c94e746ecd37d2fe2117e00b84c.png","width":1280,"height":1280}

class Data {
  Data({
    FileInfo? fileInfo,
    RoleAudio? roleAudio,
    RoleImg? roleImg,
  }) {
    _fileInfo = fileInfo;
    _roleAudio = roleAudio;
    _roleImg = roleImg;
  }

  Data.fromJson(dynamic json) {
    _fileInfo = json['fileInfo'] != null ? FileInfo.fromJson(json['fileInfo']) : null;
    _roleAudio = json['roleAudio'] != null ? RoleAudio.fromJson(json['roleAudio']) : null;
    _roleImg = json['roleImg'] != null ? RoleImg.fromJson(json['roleImg']) : null;
  }

  FileInfo? _fileInfo;
  RoleAudio? _roleAudio;
  RoleImg? _roleImg;

  Data copyWith({
    FileInfo? fileInfo,
    RoleAudio? roleAudio,
    RoleImg? roleImg,
  }) =>
      Data(
        fileInfo: fileInfo ?? _fileInfo,
        roleAudio: roleAudio ?? _roleAudio,
        roleImg: roleImg ?? _roleImg,
      );

  FileInfo? get fileInfo => _fileInfo;

  RoleAudio? get roleAudio => _roleAudio;

  RoleImg? get roleImg => _roleImg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_fileInfo != null) {
      map['fileInfo'] = _fileInfo!.toJson();
    }
    if (_roleAudio != null) {
      map['roleAudio'] = _roleAudio!.toJson();
    }
    if (_roleImg != null) {
      map['roleImg'] = _roleImg!.toJson();
    }
    return map;
  }
}

/// unlockStatus : 4
/// needPopularityValue : 0
/// imgUrl : "https://bookcdn.xxsypro.com/roleImage/b4634c94e746ecd37d2fe2117e00b84c.png"
/// width : 1280
/// height : 1280

class RoleImg {
  RoleImg({
    num? unlockStatus,
    num? needPopularityValue,
    String? imgUrl,
    num? width,
    num? height,
  }) {
    _unlockStatus = unlockStatus;
    _needPopularityValue = needPopularityValue;
    _imgUrl = imgUrl;
    _width = width;
    _height = height;
  }

  RoleImg.fromJson(dynamic json) {
    _unlockStatus = json['unlockStatus'];
    _needPopularityValue = json['needPopularityValue'];
    _imgUrl = json['imgUrl'];
    _width = json['width'];
    _height = json['height'];
  }

  num? _unlockStatus;
  num? _needPopularityValue;
  String? _imgUrl;
  num? _width;
  num? _height;

  RoleImg copyWith({
    num? unlockStatus,
    num? needPopularityValue,
    String? imgUrl,
    num? width,
    num? height,
  }) =>
      RoleImg(
        unlockStatus: unlockStatus ?? _unlockStatus,
        needPopularityValue: needPopularityValue ?? _needPopularityValue,
        imgUrl: imgUrl ?? _imgUrl,
        width: width ?? _width,
        height: height ?? _height,
      );

  num? get unlockStatus => _unlockStatus;

  num? get needPopularityValue => _needPopularityValue;

  String? get imgUrl => _imgUrl;

  num? get width => _width;

  num? get height => _height;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['unlockStatus'] = _unlockStatus;
    map['needPopularityValue'] = _needPopularityValue;
    map['imgUrl'] = _imgUrl;
    map['width'] = _width;
    map['height'] = _height;
    return map;
  }
}

/// unlockStatus : 8
/// needPopularityValue : 0
/// audioList : [{"text":"那是一个非常重要的日子，天气很好，阳光明媚，似乎代表着有好事发生，因为那天是我去学校领小学最后一份成绩报告单的日子。等了七天，所有人都期待着……","audioUrl":"https://bookcdn.xxsypro.com/audio/roleAudio_1673523611063.mp3","unlockStatus":2,"unlockTime":0,"likeCount":2,"selfLike":false,"ugcId":"830881469353754624","duration":20,"cbid":"22436383000317602","qurl":"unitexxreader://nativepage/client/readepage?bid=22436383000317602&ccid=43960985287375514¶Index=2&noHistory=1","unAudioMsg":"","ccid":"43960985287375514","paraIndex":2,"replyCount":0,"iconUrl":"https://bookcdn.xxsypro.com/roleImage/2fd6c923291e519945e332f5b241bc8e.png","goldShareUrl":"https://oah5.xxsypro.com/share/roleAudio?roleId=49674968438577191&inviterId=813100107257&audioId=21","nickname":"西瓜好可爱","cv":"轻薄的假相","id":21},{"text":"成都市多少","audioUrl":"https://bookcdn.xxsypro.com/audio/roleAudio_1675252997201.mp3","unlockStatus":2,"unlockTime":0,"likeCount":0,"selfLike":false,"ugcId":"838134515310198784","duration":20,"cbid":"22436383000317602","qurl":"unitexxreader://nativepage/client/readepage?bid=22436383000317602&ccid=0¶Index=0&noHistory=1","unAudioMsg":"","ccid":"0","paraIndex":0,"replyCount":0,"iconUrl":"https://bookcdn.xxsypro.com/roleImage/2fd6c923291e519945e332f5b241bc8e.png","goldShareUrl":"https://oah5.xxsypro.com/share/roleAudio?roleId=49674968438577191&inviterId=813100107257&audioId=150","nickname":"西瓜好可爱","cv":"66","id":150}]

class RoleAudio {
  RoleAudio({
    num? unlockStatus,
    num? needPopularityValue,
    List<AudioList>? audioList,
  }) {
    _unlockStatus = unlockStatus;
    _needPopularityValue = needPopularityValue;
    _audioList = audioList;
  }

  RoleAudio.fromJson(dynamic json) {
    _unlockStatus = json['unlockStatus'];
    _needPopularityValue = json['needPopularityValue'];
    if (json['audioList'] != null) {
      _audioList = <AudioList>[];
      (json['audioList'] as List).forEach((v) {
        _audioList!.add(AudioList.fromJson(v));
      });
    }
  }

  num? _unlockStatus;
  num? _needPopularityValue;
  List<AudioList>? _audioList;

  RoleAudio copyWith({
    num? unlockStatus,
    num? needPopularityValue,
    List<AudioList>? audioList,
  }) =>
      RoleAudio(
        unlockStatus: unlockStatus ?? _unlockStatus,
        needPopularityValue: needPopularityValue ?? _needPopularityValue,
        audioList: audioList ?? _audioList,
      );

  num? get unlockStatus => _unlockStatus;

  num? get needPopularityValue => _needPopularityValue;

  List<AudioList>? get audioList => _audioList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['unlockStatus'] = _unlockStatus;
    map['needPopularityValue'] = _needPopularityValue;
    if (_audioList != null) {
      map['audioList'] = _audioList!.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// text : "那是一个非常重要的日子，天气很好，阳光明媚，似乎代表着有好事发生，因为那天是我去学校领小学最后一份成绩报告单的日子。等了七天，所有人都期待着……"
/// audioUrl : "https://bookcdn.xxsypro.com/audio/roleAudio_1673523611063.mp3"
/// unlockStatus : 2
/// unlockTime : 0
/// likeCount : 2
/// selfLike : false
/// ugcId : "830881469353754624"
/// duration : 20
/// cbid : "22436383000317602"
/// qurl : "unitexxreader://nativepage/client/readepage?bid=22436383000317602&ccid=43960985287375514¶Index=2&noHistory=1"
/// unAudioMsg : ""
/// ccid : "43960985287375514"
/// paraIndex : 2
/// replyCount : 0
/// iconUrl : "https://bookcdn.xxsypro.com/roleImage/2fd6c923291e519945e332f5b241bc8e.png"
/// goldShareUrl : "https://oah5.xxsypro.com/share/roleAudio?roleId=49674968438577191&inviterId=813100107257&audioId=21"
/// nickname : "西瓜好可爱"
/// cv : "轻薄的假相"
/// id : 21

class AudioList {
  AudioList({
    String? text,
    String? audioUrl,
    num? unlockStatus,
    num? unlockTime,
    num? likeCount,
    bool? selfLike,
    String? ugcId,
    num? duration,
    String? cbid,
    String? qurl,
    String? unAudioMsg,
    String? ccid,
    num? paraIndex,
    num? replyCount,
    String? iconUrl,
    String? goldShareUrl,
    String? nickname,
    String? cv,
    num? id,
  }) {
    _text = text;
    _audioUrl = audioUrl;
    _unlockStatus = unlockStatus;
    _unlockTime = unlockTime;
    _likeCount = likeCount;
    _selfLike = selfLike;
    _ugcId = ugcId;
    _duration = duration;
    _cbid = cbid;
    _qurl = qurl;
    _unAudioMsg = unAudioMsg;
    _ccid = ccid;
    _paraIndex = paraIndex;
    _replyCount = replyCount;
    _iconUrl = iconUrl;
    _goldShareUrl = goldShareUrl;
    _nickname = nickname;
    _cv = cv;
    _id = id;
  }

  AudioList.fromJson(dynamic json) {
    _text = json['text'];
    _audioUrl = json['audioUrl'];
    _unlockStatus = json['unlockStatus'];
    _unlockTime = json['unlockTime'];
    _likeCount = json['likeCount'];
    _selfLike = json['selfLike'];
    _ugcId = json['ugcId'];
    _duration = json['duration'];
    _cbid = json['cbid'];
    _qurl = json['qurl'];
    _unAudioMsg = json['unAudioMsg'];
    _ccid = json['ccid'];
    _paraIndex = json['paraIndex'];
    _replyCount = json['replyCount'];
    _iconUrl = json['iconUrl'];
    _goldShareUrl = json['goldShareUrl'];
    _nickname = json['nickname'];
    _cv = json['cv'];
    _id = json['id'];
  }

  String? _text;
  String? _audioUrl;
  num? _unlockStatus;
  num? _unlockTime;
  num? _likeCount;
  bool? _selfLike;
  String? _ugcId;
  num? _duration;
  String? _cbid;
  String? _qurl;
  String? _unAudioMsg;
  String? _ccid;
  num? _paraIndex;
  num? _replyCount;
  String? _iconUrl;
  String? _goldShareUrl;
  String? _nickname;
  String? _cv;
  num? _id;

  AudioList copyWith({
    String? text,
    String? audioUrl,
    num? unlockStatus,
    num? unlockTime,
    num? likeCount,
    bool? selfLike,
    String? ugcId,
    num? duration,
    String? cbid,
    String? qurl,
    String? unAudioMsg,
    String? ccid,
    num? paraIndex,
    num? replyCount,
    String? iconUrl,
    String? goldShareUrl,
    String? nickname,
    String? cv,
    num? id,
  }) =>
      AudioList(
        text: text ?? _text,
        audioUrl: audioUrl ?? _audioUrl,
        unlockStatus: unlockStatus ?? _unlockStatus,
        unlockTime: unlockTime ?? _unlockTime,
        likeCount: likeCount ?? _likeCount,
        selfLike: selfLike ?? _selfLike,
        ugcId: ugcId ?? _ugcId,
        duration: duration ?? _duration,
        cbid: cbid ?? _cbid,
        qurl: qurl ?? _qurl,
        unAudioMsg: unAudioMsg ?? _unAudioMsg,
        ccid: ccid ?? _ccid,
        paraIndex: paraIndex ?? _paraIndex,
        replyCount: replyCount ?? _replyCount,
        iconUrl: iconUrl ?? _iconUrl,
        goldShareUrl: goldShareUrl ?? _goldShareUrl,
        nickname: nickname ?? _nickname,
        cv: cv ?? _cv,
        id: id ?? _id,
      );

  String? get text => _text;

  String? get audioUrl => _audioUrl;

  num? get unlockStatus => _unlockStatus;

  num? get unlockTime => _unlockTime;

  num? get likeCount => _likeCount;

  bool? get selfLike => _selfLike;

  String? get ugcId => _ugcId;

  num? get duration => _duration;

  String? get cbid => _cbid;

  String? get qurl => _qurl;

  String? get unAudioMsg => _unAudioMsg;

  String? get ccid => _ccid;

  num? get paraIndex => _paraIndex;

  num? get replyCount => _replyCount;

  String? get iconUrl => _iconUrl;

  String? get goldShareUrl => _goldShareUrl;

  String? get nickname => _nickname;

  String? get cv => _cv;

  num? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['text'] = _text;
    map['audioUrl'] = _audioUrl;
    map['unlockStatus'] = _unlockStatus;
    map['unlockTime'] = _unlockTime;
    map['likeCount'] = _likeCount;
    map['selfLike'] = _selfLike;
    map['ugcId'] = _ugcId;
    map['duration'] = _duration;
    map['cbid'] = _cbid;
    map['qurl'] = _qurl;
    map['unAudioMsg'] = _unAudioMsg;
    map['ccid'] = _ccid;
    map['paraIndex'] = _paraIndex;
    map['replyCount'] = _replyCount;
    map['iconUrl'] = _iconUrl;
    map['goldShareUrl'] = _goldShareUrl;
    map['nickname'] = _nickname;
    map['cv'] = _cv;
    map['id'] = _id;
    return map;
  }
}

/// unlockStatus : 8
/// needPopularityValue : 0
/// infoList : [{"desc":"姓名","text":"已解锁未上线的"},{"desc":"角色","text":"主角"},{"desc":"别称","text":"茶茶"},{"desc":"身高","text":"188"},{"desc":"体重","text":"70kg"},{"desc":"生日","text":"农历1月1号"}]
/// extendInfoList : [{"desc":"身份","text":"二级男主"},{"desc":"性格","text":"茶里茶气"},{"desc":"爱好","text":"干饭，打人，怕黑，爱喝酒，睡觉，说大话，爱好1，爱好2，爱好3，爱好4，巴黎巴黎"},{"desc":"技能点","text":"干饭达人，技能超级多，都多大打击的啊，大号的大姐大啊擦办法哈哈，发打卡说大话，阿汉发ships啊是"},{"desc":"外貌特征","text":"已解锁未上线，就是很有特点的外貌，天下难找啊。英俊潇洒，爱着紫衣英俊潇洒，爱着紫衣英俊潇洒，爱着紫衣\n"}]

class FileInfo {
  FileInfo({
    num? unlockStatus,
    num? needPopularityValue,
    List<InfoList>? infoList,
    List<ExtendInfoList>? extendInfoList,
  }) {
    _unlockStatus = unlockStatus;
    _needPopularityValue = needPopularityValue;
    _infoList = infoList;
    _extendInfoList = extendInfoList;
  }

  FileInfo.fromJson(dynamic json) {
    _unlockStatus = json['unlockStatus'];
    _needPopularityValue = json['needPopularityValue'];
    if (json['infoList'] != null) {
      _infoList = <InfoList>[];
      (json['infoList'] as List).forEach((v) {
        _infoList!.add(InfoList.fromJson(v));
      });
    }
    if (json['extendInfoList'] != null) {
      _extendInfoList = <ExtendInfoList>[];
      (json['extendInfoList'] as List).forEach((v) {
        _extendInfoList!.add(ExtendInfoList.fromJson(v));
      });
    }
  }

  num? _unlockStatus;
  num? _needPopularityValue;
  List<InfoList>? _infoList;
  List<ExtendInfoList>? _extendInfoList;

  FileInfo copyWith({
    num? unlockStatus,
    num? needPopularityValue,
    List<InfoList>? infoList,
    List<ExtendInfoList>? extendInfoList,
  }) =>
      FileInfo(
        unlockStatus: unlockStatus ?? _unlockStatus,
        needPopularityValue: needPopularityValue ?? _needPopularityValue,
        infoList: infoList ?? _infoList,
        extendInfoList: extendInfoList ?? _extendInfoList,
      );

  num? get unlockStatus => _unlockStatus;

  num? get needPopularityValue => _needPopularityValue;

  List<InfoList>? get infoList => _infoList;

  List<ExtendInfoList>? get extendInfoList => _extendInfoList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['unlockStatus'] = _unlockStatus;
    map['needPopularityValue'] = _needPopularityValue;
    if (_infoList != null) {
      map['infoList'] = _infoList!.map((v) => v.toJson()).toList();
    }
    if (_extendInfoList != null) {
      map['extendInfoList'] = _extendInfoList!.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class ExtendInfoList {
  ExtendInfoList({
    String? desc,
    String? text,
  }) {
    _desc = desc;
    _text = text;
  }

  ExtendInfoList.fromJson(dynamic json) {
    _desc = json['desc'];
    _text = json['text'];
  }

  String? _desc;
  String? _text;

  ExtendInfoList copyWith({
    String? desc,
    String? text,
  }) =>
      ExtendInfoList(
        desc: desc ?? _desc,
        text: text ?? _text,
      );

  String? get desc => _desc;

  String? get text => _text;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['desc'] = _desc;
    map['text'] = _text;
    return map;
  }
}

class InfoList {
  InfoList({
    String? desc,
    String? text,
  }) {
    _desc = desc;
    _text = text;
  }

  InfoList.fromJson(dynamic json) {
    _desc = json['desc'];
    _text = json['text'];
  }

  String? _desc;
  String? _text;

  InfoList copyWith({
    String? desc,
    String? text,
  }) =>
      InfoList(
        desc: desc ?? _desc,
        text: text ?? _text,
      );

  String? get desc => _desc;

  String? get text => _text;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['desc'] = _desc;
    map['text'] = _text;
    return map;
  }
}
