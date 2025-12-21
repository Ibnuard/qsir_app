import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qsir_app/core/themes/app_theme.dart';
import 'package:qsir_app/presentation/widgets/input_group.dart';

class OwnerProductAddPage extends StatefulWidget {
  const OwnerProductAddPage({super.key});

  @override
  State<OwnerProductAddPage> createState() => _OwnerProductAddPageState();
}

class _OwnerProductAddPageState extends State<OwnerProductAddPage> {
  final InputGroupController _controller = InputGroupController();

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
          "Tambah Produk",
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
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_a_photo_outlined,
                        color: AppColors.textSecondary,
                        size: 32.sp,
                      ),
                      SizedBox(height: 8.h),
                      Text("Foto Produk", style: context.textTheme.bodySmall),
                    ],
                  ),
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
                    label: 'Stok Awal',
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
        child: SizedBox(
          width: double.infinity,
          height: 48.h,
          child: ElevatedButton(
            onPressed: () {
              // TODO: Implement save logic
              Get.back();
            },
            child: const Text("Simpan Produk"),
          ),
        ),
      ),
    );
  }
}
