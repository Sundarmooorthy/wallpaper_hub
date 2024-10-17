import 'package:flutter/material.dart';
import 'package:wallpaper_hub/my_app_exports.dart';
import 'package:wallpaper_hub/res/app_text_style.dart';

class CommonElevatedButton extends StatelessWidget {
  final String? text;
  final TextStyle? textStyle;
  final VoidCallback? onPressed;
  final ButtonStyle? style;
  final Color? textColor;
  final Color? bgColor;
  final Widget? icon;
  final double? width;
  final double? height;
  final bool isLoading;

  CommonElevatedButton({
    super.key,
    this.text,
    this.textStyle,
    this.onPressed,
    this.style,
    this.icon,
    this.width,
    this.height,
    this.textColor = Colors.white,
    this.bgColor = Colors.orange,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: style ??
            ElevatedButton.styleFrom(
              backgroundColor: bgColor,
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(50), // Default border radius
              ),
            ),
        child: icon != null
            ? isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        icon!,
                        const SizedBox(
                            width: 8), // Spacing between icon and text
                        if (text != null)
                          Text(
                            text!,
                            style: textStyle ??
                                const TextStyle(
                                    fontSize: 16), // Default text style
                          ),
                      ],
                    ),
                  )
            : (text != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    child: Text(
                      text!,
                      style: textStyle ??
                          AppTextStyle.semiBold16(
                              color: textColor), // Default text style
                    ),
                  )
                : const SizedBox.shrink()),
      ),
    );
  }
}
