import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qsir_app/core/themes/app_theme.dart';

class CategoryIconSelector extends StatelessWidget {
  final IconData selectedIcon;
  final VoidCallback onTap;

  const CategoryIconSelector({
    super.key,
    required this.selectedIcon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              width: 100.w,
              height: 100.w,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(50.r),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.3),
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Icon(selectedIcon, size: 48.sp, color: AppColors.primary),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(6.w),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: Icon(Icons.edit, size: 14.sp, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 12.h),
        Center(
          child: Text(
            "Ketuk icon untuk mengubah",
            style: context.textTheme.bodySmall?.copyWith(color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
