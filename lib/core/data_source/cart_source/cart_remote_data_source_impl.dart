import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/data_source/cart_source/cart_remote_data_source.dart';
import 'package:ecommerce_app/core/enums/http_method.dart';
import 'package:ecommerce_app/core/models/app_error.dart';
import 'package:ecommerce_app/core/services/api/api_service.dart';

class CartRemoteDataSourceImpl extends CartRemoteDataSource {
  final ApiService _api;

  CartRemoteDataSourceImpl(this._api);

  @override
  Future<Either<AppError, dynamic>> addToCart({
    required int productId,
    required int quantity,
  }) {
    return _api.makeRequest(
      url: '/cart/add',
      method: HttpMethod.post,
      data: {'productId': productId, 'quantity': quantity},
      fromJson: (json) => json,
    );
  }

  @override
  Future<Either<AppError, dynamic>> getCart() {
    return _api.makeRequest(
      url: '/cart',
      method: HttpMethod.get,
      fromJson: (json) => json,
    );
  }

  @override
  Future<Either<AppError, dynamic>> removeFromCart({required int cartItemId}) {
    return _api.makeRequest(
      url: '/cart/remove/$cartItemId',
      method: HttpMethod.delete,
      fromJson: (json) => json,
    );
  }

  @override
  Future<Either<AppError, dynamic>> cartCount() {
    return _api.makeRequest(
      url: '/cart/count',
      method: HttpMethod.get,
      fromJson: (json) => json,
    );
  }
}
