// import 'package:ecommerce_app/resources/app_colours.dart';
import 'dart:developer' as dev;

import 'package:ecommerce_app/screens/auth/login/login_viewmodel.dart';
import 'package:ecommerce_app/screens/auth/login/widget/login_form.dart';
import 'package:ecommerce_app/app/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginViewModel(),
      child: Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
              children: [
                20.verticalSpace,
                Align(
                  alignment: Alignment.topLeft,
                  child: SvgPicture.asset('assets/svgs/vector.svg'),
                ),
                50.verticalSpace,
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    'Welcome Back to \n Mega Mail',
                    style: TextStyle(
                      color: const Color(0xFF0C1A30),
                      fontWeight: FontWeight.w600,
                      fontSize: 35.sp,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Enter your details to login!',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: const Color(0xFF838589),
                    fontSize: 14.sp,
                  ),
                ),
                50.verticalSpace,
                const LoginForm(),
                SizedBox(height: 50),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Forgot Password',
                      style: TextStyle(
                        color: const Color(0xFF0C1A30),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        dev.log('🔄 NAVIGATING to signup screen from login', name: 'NAVIGATION');
                        Get.toNamed(Routes.signup);
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(color: Colors.lightBlue, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      ),
    );
  }
}
