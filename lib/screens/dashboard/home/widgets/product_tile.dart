import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductTile extends StatelessWidget {
  const ProductTile({
    super.key,
    required this.title,
    required this.imagePath,
    required this.price,
    required this.rating,
    this.isNetworkImage = false,
  });

  final String title;
  final String imagePath;
  final String price;
  final double rating;

  /// Set to [true] when [imagePath] is a URL from the API.
  final bool isNetworkImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 242,
      width: 156,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: isNetworkImage
                ? Image.network(
                    imagePath,
                    width: double.maxFinite,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      height: 120,
                      color: Colors.grey.shade200,
                      child: const Icon(Icons.image_not_supported,
                          color: Colors.grey),
                    ),
                  )
                : Image.asset(
                    imagePath,
                    width: double.maxFinite,
                    fit: BoxFit.cover,
                  ),
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
              color: Color(0xFF0C1A30),
            ),
          ),
          4.verticalSpace,
          Text(
            price,
            style: const TextStyle(fontSize: 12, color: Color(0xFFFE3A30)),
          ),
          4.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.orange, size: 14),
                  4.horizontalSpace,
                  Text(rating.toString(),
                      style: const TextStyle(fontSize: 12)),
                ],
              ),
              const Icon(Icons.more_vert, color: Colors.grey, size: 20),
            ],
          ),
        ],
      ),
    );
  }
}