import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:qsir_app/core/themes/app_theme.dart';
import 'package:qsir_app/presentation/pages/owner/sub_menu/cash_diff/models/cash_diff_record.dart';

class CashDiffController extends GetxController {
  final history = <DateTime, List<CashDiffRecord>>{}.obs;

  // Latest shift data for summary
  final latestShift = Rxn<CashDiffRecord>();

  final isHistoryExpanded = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadDummyData();
  }

  void _loadDummyData() {
    latestShift.value = CashDiffRecord(
      id: "S-12345",
      openedBy: "Ahmad (Kasir)",
      openedAt: DateTime.now().subtract(const Duration(hours: 8)),
      closedBy: "Budi (Supervisor)",
      closedAt: DateTime.now(),
      saldoAwal: 500000,
      penjualanCash: 1250000,
      cashIn: 200000,
      cashOut: 150000,
      saldoSistem: 1800000,
      saldoFisik: 1750000,
      amount: -50000,
      note: "Ada selisih di penjualan voucher fisik yang belum tercatat.",
    );

    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    final twoDaysAgo = DateTime.now().subtract(const Duration(days: 2));

    final list = [
      latestShift.value!,
      CashDiffRecord(
        id: "S-12344",
        openedBy: "Siti (Kasir)",
        openedAt: yesterday.subtract(const Duration(hours: 8)),
        closedBy: "Budi (Supervisor)",
        closedAt: yesterday,
        saldoAwal: 500000,
        penjualanCash: 2100000,
        cashIn: 0,
        cashOut: 100000,
        saldoSistem: 2500000,
        saldoFisik: 2500000,
        amount: 0,
      ),
      CashDiffRecord(
        id: "S-12343",
        openedBy: "Ahmad (Kasir)",
        openedAt: twoDaysAgo.subtract(const Duration(hours: 8)),
        closedBy: "Siti (Kasir)",
        closedAt: twoDaysAgo,
        saldoAwal: 500000,
        penjualanCash: 1800000,
        cashIn: 50000,
        cashOut: 0,
        saldoSistem: 2350000,
        saldoFisik: 2365000,
        amount: 15000,
        note: "Kelebihan uang receh kembalian.",
      ),
    ];

    final Map<DateTime, List<CashDiffRecord>> grouped = {};
    for (var record in list) {
      final dateOnly = DateTime(
        record.openedAt.year,
        record.openedAt.month,
        record.openedAt.day,
      );
      if (grouped[dateOnly] == null) {
        grouped[dateOnly] = [];
      }
      grouped[dateOnly]!.add(record);
    }
    history.value = grouped;
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
