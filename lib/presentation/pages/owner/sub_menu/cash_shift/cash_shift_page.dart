import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qsir_app/core/themes/app_theme.dart';
import 'package:qsir_app/presentation/pages/owner/sub_menu/cash_shift/controllers/cash_shift_controller.dart';
import 'package:qsir_app/presentation/pages/owner/sub_menu/cash_shift/widgets/quick_amount_picker.dart';
import 'package:qsir_app/presentation/pages/owner/sub_menu/cash_shift/widgets/user_info_card.dart';
import 'package:qsir_app/presentation/widgets/custom_input.dart';

class CashShiftPage extends GetView<CashShiftController> {
  const CashShiftPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Kas & Shift",
          style: context.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        if (!controller.isShiftOpen.value) {
          return _buildOpenShiftView(context);
        } else {
          return _buildShiftStatusView(context);
        }
      }),
    );
  }

  Widget _buildOpenShiftView(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const UserInfoCard(),
          SizedBox(height: 24.h),
          Text(
            "Buka Shift Baru",
            style: context.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            "Masukkan saldo awal untuk memulai transaksi hari ini.",
            style: context.textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          SizedBox(height: 24.h),
          CustomInput(
            label: "Saldo Awal (Modal Tunai)",
            controller: controller.startingBalanceController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(prefixText: "Rp ", hintText: "0"),
          ),
          SizedBox(height: 16.h),
          const QuickAmountPicker(),
          SizedBox(height: 24.h),
          CustomInput(
            label: "Catatan (Opsional)",
            controller: controller.notesController,
            maxLines: 3,
            decoration: const InputDecoration(
              hintText: "Contoh: Uang modal dari kas pusat",
            ),
          ),
          SizedBox(height: 40.h),
          SizedBox(
            width: double.infinity,
            height: 52.h,
            child: ElevatedButton(
              onPressed: () => controller.openShift(),
              child: const Text("Buka Shift Sekarang"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShiftStatusView(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle_rounded,
              size: 80.sp,
              color: AppColors.success,
            ),
            SizedBox(height: 24.h),
            Text(
              "Shift Sedang Aktif",
              style: context.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              "Anda sudah membuka shift hari ini. Silakan mulai melakukan transaksi di halaman POS.",
              textAlign: TextAlign.center,
              style: context.textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            SizedBox(height: 40.h),
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                children: [
                  _buildStatusRow(
                    Icons.person_outline,
                    "Dibuka oleh",
                    controller.openedBy ?? "-",
                  ),
                  const Divider(height: 24),
                  _buildStatusRow(
                    Icons.calendar_today_outlined,
                    "Tanggal",
                    controller.openedAt.value != null
                        ? DateFormat(
                            'dd MMM yyyy',
                          ).format(controller.openedAt.value!)
                        : "-",
                  ),
                  const Divider(height: 24),
                  _buildStatusRow(
                    Icons.access_time_rounded,
                    "Jam Buka",
                    controller.openedAt.value != null
                        ? DateFormat('HH:mm').format(controller.openedAt.value!)
                        : "-",
                  ),
                  const Divider(height: 24),
                  _buildStatusRow(
                    Icons.account_balance_wallet_outlined,
                    "Saldo awal",
                    "Rp ${controller.startingBalanceController.text}",
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            SizedBox(
              width: double.infinity,
              height: 52.h,
              child: OutlinedButton(
                onPressed: () => controller.closeShift(),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.error,
                  side: const BorderSide(color: AppColors.error),
                ),
                child: const Text("Tutup Shift"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20.sp, color: AppColors.textSecondary),
        SizedBox(width: 12.w),
        Text(
          label,
          style: TextStyle(fontSize: 14.sp, color: AppColors.textSecondary),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
