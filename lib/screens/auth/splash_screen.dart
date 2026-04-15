import 'package:ecommerce_app/styles/app_colours.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../app/route_names.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    await Future.delayed(const Duration(seconds: 2));
    Get.offAllNamed(Routes.onboardingScreen);

    // if (_navigated) return; // ✅ prevents multiple calls
    // _navigated = true;

    // bool isOnboarded = HiveHelper.read(Keys.onBoarded) ?? false;
    // bool isLoggedIn = HiveHelper.read(Keys.token)?.toString().isNotEmpty ?? false;

    // if (!isOnboarded) {
    //   Get.offAllNamed(RoutesName.onbordingScreen);
    // } else if (!isLoggedIn) {
    //   Get.offAllNamed(RoutesName.loginScreen);
    // } else {
    //   Get.offAllNamed(RoutesName.bottomNavBar);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.primaryGreen, AppColors.primaryGreenDark],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/icons/home.png', width: 87.w, height: 87.h),
              Text(
                'HomeHaven',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 36.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
