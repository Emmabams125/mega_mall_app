import 'package:ecommerce_app/screens/dashboard/cart/cart_viewmodel.dart';
import 'package:ecommerce_app/widgets/slidable_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CartViewModel()..fetchCart(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Consumer<CartViewModel>(
            builder: (context, vm, _) {
              return Column(
                children: [
                  /// HEADER
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(Icons.arrow_back_ios),
                        ),
                        SizedBox(width: 12.w),
                        Text(
                          "Cart",
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// CONTENT
                  Expanded(
                    child: vm.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : vm.cartItems.isEmpty
                        ? const Center(
                            child: Text(
                              "Your cart is empty ",
                              style: TextStyle(fontSize: 16),
                            ),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.all(16),
                            itemCount: vm.cartItems.length,
                            itemBuilder: (context, index) {
                              final item = vm.cartItems[index];
                              final product = item['product'];

                              return SlidableTile(
                                title: product?['name'] ?? '',
                                subtitle: "Qty: ${item['quantity'] ?? 1}",
                                image: product?['image'] ?? '',
                                onDelete: () => vm.removeItem(item['id'],),
                              );
                            },
                          ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
