import 'package:ecommerce_app/core/models/category_model.dart';
import 'package:ecommerce_app/screens/dashboard/home/category/category_viewmodel.dart';
import 'package:ecommerce_app/screens/dashboard/home/widgets/product_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatelessWidget {
  final CategoryModel category;

  const CategoryScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          CategoryViewModel()..fetchProducts(categoryId: category.id),
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 220.h,
              pinned: true,
              backgroundColor: Colors.white,
              leading: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.85),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.arrow_back, color: Colors.black),
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  category.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                    shadows: const [
                      Shadow(color: Colors.black54, blurRadius: 6),
                    ],
                  ),
                ),
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      category.image,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: Colors.blue.shade100,
                        child: const Icon(
                          Icons.category,
                          size: 80,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    
                    const DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Colors.black54],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Products grid
            Consumer<CategoryViewModel>(
              builder: (context, vm, _) {
                if (vm.isLoading && vm.products.isEmpty) {
                  return const SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                if (vm.error != null && vm.products.isEmpty) {
                  return SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            vm.error!,
                            style: const TextStyle(color: Colors.red),
                            textAlign: TextAlign.center,
                          ),
                          16.verticalSpace,
                          ElevatedButton(
                            onPressed: () => vm.fetchProducts(
                              categoryId: category.id,
                              refresh: true,
                            ),
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                if (vm.products.isEmpty) {
                  return const SliverFillRemaining(
                    child: Center(
                      child: Text('No products in this category yet.'),
                    ),
                  );
                }

                return SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 16,
                  ),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      if (index == vm.products.length - 1 && vm.hasMore) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          vm.fetchProducts(categoryId: category.id);
                        });
                      }

                      final product = vm.products[index];
                      return ProductTile(
                        title: product.name,
                        imagePath: product.image,
                        price: '₦${product.price.toStringAsFixed(0)}',
                        rating: 4.5,
                        isNetworkImage: true,
                      );
                    }, childCount: vm.products.length),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.72,
                        ),
                  ),
                );
              },
            ),

            // Bottom loading indicator for pagination
            Consumer<CategoryViewModel>(
              builder: (context, vm, _) {
                if (vm.isLoading && vm.products.isNotEmpty) {
                  return const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  );
                }
                return const SliverToBoxAdapter(child: SizedBox.shrink());
              },
            ),
          ],
        ),
      ),
    );
  }
}
