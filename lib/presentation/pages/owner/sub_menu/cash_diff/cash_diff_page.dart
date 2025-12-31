import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qsir_app/core/themes/app_theme.dart';
import 'package:qsir_app/presentation/pages/owner/sub_menu/cash_diff/controllers/cash_diff_controller.dart';
import 'package:qsir_app/presentation/pages/owner/sub_menu/cash_diff/models/cash_diff_record.dart';
import 'package:qsir_app/presentation/widgets/date_selector.dart';
import 'package:qsir_app/routes/app_routes.dart';

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
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (controller.latestShift.value != null) ...[
                      SizedBox(height: 8.h),
                      _buildStatusIndicator(
                        context,
                        controller.latestShift.value!,
                      ),
                      SizedBox(height: 20.h),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () =>
                              Get.toNamed(AppRoutes.ownerClosingReport),
                          icon: const Icon(Icons.summarize, size: 18),
                          label: const Text("Lihat Laporan Penutupan"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            elevation: 0,
                          ),
                        ),
                      ),
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
                                    style: context.textTheme.bodySmall
                                        ?.copyWith(
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
              ),
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
    Get.toNamed(AppRoutes.ownerClosingReport, arguments: record);
  }
}
