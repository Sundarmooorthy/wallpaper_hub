import 'package:flutter/material.dart';
import 'package:wallpaper_hub/my_app_exports.dart';

class CommonIconButton extends StatelessWidget {
  final IconData? icon;
  final VoidCallback? onPressed;
  final String? tooltip;
  final String? text;
  final Color? color;
  final double? size;
  final bool isText;

  const CommonIconButton({
    super.key,
    this.icon,
    this.onPressed,
    this.tooltip,
    this.color,
    this.size,
    this.isText = false,
    this.text = 'text here',
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Row(
        children: [
          Icon(
            icon ?? Icons.info,
            color: color ?? Colors.black,
            size: size ?? 24.0,
          ),
          isText ? Gap(width: 5) : const SizedBox.shrink(),
          isText
              ? Text(
                  'Download',
                  style: AppTextStyle.semiBold16(),
                )
              : const SizedBox.shrink(),
        ],
      ),
      onPressed: onPressed ?? () {},
      tooltip: tooltip,
    );
  }
}
