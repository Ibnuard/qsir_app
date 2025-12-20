import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeMainMenu extends StatelessWidget {
  const HomeMainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> menuItems = [
      {
        'label': 'Produk & Stock',
        'icon': Icons.inventory_2_rounded,
        'colors': [const Color(0xFF2196F3), const Color(0xFF64B5F6)],
      },
      {
        'label': 'Kas & Shift',
        'icon': Icons.point_of_sale_rounded,
        'colors': [const Color(0xFF4CAF50), const Color(0xFF81C784)],
      },
      {
        'label': 'Managemen Kasir',
        'icon': Icons.badge_rounded,
        'colors': [const Color(0xFFFF9800), const Color(0xFFFFB74D)],
      },
      {
        'label': 'Pelanggan',
        'icon': Icons.groups_rounded,
        'colors': [const Color(0xFF9C27B0), const Color(0xFFBA68C8)],
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.w,
        mainAxisSpacing: 16.h,
        childAspectRatio: 1.5,
      ),
      itemCount: menuItems.length,
      itemBuilder: (context, index) {
        final item = menuItems[index];
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: item['colors'] as List<Color>,
            ),
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: (item['colors'] as List<Color>).first.withValues(
                  alpha: 0.3,
                ),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(16.r),
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Icon(
                        item['icon'] as IconData,
                        color: Colors.white,
                        size: 24.sp,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      item['label'] as String,
                      style: context.textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
