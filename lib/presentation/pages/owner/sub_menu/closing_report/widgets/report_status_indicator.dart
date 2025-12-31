import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qsir_app/core/themes/app_theme.dart';
import 'package:qsir_app/presentation/pages/owner/sub_menu/cash_diff/models/cash_diff_record.dart';

class ReportStatusIndicator extends StatelessWidget {
  final CashDiffRecord record;
  final String Function(double) formatCurrency;

  const ReportStatusIndicator({
    super.key,
    required this.record,
    required this.formatCurrency,
  });

  @override
  Widget build(BuildContext context) {
    final color = record.amount < 0
        ? AppColors.error
        : (record.amount > 0 ? Colors.orange : AppColors.success);
    final isDifference = record.amount != 0;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: color.withValues(alpha: 0.2), width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (isDifference)
                      Icon(
                        Icons.warning_amber_rounded,
                        color: color,
                        size: 16.sp,
                      ),
                    if (isDifference) SizedBox(width: 6.w),
                    Text(
                      record.amount < 0
                          ? 'Kurang'
                          : (record.amount > 0 ? 'Lebih' : 'Seimbang'),
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                Text(
                  formatCurrency(record.amount),
                  style: context.textTheme.headlineSmall?.copyWith(
                    color: color,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
          if (isDifference)
            Icon(
              Icons.error_outline,
              color: color.withValues(alpha: 0.5),
              size: 32.sp,
            ),
        ],
      ),
    );
  }
}
