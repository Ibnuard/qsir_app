import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qsir_app/core/themes/app_theme.dart';
import 'package:qsir_app/presentation/pages/owner/sub_menu/category/detail/owner_category_detail_page.dart';

class CategoryItem {
  final String id;
  final String name;
  final IconData icon;

  CategoryItem({required this.id, required this.name, required this.icon});
}

class OwnerCategoryPage extends StatelessWidget {
  const OwnerCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data
    final List<CategoryItem> categories = [
      CategoryItem(id: '1', name: 'Makanan', icon: Icons.fastfood),
      CategoryItem(id: '2', name: 'Minuman', icon: Icons.local_drink),
      CategoryItem(id: '3', name: 'Snack', icon: Icons.cookie),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Kategori Produk",
          style: context.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(16.w),
        itemCount: categories.length,
        separatorBuilder: (context, index) =>
            Divider(height: 1, color: Colors.grey.shade200),
        itemBuilder: (context, index) {
          final item = categories[index];
          return ListTile(
            contentPadding: EdgeInsets.symmetric(
              vertical: 8.h,
              horizontal: 8.w,
            ),
            leading: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(item.icon, color: AppColors.primary, size: 24.sp),
            ),
            title: Text(
              item.name,
              style: context.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            trailing: Icon(
              Icons.chevron_right,
              color: Colors.grey,
              size: 24.sp,
            ),
            onTap: () {
              Get.to(() => OwnerCategoryDetailPage(), arguments: item);
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => OwnerCategoryDetailPage());
        },
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
