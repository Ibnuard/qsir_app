import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qsir_app/core/themes/app_theme.dart';
import 'package:qsir_app/presentation/pages/owner/sub_menu/cash_diff/controllers/cash_diff_controller.dart';
import 'package:qsir_app/presentation/pages/owner/sub_menu/cash_diff/models/cash_diff_record.dart';

class CashDiffDetailModal extends StatelessWidget {
  final CashDiffRecord record;
  final CashDiffController controller;

  const CashDiffDetailModal({
    super.key,
    required this.record,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: 0.85.sh),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.only(top: 12.h),
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(24.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Detail Selisih Kas",
                  style: context.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.close),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 40.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildStatusIndicator(context),
                  SizedBox(height: 24.h),
                  _buildSummaryGrid(context),
                  SizedBox(height: 24.h),
                  _buildBreakdownSection(context),
                  SizedBox(height: 24.h),
                  _buildShiftInfoCard(context),
                  if (record.note != null && record.note!.isNotEmpty) ...[
                    SizedBox(height: 24.h),
                    _buildSectionTitle(context, "Catatan / Penjelasan"),
                    SizedBox(height: 12.h),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Text(
                        record.note!,
                        style: context.textTheme.bodyMedium?.copyWith(
                          fontStyle: FontStyle.italic,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusIndicator(BuildContext context) {
    final color = controller.getStatusColor(record.amount);
    final isDifference = record.amount != 0;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: color.withValues(alpha: 0.2), width: 1.5),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isDifference)
                Icon(Icons.warning_amber_rounded, color: color, size: 24.sp),
              if (isDifference) SizedBox(width: 8.w),
              Text(
                controller.getStatusLabel(record.amount),
                style: context.textTheme.titleMedium?.copyWith(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            controller.formatCurrency(record.amount),
            style: context.textTheme.headlineLarge?.copyWith(
              color: color,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: context.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildSummaryGrid(BuildContext context) {
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
            controller.formatCurrency(record.saldoAwal),
          ),
          _buildSummaryItem(
            context,
            "Penjualan Cash",
            controller.formatCurrency(record.penjualanCash),
          ),
          _buildSummaryItem(
            context,
            "Cash In",
            controller.formatCurrency(record.cashIn),
            color: AppColors.success,
          ),
          _buildSummaryItem(
            context,
            "Cash Out",
            "- ${controller.formatCurrency(record.cashOut)}",
            color: AppColors.error,
          ),
          _buildSummaryItem(
            context,
            "Saldo Sistem",
            controller.formatCurrency(record.saldoSistem),
            isBold: true,
          ),
          _buildSummaryItem(
            context,
            "Saldo Fisik",
            controller.formatCurrency(record.saldoFisik),
            isBold: true,
          ),
          _buildSummaryItem(
            context,
            "Selisih Kas",
            controller.formatCurrency(record.amount),
            color: controller.getStatusColor(record.amount),
            isBold: true,
            isHighlighted: true,
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

  Widget _buildBreakdownSection(BuildContext context) {
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
            controller.formatCurrency(record.saldoSistem),
          ),
          SizedBox(height: 16.h),
          _buildFormulaRow(
            context,
            "Selisih Kas",
            "Saldo Fisik - Saldo Sistem",
            controller.formatCurrency(record.amount),
            valueColor: controller.getStatusColor(record.amount),
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

  Widget _buildShiftInfoCard(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        children: [
          _buildInfoRow(context, Icons.tag, "Shift ID", record.id),
          SizedBox(height: 12.h),
          _buildInfoRow(
            context,
            Icons.person_outline,
            "Dibuka oleh",
            record.openedBy,
          ),
          SizedBox(height: 12.h),
          _buildInfoRow(
            context,
            Icons.access_time,
            "Waktu buka",
            controller.formatTime(record.openedAt),
          ),
          SizedBox(height: 12.h),
          _buildInfoRow(context, Icons.person, "Ditutup oleh", record.closedBy),
          SizedBox(height: 12.h),
          _buildInfoRow(
            context,
            Icons.access_time_filled,
            "Waktu tutup",
            controller.formatTime(record.closedAt),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    return Row(
      children: [
        Icon(icon, size: 14.sp, color: Colors.grey),
        SizedBox(width: 10.w),
        Text(
          label,
          style: context.textTheme.bodySmall?.copyWith(color: Colors.grey),
        ),
        const Spacer(),
        Text(
          value,
          style: context.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
