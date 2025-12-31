import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qsir_app/core/themes/app_theme.dart';
import 'package:qsir_app/presentation/pages/owner/sub_menu/cash_diff/models/cash_diff_record.dart';

class CashDiffHistoryController extends GetxController {
  final allRecords = <CashDiffRecord>[].obs;
  final selectedRange = Rxn<DateTimeRange>();

  List<CashDiffRecord> get filteredRecords {
    if (selectedRange.value == null) return allRecords;
    return allRecords.where((record) {
      final date = record.openedAt;
      final start = selectedRange.value!.start;
      final end = selectedRange.value!.end;

      final recordDate = DateTime(date.year, date.month, date.day);
      final startDate = DateTime(start.year, start.month, start.day);
      final endDate = DateTime(end.year, end.month, end.day);

      return recordDate.isAtSameMomentAs(startDate) ||
          recordDate.isAtSameMomentAs(endDate) ||
          (recordDate.isAfter(startDate) && recordDate.isBefore(endDate));
    }).toList();
  }

  bool get isFilterActive => selectedRange.value != null;

  @override
  void onInit() {
    super.onInit();
    _loadDummyHistory();
  }

  void setDateRange(DateTimeRange? range) {
    selectedRange.value = range;
  }

  void resetFilter() {
    selectedRange.value = null;
  }

  void _loadDummyHistory() {
    final now = DateTime.now();
    allRecords.assignAll(
      List.generate(10, (index) {
        final date = now.subtract(Duration(days: index));
        final isBalanced = index % 3 == 0;
        final amount = isBalanced ? 0.0 : (index % 2 == 0 ? -25000.0 : 15000.0);

        return CashDiffRecord(
          id: "S-${DateFormat('yyyyMMdd').format(date)}-1",
          openedBy: index % 2 == 0 ? "Ahmad (Kasir)" : "Siti (Kasir)",
          openedAt: DateTime(date.year, date.month, date.day, 8, 0),
          closedBy: "Budi (Supervisor)",
          closedAt: DateTime(date.year, date.month, date.day, 16, 0),
          saldoAwal: 500000,
          penjualanCash: 1000000 + (index * 50000),
          cashIn: 0,
          cashOut: 0,
          saldoSistem: 1500000 + (index * 50000),
          saldoFisik: 1500000 + (index * 50000) + amount,
          amount: amount,
          note: amount != 0 ? "Dummy note for record $index" : null,
        );
      }),
    );
  }

  String formatCurrency(double amount) {
    return NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    ).format(amount);
  }

  String formatDate(DateTime date) {
    return DateFormat('dd MMM yyyy').format(date);
  }

  String formatTime(DateTime time) {
    return DateFormat('HH:mm').format(time);
  }

  Color getStatusColor(double amount) {
    if (amount < 0) return AppColors.error;
    if (amount > 0) return Colors.orange;
    return AppColors.success;
  }

  String getStatusLabel(double amount) {
    if (amount < 0) return 'Kurang';
    if (amount > 0) return 'Lebih';
    return 'Seimbang';
  }
}
