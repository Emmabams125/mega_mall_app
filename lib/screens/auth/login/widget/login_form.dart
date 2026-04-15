import 'dart:developer' as dev;
import 'package:ecommerce_app/screens/auth/login/login_viewmodel.dart';
import 'package:ecommerce_app/styles/app_colours.dart';
import 'package:ecommerce_app/widgets/custom_app_button.dart';
import 'package:ecommerce_app/widgets/verical_label_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final obscurePasswordNotifier = ValueNotifier(true);

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    obscurePasswordNotifier.dispose();
    super.dispose();
  }

  void _submitForm(LoginViewModel viewModel) {
    dev.log('📝 LOGIN FORM SUBMITTED: Email: ${emailController.text}, Password: ${passwordController.text.isNotEmpty ? "****" : "empty"}', name: 'FORM');

    if (formKey.currentState!.validate()) {
      dev.log('✅ LOGIN FORM VALIDATION PASSED', name: 'FORM');
      viewModel.login(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } else {
      dev.log('❌ LOGIN FORM VALIDATION FAILED', name: 'FORM');
    }
  }

  @override
  void initState() {
    super.initState();

    emailController.addListener(() => setState(() {}));
    passwordController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginViewModel>(
      builder: (context, viewModel, _) {
        return Consumer<LoginViewModel>(
          builder: (context, viewModel, _) {
            return Form(
              key: formKey,
              child: Column(
                children: [
                  VerticalLabelField(
                    label: 'Email/phone',
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(color: Color(0xFFFAFAFA)),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.email_outlined,
                        color: Colors.grey,
                      ),
                      hintText: "Email address",

                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (val) =>
                        val!.isEmpty ? "Email is required" : null,
                  ),

                  30.verticalSpace,
                  ValueListenableBuilder(
                    valueListenable: obscurePasswordNotifier,
                    builder: (_, obscurePassword, __) {
                      return VerticalLabelField(
                        label: 'Password',
                        controller: passwordController,
                        obscureText: obscurePassword,
                        keyboardType: TextInputType.text,
                        style: TextStyle(color: AppColors.darkNavy),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.lock_open_outlined,
                            color: Colors.grey,
                          ),
                          hintText: "Password",
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.grey,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.grey,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () => obscurePasswordNotifier.value =
                                !obscurePasswordNotifier.value,
                            child: Icon(
                              obscurePassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                            ),
                          ),
                        ),
                        validator: (val) =>
                            val!.isEmpty ? "Password required" : null,
                      );
                    },
                  ),
                  100.verticalSpace,
                  if (viewModel.error != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Text(
                        viewModel.error!,
                        style: const TextStyle(color: Colors.red, fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  CustomButton(
                    text: 'Sign In',
                    onPressed: viewModel.isLoading
                        ? null
                        : () => _submitForm(viewModel),
                    isLoading: viewModel.isLoading,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // Widget _socialButton(String imagePath, String text) {
  //   return Container(
  //     height: 48.h,
  //     padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
  //     decoration: BoxDecoration(
  //       color: Colors.transparent,
  //       borderRadius: BorderRadius.circular(8.r),
  //       border: Border.all(color: AppColors.primaryGreen, width: 1),
  //     ),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Image.asset(imagePath, width: 22.w, height: 22.h),
  //         SizedBox(width: 8.w),
  //         Flexible(
  //           child: Text(
  //             text,
  //             overflow: TextOverflow.ellipsis,
  //             style: TextStyle(
  //               fontSize: 14.sp,
  //               fontWeight: FontWeight.w500,
  //               color: AppColors.primaryGreen,
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
