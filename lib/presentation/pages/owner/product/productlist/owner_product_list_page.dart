import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qsir_app/core/themes/app_theme.dart';
import 'package:qsir_app/presentation/widgets/custom_search_bar.dart';
import 'package:qsir_app/presentation/widgets/product/product_card.dart';
import 'package:qsir_app/routes/app_routes.dart';

class OwnerProductListPage extends StatelessWidget {
  const OwnerProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy Data
    final List<ProductItem> products = [
      ProductItem(
        id: '1',
        name: 'Kopi Susu Gula Aren',
        price: 18000,
        stock: 45,
        categoryId: 'minuman',
        sku: 'KPS-001',
        minStock: 10,
      ),
      ProductItem(
        id: '2',
        name: 'Americano Hot',
        price: 15000,
        stock: 8,
        categoryId: 'minuman',
        sku: 'KPS-002',
        minStock: 10,
      ),
      ProductItem(
        id: '3',
        name: 'Croissant Butter',
        price: 22000,
        stock: 0,
        categoryId: 'makanan',
        sku: 'KPS-003',
        minStock: 5,
      ),
      ProductItem(
        id: '4',
        name: 'Red Velvet Latte',
        price: 24000,
        stock: 12,
        categoryId: 'minuman',
        sku: 'KPS-004',
        minStock: 10,
      ),
      ProductItem(
        id: '5',
        name: 'Mineral Water 600ml',
        price: 5000,
        stock: 100,
        categoryId: 'minuman',
        sku: 'KPS-005',
        minStock: 20,
      ),
      ProductItem(
        id: '6',
        name: 'Donat Kampung',
        price: 8000,
        stock: 3,
        categoryId: 'makanan',
        sku: 'KPS-006',
        minStock: 10,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Daftar Produk",
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
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.w),
              child: CustomSearchBar(
                hintText: "Cari produk...",
                onChanged: (value) {},
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                itemCount: products.length,
                separatorBuilder: (context, index) => SizedBox(height: 12.h),
                itemBuilder: (context, index) {
                  return ProductCard(
                    product: products[index],
                    onTap: () {
                      Get.toNamed(
                        AppRoutes.ownerProductDetail,
                        arguments: products[index],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(AppRoutes.ownerProductAdd),
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
