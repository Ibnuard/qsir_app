import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qsir_app/core/themes/app_theme.dart';
import 'package:qsir_app/presentation/pages/owner/sub_menu/cash_diff/controllers/cash_diff_controller.dart';
import 'package:qsir_app/presentation/pages/owner/sub_menu/cash_diff/models/cash_diff_record.dart';
import 'package:qsir_app/presentation/pages/owner/sub_menu/cash_diff/widgets/cash_diff_detail_modal.dart';

class CashDiffPage extends GetView<CashDiffController> {
  const CashDiffPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Selisih Kas",
          style: context.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Obx(() {
        if (controller.latestShift.value == null &&
            controller.history.isEmpty) {
          return _buildEmptyState(context);
        }

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),
              if (controller.latestShift.value != null) ...[
                _buildSectionTitle(context, "Shift Hari Ini"),
                SizedBox(height: 4.h),
                Text(
                  "Ringkasan untuk shift hari ini",
                  style: context.textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                SizedBox(height: 12.h),
                _buildStatusIndicator(context, controller.latestShift.value!),
                SizedBox(height: 24.h),
                _buildSectionTitle(context, "Ringkasan Keuangan"),
                SizedBox(height: 12.h),
                _buildSummaryGrid(context, controller.latestShift.value!),
                SizedBox(height: 24.h),
                _buildSectionTitle(context, "Rincian Perhitungan"),
                SizedBox(height: 12.h),
                _buildBreakdownSection(context, controller.latestShift.value!),
                SizedBox(height: 24.h),
                _buildSectionTitle(context, "Informasi Shift"),
                SizedBox(height: 12.h),
                _buildShiftInfoCard(context, controller.latestShift.value!),
                SizedBox(height: 32.h),
              ],
              if (controller.history.isNotEmpty) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildSectionTitle(context, "Riwayat Selisih Kas"),
                    InkWell(
                      onTap: null, // No action as requested
                      borderRadius: BorderRadius.circular(8.r),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Lihat Semua",
                              style: context.textTheme.bodySmall?.copyWith(
                                color: AppColors.primary.withValues(
                                  alpha: 0.5,
                                ), // Muted for no action
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 4.w),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 10.sp,
                              color: AppColors.primary.withValues(
                                alpha: 0.5,
                              ), // Muted for no action
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                _buildHistorySection(context),
                SizedBox(height: 40.h),
              ],
            ],
          ),
        );
      }),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.account_balance_wallet_outlined,
            size: 64.sp,
            color: Colors.grey.shade300,
          ),
          SizedBox(height: 16.h),
          Text(
            "Belum ada data selisih kas",
            style: context.textTheme.bodyMedium?.copyWith(color: Colors.grey),
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

  Widget _buildStatusIndicator(BuildContext context, CashDiffRecord record) {
    final color = controller.getStatusColor(record.amount);
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
                      controller.getStatusLabel(record.amount),
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                Text(
                  controller.formatCurrency(record.amount),
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

  Widget _buildSummaryGrid(BuildContext context, CashDiffRecord record) {
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

  Widget _buildBreakdownSection(BuildContext context, CashDiffRecord record) {
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

  Widget _buildShiftInfoCard(BuildContext context, CashDiffRecord record) {
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
            Icons.calendar_today_outlined,
            "Tanggal",
            controller.formatDate(record.openedAt),
          ),
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

  Widget _buildHistorySection(BuildContext context) {
    var allRecords = controller.history.values
        .expand((element) => element)
        .toList();
    var recordsToShow = controller.isHistoryExpanded.value
        ? allRecords
        : allRecords.take(3).toList();

    return Column(
      children: recordsToShow
          .map((record) => _buildHistoryItem(context, record))
          .toList(),
    );
  }

  Widget _buildHistoryItem(BuildContext context, CashDiffRecord record) {
    final color = controller.getStatusColor(record.amount);

    return InkWell(
      onTap: () => _showDetailModal(context, record),
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: Colors.grey.shade100),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                record.amount == 0
                    ? Icons.check_circle_outline
                    : Icons.warning_amber_rounded,
                color: color,
                size: 20.sp,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.formatDate(record.openedAt),
                    style: context.textTheme.bodySmall?.copyWith(
                      color: Colors.grey,
                      fontSize: 10.sp,
                    ),
                  ),
                  Text(
                    "${controller.formatTime(record.openedAt)} - ${controller.formatTime(record.closedAt)}",
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    controller.getStatusLabel(record.amount),
                    style: context.textTheme.bodySmall?.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  controller.formatCurrency(record.amount),
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                Text(
                  controller.formatCurrency(record.saldoFisik),
                  style: context.textTheme.bodySmall?.copyWith(
                    fontSize: 10.sp,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(width: 8.w),
            Icon(Icons.chevron_right, size: 18.sp, color: Colors.grey.shade300),
          ],
        ),
      ),
    );
  }

  void _showDetailModal(BuildContext context, CashDiffRecord record) {
    Get.bottomSheet(
      CashDiffDetailModal(record: record, controller: controller),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
}
