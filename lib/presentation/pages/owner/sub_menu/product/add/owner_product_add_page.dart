import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qsir_app/core/themes/app_theme.dart';
import 'package:qsir_app/presentation/pages/owner/sub_menu/category/widgets/category_picker_bottom_sheet.dart';
import 'package:qsir_app/presentation/widgets/custom_input.dart';
import 'package:qsir_app/presentation/widgets/input_group.dart';

class OwnerProductAddPage extends StatefulWidget {
  const OwnerProductAddPage({super.key});

  @override
  State<OwnerProductAddPage> createState() => _OwnerProductAddPageState();
}

class _OwnerProductAddPageState extends State<OwnerProductAddPage> {
  final InputGroupController _controller = InputGroupController();
  bool useDiscount = false;
  double discountPercent = 0;
  double originalPrice = 0;

  @override
  void initState() {
    super.initState();
    _controller.getController('price').addListener(_updatePrice);
    _controller.getController('discount_percent').addListener(_updateDiscount);
  }

  void _updatePrice() {
    setState(() {
      originalPrice = double.tryParse(_controller.getText('price')) ?? 0;
    });
  }

  void _updateDiscount() {
    setState(() {
      discountPercent =
          double.tryParse(_controller.getText('discount_percent')) ?? 0;
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
                    key: 'use_discount',
                    customBuilder: (context, controller) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 24.w,
                                height: 24.w,
                                child: Checkbox(
                                  value: useDiscount,
                                  onChanged: (value) {
                                    setState(() {
                                      useDiscount = value ?? false;
                                    });
                                  },
                                  activeColor: AppColors.primary,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                "Gunakan Diskon",
                                style: context.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          if (useDiscount) ...[
                            SizedBox(height: 16.h),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: CustomInput(
                                    label: "Diskon (%)",
                                    controller: _controller.getController(
                                      'discount_percent',
                                    ),
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      hintText: '0',
                                      suffixText: '%',
                                    ),
                                  ),
                                ),
                                SizedBox(width: 16.w),
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Harga Setelah Diskon",
                                        style: context.textTheme.bodySmall
                                            ?.copyWith(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                      SizedBox(height: 8.h),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 16.w,
                                          vertical: 12.h,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade50,
                                          borderRadius: BorderRadius.circular(
                                            8.r,
                                          ),
                                          border: Border.all(
                                            color: Colors.grey.shade300,
                                          ),
                                        ),
                                        child: Text(
                                          "Rp ${(originalPrice * (1 - discountPercent / 100)).toStringAsFixed(0)}",
                                          style: context.textTheme.bodyLarge
                                              ?.copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.primary,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      );
                    },
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
                    readOnly: true,
                    onTap: () {
                      Get.bottomSheet(
                        CategoryPickerBottomSheet(
                          onSelected: (category) {
                            _controller.setText('category_id', category.name);
                          },
                        ),
                      );
                    },
                    decoration: const InputDecoration(
                      hintText: 'Pilih Kategori',
                      suffixIcon: Icon(Icons.arrow_drop_down),
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
