import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qsir_app/core/themes/app_theme.dart';
import 'package:qsir_app/presentation/pages/owner/sub_menu/cash_diff/models/cash_diff_record.dart';
import 'package:qsir_app/routes/app_routes.dart';
import 'breakdown_item_row.dart';

class SalesBreakdownSection extends StatelessWidget {
  final List<SalesBreakdownItem> items;
  final String Function(double) formatCurrency;

  const SalesBreakdownSection({
    super.key,
    required this.items,
    required this.formatCurrency,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total Penjualan",
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            TextButton(
              onPressed: () => Get.toNamed(
                AppRoutes.ownerClosingReportSales,
                arguments: items,
              ),
              child: Text(
                "Tampilkan Semua",
                style: context.textTheme.bodySmall?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: Colors.grey.shade100),
          ),
          child: Column(
            children: items
                .map(
                  (item) => BreakdownItemRow(
                    label: item.label,
                    count: item.count,
                    amount: item.amount,
                    formatCurrency: formatCurrency,
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
