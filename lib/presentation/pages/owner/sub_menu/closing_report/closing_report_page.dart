import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qsir_app/core/themes/app_theme.dart';
import 'package:qsir_app/presentation/pages/owner/sub_menu/cash_diff/models/cash_diff_record.dart';
import 'package:qsir_app/presentation/pages/owner/sub_menu/closing_report/controllers/closing_report_controller.dart';
import 'package:qsir_app/presentation/widgets/date_selector.dart';

class ClosingReportPage extends GetView<ClosingReportController> {
  const ClosingReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Laporan Penutupan",
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
        final report = controller.report.value;
        if (report == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8.h),
              DateSelector(
                selectedDate: controller.selectedDate.value,
                onDateSelected: controller.onDateChanged,
              ),
              SizedBox(height: 12.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildStatusIndicator(context, report),
                    SizedBox(height: 16.h),
                    _buildShiftInfoCard(context, report),
                    SizedBox(height: 24.h),
                    _buildSectionTitle(context, "Ringkasan Keuangan"),
                    SizedBox(height: 12.h),
                    _buildSummaryGrid(context, report),
                    SizedBox(height: 24.h),
                    _buildSectionTitle(context, "Sisa Saldo Kas (Selisih)"),
                    SizedBox(height: 12.h),
                    _buildBreakdownSection(context, report),
                    if (report.salesBreakdown != null &&
                        report.salesBreakdown!.isNotEmpty) ...[
                      SizedBox(height: 24.h),
                      _buildSectionTitle(context, "Total Penjualan"),
                      SizedBox(height: 12.h),
                      _buildSalesBreakdown(context, report.salesBreakdown!),
                    ],
                    if (report.paymentMethods != null &&
                        report.paymentMethods!.isNotEmpty) ...[
                      SizedBox(height: 24.h),
                      _buildSectionTitle(context, "Metode Pembayaran"),
                      SizedBox(height: 12.h),
                      _buildPaymentMethods(context, report.paymentMethods!),
                    ],
                    if (report.note != null && report.note!.isNotEmpty) ...[
                      SizedBox(height: 24.h),
                      _buildSectionTitle(context, "Catatan"),
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
                          report.note!,
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ],
                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
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

  Widget _buildShiftInfoCard(BuildContext context, CashDiffRecord record) {
    return Container(
      padding: EdgeInsets.all(16.w),
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
            controller.formatCurrency(record.saldoSistem),
          ),
          SizedBox(height: 16.h),
          _buildFormulaRow(
            context,
            "Selisih Kas",
            "Saldo Fisik - Saldo Sistem",
            controller.formatCurrency(record.amount),
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

  Widget _buildSalesBreakdown(
    BuildContext context,
    List<SalesBreakdownItem> items,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        children: items
            .map(
              (item) => _buildBreakdownRow(
                context,
                item.label,
                item.count,
                item.amount,
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildPaymentMethods(
    BuildContext context,
    List<PaymentMethodItem> items,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        children: items
            .map(
              (item) => _buildBreakdownRow(
                context,
                item.method,
                item.count,
                item.amount,
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildBreakdownRow(
    BuildContext context,
    String label,
    int count,
    double amount,
  ) {
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
            controller.formatCurrency(amount),
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusIndicator(BuildContext context, CashDiffRecord record) {
    final color = controller.report.value!.amount < 0
        ? AppColors.error
        : (controller.report.value!.amount > 0
              ? Colors.orange
              : AppColors.success);
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
}
