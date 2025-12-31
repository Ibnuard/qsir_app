import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qsir_app/core/themes/app_theme.dart';
import 'package:qsir_app/presentation/pages/owner/sub_menu/cash_diff/models/cash_diff_record.dart';

class CalculationBreakdown extends StatelessWidget {
  final CashDiffRecord record;
  final String Function(double) formatCurrency;

  const CalculationBreakdown({
    super.key,
    required this.record,
    required this.formatCurrency,
  });

  @override
  Widget build(BuildContext context) {
    final statusColor = record.amount < 0
        ? AppColors.error
        : (record.amount > 0 ? Colors.orange : AppColors.success);

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFormulaRow(
            context,
            "Saldo Sistem",
            "Saldo Awal + Penjualan + In - Out",
            formatCurrency(record.saldoSistem),
          ),
          SizedBox(height: 16.h),
          _buildFormulaRow(
            context,
            "Selisih Kas",
            "Saldo Fisik - Saldo Sistem",
            formatCurrency(record.amount),
            valueColor: statusColor,
          ),
        ],
      ),
    );
  }

  Widget _buildFormulaRow(
    BuildContext context,
    String title,
    String formula,
    String result, {
    Color? valueColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.textSecondary,
          ),
        ),
        SizedBox(height: 4.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                formula,
                style: context.textTheme.bodySmall?.copyWith(
                  color: Colors.grey,
                  fontSize: 10.sp,
                ),
              ),
            ),
            Text(
              result,
              style: context.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: valueColor ?? Colors.black87,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
