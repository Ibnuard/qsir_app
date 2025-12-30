import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qsir_app/core/themes/app_theme.dart';
import 'package:qsir_app/presentation/pages/owner/sub_menu/cash_history/controllers/cash_history_controller.dart';
import 'package:qsir_app/presentation/widgets/custom_input.dart';

class CashInputBottomSheet extends StatefulWidget {
  const CashInputBottomSheet({super.key});

  @override
  State<CashInputBottomSheet> createState() => _CashInputBottomSheetState();
}

class _CashInputBottomSheetState extends State<CashInputBottomSheet> {
  final controller = Get.find<CashHistoryController>();
  final amountController = TextEditingController();
  final noteController = TextEditingController();
  String selectedType = 'Cash In';

  @override
  void dispose() {
    amountController.dispose();
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Tambah Arus Kas",
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
            SizedBox(height: 24.h),
            Text(
              "Jenis Transaksi",
              style: context.textTheme.labelMedium?.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                _buildTypeChip('Cash In', AppColors.success),
                SizedBox(width: 12.w),
                _buildTypeChip('Cash Out', AppColors.error),
              ],
            ),
            SizedBox(height: 24.h),
            CustomInput(
              controller: amountController,
              label: "Nominal",
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                hintText: "Masukkan nominal",
                prefixText: "Rp ",
              ),
            ),
            SizedBox(height: 16.h),
            CustomInput(
              controller: noteController,
              label: "Catatan (Opsional)",
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: "Contoh: Beli bensin",
              ),
            ),
            SizedBox(height: 32.h),
            SizedBox(
              width: double.infinity,
              height: 52.h,
              child: ElevatedButton(
                onPressed: () {
                  final amountStr = amountController.text.replaceAll(
                    RegExp(r'[^0-9]'),
                    '',
                  );
                  if (amountStr.isEmpty) {
                    Get.snackbar(
                      "Error",
                      "Nominal tidak boleh kosong",
                      backgroundColor: AppColors.error,
                      colorText: Colors.white,
                    );
                    return;
                  }

                  controller.addRecord(
                    type: selectedType,
                    amount: double.parse(amountStr),
                    note: noteController.text,
                  );
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: const Text(
                  "Simpan Transaksi",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeChip(String type, Color color) {
    bool isSelected = selectedType == type;
    return Expanded(
      child: InkWell(
        onTap: () => setState(() => selectedType = type),
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            color: isSelected
                ? color.withValues(alpha: 0.1)
                : Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: isSelected ? color : Colors.grey.shade200,
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                type == 'Cash In'
                    ? Icons.south_west_rounded
                    : Icons.north_east_rounded,
                color: isSelected ? color : Colors.grey,
                size: 18.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                type,
                style: TextStyle(
                  color: isSelected ? color : Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
