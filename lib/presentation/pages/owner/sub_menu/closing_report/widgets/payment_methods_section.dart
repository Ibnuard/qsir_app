import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qsir_app/presentation/pages/owner/sub_menu/cash_diff/models/cash_diff_record.dart';
import 'breakdown_item_row.dart';

class PaymentMethodsSection extends StatelessWidget {
  final List<PaymentMethodItem> items;
  final String Function(double) formatCurrency;

  const PaymentMethodsSection({
    super.key,
    required this.items,
    required this.formatCurrency,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Metode Pembayaran",
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
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
                    label: item.method,
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
