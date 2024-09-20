import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_colors.dart';
import 'app_text.dart';

class AppButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final double? fontSize;
  final FontWeight fontWeight;
  final Color textColor;
  final Color backgroundColor;
  final EdgeInsetsGeometry? padding;
  final double? elevation;
  final BorderRadiusGeometry? borderRadius;
  final bool isOutlined;
  final Color borderColor;
  final double? borderWidth;
  final Widget? leading;
  final double? leadingIconGap;
  final bool isExpand;
  final double? width;
  const AppButton({
    super.key,
    this.onPressed,
    required this.text,
    this.fontSize,
    this.fontWeight = FontWeight.w600,
    this.textColor = AppColors.white,
    this.backgroundColor = AppColors.primary,
    this.padding,
    this.elevation = 0,
    this.borderRadius,
    this.isOutlined = false,
    this.borderColor = AppColors.primary,
    this.borderWidth,
    this.leading,
    this.leadingIconGap,
    this.isExpand = true,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return isExpand || width != null
        ? SizedBox(
            width: width ?? double.infinity,
            child: _buildButton(),
          )
        : _buildButton();
  }

  Widget _buildButton() {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        splashFactory: NoSplash.splashFactory,
        shadowColor: AppColors.transparent,
        backgroundColor: isOutlined ? AppColors.transparent : backgroundColor,
        padding:
            padding ?? EdgeInsets.symmetric(vertical: 12.h, horizontal: 28.w),
        elevation: isOutlined ? 0 : elevation,
        foregroundColor: isOutlined
            ? AppColors.white.withOpacity(0.00001)
            : backgroundColor.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(24.r),
          side: isOutlined
              ? BorderSide(
                  color: borderColor,
                  width: borderWidth ?? 1.w,
                )
              : BorderSide.none,
        ),
      ),
      child: leading != null
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: leadingIconGap ?? 12.w),
                  child: leading!,
                ),
                _buildText(),
              ],
            )
          : _buildText(),
    );
  }

  Widget _buildText() {
    return AppText(
      text,
      fontSize: fontSize ?? 14.sp,
      fontWeight: fontWeight,
      color: textColor,
    );
  }
}
