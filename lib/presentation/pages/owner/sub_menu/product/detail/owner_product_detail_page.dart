import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qsir_app/core/themes/app_theme.dart';
import 'package:qsir_app/presentation/widgets/input_group.dart';
import 'package:qsir_app/presentation/widgets/product/product_card.dart';

class OwnerProductDetailPage extends StatefulWidget {
  const OwnerProductDetailPage({super.key});

  @override
  State<OwnerProductDetailPage> createState() => _OwnerProductDetailPageState();
}

class _OwnerProductDetailPageState extends State<OwnerProductDetailPage> {
  final InputGroupController _controller = InputGroupController();
  late ProductItem product;

  @override
  void initState() {
    super.initState();
    if (Get.arguments is ProductItem) {
      product = Get.arguments as ProductItem;
      _initializeData();
    } else {
      // Handle error or redirect
      Get.back();
    }
  }

  void _initializeData() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.getController('name').text = product.name;
      _controller.getController('price').text = product.price.toStringAsFixed(
        0,
      );
      _controller.getController('stock').text = product.stock.toString();
      _controller.getController('category_id').text = product.categoryId;
      _controller.getController('sku').text = product.sku;
      _controller.getController('min_stock').text = product.minStock.toString();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Detail Produk",
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
              // Image Placeholder
              Center(
                child: Container(
                  width: 120.w,
                  height: 120.w,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceVariant,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: AppColors.border),
                    image: product.imagePath != null
                        ? DecorationImage(
                            image: NetworkImage(product.imagePath!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: product.imagePath == null
                      ? Icon(
                          Icons.image_not_supported_outlined,
                          color: AppColors.textSecondary,
                          size: 32.sp,
                        )
                      : null,
                ),
              ),
              SizedBox(height: 24.h),

              // Form Fields
              InputGroup(
                controller: _controller,
                items: [
                  InputGroupItem(
                    key: 'name',
                    label: 'Nama Produk',
                    decoration: const InputDecoration(
                      hintText: 'Contoh: Kopi Susu',
                    ),
                  ),
                  InputGroupItem(
                    key: 'price',
                    label: 'Harga',
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(hintText: '0'),
                  ),
                  InputGroupItem(
                    key: 'stock',
                    label: 'Stok Saat Ini',
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(hintText: '0'),
                  ),
                  InputGroupItem(
                    key: 'category_id',
                    label: 'Kategori',
                    decoration: const InputDecoration(
                      hintText: 'Pilih Kategori',
                    ),
                  ),
                  InputGroupItem(
                    key: 'sku',
                    label: 'SKU (Kode Produk)',
                    decoration: InputDecoration(
                      hintText: 'Contoh: KPS-001',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.qr_code_scanner),
                        onPressed: () {
                          // TODO: Implement scan logic
                        },
                      ),
                    ),
                  ),
                  InputGroupItem(
                    key: 'min_stock',
                    label: 'Minimal Stok (Alert)',
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(hintText: '10'),
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
            Expanded(
              child: SizedBox(
                height: 48.h,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Implement update logic
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
