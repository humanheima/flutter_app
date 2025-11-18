import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

/// 我的作品页面
class StaggeredGridViewDemoPage extends StatefulWidget {
  const StaggeredGridViewDemoPage({Key? key}) : super(key: key);

  @override
  State<StaggeredGridViewDemoPage> createState() =>
      _StaggeredGridViewDemoPageState();
}

class _StaggeredGridViewDemoPageState extends State<StaggeredGridViewDemoPage> {
  final ScrollController _scrollController = ScrollController();
  final List<WorkItem> _works = [];
  bool _isLoading = false;
  bool _hasMoreData = true;

  // 模拟的作品数据
  // 标题 mock，极短和极长混合
  final List<String> _mockTitles = [
    '罢工',
    '魔王',
    '高手',
    '都市修仙',
    '大亨',
    '恋爱物语',
    '机甲战士',
    '学院日常',
    '末世求生',
    '宫廷秘史',
    '超级无敌爆笑穿越异界成为魔王的日常生活与成长故事',
    '都市修仙传说之少年逆袭成长史，热血与友情并存',
    '重生之商业大亨的崛起与跌宕起伏的创业人生',
    '魔法学院日常生活点滴，友情、爱情与魔法的交织',
    '古风宫廷秘史：一个宫女的逆袭之路，权谋与情感的较量',
    '末世求生指南：人类在废土中的生存法则与希望',
    '机甲战士传奇：未来世界的少年驾驶员成长之路',
    '仙侠恋爱物语：跨越种族的浪漫传奇',
    '校花的贴身高手：普通学生意外获得超能力，守护校花的故事',
    '孟婆今天也想罢工：仙侠地府，爱恨情仇，白无常办错了事情',
  ];

  // 描述 mock，极短和极长混合
  final List<String> _mockDescriptions = [
    '一部作品。',
    '很短的描述。',
    '热血成长。',
    '逆袭。',
    '创业人生。',
    '友情并存。',
    '魔法交织。',
    '权谋较量。',
    '生存法则。',
    '少年成长。',
    '跨越种族。',
    '守护校花。',
    '仙侠地府。',
    '这是一个关于友情、成长、逆袭和梦想的故事，主角在经历了无数挫折后终于实现了自己的目标。',
    '在未来的世界里，少年驾驶着机甲与敌人战斗，经历了友情、背叛和成长，最终成为了传奇战士。',
    '古风宫廷秘史，讲述一个宫女如何在权谋斗争中逆袭，最终获得自由与幸福。',
    '末世来临，人类在废土中挣扎求生，主角带领团队寻找希望与新生。',
    '魔法学院的日常生活充满欢声笑语，学生们在学习魔法的同时也收获了珍贵的友谊和爱情。',
    '重生回到过去，利用前世记忆创建商业帝国，经历了无数风雨，最终成为商业巨头。',
    '仙侠恋爱物语，跨越种族的浪漫传奇，主角与爱人共同面对各种挑战，最终走到一起。',
    '普通学生意外获得超能力，守护校花的故事，充满了青春、热血和感动。',
    '仙侠地府，爱恨情仇，试图搞潜规则的白无常办错了事情，主角如何化解危机？',
    '现代都市中隐藏的修仙世界，一个少年的成长历程，既有热血也有温情。',
    '穿越到异界成为魔王，却发现这个世界并不简单，主角如何在异界生存？',
  ];

  // 模拟的封面图片URL（使用随机图片）
  final List<String> _mockImages = [
    'https://picsum.photos/300/400?random=1',
    'https://picsum.photos/300/450?random=2',
    'https://picsum.photos/300/380?random=3',
    'https://picsum.photos/300/420?random=4',
    'https://picsum.photos/300/460?random=5',
    'https://picsum.photos/300/390?random=6',
    'https://picsum.photos/300/440?random=7',
    'https://picsum.photos/300/410?random=8',
    'https://picsum.photos/300/470?random=9',
    'https://picsum.photos/300/400?random=10',
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _loadInitialData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // 监听滚动，实现加载更多
  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      if (!_isLoading && _hasMoreData) {
        _loadMoreData();
      }
    }
  }

  // 加载初始数据
  Future<void> _loadInitialData() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1)); // 模拟网络延迟

    final initialWorks = _generateMockWorks(10);
    setState(() {
      _works.addAll(initialWorks);
      _isLoading = false;
    });
  }

  // 下拉刷新
  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 1)); // 模拟网络延迟

    final newWorks = _generateMockWorks(10);
    setState(() {
      _works.clear();
      _works.addAll(newWorks);
      _hasMoreData = true;
    });
  }

  // 加载更多数据
  Future<void> _loadMoreData() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1)); // 模拟网络延迟

    final moreWorks = _generateMockWorks(6);
    setState(() {
      _works.addAll(moreWorks);
      _isLoading = false;
      // 模拟到达数据末尾
      if (_works.length >= 50) {
        _hasMoreData = false;
      }
    });
  }

  // 生成模拟数据
  List<WorkItem> _generateMockWorks(int count) {
    final Random random = Random();
    return List.generate(count, (index) {
      // 随机决定标题和描述长度
      String title;
      String description;
      if (random.nextBool()) {
        // 极短标题
        title = _mockTitles[random.nextInt(10)];
      } else {
        // 极长标题
        title = _mockTitles[10 + random.nextInt(_mockTitles.length - 10)];
      }
      if (random.nextBool()) {
        // 极短描述
        description = _mockDescriptions[random.nextInt(12)];
      } else {
        // 极长描述
        description = _mockDescriptions[
            12 + random.nextInt(_mockDescriptions.length - 12)];
      }
      final imageIndex = random.nextInt(_mockImages.length);

      return WorkItem(
        id: DateTime.now().millisecondsSinceEpoch.toString() + index.toString(),
        title: title,
        description: description,
        imageUrl: _mockImages[imageIndex],
        status: random.nextBool() ? WorkStatus.published : WorkStatus.draft,
        lastEditTime: DateTime.now().subtract(
          Duration(days: random.nextInt(30), hours: random.nextInt(24)),
        ),
        imageHeight: 350 + random.nextInt(100).toDouble(), // 随机高度实现瀑布流效果
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020203),
      appBar: _buildAppBar(),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        backgroundColor: const Color(0xFF1f1f20),
        color: const Color(0xFF80de4f),
        child: _buildBody(),
      ),
    );
  }

  // 构建AppBar
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFF020203),
      elevation: 0,
      leading: IconButton(
        icon: const Icon(
          Icons.chevron_left,
          color: Color(0xFFb0aeb6),
          size: 28,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: const Text(
        '我的作品',
        style: TextStyle(
          fontFamily: 'PingFang SC',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Color(0xFFf4f3f7),
        ),
      ),
      centerTitle: true,
    );
  }

  // 构建主体内容
  Widget _buildBody() {
    if (_works.isEmpty && _isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF80de4f)),
        ),
      );
    }

    // return QuiltedGridView();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: AlignedGridView.count(
        controller: _scrollController,
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 8,
        itemCount: _works.length + (_hasMoreData ? 1 : 0),
        itemBuilder: (context, index) {
          if (index >= _works.length) {
            // 加载更多指示器
            return _buildLoadMoreIndicator();
          }
          return _buildWorkCard(_works[index]);
        },
      ),
    );
  }

  // 构建作品卡片
  Widget _buildWorkCard(WorkItem work) {
    return GestureDetector(
      onTap: () => _onWorkTap(work),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1f1f20),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 封面图片和状态标签
            _buildCoverWithStatus(work),
            // 内容区域
            _buildContentArea(work),
          ],
        ),
      ),
    );
  }

  // 构建封面图片和状态标签
  Widget _buildCoverWithStatus(WorkItem work) {
    return Container(
      margin: const EdgeInsets.all(6).copyWith(bottom: 0),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: AspectRatio(
              aspectRatio: 146 / 193,
              child: Image.network(
                work.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: const Color(0xFF68666b),
                    child: const Icon(
                      Icons.image_not_supported_outlined,
                      color: Color(0xFFb0aeb6),
                      size: 48,
                    ),
                  );
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    color: const Color(0xFF68666b),
                    child: Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Color(0xFF80de4f),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          // 状态标签
          if (work.status != WorkStatus.none)
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: work.status == WorkStatus.published
                      ? const Color(0xFF80de4f)
                      : const Color(0xFF909399),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  work.status == WorkStatus.published ? '已发布' : '草稿',
                  style: const TextStyle(
                    fontFamily: 'PingFang SC',
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // 构建内容区域
  Widget _buildContentArea(WorkItem work) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 标题
          Text(
            work.title,
            style: const TextStyle(
              fontFamily: 'PingFang SC',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFFf4f3f7),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 6),
          // 描述
          Text(
            work.description,
            style: const TextStyle(
              fontFamily: 'PingFang SC',
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Color(0xFFb0aeb6),
              height: 1.33,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 6),
          // 编辑时间
          Text(
            _formatEditTime(work.lastEditTime),
            style: const TextStyle(
              fontFamily: 'PingFang SC',
              fontSize: 10,
              fontWeight: FontWeight.w400,
              color: Color(0xFF68666b),
            ),
          ),
        ],
      ),
    );
  }

  // 构建加载更多指示器
  Widget _buildLoadMoreIndicator() {
    return StaggeredGridTile.fit(
        crossAxisCellCount: 2,
        child: Container(
          height: 80,
          alignment: Alignment.center,
          child: _isLoading
              ? Center(
                  child: const CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Color(0xFF80de4f)),
                  ),
                )
              : const SizedBox.shrink(),
        ));
  }

  // 格式化编辑时间
  String _formatEditTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inDays > 0) {
      return '最近编辑 ${time.month.toString().padLeft(2, '0')}-${time.day.toString().padLeft(2, '0')} ${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    } else if (difference.inHours > 0) {
      return '最近编辑 ${difference.inHours}小时前';
    } else if (difference.inMinutes > 0) {
      return '最近编辑 ${difference.inMinutes}分钟前';
    } else {
      return '最近编辑 刚刚';
    }
  }

  // 处理卡片点击事件
  void _onWorkTap(WorkItem work) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1f1f20),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              work.title,
              style: const TextStyle(
                color: Color(0xFFf4f3f7),
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              work.description,
              style: const TextStyle(
                color: Color(0xFFb0aeb6),
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF80de4f),
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('编辑'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFFb0aeb6),
                      side: const BorderSide(color: Color(0xFFb0aeb6)),
                    ),
                    child: const Text('分享'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// 作品数据模型
class WorkItem {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final WorkStatus status;
  final DateTime lastEditTime;
  final double imageHeight;

  WorkItem({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.status,
    required this.lastEditTime,
    this.imageHeight = 400,
  });
}

// 作品状态枚举
enum WorkStatus {
  none, // 无状态
  draft, // 草稿
  published, // 已发布
}
