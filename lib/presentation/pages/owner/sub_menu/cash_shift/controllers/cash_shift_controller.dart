import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CashShiftController extends GetxController {
  // Shift Status
  final RxBool isShiftOpen = false.obs;

  // Current User Info (Mock)
  final String userName = "Ibnu Putra";
  final String userRole = "Owner";

  // Open Shift Form
  final TextEditingController startingBalanceController =
      TextEditingController();
  final TextEditingController notesController = TextEditingController();
  final RxDouble currentBalance = 0.0.obs;

  // Shift Metadata
  final Rx<DateTime?> openedAt = Rx<DateTime?>(null);
  String? openedBy;

  final List<int> quickAmounts = [
    1000,
    2000,
    5000,
    10000,
    20000,
    50000,
    100000,
  ];

  @override
  void onInit() {
    super.onInit();
    startingBalanceController.addListener(() {
      final text = startingBalanceController.text.replaceAll(
        RegExp(r'[^0-9]'),
        '',
      );
      if (text.isNotEmpty) {
        final double val = double.parse(text);
        currentBalance.value = val;

        // Format with thousand separators while typing
        final formatted = NumberFormat.decimalPattern('id').format(val);
        if (startingBalanceController.text != formatted) {
          startingBalanceController.value = TextEditingValue(
            text: formatted,
            selection: TextSelection.collapsed(offset: formatted.length),
          );
        }
      } else {
        currentBalance.value = 0.0;
      }
    });
  }

  void addAmount(int amount) {
    currentBalance.value += amount;
    startingBalanceController.text = NumberFormat.decimalPattern(
      'id',
    ).format(currentBalance.value);
  }

  void resetAmount() {
    currentBalance.value = 0.0;
    startingBalanceController.text = "";
  }

  void openShift() {
    if (currentBalance.value < 0) {
      Get.snackbar(
        "Error",
        "Saldo awal tidak boleh negatif",
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
      return;
    }
    isShiftOpen.value = true;
    openedAt.value = DateTime.now();
    openedBy = userName;
    Get.snackbar(
      "Sukses",
      "Shift berhasil dibuka",
      backgroundColor: Colors.green.withOpacity(0.1),
      colorText: Colors.green,
    );
  }

  void closeShift() {
    isShiftOpen.value = false;
    Get.snackbar(
      "Sukses",
      "Shift berhasil ditutup",
      backgroundColor: Colors.blue.withOpacity(0.1),
      colorText: Colors.blue,
    );
  }

  @override
  void onClose() {
    startingBalanceController.dispose();
    notesController.dispose();
    super.onClose();
  }
}
