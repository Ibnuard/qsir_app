import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BreakdownItemRow extends StatelessWidget {
  final String label;
  final int count;
  final double amount;
  final String Function(double) formatCurrency;

  const BreakdownItemRow({
    super.key,
    required this.label,
    required this.count,
    required this.amount,
    required this.formatCurrency,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade50)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  "$count transaksi",
                  style: context.textTheme.bodySmall?.copyWith(
                    color: Colors.grey,
                    fontSize: 10.sp,
                  ),
                ),
              ],
            ),
          ),
          Text(
            formatCurrency(amount),
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
