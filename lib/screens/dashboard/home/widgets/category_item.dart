import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryItem extends StatelessWidget {
  final String title;

  /// Use [imagePath] for local asset images.
  final String? imagePath;

  /// Use [imageUrl] for network images from the API.
  final String? imageUrl;

  const CategoryItem({
    super.key,
    required this.title,
    this.imagePath,
    this.imageUrl,
  }) : assert(
         imagePath != null || imageUrl != null,
         'Provide either imagePath or imageUrl',
       );

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: SizedBox(
            width: 48.w,
            height: 48.h,
            child: imageUrl != null
                ? Image.network(
                    imageUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      debugPrint("IMAGE FAILED: $imageUrl");
                      debugPrint(error.toString());

                      return Container(
                        color: Colors.red,
                        child: const Icon(Icons.error),
                      );
                    },
                  )
                : Image.asset(imagePath!, fit: BoxFit.cover),
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          title,
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
