import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/data_source/wishlist/wishlist_data_source.dart';
import 'package:ecommerce_app/core/enums/http_method.dart';
import 'package:ecommerce_app/core/models/app_error.dart';
import 'package:ecommerce_app/core/services/api/api_service.dart';

class WishlistRemoteDataSourceImpl extends WishlistRemoteDataSource {
  final ApiService _api;

  WishlistRemoteDataSourceImpl(this._api);



  @override
  Future<Either<AppError, dynamic>> addToWishlist({
    required int productId,
  }) {
    return _api.makeRequest(
      url: '/wishlist/add',
      method: HttpMethod.post,
      data: {
        'productId': productId,
      },
      fromJson: (json) => json,
    );
  }

  @override
  Future<Either<AppError, dynamic>> removeFromWishlist({
    required int itemId,
  }) {
    return _api.makeRequest(
      url: '/wishlist/remove/$itemId',
      method: HttpMethod.delete,
      fromJson: (json) => json,
    );
  }

  @override
  Future<Either<AppError, dynamic>> getWishlist() {
    return _api.makeRequest(
      url: '/wishlist',
      method: HttpMethod.get,
      fromJson: (json) => json,
    );
  }

  @override
  Future<Either<AppError, dynamic>> wishlistCount() {
    return _api.makeRequest(
      url: '/wishlist/count',
      method: HttpMethod.get,
      fromJson: (json) => json,
    );
  }
}