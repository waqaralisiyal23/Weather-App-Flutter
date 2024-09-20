import '../constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final bool? alignLabelWithHint;
  final String? labelText;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final Color? cursorColor;
  final bool obscureText;
  final bool autofocus;
  final bool readOnly;
  final bool? enabled;
  final EdgeInsetsGeometry? contentPadding;
  final bool? filled;
  final Color? fillColor;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Widget? suffix;
  final Widget? prefix;
  final void Function(String?)? onChanged;
  final void Function()? onTap;
  final void Function()? onEditingComplete;
  final FocusNode? focusNode;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatters;
  final InputBorder? border;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final double? borderRadius;
  const AppField({
    super.key,
    this.controller,
    this.hintText,
    this.alignLabelWithHint,
    this.labelText,
    this.hintStyle,
    this.labelStyle,
    this.textInputAction,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.cursorColor,
    this.obscureText = false,
    this.autofocus = false,
    this.readOnly = false,
    this.enabled = true,
    this.contentPadding,
    this.filled,
    this.fillColor,
    this.suffixIcon,
    this.prefixIcon,
    this.suffix,
    this.prefix,
    this.onChanged,
    this.onTap,
    this.onEditingComplete,
    this.focusNode,
    this.maxLines = 1,
    this.inputFormatters,
    this.border,
    this.enabledBorder,
    this.focusedBorder,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      cursorColor: cursorColor ?? AppColors.black,
      obscureText: obscureText,
      autofocus: autofocus,
      readOnly: readOnly,
      enabled: enabled,
      textInputAction: textInputAction,
      textCapitalization: textCapitalization,
      keyboardType: keyboardType,
      focusNode: focusNode,
      maxLines: maxLines,
      onChanged: onChanged,
      onTap: onTap,
      inputFormatters: inputFormatters,
      onEditingComplete: onEditingComplete,
      decoration: InputDecoration(
        hintText: hintText,
        alignLabelWithHint: alignLabelWithHint,
        labelText: labelText,
        contentPadding: contentPadding ??
            EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 12.h,
            ),
        hintStyle: hintStyle ??
            TextStyle(
              color: AppColors.grey100,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
        labelStyle: labelStyle ??
            TextStyle(
              color: AppColors.grey250,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
        filled: filled,
        fillColor: fillColor,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        suffix: suffix,
        prefix: prefix,
        border: border ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 5.r),
              borderSide: BorderSide(width: 1.w, color: AppColors.grey150),
            ),
        enabledBorder: enabledBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 5.r),
              borderSide: BorderSide(width: 1.w, color: AppColors.grey150),
            ),
        focusedBorder: focusedBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 5.r),
              borderSide: BorderSide(width: 1.w, color: AppColors.primary),
            ),
      ),
    );
  }
}
