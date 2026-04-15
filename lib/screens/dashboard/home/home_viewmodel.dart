import 'package:ecommerce_app/core/data_source/category_remote/category_remote_data_source.dart';
import 'package:ecommerce_app/app/locator.dart';
import 'package:ecommerce_app/core/models/category_model.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  final CategoryRemoteDataSource _categoryDs =
      locator<CategoryRemoteDataSource>();

  List<CategoryModel> _categories = [];
  List<CategoryModel> get categories => _categories;

  bool _isLoadingCategories = false;
  bool get isLoadingCategories => _isLoadingCategories;

  String? categoryError;

  bool _disposed = false;

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  void _safeNotify() {
    if (_disposed) return;
    notifyListeners();
  }

  Future<void> fetchCategories() async {
    _isLoadingCategories = true;
    categoryError = null;
    _safeNotify();

    final result = await _categoryDs.getCategories();

    if (_disposed) return;

    result.fold(
      (error) {
        categoryError = error.message;
        _isLoadingCategories = false;
        _safeNotify();
      },
      (data) {
        _categories = data;
        _isLoadingCategories = false;
        _safeNotify();
      },
    );
  }
}
