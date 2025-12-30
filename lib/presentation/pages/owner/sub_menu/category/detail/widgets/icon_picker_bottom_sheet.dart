import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qsir_app/core/themes/app_theme.dart';

class IconPickerBottomSheet extends StatelessWidget {
  final IconData selectedIcon;
  final List<IconData> availableIcons;
  final Function(IconData) onIconSelected;

  const IconPickerBottomSheet({
    super.key,
    required this.selectedIcon,
    required this.availableIcons,
    required this.onIconSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.85,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 32.w), // Spacer for centering
              Text(
                "Pilih Icon",
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(Icons.close),
                visualDensity: VisualDensity.compact,
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                mainAxisSpacing: 12.w,
                crossAxisSpacing: 12.w,
              ),
              itemCount: availableIcons.length,
              itemBuilder: (context, index) {
                final icon = availableIcons[index];
                final isSelected = icon == selectedIcon;
                return InkWell(
                  onTap: () {
                    onIconSelected(icon);
                    Get.back();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primary.withValues(alpha: 0.1)
                          : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8.r),
                      border: isSelected
                          ? Border.all(color: AppColors.primary, width: 2)
                          : null,
                    ),
                    child: Icon(
                      icon,
                      color: isSelected ? AppColors.primary : Colors.grey,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
