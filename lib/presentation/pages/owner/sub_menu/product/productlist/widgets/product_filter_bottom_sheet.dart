import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qsir_app/core/themes/app_theme.dart';

class ProductFilterBottomSheet extends StatefulWidget {
  const ProductFilterBottomSheet({super.key});

  @override
  State<ProductFilterBottomSheet> createState() =>
      _ProductFilterBottomSheetState();
}

class _ProductFilterBottomSheetState extends State<ProductFilterBottomSheet> {
  String selectedCategory = 'Semua';
  String selectedStockStatus = 'Semua';
  String selectedSort = 'Terbaru';

  final List<String> categories = ['Semua', 'Makanan', 'Minuman', 'Snack'];
  final List<String> stockStatuses = ['Semua', 'Stok Sedikit', 'Stok Habis'];
  final List<String> sortOptions = ['Terbaru', 'Terlama'];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Filter Produk",
                style: context.textTheme.titleLarge?.copyWith(
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
          SizedBox(height: 24.h),

          // Category Filter
          _buildSectionTitle("Kategori"),
          SizedBox(height: 12.h),
          Wrap(
            spacing: 8.w,
            children: categories
                .map(
                  (cat) => _buildChip(cat, selectedCategory, (val) {
                    setState(() => selectedCategory = val);
                  }),
                )
                .toList(),
          ),
          SizedBox(height: 24.h),

          // Stock Status Filter
          _buildSectionTitle("Status Stok"),
          SizedBox(height: 12.h),
          Wrap(
            spacing: 8.w,
            children: stockStatuses
                .map(
                  (status) => _buildChip(status, selectedStockStatus, (val) {
                    setState(() => selectedStockStatus = val);
                  }),
                )
                .toList(),
          ),
          SizedBox(height: 24.h),

          // Sorting
          _buildSectionTitle("Urutkan"),
          SizedBox(height: 12.h),
          Wrap(
            spacing: 8.w,
            children: sortOptions
                .map(
                  (opt) => _buildChip(
                    opt == 'Terbaru' ? 'Terbaru' : 'Terlama',
                    selectedSort,
                    (val) {
                      setState(() => selectedSort = val);
                    },
                  ),
                )
                .toList(),
          ),
          SizedBox(height: 32.h),

          // Actions
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    setState(() {
                      selectedCategory = 'Semua';
                      selectedStockStatus = 'Semua';
                      selectedSort = 'Terbaru';
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    side: const BorderSide(color: AppColors.error),
                    foregroundColor: AppColors.error,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: const Text("Reset"),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Implement apply logic
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: const Text("Terapkan"),
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: context.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildChip(
    String label,
    String selectedValue,
    Function(String) onSelected,
  ) {
    final isSelected = label == selectedValue;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        if (selected) onSelected(label);
      },
      selectedColor: AppColors.primary.withValues(alpha: 0.1),
      labelStyle: TextStyle(
        color: isSelected ? AppColors.primary : Colors.black87,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
        side: BorderSide(
          color: isSelected ? AppColors.primary : Colors.grey.shade300,
        ),
      ),
      backgroundColor: Colors.white,
      showCheckmark: false,
    );
  }
}
