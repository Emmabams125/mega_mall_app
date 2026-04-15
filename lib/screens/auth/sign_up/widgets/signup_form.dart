import 'dart:developer' as dev;
import 'package:ecommerce_app/screens/auth/sign_up/signup_viewmodel.dart';
import 'package:ecommerce_app/widgets/verical_label_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final obscurePasswordNotifier = ValueNotifier(true);

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    obscurePasswordNotifier.dispose();
    super.dispose();
  }

  void _submitForm(SignupViewModel viewModel) {
    dev.log('📝 SIGNUP FORM SUBMITTED: Name: ${nameController.text}, Email: ${emailController.text}, Password: ${passwordController.text.isNotEmpty ? "****" : "empty"}', name: 'FORM');

    if (formKey.currentState!.validate()) {
      dev.log('✅ SIGNUP FORM VALIDATION PASSED', name: 'FORM');
      viewModel.signup(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } else {
      dev.log('❌ SIGNUP FORM VALIDATION FAILED', name: 'FORM');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SignupViewModel>(
      builder: (context, viewModel, _) {
        return Form(
          key: formKey,
          child: Column(
            children: [
              VerticalLabelField(
                label: 'Full Name',
                controller: nameController,
                keyboardType: TextInputType.name,
                style: TextStyle(color: Color(0xFFFAFAFA)),
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.person_outlined,
                    color: Colors.grey,
                  ),
                  hintText: "Full name",
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (val) => val!.isEmpty ? "Name is required" : null,
              ),
              30.verticalSpace,
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
                validator: (val) => val!.isEmpty ? "Email is required" : null,
              ),
              30.verticalSpace,
              ValueListenableBuilder(
                valueListenable: obscurePasswordNotifier,
                builder: (_, obscurePassword, __) {
                  return VerticalLabelField(
                    label: 'Password',
                    controller: passwordController,
                    obscureText: obscurePassword,
                    style: TextStyle(color: Color(0xFFFAFAFA)),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.lock_outline,
                        color: Colors.grey,
                      ),
                      hintText: "Password",
                      suffixIcon: GestureDetector(
                        onTap: () =>
                            obscurePasswordNotifier.value = !obscurePassword,
                        child: Icon(
                          obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.grey,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (val) =>
                        val!.isEmpty ? "Password is required" : null,
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
              const SizedBox(height: 10),
              // CustomButton wired up
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: viewModel.isLoading
                        ? null
                        : () => _submitForm(viewModel),
                    child: Center(
                      child: viewModel.isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              'Sign Up',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        );
      },
    );
  }
}
