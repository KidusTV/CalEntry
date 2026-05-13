/// Reine Domain-Entität — kennt weder Drift noch JSON.
class WaterEntryEntity {
  final String id;
  final double amount;
  final DateTime createdAt;

  const WaterEntryEntity({
    required this.id,
    required this.amount,
    required this.createdAt,
  });

  @override
  String toString() =>
      'WaterEntryEntity(id: $id, amount: $amount, createdAt: $createdAt)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is WaterEntryEntity &&
              other.id == id &&
              other.amount == amount &&
              other.createdAt == createdAt;

  @override
  int get hashCode => Object.hash(id, amount, createdAt);
}