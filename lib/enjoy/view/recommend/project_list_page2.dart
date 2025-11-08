import 'package:flutter/material.dart';
import 'package:flutter_app/enjoy/manager/api_manager.dart';

import '../../model/HomeResponse.dart';
import 'CharacterCard.dart';
import 'recommend_banner.dart';

///
/// Created by dumingwei on 2019/4/4. 不敢想象，这是6年前创建的文件了。Amazing！
/// Desc: 项目列表页
///

class ProjectListPage2 extends StatefulWidget {
  final String cid;

  //final String cid;

  ProjectListPage2({this.cid = "0"});

  @override
  State createState() {
    return _ProjectListState();
  }
}

class _ProjectListState extends State<ProjectListPage2>
    with AutomaticKeepAliveClientMixin {
  static const TAG = "ProjectListPage2";

  // 筛选的标签名
  String? tagName;

  // 筛选的排序方式
  String? sortType;

  // 页码（从1开始）
  int pageNum = 0;

  HomeData? mHomeData;
  List<RecBanner> _banners = <RecBanner>[];

  List<Character> projects = <Character>[];

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    getList(loadMore: false);

    ///处理加载更多的逻辑
    _scrollController.addListener(() {
      var maxScroll = _scrollController.position.maxScrollExtent;
      var pixels = _scrollController.position.pixels;
      if (maxScroll == pixels) {
        getList(loadMore: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // 使用 RefreshIndicator 包裹 ListView，实现下拉刷新
    return RefreshIndicator(
        onRefresh: _handleRefresh,
        child: CustomScrollView(controller: _scrollController, slivers: [
          // 固定组件
          SliverToBoxAdapter(
            child: Align(
              alignment: Alignment.centerLeft, // 改为 Alignment.center 以居中显示
              child: SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  height: 124,
                  child: Padding(
                    padding: EdgeInsets.all(2),
                    child: Row(
                      children: [
                        RecommendBanner(banners: _banners, height: 124),
                        Text('推荐人物',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  )),
            ),
          ),

          SliverToBoxAdapter(
              child: Container(
            height: 60,
            color: Colors.orange,
            child: Center(
              child: Text('固定组件'),
            ),
          )),
          SliverToBoxAdapter(
              child: Container(
            height: 60,
            color: Colors.red,
            child: Center(
              child: Text('固定组件'),
            ),
          )),

          if (projects.isEmpty)
            const SliverToBoxAdapter(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('暂无数据'),
                ),
              ),
            )
          else
            SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
              return CharacterCard(character: projects[index]);
            }, childCount: projects.length))
        ]));
  }

  /// 下拉刷新回调
  Future<void> _handleRefresh() async {
    // 重置为第一页（page 从1开始），然后重新请求
    setState(() {
      pageNum = 0; // getList 会把非加载更多的情况视为第一页
      _banners.clear();
      mHomeData = null;
    });
    await getList(loadMore: false);
  }

  /// 发起网络请求，获取项目列表
  Future<void> getList({bool loadMore = false}) async {
    // 使用新的 getCharacterDiscovery 接口，传入分页和筛选参数
    try {
      // 当不是加载更多时，我们需要请求第1页；当加载更多时，pageNum+1
      var currentPage = loadMore ? pageNum + 1 : 1;

      print("$TAG currentPage = $currentPage loadMore=$loadMore");

      final response = await ApiManager().getCharacterDiscovery(
          sort: sortType ?? '',
          tagName: tagName ?? '',
          recPageNum: currentPage);

      var homeResponse = HomeResponse.fromJson(response.data);

      var projectListBean = homeResponse.data.character?.list ?? <Character>[];

      setState(() {
        if (mHomeData == null) {
          print("$TAG 首次加载，保存 mHomeData");
          mHomeData = homeResponse.data;
          List<RecBanner> banners =
              mHomeData?.noticeInfo?.banner ?? <RecBanner>[];
          _banners.clear();
          _banners.addAll(banners);
        }
        pageNum = currentPage;
        if (loadMore) {
          // 加载更多时，页码已经在外部增加
          projects.addAll(projectListBean);
          // 下一页
        } else {
          // 非加载更多时，重置页码为1
          projects.clear();
          projects.addAll(projectListBean);
        }
      });
    } catch (e) {
      // 可以在此处理错误或提示用户
      rethrow;
    }
  }

  @override
  bool get wantKeepAlive => true;
}
