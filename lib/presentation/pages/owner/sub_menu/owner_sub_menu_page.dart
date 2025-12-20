import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qsir_app/core/themes/app_theme.dart';

class SubMenuItem {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;
  final bool isWarning;

  SubMenuItem({
    required this.title,
    required this.icon,
    this.onTap,
    this.isWarning = false,
  });
}

class OwnerSubMenuPage extends StatelessWidget {
  final String title;
  final List<SubMenuItem> items;

  const OwnerSubMenuPage({super.key, required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: context.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(16.w),
        itemCount: items.length,
        separatorBuilder: (context, index) =>
            Divider(height: 1, color: Colors.grey.shade200),
        itemBuilder: (context, index) {
          final item = items[index];
          return ListTile(
            contentPadding: EdgeInsets.symmetric(
              vertical: 8.h,
              horizontal: 8.w,
            ),
            leading: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: item.isWarning
                    ? Colors.red.withValues(alpha: 0.1)
                    : AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                item.icon,
                color: item.isWarning ? Colors.red : AppColors.primary,
                size: 24.sp,
              ),
            ),
            title: Text(
              item.title,
              style: context.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w500,
                color: item.isWarning ? Colors.red : Colors.black87,
              ),
            ),
            trailing: Icon(
              item.isWarning
                  ? Icons.warning_amber_rounded
                  : Icons.chevron_right,
              color: item.isWarning ? Colors.red : Colors.grey,
              size: 24.sp,
            ),
            onTap: item.onTap,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          );
        },
      ),
    );
  }
}
