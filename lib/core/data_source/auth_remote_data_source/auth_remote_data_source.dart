import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/models/app_error.dart';
import 'package:ecommerce_app/core/models/auth_response/auth_reponse.dart';

abstract class AuthRemoteDataSource {
  Future<Either<AppError, AuthResponse>> login({
    required String email,
    required String password,
  });

  Future<Either<AppError, dynamic>> signup({
    required String name,
    required String email,
    required String password,
  });

  // Future<Either<AppError, dynamic>> getProfile();
}