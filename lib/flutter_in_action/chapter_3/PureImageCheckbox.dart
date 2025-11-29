import 'package:flutter/material.dart';

///
/// Created by p_dmweidu on 2025/11/26
/// Desc: 3.6 自定义图片复选框组件
///
class PureImageCheckbox extends StatefulWidget {

  // 必传：未选中图片路径（本地资源，如 "images/unchecked.png"）
  final String uncheckedImagePath;
  // 必传：选中图片路径（本地资源，如 "images/checked.png"）
  final String checkedImagePath;
  // 可选：图片宽度（默认 24px）
  final double imageWidth;
  // 可选：图片高度（默认 24px）
  final double imageHeight;
  // 可选：初始选中状态（默认 false）
  final bool initialChecked;
  // 可选：是否禁用（默认 false）
  final bool isDisabled;
  // 可选：选中状态变化回调（用于向父组件传递状态）
  final ValueChanged<bool>? onCheckedChanged;

  // 构造函数：必传路径，其他参数可选
  const PureImageCheckbox({
    super.key,
    required this.uncheckedImagePath,
    required this.checkedImagePath,
    this.imageWidth = 24.0,
    this.imageHeight = 24.0,
    this.initialChecked = false,
    this.isDisabled = false,
    this.onCheckedChanged,
  });

  @override
  State<PureImageCheckbox> createState() => _PureImageCheckboxState();
}

class _PureImageCheckboxState extends State<PureImageCheckbox> {

  late bool _isChecked; // 选中状态（延迟初始化，使用 widget.initialChecked）

  @override
  void initState() {
    super.initState();
    // 初始化选中状态（从外部传入的 initialChecked 获取）
    _isChecked = widget.initialChecked;
  }

  // 构建图片 Widget（根据状态和禁用状态选择图片）
  Widget _buildCheckboxImage() {
    String imagePath = _isChecked ? widget.checkedImagePath : widget.uncheckedImagePath;

    // 基础图片（本地资源）
    Widget image = Image.asset(
      imagePath,
      width: widget.imageWidth,
      height: widget.imageHeight,
      fit: BoxFit.contain, // 保持图片比例，避免拉伸
      errorBuilder: (context, error, stackTrace) {
        // 图片加载失败时显示默认图标（兜底）
        return Icon(
          _isChecked ? Icons.check_box : Icons.check_box_outline_blank,
          size: widget.imageWidth,
          color: Colors.grey,
        );
      },
    );

    // 禁用状态：图片置灰
    if (widget.isDisabled) {
      return ColorFiltered(
        colorFilter: ColorFilter.mode(
          Colors.grey[400]!,
          BlendMode.saturation, // 饱和度为 0，实现置灰效果
        ),
        child: image,
      );
    }

    return image;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 禁用时不可点击
      onTap: widget.isDisabled
          ? null
          : () {
        // 切换选中状态
        setState(() {
          _isChecked = !_isChecked;
        });
        // 回调通知父组件状态变化
        widget.onCheckedChanged?.call(_isChecked);
      },
      child: InkWell(
        // 水波纹点击反馈（可选，贴近原生体验）
        borderRadius: BorderRadius.circular(widget.imageWidth / 4), // 水波纹圆角（适配图片大小）
        splashColor: Colors.grey[200], // 水波纹颜色
        child: Container(
          padding: const EdgeInsets.all(4), // 图片边距（避免点击区域过小）
          child: _buildCheckboxImage(),
        ),
      ),
    );
  }
}