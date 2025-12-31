import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qsir_app/core/themes/app_theme.dart';

class ProfileHeader extends StatelessWidget {
  final String storeName;
  final String storeAddress;
  final String storePhone;

  const ProfileHeader({
    super.key,
    required this.storeName,
    required this.storeAddress,
    required this.storePhone,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 24.w),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50.r,
            backgroundColor: AppColors.primary.withValues(alpha: 0.1),
            child: Icon(Icons.store, size: 50.sp, color: AppColors.primary),
          ),
          SizedBox(height: 16.h),
          Text(
            storeName,
            style: context.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            storeAddress,
            textAlign: TextAlign.center,
            style: context.textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            storePhone,
            style: context.textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
