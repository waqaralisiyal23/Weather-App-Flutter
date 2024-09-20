import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../di/injector.dart';
import '../../common/components/app_text.dart';
import '../../common/constants/app_images.dart';
import '../../common/constants/route_constants.dart';
import '../../common/routes/navigation_route.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        getIt<NavigationRoute>()
            .popAllAndPush(context, RouteConstants.weatherRoute);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 100.r,
                backgroundImage: const AssetImage(AppImages.appLogo),
              ),
              28.verticalSpace,
              AppText(
                AppConstants.appName,
                fontSize: 28.sp,
              ),
              60.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
