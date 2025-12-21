import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qsir_app/presentation/widgets/custom_search_bar.dart';
import 'package:qsir_app/presentation/widgets/product/product_card.dart';

class OwnerProductListPage extends StatelessWidget {
  const OwnerProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy Data
    final List<ProductItem> products = [
      ProductItem(name: 'Kopi Susu Gula Aren', price: 18000, stock: 45),
      ProductItem(name: 'Americano Hot', price: 15000, stock: 8),
      ProductItem(name: 'Croissant Butter', price: 22000, stock: 0),
      ProductItem(name: 'Red Velvet Latte', price: 24000, stock: 12),
      ProductItem(name: 'Mineral Water 600ml', price: 5000, stock: 100),
      ProductItem(name: 'Donat Kampung', price: 8000, stock: 3),
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
                      // TODO: Navigate to product detail
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
