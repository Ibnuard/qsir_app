class CashierLoginRecord {
  final String id;
  final String cashierId;
  final String cashierName;
  final DateTime loginTime;

  CashierLoginRecord({
    required this.id,
    required this.cashierId,
    required this.cashierName,
    required this.loginTime,
  });

  factory CashierLoginRecord.fromJson(Map<String, dynamic> json) {
    return CashierLoginRecord(
      id: json['id'] as String,
      cashierId: json['cashier_id'] as String,
      cashierName: json['cashier_name'] as String,
      loginTime: DateTime.parse(json['login_time'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cashier_id': cashierId,
      'cashier_name': cashierName,
      'login_time': loginTime.toIso8601String(),
    };
  }
}
