import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:qsir_app/presentation/pages/owner/sub_menu/cashier/models/cashier_login_record.dart';

class CashierLoginHistoryController extends GetxController {
  final RxList<CashierLoginRecord> _allRecords = <CashierLoginRecord>[].obs;
  final Rx<DateTimeRange?> selectedRange = Rx<DateTimeRange?>(null);
  final RxBool isLoading = false.obs;

  List<CashierLoginRecord> get allRecords => _allRecords;

  List<CashierLoginRecord> get filteredRecords {
    if (selectedRange.value == null) {
      return _allRecords;
    }

    final start = selectedRange.value!.start;
    final end = selectedRange.value!.end.add(const Duration(days: 1));

    return _allRecords.where((record) {
      return record.loginTime.isAfter(start) && record.loginTime.isBefore(end);
    }).toList();
  }

  bool get isFilterActive => selectedRange.value != null;

  @override
  void onInit() {
    super.onInit();
    loadLoginHistory();
  }

  Future<void> loadLoginHistory() async {
    isLoading.value = true;
    try {
      // TODO: Replace with actual API call
      await Future.delayed(const Duration(milliseconds: 500));

      // Mock data
      _allRecords.value = [
        CashierLoginRecord(
          id: '1',
          cashierId: '1',
          cashierName: 'Ahmad Faisal',
          loginTime: DateTime.now().subtract(const Duration(hours: 2)),
        ),
        CashierLoginRecord(
          id: '2',
          cashierId: '2',
          cashierName: 'Siti Nurhaliza',
          loginTime: DateTime.now().subtract(const Duration(hours: 5)),
        ),
        CashierLoginRecord(
          id: '3',
          cashierId: '1',
          cashierName: 'Ahmad Faisal',
          loginTime: DateTime.now().subtract(const Duration(days: 1, hours: 3)),
        ),
        CashierLoginRecord(
          id: '4',
          cashierId: '3',
          cashierName: 'Budi Santoso',
          loginTime: DateTime.now().subtract(const Duration(days: 2)),
        ),
        CashierLoginRecord(
          id: '5',
          cashierId: '2',
          cashierName: 'Siti Nurhaliza',
          loginTime: DateTime.now().subtract(const Duration(days: 3, hours: 1)),
        ),
      ];
    } finally {
      isLoading.value = false;
    }
  }

  void setDateRange(DateTimeRange? range) {
    selectedRange.value = range;
  }

  void resetFilter() {
    selectedRange.value = null;
  }

  String formatDateTime(DateTime dateTime) {
    return DateFormat('d MMM yyyy, HH:mm').format(dateTime);
  }

  String formatDate(DateTime dateTime) {
    return DateFormat('d MMMM yyyy').format(dateTime);
  }

  String formatTime(DateTime dateTime) {
    return DateFormat('HH:mm').format(dateTime);
  }

  String getRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} menit yang lalu';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} jam yang lalu';
    } else if (difference.inDays == 1) {
      return 'Kemarin';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} hari yang lalu';
    } else {
      return formatDate(dateTime);
    }
  }
}
