import 'package:flutter/material.dart';
import 'package:ecommerce_app/app/locator.dart';
import 'package:ecommerce_app/core/data_source/wishlist/wishlist_data_source.dart';

class WishlistViewModel extends ChangeNotifier {
  final WishlistRemoteDataSource _wishlistDs =
      locator<WishlistRemoteDataSource>();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<dynamic> _items = [];
  List<dynamic> get items => _items;

  Future<void> fetchWishlist() async {
    _isLoading = true;
    notifyListeners();

    final result = await _wishlistDs.getWishlist();

    result.fold(
      (error) {
        _items = [];
      },
      (data) {
        _items = data['items'] ?? [];
      },
    );

    _isLoading = false;
    notifyListeners();
  }

  Future<bool> removeItem(int itemId) async {
    final result = await _wishlistDs.removeFromWishlist(itemId: itemId);

    return result.fold((error) => false, (_) {
      _items.removeWhere((e) => e['id'] == itemId);
      notifyListeners();
      return true;
    });
  }
}
