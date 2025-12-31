import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qsir_app/core/themes/app_theme.dart';
import 'package:qsir_app/presentation/pages/owner/sub_menu/closing_report/controllers/closing_report_controller.dart';
import 'package:qsir_app/presentation/pages/owner/sub_menu/closing_report/widgets/calculation_breakdown.dart';
import 'package:qsir_app/presentation/pages/owner/sub_menu/closing_report/widgets/financial_summary_grid.dart';
import 'package:qsir_app/presentation/pages/owner/sub_menu/closing_report/widgets/payment_methods_section.dart';
import 'package:qsir_app/presentation/pages/owner/sub_menu/closing_report/widgets/report_status_indicator.dart';
import 'package:qsir_app/presentation/pages/owner/sub_menu/closing_report/widgets/sales_breakdown_section.dart';
import 'package:qsir_app/presentation/pages/owner/sub_menu/closing_report/widgets/shift_info_card.dart';
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
                    ReportStatusIndicator(
                      record: report,
                      formatCurrency: controller.formatCurrency,
                    ),
                    SizedBox(height: 16.h),
                    ShiftInfoCard(
                      record: report,
                      formatDate: controller.formatDate,
                      formatTime: controller.formatTime,
                    ),
                    SizedBox(height: 24.h),
                    _buildSectionTitle(context, "Ringkasan Keuangan"),
                    SizedBox(height: 12.h),
                    FinancialSummaryGrid(
                      record: report,
                      formatCurrency: controller.formatCurrency,
                    ),
                    SizedBox(height: 24.h),
                    _buildSectionTitle(context, "Sisa Saldo Kas (Selisih)"),
                    SizedBox(height: 12.h),
                    CalculationBreakdown(
                      record: report,
                      formatCurrency: controller.formatCurrency,
                    ),
                    if (report.salesBreakdown != null &&
                        report.salesBreakdown!.isNotEmpty) ...[
                      SizedBox(height: 24.h),
                      SalesBreakdownSection(
                        items: report.salesBreakdown!,
                        formatCurrency: controller.formatCurrency,
                      ),
                    ],
                    if (report.paymentMethods != null &&
                        report.paymentMethods!.isNotEmpty) ...[
                      SizedBox(height: 24.h),
                      PaymentMethodsSection(
                        items: report.paymentMethods!,
                        formatCurrency: controller.formatCurrency,
                      ),
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
}
