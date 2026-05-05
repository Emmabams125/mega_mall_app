import 'package:ecommerce_app/app/locator.dart';
import 'package:ecommerce_app/core/data_source/cart_source/cart_remote_data_source.dart';
import 'package:ecommerce_app/core/data_source/wishlist/wishlist_data_source.dart';
import 'package:ecommerce_app/core/models/product_model.dart';
import 'package:ecommerce_app/widgets/flusher.dart';
import 'package:flutter/material.dart';

class ProductDetailsViewModel extends ChangeNotifier {
  final CartRemoteDataSource _cartDs = locator<CartRemoteDataSource>();
  final WishlistRemoteDataSource _wishlistDs =
      locator<WishlistRemoteDataSource>();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isWishlisted = false;
  bool get isWishlisted => _isWishlisted;

  ProductModel? _product;
  ProductModel? get product => _product;

  String? _error;
  String? get error => _error;

  // ✅ SINGLE SOURCE OF TRUTH
  final Set<int> _cartProductIds = {};
  final Map<int, int> _cartItemIds = {}; // productId → cartItemId

  bool isInCart(int productId) => _cartProductIds.contains(productId);

  void setProduct(ProductModel product) {
    _product = product;
    notifyListeners();
  }

  // ---------------- TOGGLE CART ----------------
  Future<void> toggleCart(BuildContext context, int productId) async {
    _isLoading = true;
    notifyListeners();

    try {
      final isInCart = _cartProductIds.contains(productId);

      if (isInCart) {
        final cartItemId = _cartItemIds[productId];

        if (cartItemId == null) {
          Flusher.error(context, "Cart item not found");
          _isLoading = false;
          notifyListeners();
          return;
        }

        final result = await _cartDs.removeFromCart(cartItemId: cartItemId);

        result.fold(
          (error) {
            Flusher.error(context, error.message);
          },
          (_) {
            _cartProductIds.remove(productId);
            _cartItemIds.remove(productId);

            Flusher.success(context, "Removed from cart");
          },
        );
      } else {
        final result = await _cartDs.addToCart(
          productId: productId,
          quantity: 1,
        );

        result.fold(
          (error) {
            Flusher.error(context, error.message);
          },
          (data) {
            _cartProductIds.add(productId);

            final cartItemId = data['cartItemId'];
            if (cartItemId != null) {
              _cartItemIds[productId] = cartItemId;
            }

            Flusher.success(context, "Added to cart");
          },
        );
      }
    } catch (e) {
      Flusher.error(context, e.toString());
    }

    _isLoading = false;
    notifyListeners();
  }

  // ---------------- WISHLIST ----------------
  Future<void> toggleWishlist(BuildContext context, int productId) async {
    _isLoading = true;
    notifyListeners();

    try {
      if (_isWishlisted) {
        await _wishlistDs.removeFromWishlist(itemId: productId);
        _isWishlisted = false;
        Flusher.success(context, "Removed from wishlist");
      } else {
        await _wishlistDs.addToWishlist(productId: productId);
        _isWishlisted = true;
        Flusher.success(context, "Added to wishlist");
      }
    } catch (e) {
      Flusher.error(context, e.toString());
    }

    _isLoading = false;
    notifyListeners();
  }
}
