import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qsir_app/presentation/pages/owner/sub_menu/cash_diff/models/cash_diff_record.dart';

class ClosingReportController extends GetxController {
  final report = Rxn<CashDiffRecord>();

  final selectedDate = DateTime.now().obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments is CashDiffRecord) {
      final record = Get.arguments as CashDiffRecord;
      report.value = record;
      selectedDate.value = record.openedAt;
    } else {
      onDateChanged(selectedDate.value);
    }
  }

  void onDateChanged(DateTime date) {
    selectedDate.value = date;
    _loadDummyReport();
  }

  void _loadDummyReport() {
    final baseDate = selectedDate.value;
    report.value = CashDiffRecord(
      id: "S-${DateFormat('yyyyMMdd').format(baseDate)}-1",
      openedBy: "Ahmad (Kasir)",
      openedAt: DateTime(baseDate.year, baseDate.month, baseDate.day, 8, 0),
      closedBy: "Budi (Supervisor)",
      closedAt: DateTime(baseDate.year, baseDate.month, baseDate.day, 16, 0),
      saldoAwal: 500000,
      penjualanCash: 1250000,
      cashIn: 200000,
      cashOut: 150000,
      saldoSistem: 1800000,
      saldoFisik: 1750000,
      amount: -50000,
      note: "Ada selisih di penjualan voucher fisik yang belum tercatat.",
      salesBreakdown: [
        SalesBreakdownItem(label: "Kopi Gula Aren", amount: 450000, count: 15),
        SalesBreakdownItem(
          label: "Croissant Almond",
          amount: 300000,
          count: 10,
        ),
        SalesBreakdownItem(label: "Earl Grey Tea", amount: 200000, count: 8),
      ],
      paymentMethods: [
        PaymentMethodItem(method: "Cash", amount: 950000, count: 20),
        PaymentMethodItem(method: "QRIS", amount: 300000, count: 13),
      ],
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
}
