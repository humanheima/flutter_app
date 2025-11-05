import 'package:flutter/material.dart';

import '../../model/HomeResponse.dart';

///
///列表项：推荐人物卡片
///
class CharacterCard extends StatelessWidget {
  final Character character; // 接收Character数据

  const CharacterCard({
    super.key,
    required this.character,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.purple.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            // 渐变背景容器
            width: 110,
            height: 144,
            decoration: BoxDecoration(
              // 圆角设置
              borderRadius: BorderRadius.circular(12),
              // 左上到右下的渐变色
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF4158D0),
                  Color(0xFFC850C0),
                  Color(0xFFFFCC70),
                ],
              ),
            ),
            // 图片容器 - 向右向下偏移4像素
            child: Transform.translate(
              offset: const Offset(4, 4), // 偏移量：x=4, y=4
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: FadeInImage.assetNetwork(
                    width: 106,
                    height: 140,
                    placeholder: "images/image_default.png",
                    imageErrorBuilder: (_, __, ___) {
                      return Image.asset(
                        "images/image_default.png",
                        width: 106,
                        height: 140,
                        fit: BoxFit.fitWidth,
                      );
                    },
                    fit: BoxFit.cover,
                    image: character.avatar ?? ""),
              ),
            ),
          ),

          const SizedBox(width: 12),
          // 信息区域
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 名称+性别图标
                Row(
                  children: [
                    Text(
                      character.name, // 使用数据中的名称
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      // 根据性别显示不同图标
                      character.isMale() ? Icons.male : Icons.female,
                      color: character.isMale() ? Colors.blue : Colors.pink,
                      size: 16,
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                // 标签列表（动态生成）
                Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  children: character.tagList
                      .map((tag) => _buildTag(tag)) // 遍历标签列表生成标签
                      .toList(),
                ),
                const SizedBox(height: 8),
                // 描述文本
                Text(
                  character.otherSetting, // 使用数据中的描述
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                    height: 1.4,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                // 底部统计信息
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildStat(
                        '入梦${character.chatUserCount} 梦境${character.memoryCount} 小剧场${character.storyCount}'),
                    // 入梦次数
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 构建标签组件
  Widget _buildTag(TagInfo tag) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.pink.withOpacity(0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        tag.tagName,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.pink,
        ),
      ),
    );
  }

  // 构建统计项组件
  Widget _buildStat(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 12,
        color: Colors.black54,
      ),
    );
  }
}
