import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qsir_app/core/themes/app_theme.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: Colors.white,
          child: Icon(
            Icons.person,
            color: AppColors.primary.withValues(alpha: 0.6),
            size: 20,
          ),
        ),
        SizedBox(width: 8.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "John Doe",
              style: context.textTheme.titleSmall?.copyWith(
                color: Colors.white,
              ),
            ),
            Text(
              "Owner",
              style: context.textTheme.bodySmall?.copyWith(color: Colors.white),
            ),
          ],
        ),
      ],
    );
  }
}
