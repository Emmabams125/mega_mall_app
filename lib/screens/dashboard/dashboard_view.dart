import 'package:ecommerce_app/screens/dashboard/dashboard_viewmodel.dart';
import 'package:ecommerce_app/screens/dashboard/home/home_Screen.dart';
import 'package:ecommerce_app/screens/dashboard/order/order_view.dart';
import 'package:ecommerce_app/screens/dashboard/profile/profile_view.dart';
import 'package:ecommerce_app/screens/dashboard/wishlist/wishlist_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:stacked/stacked.dart';

class DashboardView extends StatelessWidget {
  final int index;

  const DashboardView({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DashboardViewModel>.reactive(
      viewModelBuilder: () => DashboardViewModel(),
      onViewModelReady: (viewModel) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          viewModel.setIndex(index);
        });
      },
      builder: (context, viewModel, child) =>
          AnnotatedRegion<SystemUiOverlayStyle>(
            value: context.isDarkMode
                ? SystemUiOverlayStyle.light
                : SystemUiOverlayStyle.dark,
            child: WillPopScope(
              onWillPop: () async => false,
              child: Scaffold(
                body: IndexedStack(
                  index: viewModel.currentIndex,
                  children: const [
                    HomeScreen(),
                    WishlistView(),
                    OrderView(),
                    ProfileView(),
                  ],
                ),

                bottomNavigationBar: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 0.h),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.h),
                      child: Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide(color: Color(0xFFE6EBF0), width: 1),
                          ),
                        ),
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            splashFactory: NoSplash.splashFactory,
                          ),
                          child: BottomNavigationBar(
                            backgroundColor: Colors.white,
                            type: BottomNavigationBarType.fixed,
                            currentIndex: viewModel.currentIndex,
                            onTap: (index) {
                              HapticFeedback.mediumImpact();
                              viewModel.setIndex(index);
                            },

                            selectedItemColor: const Color(0xFF0C1A30),
                            unselectedItemColor: const Color(0xFFA5A5A5),
                            elevation: 1,

                            items: [
                              bottomBarItem(
                                name: 'Home',
                                iconPath: 'assets/svgs/home.svg',
                                semanticLabel: 'Home',
                              ),
                              bottomBarItem(
                                name: 'Wishlist',
                                iconPath: 'assets/svgs/wishlist.svg',
                                semanticLabel: 'Wishlist',
                              ),
                              bottomBarItem(
                                name: 'Orders',
                                iconPath: 'assets/svgs/order.svg',
                                semanticLabel: 'Orders',
                              ),
                              bottomBarItem(
                                name: 'Profile',
                                iconPath: 'assets/images/pee.png',
                                semanticLabel: 'Profile',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
    );
  }
}

BottomNavigationBarItem bottomBarItem({
  required String name,
  required String iconPath,
  required String semanticLabel,
}) {
  Widget buildIcon(Color color, double size) {
    if (iconPath.toLowerCase().endsWith('.svg')) {
      return SvgPicture.asset(
        iconPath,
        height: size,
        width: size,
        color: color,
        semanticsLabel: semanticLabel,
      );
    } else {
      return Image.asset(
        iconPath,
        height: size,
        width: size,
        color: color,
      );
    }
  }

  return BottomNavigationBarItem(
    label: name,

    icon: Column(
      children: [
        const SizedBox(height: 5),
        buildIcon(const Color(0xFF8B8B8B), 22),
      ],
    ),

    activeIcon: Column(
      children: [
        const SizedBox(height: 5),
        buildIcon(const Color(0xFF0C1A30), 24),
      ],
    ),
  );
}
