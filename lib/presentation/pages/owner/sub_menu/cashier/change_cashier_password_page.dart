import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qsir_app/core/themes/app_theme.dart';
import 'package:qsir_app/presentation/pages/owner/sub_menu/cashier/controllers/cashier_management_controller.dart';
import 'package:qsir_app/presentation/pages/owner/sub_menu/cashier/widgets/change_password_bottom_sheet.dart';

class ChangeCashierPasswordPage extends GetView<CashierManagementController> {
  const ChangeCashierPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Ubah Password Kasir",
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
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final activeCashiers = controller.cashiers
            .where((c) => c.isActive)
            .toList();

        if (activeCashiers.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.person_off_rounded,
                  size: 64.sp,
                  color: Colors.grey.shade300,
                ),
                SizedBox(height: 16.h),
                Text(
                  "Tidak ada kasir aktif",
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          itemCount: activeCashiers.length,
          itemBuilder: (context, index) {
            final cashier = activeCashiers[index];
            return Container(
              margin: EdgeInsets.only(bottom: 12.h),
              child: Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                child: InkWell(
                  onTap: () {
                    Get.bottomSheet(
                      ChangePasswordBottomSheet(
                        cashierName: cashier.name,
                        onSave: (newPassword) {
                          // TODO: Implement password change logic
                          Get.back();
                          Get.snackbar(
                            'Berhasil',
                            'Password ${cashier.name} berhasil diubah',
                            backgroundColor: AppColors.success,
                            colorText: Colors.white,
                          );
                        },
                      ),
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                    );
                  },
                  borderRadius: BorderRadius.circular(16.r),
                  child: Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: Colors.grey.shade100),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.02),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 24.r,
                          backgroundColor: AppColors.primary.withValues(
                            alpha: 0.1,
                          ),
                          child: Icon(
                            Icons.person,
                            color: AppColors.primary,
                            size: 24.sp,
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cashier.name,
                                style: context.textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                "Ditambahkan pada ${controller.formatDate(cashier.joinedAt)}",
                                style: context.textTheme.bodySmall?.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.chevron_right,
                          color: Colors.grey.shade400,
                          size: 24.sp,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
