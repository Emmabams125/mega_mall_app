import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/models/app_error.dart';

abstract class CartRemoteDataSource {
  Future<Either<AppError, dynamic>> addToCart({
    required int productId,
    required int quantity,
  });

  Future<Either<AppError, dynamic>> getCart();

  Future<Either<AppError, dynamic>> removeFromCart({
    required int cartItemId,
  });

  Future<Either<AppError, dynamic>> cartCount();
}