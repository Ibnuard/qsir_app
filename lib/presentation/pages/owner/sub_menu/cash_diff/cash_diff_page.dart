import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qsir_app/core/themes/app_theme.dart';
import 'package:qsir_app/presentation/pages/owner/sub_menu/cash_diff/controllers/cash_diff_controller.dart';
import 'package:qsir_app/presentation/pages/owner/sub_menu/cash_diff/models/cash_diff_record.dart';
import 'package:qsir_app/presentation/pages/owner/sub_menu/cash_diff/widgets/cash_diff_empty_state.dart';
import 'package:qsir_app/presentation/pages/owner/sub_menu/cash_diff/widgets/cash_diff_history_card.dart';
import 'package:qsir_app/presentation/pages/owner/sub_menu/cash_diff/widgets/cash_diff_status_indicator.dart';
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
          return const CashDiffEmptyState();
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
                      CashDiffStatusIndicator(
                        record: controller.latestShift.value!,
                        formatCurrency: controller.formatCurrency,
                        getStatusColor: controller.getStatusColor,
                        getStatusLabel: controller.getStatusLabel,
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
                            onTap: () =>
                                Get.toNamed(AppRoutes.ownerCashDiffHistory),
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
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  SizedBox(width: 4.w),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 10.sp,
                                    color: AppColors.primary,
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

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: context.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.bold,
        color: Colors.black87,
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
          .map(
            (record) => CashDiffHistoryCard(
              record: record,
              onTap: () => _showDetailModal(context, record),
              formatCurrency: controller.formatCurrency,
              formatDate: controller.formatDate,
              formatTime: controller.formatTime,
              getStatusColor: controller.getStatusColor,
              getStatusLabel: controller.getStatusLabel,
            ),
          )
          .toList(),
    );
  }

  void _showDetailModal(BuildContext context, CashDiffRecord record) {
    Get.toNamed(AppRoutes.ownerClosingReport, arguments: record);
  }
}
