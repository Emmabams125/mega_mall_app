import 'dart:developer' as dev;
import 'package:ecommerce_app/app/locator.dart';
import 'package:ecommerce_app/app/route_names.dart';
import 'package:ecommerce_app/core/data_source/auth_remote_data_source/auth_remote_data_source.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class SignupViewModel extends ChangeNotifier {
  final AuthRemoteDataSource _auth = locator<AuthRemoteDataSource>();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? error;

  Future<bool> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    dev.log('📝 SIGNUP ATTEMPT: Name: $name, Email: $email', name: 'AUTH');

    _isLoading = true;
    error = null;
    notifyListeners();

    final result = await _auth.signup(
      name: name,
      email: email,
      password: password,
    );

    bool success = false;

    result.fold(
      (err) {
        dev.log('❌ SIGNUP FAILED: ${err.message}', name: 'AUTH', error: err);
        error = err.message;
        _isLoading = false;
        notifyListeners();
      },
      (_) {
        dev.log('✅ SIGNUP SUCCESS: User registered', name: 'AUTH');
        success = true;
        _isLoading = false;
        notifyListeners();

        // Navigate to login screen after successful signup
        dev.log('🔄 NAVIGATING to login screen after signup', name: 'AUTH');
        Get.offAllNamed(Routes.login);
      },
    );

    return success;
  }
}
