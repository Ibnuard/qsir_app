import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qsir_app/core/themes/app_theme.dart';
import 'package:qsir_app/presentation/pages/owner/sub_menu/cash_shift/controllers/cash_shift_controller.dart';

class QuickAmountPicker extends GetView<CashShiftController> {
  const QuickAmountPicker({super.key});

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat.decimalPattern('id');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Quick Pick",
          style: context.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.textSecondary,
          ),
        ),
        SizedBox(height: 12.h),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 8.h,
            crossAxisSpacing: 8.w,
            childAspectRatio: 2.2,
          ),
          itemCount: controller.quickAmounts.length + 1,
          itemBuilder: (context, index) {
            if (index == controller.quickAmounts.length) {
              return _buildResetButton();
            }
            final amount = controller.quickAmounts[index];
            return _buildAmountButton(amount, currencyFormatter);
          },
        ),
      ],
    );
  }

  Widget _buildAmountButton(int amount, NumberFormat formatter) {
    return InkWell(
      onTap: () => controller.addAmount(amount),
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Text(
          "+${formatter.format(amount)}",
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }

  Widget _buildResetButton() {
    return InkWell(
      onTap: () => controller.resetAmount(),
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.error.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: AppColors.error.withValues(alpha: 0.2)),
        ),
        child: Text(
          "Reset",
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.error,
          ),
        ),
      ),
    );
  }
}
