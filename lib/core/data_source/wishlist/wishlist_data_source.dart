import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/models/app_error.dart';

abstract class WishlistRemoteDataSource {
  Future<Either<AppError, dynamic>> addToWishlist({
    required int productId,
  });

  Future<Either<AppError, dynamic>> removeFromWishlist({
    required int itemId,
  });

  Future<Either<AppError, dynamic>> getWishlist();

  Future<Either<AppError, dynamic>> wishlistCount();
}