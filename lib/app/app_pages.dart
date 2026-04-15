import 'package:ecommerce_app/screens/auth/login/login_screen.dart';
import 'package:ecommerce_app/screens/auth/onboarding_screen.dart';
import 'package:ecommerce_app/screens/auth/sign_up/signup_view.dart';
import 'package:ecommerce_app/screens/auth/splash_screen.dart';
import 'package:ecommerce_app/screens/dashboard/dashboard_view.dart';
import 'package:ecommerce_app/screens/dashboard/home/home_Screen.dart';
import 'package:ecommerce_app/app/route_names.dart';
import 'package:ecommerce_app/screens/dashboard/order/order_view.dart';
import 'package:ecommerce_app/screens/dashboard/profile/profile_view.dart';
import 'package:ecommerce_app/screens/dashboard/wishlist/wishlist_view.dart';
import 'package:get/get.dart';

class AppPages {
  static final routes = [
    GetPage(name: Routes.splashScreen, page: () => const SplashScreen()),
    GetPage(
      name: Routes.onboardingScreen,
      page: () => const OnboardingScreen(),
    ),
    GetPage(name: Routes.login, page: () => LoginScreen()),
    GetPage(name: Routes.signup, page: () => const SignUpScreen()),
    GetPage(name: Routes.home, page: () => const HomeScreen()),
    GetPage(name: Routes.profile, page: () => const ProfileView()),
    GetPage(name: Routes.wishlist, page: () => const WishlistView()),
    GetPage(name: Routes.order, page: () => const OrderView()),
    GetPage(name: Routes.dashboard, page: () => const DashboardView(index: 0)),
  ];
}
