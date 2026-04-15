import 'dart:developer' as dev;
import 'package:ecommerce_app/core/data_source/auth_remote_data_source/auth_remote_data_source.dart';
import 'package:ecommerce_app/core/services/storage_service/storage_service.dart';
import 'package:ecommerce_app/app/locator.dart';
import 'package:ecommerce_app/app/route_names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthRemoteDataSource _auth = locator<AuthRemoteDataSource>();
  final StorageService _storage = locator<StorageService>();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? error;

  Future<void> login({required String email, required String password}) async {
    dev.log('🔐 LOGIN ATTEMPT: Email: $email', name: 'AUTH');

    _isLoading = true;
    error = null;
    notifyListeners();

    try {
      final result = await _auth.login(email: email, password: password);

      result.fold(
        (loginError) {
          dev.log(
            '❌ LOGIN FAILED: ${loginError.message}',
            name: 'AUTH',
            error: loginError,
          );
          this.error = loginError.message;
          _isLoading = false;
          notifyListeners();
        },
        (response) async {
          dev.log('✅ LOGIN SUCCESS: Token received', name: 'AUTH');

          // Save token
          if (response.token != null) {
            await _storage.addString("token", response.token!);
            dev.log('💾 TOKEN SAVED to storage', name: 'AUTH');
          }

          _isLoading = false;
          notifyListeners();

          // Navigate to home screen
          dev.log('🏠 NAVIGATING to home screen', name: 'AUTH');
          Get.offAllNamed(Routes.dashboard, arguments: 0);
        },
      );
    } catch (e) {
      dev.log('💥 LOGIN EXCEPTION: $e', name: 'AUTH', error: e);
      error = "Login failed: $e";
      _isLoading = false;
      notifyListeners();
    }
  }
}
