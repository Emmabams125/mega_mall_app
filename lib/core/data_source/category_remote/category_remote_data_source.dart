import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/models/app_error.dart';
import 'package:ecommerce_app/core/models/category_model.dart';
import 'package:ecommerce_app/core/models/product_model.dart';

abstract class CategoryRemoteDataSource {
  Future<Either<AppError, List<CategoryModel>>> getCategories();

  Future<Either<AppError, List<ProductModel>>> getProductsByCategory({
    required int categoryId,
    int page = 1,
  });
}