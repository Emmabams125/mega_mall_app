import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/app/route_names.dart';

class OnboardingController extends GetxController {
  final currentPage = 0.obs;

  void nextPage(PageController controller, int totalPages) {
    if (currentPage.value < totalPages - 1) {
      controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // LAST PAGE → navigate
      Get.offAllNamed(Routes.login); // change route if needed
    }
  }

  void previousPage(PageController controller) {
    if (currentPage.value > 0) {
      controller.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }
}
