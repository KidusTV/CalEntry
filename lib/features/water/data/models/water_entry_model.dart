import '../../domain/entities/water_entry_entity.dart';

/// Dart-Modell für eine einzelne Drift-Zeile aus [WaterEntries].
/// Trennt die DB-Repräsentation von der Domain-Entität.
class WaterEntryModel {
  final String id;
  final double amount;
  final DateTime createdAt;

  const WaterEntryModel({
    required this.id,
    required this.amount,
    required this.createdAt,
  });

  /// Wandelt einen Drift-DataClass-Row direkt in ein Model um.
  /// Erwartet ein Objekt mit den Feldern id, amount, createdAt —
  /// also genau das, was der generierte [WaterEntry]-DataClass liefert.
  factory WaterEntryModel.fromDrift(dynamic row) {
    return WaterEntryModel(
      id: row.id as String,
      amount: row.amount as double,
      createdAt: row.createdAt as DateTime,
    );
  }

  WaterEntryEntity toEntity() {
    return WaterEntryEntity(
      id: id,
      amount: amount,
      createdAt: createdAt,
    );
  }
}