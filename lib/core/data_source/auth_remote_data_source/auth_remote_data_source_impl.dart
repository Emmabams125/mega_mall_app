import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/data_source/auth_remote_data_source/auth_remote_data_source.dart';
import 'package:ecommerce_app/core/enums/http_method.dart';
import 'package:ecommerce_app/core/models/app_error.dart';
import 'package:ecommerce_app/core/models/auth_response/auth_reponse.dart';
import 'package:ecommerce_app/core/services/api/api_service.dart';

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final ApiService _api;
  
  AuthRemoteDataSourceImpl(this._api);
  @override
  Future<Either<AppError, AuthResponse>> login({
    required String email,
    required String password,
  }) {
    return _api.makeRequest(
      url: "/auth/login",
      method: HttpMethod.post,
      data: {"email": email, "password": password},
      fromJson: (json) => AuthResponse.fromJson(json),
    );
  }

  @override
  Future<Either<AppError, dynamic>> signup({
    required String name,
    required String email,
    required String password,
  }) {
    return _api.makeRequest(
      url: "/auth/signup",
      method: HttpMethod.post,
      data: {"name": name, "email": email, "password": password},
      fromJson: (json) => AuthResponse.fromJson(json),
    );
  }

  // Future<Map<String, dynamic>> getProfile(String token) async {
  //   final response = await _api.get(
  //     "/profile",
  //     token: token,
  //   );

  //   return response.data;
  // }
}
