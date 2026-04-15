import 'package:ecommerce_app/styles/app_colours.dart';
import 'package:ecommerce_app/app/route_names.dart';
import 'package:ecommerce_app/widgets/custom_app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controllers/onboardingController.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final onboardingController = Get.put(OnboardingController());
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryGrey,
      body: Column(
        children: [
          /// PAGES
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) =>
                  onboardingController.currentPage.value = index,
              itemCount: onboardingData.length,
              itemBuilder: (context, index) {
                return OnboardingPage(
                  title: onboardingData[index]['title'],
                  description: onboardingData[index]['description'],
                  svgPath: onboardingData[index]['svgPath'],
                );
              },
            ),
          ),

          /// DOT INDICATORS
          Obx(
            () => Padding(
              padding: EdgeInsets.only(top: 20.h, bottom: 20.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  onboardingData.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: EdgeInsets.symmetric(horizontal: 5.w),
                    width: onboardingController.currentPage.value == index
                        ? 10.w
                        : 8.w,
                    height: onboardingController.currentPage.value == index
                        ? 10.w
                        : 8.w,
                    decoration: BoxDecoration(
                      color: onboardingController.currentPage.value == index
                          ? AppColors.primaryGreen
                          : AppColors.lightGrey,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
          ),

          Obx(() {
            final isFirst = onboardingController.currentPage.value == 0;
            final isLast =
                onboardingController.currentPage.value ==
                onboardingData.length - 1;

            return Padding(
              padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 30.h),
              child: isFirst
                  ? CustomButton(
                      text: 'Next',
                      onPressed: () => onboardingController.nextPage(
                        _pageController,
                        onboardingData.length,
                      ),
                    )
                  : Row(
                      children: [
                        GestureDetector(
                          onTap: () => onboardingController.previousPage(
                            _pageController,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Text(
                              'Back',
                              style: TextStyle(
                                color: AppColors.primaryGreen,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.sp,
                              ),
                            ),
                          ),
                        ),

                        const Spacer(),

                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: isLast ? 220.w : 220.w,
                          child: CustomButton(
                            text: isLast ? 'Get Started' : 'Next',
                            onPressed: () {
                              if (isLast) {
                                // Navigate to next screen
                                Get.offAllNamed(Routes.login);
                                // or LoginScreen(), etc.
                              } else {
                                onboardingController.nextPage(
                                  _pageController,
                                  onboardingData.length,
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
            );
          }),
        ],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final dynamic title;
  final dynamic description;
  final dynamic svgPath;

  OnboardingPage({
    required this.title,
    required this.description,
    required this.svgPath,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ClipPath(
          clipper: CenterCurveClipper(),
          child: Container(
            width: 472.w,
            height: 472.h,
            child: Image.asset(svgPath, fit: BoxFit.cover),
          ),
        ),

        Text(
          title,
          style: TextStyle(
            color: AppColors.darkNavy,
            fontSize: 25.sp,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 16.h),
        Text(
          description,
          style: TextStyle(fontSize: 16.sp, color: AppColors.lightGrey),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

final List<Map<String, String>> onboardingData = [
  {
    'title': 'Online Home Store\n and Furniture',
    'description':
        'Discover all style and budgets of furniture, appliances, kitchen, and more from 500+ brands in your hand.',
    'svgPath': 'assets/images/delivery.png', // was "image"
  },
  {
    'title': 'Delivery Right to Your Doorstep',
    'description':
        'Sit back, and enjoy the convenience of our drivers delivering your order to your doorstep.',
    'svgPath': 'assets/images/kitchen.png',
  },
  {
    'title': 'Get Support From Our Skilled Team',
    'description':
        "If our products don't meet your expectations, we're available 24/7 to assist you.",
    'svgPath': 'assets/images/support.png',
  },
];

class CenterCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    // 1. Move to top left
    path.lineTo(0, 0);

    // 2. Line down the left side, but stop 100 pixels early
    // Increasing this number makes the curve "deeper"
    double curveDepth = 100.h;
    path.lineTo(0, size.height - curveDepth);

    // 3. The Curve
    // Control Point is at the very bottom (size.height)
    // End Point is on the right side, at the same height as the left start
    path.quadraticBezierTo(
      size.width / 2, // Center of the screen
      size.height, // The "peak" of the curve at the bottom
      size.width, // Right side
      size.height - curveDepth,
    );

    // 4. Line up to top right and close
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
