import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/data_source/category_remote/category_remote_data_source.dart';
import 'package:ecommerce_app/core/enums/http_method.dart';
import 'package:ecommerce_app/core/models/app_error.dart';
import 'package:ecommerce_app/core/models/category_model.dart';
import 'package:ecommerce_app/core/models/product_model.dart';
import 'package:ecommerce_app/core/services/api/api_service.dart';

class CategoryRemoteDataSourceImpl extends CategoryRemoteDataSource {
  final ApiService _api;

  CategoryRemoteDataSourceImpl(this._api);

  @override
  Future<Either<AppError, List<CategoryModel>>> getCategories() {
    return _api.makeRequest(
      url: "/categories",
      method: HttpMethod.get,
      fromJson: (json) =>
          (json as List).map((e) => CategoryModel.fromJson(e)).toList(),
    );
  }

  @override
  Future<Either<AppError, List<ProductModel>>> getProductsByCategory({
    required int categoryId,
    int page = 1,
  }) {
    return _api.makeRequest(
      url: "/products",
      method: HttpMethod.get,
      queryParams: {"category": categoryId, "page": page},
      fromJson: (json) =>
          (json as List).map((e) => ProductModel.fromJson(e)).toList(),
    );
  }
}