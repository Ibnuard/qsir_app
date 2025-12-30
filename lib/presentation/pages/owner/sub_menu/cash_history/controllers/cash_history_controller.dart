import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CashRecord {
  final String id;
  final String type; // 'Cash In' or 'Cash Out'
  final double amount;
  final DateTime time;
  final String userName;
  final String? note;

  CashRecord({
    required this.id,
    required this.type,
    required this.amount,
    required this.time,
    required this.userName,
    this.note,
  });
}

class CashHistoryController extends GetxController {
  final records = <CashRecord>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadDummyData();
  }

  void _loadDummyData() {
    records.assignAll([
      CashRecord(
        id: '1',
        type: 'Cash In',
        amount: 50000,
        time: DateTime.now().subtract(const Duration(minutes: 30)),
        userName: 'Admin',
        note: 'Kas masuk dari modal awal',
      ),
      CashRecord(
        id: '2',
        type: 'Cash Out',
        amount: 25000,
        time: DateTime.now().subtract(const Duration(hours: 1)),
        userName: 'Kasir 1',
        note: 'Beli ATK',
      ),
      CashRecord(
        id: '3',
        type: 'Cash In',
        amount: 100000,
        time: DateTime.now().subtract(const Duration(hours: 3)),
        userName: 'Admin',
        note: 'Setoran penjualan',
      ),
      CashRecord(
        id: '4',
        type: 'Cash Out',
        amount: 15000,
        time: DateTime.now().subtract(const Duration(days: 1)),
        userName: 'Kasir 2',
        note: 'Ongkir paket',
      ),
    ]);
  }

  void addRecord({required String type, required double amount, String? note}) {
    final newRecord = CashRecord(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      type: type,
      amount: amount,
      time: DateTime.now(),
      userName: 'Admin', // Dummy user for now
      note: note,
    );
    records.insert(0, newRecord); // Insert at top
  }

  String formatAmount(double amount) {
    return NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    ).format(amount);
  }

  String formatTime(DateTime time) {
    return DateFormat('dd MMM yyyy, HH:mm').format(time);
  }
}
