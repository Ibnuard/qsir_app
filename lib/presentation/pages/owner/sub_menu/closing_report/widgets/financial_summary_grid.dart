import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qsir_app/core/themes/app_theme.dart';
import 'package:qsir_app/presentation/pages/owner/sub_menu/cash_diff/models/cash_diff_record.dart';

class FinancialSummaryGrid extends StatelessWidget {
  final CashDiffRecord record;
  final String Function(double) formatCurrency;

  const FinancialSummaryGrid({
    super.key,
    required this.record,
    required this.formatCurrency,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        children: [
          _buildSummaryItem(
            context,
            "Saldo Awal",
            formatCurrency(record.saldoAwal),
          ),
          _buildSummaryItem(
            context,
            "Penjualan Cash",
            formatCurrency(record.penjualanCash),
          ),
          _buildSummaryItem(
            context,
            "Cash In",
            formatCurrency(record.cashIn),
            color: AppColors.success,
          ),
          _buildSummaryItem(
            context,
            "Cash Out",
            "- ${formatCurrency(record.cashOut)}",
            color: AppColors.error,
          ),
          _buildSummaryItem(
            context,
            "Saldo Sistem",
            formatCurrency(record.saldoSistem),
            isBold: true,
          ),
          _buildSummaryItem(
            context,
            "Saldo Fisik",
            formatCurrency(record.saldoFisik),
            isBold: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(
    BuildContext context,
    String label,
    String value, {
    Color? color,
    bool isBold = false,
    bool isHighlighted = false,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: isHighlighted
          ? BoxDecoration(
              color: (color ?? Colors.black).withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12.r),
            )
          : null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: context.textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: context.textTheme.bodyMedium?.copyWith(
              color: color ?? Colors.black87,
              fontWeight: isBold || isHighlighted
                  ? FontWeight.bold
                  : FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
