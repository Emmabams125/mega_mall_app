import 'dart:developer' as dev;
import 'package:ecommerce_app/screens/auth/sign_up/signup_viewmodel.dart';
import 'package:ecommerce_app/screens/auth/sign_up/widgets/signup_form.dart';
import 'package:ecommerce_app/app/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SignupViewModel(),
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
                    'Register Account',
                    style: TextStyle(
                      color: const Color(0xFF0C1A30),
                      fontWeight: FontWeight.w600,
                      fontSize: 35.sp,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),

                const SignupForm(),
                SizedBox(height: 50),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: TextStyle(
                        color: const Color(0xFF838589),
                        fontSize: 14.sp,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        dev.log('🔄 NAVIGATING to login screen from signup', name: 'NAVIGATION');
                        Get.toNamed(Routes.login);
                      },
                      child: Text(
                        'Sign In',
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
