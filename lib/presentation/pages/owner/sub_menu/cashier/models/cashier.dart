class Cashier {
  final String id;
  final String name;
  final DateTime joinedAt;
  final bool isActive;

  Cashier({
    required this.id,
    required this.name,
    required this.joinedAt,
    this.isActive = true,
  });

  Cashier copyWith({
    String? id,
    String? name,
    DateTime? joinedAt,
    bool? isActive,
  }) {
    return Cashier(
      id: id ?? this.id,
      name: name ?? this.name,
      joinedAt: joinedAt ?? this.joinedAt,
      isActive: isActive ?? this.isActive,
    );
  }
}
