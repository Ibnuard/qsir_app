import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qsir_app/core/themes/app_theme.dart';

class ProductItem {
  final String id;
  final String name;
  final double price;
  final int stock;
  final String categoryId;
  final String sku;
  final String? imagePath;
  final int minStock;
  final double discountPercent;
  final bool useDiscount;

  ProductItem({
    required this.id,
    required this.name,
    required this.price,
    required this.stock,
    required this.categoryId,
    required this.sku,
    this.imagePath,
    required this.minStock,
    this.discountPercent = 0,
    this.useDiscount = false,
  });
}

class ProductCard extends StatelessWidget {
  final ProductItem product;
  final VoidCallback? onTap;

  const ProductCard({super.key, required this.product, this.onTap});

  Color _getStatusColor() {
    if (product.stock == 0) return AppColors.error;
    if (product.stock <= 10) return AppColors.warning;
    return AppColors.success;
  }

  String _getStatusText() {
    if (product.stock == 0) return 'Habis';
    if (product.stock <= 10) return 'Hampir Habis';
    return 'Aman';
  }

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12.r),
          child: Padding(
            padding: EdgeInsets.all(12.w),
            child: Row(
              children: [
                // Thumbnail
                Container(
                  width: 60.w,
                  height: 60.w,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceVariant,
                    borderRadius: BorderRadius.circular(8.r),
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
                          color: AppColors.textDisabled,
                          size: 24.sp,
                        )
                      : null,
                ),
                SizedBox(width: 12.w),
                // Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: context.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Text(
                            currencyFormatter.format(
                              product.useDiscount
                                  ? product.price *
                                        (1 - product.discountPercent / 100)
                                  : product.price,
                            ),
                            style: context.textTheme.bodyMedium?.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          if (product.useDiscount) ...[
                            SizedBox(width: 8.w),
                            Text(
                              currencyFormatter.format(product.price),
                              style: context.textTheme.bodySmall?.copyWith(
                                color: AppColors.textDisabled,
                                decoration: TextDecoration.lineThrough,
                                fontSize: 10.sp,
                              ),
                            ),
                          ],
                        ],
                      ),
                      if (product.useDiscount) ...[
                        SizedBox(height: 4.h),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.w,
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.error.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text(
                            'Diskon ${product.discountPercent.toStringAsFixed(0)}%',
                            style: context.textTheme.labelSmall?.copyWith(
                              color: AppColors.error,
                              fontSize: 9.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                      SizedBox(height: 4.h),
                      Text(
                        'Stok: ${product.stock}',
                        style: context.textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.w),
                // Status Chip
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: _getStatusColor().withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: _getStatusColor().withValues(alpha: 0.2),
                    ),
                  ),
                  child: Text(
                    _getStatusText(),
                    style: context.textTheme.labelSmall?.copyWith(
                      color: _getStatusColor(),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
