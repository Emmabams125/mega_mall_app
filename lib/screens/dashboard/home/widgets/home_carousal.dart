import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeCarousal extends StatefulWidget {
  const HomeCarousal({super.key});

  @override
  State<HomeCarousal> createState() => _HomeCarousalState();
}

class _HomeCarousalState extends State<HomeCarousal> {
  final PageController _pageController = PageController(viewportFraction: 1.0);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 150.h,
          child: PageView(
            controller: _pageController,
            children: [
              _buildCard('assets/images/caro1.png'),
              _buildCard('assets/images/caro2.png'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCard(String imagePath) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );
  }
}
