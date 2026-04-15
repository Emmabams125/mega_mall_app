import 'dart:developer' as dev;
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/enums/http_method.dart';
import 'package:ecommerce_app/core/models/app_error.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "http://10.0.2.2:3000/api",
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {"Content-Type": "application/json"},
    ),
  );

  Future<Either<AppError, T>> makeRequest<T>({
    required String url,
    required HttpMethod method,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParams,
    String? token,
    required T Function(dynamic json) fromJson,
  }) async {
    final requestId = DateTime.now().millisecondsSinceEpoch.toString();
    final fullUrl = _dio.options.baseUrl + url;

    // Log request details
    dev.log(
      '🚀 API REQUEST [$requestId]: ${method.name.toUpperCase()} $fullUrl',
      name: 'API',
    );

    if (data != null) {
      dev.log('📤 REQUEST DATA [$requestId]: $data', name: 'API');
    }

    if (queryParams != null) {
      dev.log('🔍 QUERY PARAMS [$requestId]: $queryParams', name: 'API');
    }

    if (token != null) {
      dev.log('🔑 AUTH TOKEN [$requestId]: Present', name: 'API');
    }

    try {
      Response response;

      final options = Options(
        headers: {if (token != null) "Authorization": "Bearer $token"},
      );

      switch (method) {
        case HttpMethod.get:
          response = await _dio.get(
            url,
            queryParameters: queryParams,
            options: options,
          );
          break;

        case HttpMethod.post:
          response = await _dio.post(url, data: data, options: options);
          break;

        case HttpMethod.put:
          response = await _dio.put(url, data: data, options: options);
          break;

        case HttpMethod.patch:
          response = await _dio.patch(url, data: data, options: options);
          break;

        case HttpMethod.delete:
          response = await _dio.delete(url, data: data, options: options);
          break;
      }

      // Log successful response
      dev.log(
        '✅ API RESPONSE [$requestId]: ${response.statusCode} ${response.statusMessage}',
        name: 'API',
      );
      dev.log('📥 RESPONSE DATA [$requestId]: ${response.data}', name: 'API');

      return Right(fromJson(response.data));
    } on DioException catch (e) {
      // Log Dio error details
      dev.log(
        '❌ DIO ERROR [$requestId]: ${e.type} - ${e.message}',
        name: 'API',
        error: e,
      );

      if (e.response != null) {
        dev.log(
          '📊 ERROR RESPONSE [$requestId]: ${e.response?.statusCode} - ${e.response?.data}',
          name: 'API',
        );
      }

      return Left(
        AppError(
          errorType: AppErrorType.network,
          message:
              e.response?.data?['message'] ??
              e.message ??
              "Network error occurred",
        ),
      );
    } on SocketException catch (e) {
      // Log socket error
      dev.log(
        '🔌 SOCKET ERROR [$requestId]: ${e.message}',
        name: 'API',
        error: e,
      );

      return Left(
        AppError(errorType: AppErrorType.network, message: e.message),
      );
    } catch (e) {
      // Log general error
      dev.log('💥 GENERAL ERROR [$requestId]: $e', name: 'API', error: e);

      return Left(AppError(errorType: AppErrorType.api, message: e.toString()));
    }
  }
}
