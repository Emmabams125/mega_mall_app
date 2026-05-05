import 'package:ecommerce_app/core/models/category_model.dart';
import 'package:ecommerce_app/screens/dashboard/cart/cart_view.dart';
import 'package:ecommerce_app/screens/dashboard/home/category/category_screen.dart';
import 'package:ecommerce_app/screens/dashboard/home/home_viewmodel.dart';
import 'package:ecommerce_app/screens/dashboard/home/widgets/category_item.dart';
import 'package:ecommerce_app/screens/dashboard/home/widgets/home_carousal.dart';
import 'package:ecommerce_app/screens/dashboard/home/widgets/product_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeViewModel()..fetchCategories(),
      child: Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              60.verticalSpace,
              Row(
                children: [
                  140.horizontalSpace,
                  Text(
                    'Mega Mall',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  70.horizontalSpace,
                  Row(
                    children: [
                      Image.asset('assets/images/noti.png', height: 20.h),
                      20.horizontalSpace,
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const CartScreen(),
                            ),
                          );
                        },
                        child: Image.asset(
                          'assets/images/cart.png',
                          height: 20.h,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              40.verticalSpace,

              // Search field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SvgPicture.asset(
                        'assets/svgs/search.svg',
                        width: 20,
                        height: 20,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    hintText: "Search Products name",
                    hintStyle: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              40.verticalSpace,
              HomeCarousal(),
              18.verticalSpace,
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Categories',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'See All',
                          style: TextStyle(fontSize: 14.sp, color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                  20.verticalSpace,

                  // Dynamic categories from API
                  Consumer<HomeViewModel>(
                    builder: (context, vm, _) {
                      if (vm.isLoadingCategories) {
                        return const SizedBox(
                          height: 80,
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }

                      if (vm.categoryError != null) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            vm.categoryError!,
                            style: const TextStyle(color: Colors.red),
                          ),
                        );
                      }

                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: List.generate(vm.categories.length, (
                            index,
                          ) {
                            final category = vm.categories[index];

                            return Row(
                              children: [
                                GestureDetector(
                                  onTap: () =>
                                      _navigateToCategory(context, category),
                                  child: CategoryItem(
                                    title: category.name,
                                    imageUrl: category.image,
                                  ),
                                ),

                                if (index != vm.categories.length - 1)
                                  const SizedBox(width: 40),
                              ],
                            );
                          }),
                        ),
                      );
                    },
                  ),

                  // Featured Products 
                  40.verticalSpace,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Featured Products',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'See All',
                          style: TextStyle(fontSize: 14.sp, color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                  10.verticalSpace,
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 160,
                          child: ProductTile(
                            title: 'Tma',
                            imagePath: 'assets/images/Pro1.png',
                            price: '500',
                            rating: 4.5,
                          ),
                        ),
                        const SizedBox(width: 12),
                        SizedBox(
                          width: 160,
                          child: ProductTile(
                            title: 'Headphones',
                            imagePath: 'assets/images/Pro2.png',
                            price: '500',
                            rating: 4.5,
                          ),
                        ),
                        const SizedBox(width: 12),
                        SizedBox(
                          width: 160,
                          child: ProductTile(
                            title: 'Speakers',
                            imagePath: 'assets/images/Pro3.png',
                            price: '750',
                            rating: 4.2,
                          ),
                        ),
                      ],
                    ),
                  ),

                  40.verticalSpace,
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    padding: const EdgeInsets.all(16),
                    child: Image.asset(
                      'assets/images/ban1.png',
                      fit: BoxFit.cover,
                    ),
                  ),

                  20.verticalSpace,
                  sectionHeader('Best Sellers'),
                  10.verticalSpace,
                  horizontalProductList(),

                  40.verticalSpace,
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: Image.asset(
                      'assets/images/Ban2.png',
                      fit: BoxFit.cover,
                    ),
                  ),

                  40.verticalSpace,
                  sectionHeader('New Arrivals'),
                  10.verticalSpace,
                  horizontalProductList(),

                  40.verticalSpace,
                  sectionHeader('Top Rated Product'),
                  10.verticalSpace,
                  horizontalProductList(),

                  40.verticalSpace,
                  sectionHeader('Special Offers'),
                  10.verticalSpace,
                  horizontalProductList(isSale: true),

                  40.verticalSpace,
                  sectionHeader('Latest News'),
                  newsItem(
                    title: "Philosophy That Addresses Topics Such As Goodness",
                    image: 'assets/images/news1.png',
                  ),
                  newsItem(
                    title:
                        "Many Inquiries Outside Of Academia Are Philosophical",
                    image: 'assets/images/news2.png',
                  ),
                  newsItem(
                    title: "Tips Merawat Bodi Mobil agar Tidak Terlihat Kusam",
                    image: 'assets/images/news3.png',
                  ),

                  20.verticalSpace,
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: const Center(child: Text("See All News")),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToCategory(BuildContext context, CategoryModel category) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => CategoryScreen(category: category)),
    );
  }
}

// ── Reusable helpers (unchanged from your original) ──────────────────────────

Widget sectionHeader(String title) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const Text('See All', style: TextStyle(color: Colors.blue)),
      ],
    ),
  );
}

Widget horizontalProductList({bool isSale = false}) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    padding: const EdgeInsets.symmetric(horizontal: 12.0),
    child: Row(
      children: [
        productItem('assets/images/Pro1.png', isSale),
        productItem('assets/images/Pro2.png', isSale),
        productItem('assets/images/Pro3.png', isSale),
      ],
    ),
  );
}

Widget productItem(String image, bool isSale) {
  return Container(
    width: 160,
    margin: const EdgeInsets.only(right: 12),
    child: Stack(
      children: [
        ProductTile(
          title: 'TMA-2 HD Wireless',
          imagePath: image,
          price: '1,500,000',
          rating: 4.6,
        ),
        if (isSale)
          Positioned(
            top: 10,
            left: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              color: Colors.red,
              child: const Text(
                'SALE',
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
            ),
          ),
      ],
    ),
  );
}

Widget newsItem({required String title, required String image}) {
  return ListTile(
    leading: ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset(image, width: 60, height: 60, fit: BoxFit.cover),
    ),
    title: Text(title, maxLines: 2, overflow: TextOverflow.ellipsis),
    subtitle: const Text("13 Jan 2021"),
  );
}
