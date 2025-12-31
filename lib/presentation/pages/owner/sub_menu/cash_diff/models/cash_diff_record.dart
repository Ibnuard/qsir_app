class SalesBreakdownItem {
  final String label;
  final double amount;
  final int count;

  SalesBreakdownItem({
    required this.label,
    required this.amount,
    required this.count,
  });
}

class PaymentMethodItem {
  final String method;
  final double amount;
  final int count;

  PaymentMethodItem({
    required this.method,
    required this.amount,
    required this.count,
  });
}

class CashDiffRecord {
  final String id;
  final String openedBy;
  final DateTime openedAt;
  final String closedBy;
  final DateTime closedAt;
  final double saldoAwal;
  final double penjualanCash;
  final double cashIn;
  final double cashOut;
  final double saldoSistem;
  final double saldoFisik;
  final double amount;
  final String? note;

  // Breakdowns for Closing Report
  final List<SalesBreakdownItem>? salesBreakdown;
  final List<PaymentMethodItem>? paymentMethods;

  CashDiffRecord({
    required this.id,
    required this.openedBy,
    required this.openedAt,
    required this.closedBy,
    required this.closedAt,
    required this.saldoAwal,
    required this.penjualanCash,
    required this.cashIn,
    required this.cashOut,
    required this.saldoSistem,
    required this.saldoFisik,
    required this.amount,
    this.note,
    this.salesBreakdown,
    this.paymentMethods,
  });
}
