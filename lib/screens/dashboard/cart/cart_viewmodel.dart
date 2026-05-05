import 'package:flutter/material.dart';
import 'package:ecommerce_app/app/locator.dart';
import 'package:ecommerce_app/core/data_source/cart_source/cart_remote_data_source.dart';

class CartViewModel extends ChangeNotifier {
  final CartRemoteDataSource _cartDs =
      locator<CartRemoteDataSource>();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<dynamic> _cartItems = [];
  List<dynamic> get cartItems => _cartItems;

  Future<void> fetchCart() async {
    _isLoading = true;
    notifyListeners();

    final result = await _cartDs.getCart();

    result.fold(
      (error) {
        _cartItems = [];
      },
      (data) {
        _cartItems = data['items'] ?? [];
      },
    );

    _isLoading = false;
    notifyListeners();
  }

  Future<bool> removeItem(int cartItemId) async {
    final result =
        await _cartDs.removeFromCart(cartItemId: cartItemId);

    return result.fold(
      (error) => false,
      (_) {
        _cartItems.removeWhere((e) => e['id'] == cartItemId);
        notifyListeners();
        return true;
      },
    );
  }
}