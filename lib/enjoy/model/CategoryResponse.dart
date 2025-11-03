import 'dart:convert';

///
///
class CategoryResponse {
  final int code;
  final String msg;
  final CategoryData data;
  final bool success;

  CategoryResponse({
    required this.code,
    required this.msg,
    required this.data,
    required this.success,
  });

  factory CategoryResponse.fromJson(Map<String, dynamic> json) {
    return CategoryResponse(
      code: json['code'] as int,
      msg: json['msg'] as String,
      data: CategoryData.fromJson(json['data'] as Map<String, dynamic>),
      success: json['success'] as bool,
    );
  }

  // 新增：将整个 CategoryResponse 转换为 Map
  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'msg': msg,
      'data': data.toJson(),
      'success': success,
    };
  }

  // 新增：返回 JSON 字符串，支持 pretty 输出
  String toJsonString({bool pretty = false}) {
    if (pretty) {
      return const JsonEncoder.withIndent('  ').convert(toJson());
    }
    return jsonEncode(toJson());
  }

  @override
  String toString() => toJsonString();
}

class CategoryData {
  final List<RecCategory> recCategoryList;

  CategoryData({required this.recCategoryList});

  factory CategoryData.fromJson(Map<String, dynamic> json) {
    var list = json['recCategoryList'] as List;
    List<RecCategory> categoryList = list
        .map((i) => RecCategory.fromJson(i as Map<String, dynamic>))
        .toList();

    return CategoryData(
      recCategoryList: categoryList,
    );
  }

  // 新增：将 CategoryData 转换为 Map
  Map<String, dynamic> toJson() {
    return {
      'recCategoryList': recCategoryList.map((c) => c.toJson()).toList(),
    };
  }

  // 新增：返回 JSON 字符串，支持 pretty 输出
  String toJsonString({bool pretty = false}) {
    if (pretty) {
      return const JsonEncoder.withIndent('  ').convert(toJson());
    }
    return jsonEncode(toJson());
  }

  @override
  String toString() => toJsonString();
}

class RecCategory {
  final String category;
  final String categoryId;

  RecCategory({
    required this.category,
    required this.categoryId,
  });

  factory RecCategory.fromJson(Map<String, dynamic> json) {
    return RecCategory(
      category: json['category'] as String,
      categoryId: json['categoryId'] as String,
    );
  }

  // 新增：将 RecCategory 转换为 JSON 的方法
  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'categoryId': categoryId,
    };
  }

  // 新增：返回 JSON 字符串，支持 pretty 输出
  String toJsonString({bool pretty = false}) {
    if (pretty) {
      return const JsonEncoder.withIndent('  ').convert(toJson());
    }
    return jsonEncode(toJson());
  }

  @override
  String toString() => toJsonString();
}
