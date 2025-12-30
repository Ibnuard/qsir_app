import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qsir_app/core/themes/app_theme.dart';
import 'package:qsir_app/presentation/pages/owner/sub_menu/category/detail/widgets/category_icon_selector.dart';
import 'package:qsir_app/presentation/pages/owner/sub_menu/category/detail/widgets/icon_picker_bottom_sheet.dart';
import 'package:qsir_app/presentation/pages/owner/sub_menu/category/list/owner_category_page.dart';
import 'package:qsir_app/presentation/widgets/input_group.dart';

class OwnerCategoryDetailPage extends StatefulWidget {
  const OwnerCategoryDetailPage({super.key});

  @override
  State<OwnerCategoryDetailPage> createState() =>
      _OwnerCategoryDetailPageState();
}

class _OwnerCategoryDetailPageState extends State<OwnerCategoryDetailPage> {
  final InputGroupController _controller = InputGroupController();
  CategoryItem? category;
  IconData selectedIcon = Icons.category; // Default icon

  final List<IconData> availableIcons = [
    Icons.fastfood,
    Icons.local_drink,
    Icons.cookie,
    Icons.cake,
    Icons.icecream,
    Icons.restaurant,
    Icons.local_cafe,
    Icons.local_bar,
    Icons.local_pizza,
    Icons.ramen_dining,
    Icons.shopping_bag,
    Icons.inventory,
    Icons.grid_view,
    Icons.category,
    Icons.star,
    Icons.favorite,
  ];

  @override
  void initState() {
    super.initState();
    if (Get.arguments is CategoryItem) {
      category = Get.arguments as CategoryItem;
      _initializeData();
    }
  }

  void _initializeData() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (category != null) {
        _controller.getController('name').text = category!.name;
        setState(() {
          selectedIcon = category!.icon;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showIconPicker() {
    Get.bottomSheet(
      IconPickerBottomSheet(
        selectedIcon: selectedIcon,
        availableIcons: availableIcons,
        onIconSelected: (icon) {
          setState(() {
            selectedIcon = icon;
          });
        },
      ),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      ignoreSafeArea: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          category != null ? "Detail Kategori" : "Tambah Kategori",
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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CategoryIconSelector(
                selectedIcon: selectedIcon,
                onTap: _showIconPicker,
              ),
              SizedBox(height: 32.h),

              // Form Fields
              InputGroup(
                controller: _controller,
                items: [
                  InputGroupItem(
                    key: 'name',
                    label: 'Nama Kategori',
                    decoration: const InputDecoration(
                      hintText: 'Contoh: Makanan',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(
          left: 16.w,
          right: 16.w,
          top: 16.w,
          bottom: 16.w + MediaQuery.of(context).padding.bottom,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Row(
          children: [
            if (category != null) ...[
              Expanded(
                child: SizedBox(
                  height: 48.h,
                  child: OutlinedButton(
                    onPressed: () {
                      // TODO: Implement delete logic
                      Get.back();
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.error,
                      side: const BorderSide(color: AppColors.error),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: const Text("Hapus"),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
            ],
            Expanded(
              child: SizedBox(
                height: 48.h,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Implement save/update logic
                    Get.back();
                  },
                  child: const Text("Simpan"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
