import 'package:flutter/material.dart';
import 'basic_animation_example.dart';
import 'implicit_animation_example.dart';
import 'rotation_scale_animation_example.dart';
import 'position_animation_example.dart';
import 'color_animation_example.dart';
import 'custom_path_animation_example.dart';
import 'page_transition_example.dart';
import 'animated_list_example.dart';

///
/// Created by dumingwei on 2025/11/12
/// Desc: Flutter 动画示例主页
///
class AnimationMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter 动画示例'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _buildAnimationCard(
            context,
            title: '基础动画',
            subtitle: 'AnimationController + AnimatedBuilder',
            icon: Icons.play_circle_outline,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BasicAnimationExample()),
            ),
          ),
          _buildAnimationCard(
            context,
            title: '隐式动画',
            subtitle: 'AnimatedContainer, AnimatedOpacity 等',
            icon: Icons.auto_awesome,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ImplicitAnimationExample()),
            ),
          ),
          _buildAnimationCard(
            context,
            title: '旋转和缩放动画',
            subtitle: 'Transform.rotate, Transform.scale',
            icon: Icons.rotate_right,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => RotationScaleAnimationExample()),
            ),
          ),
          _buildAnimationCard(
            context,
            title: '位置移动动画',
            subtitle: 'SlideTransition, PositionedTransition',
            icon: Icons.open_with,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PositionAnimationExample()),
            ),
          ),
          _buildAnimationCard(
            context,
            title: '颜色渐变动画',
            subtitle: 'ColorTween, 渐变动画',
            icon: Icons.palette,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ColorAnimationExample()),
            ),
          ),
          _buildAnimationCard(
            context,
            title: '路径动画',
            subtitle: '自定义路径动画，圆形、心形、8字形',
            icon: Icons.timeline,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CustomPathAnimationExample()),
            ),
          ),
          _buildAnimationCard(
            context,
            title: '页面过渡动画',
            subtitle: '自定义页面切换动画',
            icon: Icons.swap_horiz,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PageTransitionExample()),
            ),
          ),
          _buildAnimationCard(
            context,
            title: '动画列表',
            subtitle: 'AnimatedList 添加删除动画',
            icon: Icons.list,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AnimatedListExample()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimationCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.only(bottom: 16),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(icon, color: Colors.white, size: 30),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Padding(
          padding: EdgeInsets.only(top: 8),
          child: Text(
            subtitle,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}
