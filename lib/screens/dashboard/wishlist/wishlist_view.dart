import 'package:ecommerce_app/screens/dashboard/wishlist/wishist_viewmodel.dart';
import 'package:ecommerce_app/widgets/slidable_card.dart';
import 'package:ecommerce_app/widgets/flusher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class WishlistView extends StatelessWidget {
  const WishlistView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WishlistViewModel()..fetchWishlist(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Consumer<WishlistViewModel>(
            builder: (context, vm, _) {
              if (vm.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (vm.items.isEmpty) {
                return const Center(child: Text("No wishlist items ❤️"));
              }

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
                        const Text(
                          "Wishlist",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// LIST
                  Expanded(
                    child: ListView.builder(
                      itemCount: vm.items.length,
                      itemBuilder: (context, index) {
                        final item = vm.items[index];
                        final product = item['product'];

                        return SlidableTile(
                          title: product?['name'] ?? '',
                          subtitle: "Saved item",
                          image: product?['image'] ?? '',
                          onDelete: () async {
                            final success = await vm.removeItem(item['id']);

                            if (success) {
                              Flusher.success(context, "Removed from wishlist");
                            } else {
                              Flusher.error(context, "Failed to remove item");
                            }
                          },
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
