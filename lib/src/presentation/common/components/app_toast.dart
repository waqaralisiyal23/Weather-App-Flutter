import 'package:fluttertoast/fluttertoast.dart';

import '../constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_vectors.dart';
import 'app_svg.dart';
import 'app_text.dart';

enum ToastType { success, error, warning, info }

class AppToast {
  static void showToast(
    BuildContext context,
    String message, {
    bool makeToastPositionTop = true,
    bool extendDuration = false,
    ToastType type = ToastType.error,
    Duration? toastDuration,
    final Color backgroundColor = AppColors.primary,
    final Color textColor = AppColors.white,
    final double? borderRadius,
    final EdgeInsetsGeometry? padding,
    final Widget? leadingWidget,
    final Widget? trailingWidget,
  }) {
    final fToast = FToast()..init(context);
    final Widget toast = Container(
      width: 1.sw,
      padding:
          padding ?? EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
        color: backgroundColor,
      ),
      child: Row(
        children: [
          if (leadingWidget != null) leadingWidget,
          Expanded(
            child: AppText(
              message,
              maxLines: 3,
              overflow: TextOverflow.clip,
              color: textColor,
            ),
          ),
          12.horizontalSpace,
          trailingWidget ??
              GestureDetector(
                onTap: () {
                  fToast.removeCustomToast();
                },
                child: AppSvg(
                  AppVectors.cross,
                  color: textColor,
                ),
              ),
        ],
      ),
    );
    fToast.showToast(
      child: toast,
      gravity: makeToastPositionTop ? ToastGravity.TOP : ToastGravity.BOTTOM,
      toastDuration: toastDuration ?? Duration(seconds: extendDuration ? 5 : 3),
    );
  }

  static void showErrorToast(BuildContext context, String message) {
    showToast(context, message, backgroundColor: AppColors.error10);
  }
}
