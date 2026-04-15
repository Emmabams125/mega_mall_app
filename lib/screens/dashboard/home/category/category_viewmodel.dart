import 'package:ecommerce_app/core/data_source/category_remote/category_remote_data_source.dart';
import 'package:ecommerce_app/app/locator.dart';
import 'package:ecommerce_app/core/models/product_model.dart';
import 'package:flutter/material.dart';

class CategoryViewModel extends ChangeNotifier {
  final CategoryRemoteDataSource _categoryDs =
      locator<CategoryRemoteDataSource>();

  List<ProductModel> _products = [];
  List<ProductModel> get products => _products;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? error;

  int _currentPage = 1;
  bool _hasMore = true;
  bool get hasMore => _hasMore;

  Future<void> fetchProducts({
    required int categoryId,
    bool refresh = false,
  }) async {
    if (refresh) {
      _currentPage = 1;
      _products = [];
      _hasMore = true;
    }

    if (!_hasMore) return;

    _isLoading = true;
    error = null;
    notifyListeners();

    final result = await _categoryDs.getProductsByCategory(
      categoryId: categoryId,
      page: _currentPage,
    );

    result.fold(
      (err) {
        error = err.message;
        _isLoading = false;
        notifyListeners();
      },
      (data) {
        if (data.isEmpty) {
          _hasMore = false;
        } else {
          _products.addAll(data);
          _currentPage++;
        }
        _isLoading = false;
        notifyListeners();
      },
    );
  }
}