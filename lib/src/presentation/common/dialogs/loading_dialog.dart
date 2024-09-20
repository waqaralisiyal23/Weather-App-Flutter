import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../di/injector.dart';
import '../constants/app_colors.dart';
import '../constants/route_constants.dart';
import '../routes/navigation_route.dart';

Future<void> showLoadingDialog(BuildContext context) async {
  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Center(
        child: LoadingAnimationWidget.inkDrop(
          color: AppColors.primary,
          size: 100.w,
        ),
      );
    },
  );
}

hideLoadingDialog(BuildContext context) {
  getIt<NavigationRoute>().pop(
    context,
    previousScreen: RouteConstants.loadingDialog,
  );
}
