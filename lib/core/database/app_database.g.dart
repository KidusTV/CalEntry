// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $WaterEntriesTable extends WaterEntries
    with TableInfo<$WaterEntriesTable, WaterEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WaterEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, amount, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'water_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<WaterEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WaterEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WaterEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $WaterEntriesTable createAlias(String alias) {
    return $WaterEntriesTable(attachedDatabase, alias);
  }
}

class WaterEntry extends DataClass implements Insertable<WaterEntry> {
  final String id;
  final double amount;
  final DateTime createdAt;
  const WaterEntry({
    required this.id,
    required this.amount,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['amount'] = Variable<double>(amount);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  WaterEntriesCompanion toCompanion(bool nullToAbsent) {
    return WaterEntriesCompanion(
      id: Value(id),
      amount: Value(amount),
      createdAt: Value(createdAt),
    );
  }

  factory WaterEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WaterEntry(
      id: serializer.fromJson<String>(json['id']),
      amount: serializer.fromJson<double>(json['amount']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'amount': serializer.toJson<double>(amount),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  WaterEntry copyWith({String? id, double? amount, DateTime? createdAt}) =>
      WaterEntry(
        id: id ?? this.id,
        amount: amount ?? this.amount,
        createdAt: createdAt ?? this.createdAt,
      );
  WaterEntry copyWithCompanion(WaterEntriesCompanion data) {
    return WaterEntry(
      id: data.id.present ? data.id.value : this.id,
      amount: data.amount.present ? data.amount.value : this.amount,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WaterEntry(')
          ..write('id: $id, ')
          ..write('amount: $amount, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, amount, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WaterEntry &&
          other.id == this.id &&
          other.amount == this.amount &&
          other.createdAt == this.createdAt);
}

class WaterEntriesCompanion extends UpdateCompanion<WaterEntry> {
  final Value<String> id;
  final Value<double> amount;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const WaterEntriesCompanion({
    this.id = const Value.absent(),
    this.amount = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WaterEntriesCompanion.insert({
    required String id,
    required double amount,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       amount = Value(amount),
       createdAt = Value(createdAt);
  static Insertable<WaterEntry> custom({
    Expression<String>? id,
    Expression<double>? amount,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (amount != null) 'amount': amount,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WaterEntriesCompanion copyWith({
    Value<String>? id,
    Value<double>? amount,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return WaterEntriesCompanion(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WaterEntriesCompanion(')
          ..write('id: $id, ')
          ..write('amount: $amount, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WaterGoalsTable extends WaterGoals
    with TableInfo<$WaterGoalsTable, WaterGoal> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WaterGoalsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _dailyGoalMeta = const VerificationMeta(
    'dailyGoal',
  );
  @override
  late final GeneratedColumn<double> dailyGoal = GeneratedColumn<double>(
    'daily_goal',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
    'unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, dailyGoal, unit];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'water_goals';
  @override
  VerificationContext validateIntegrity(
    Insertable<WaterGoal> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('daily_goal')) {
      context.handle(
        _dailyGoalMeta,
        dailyGoal.isAcceptableOrUnknown(data['daily_goal']!, _dailyGoalMeta),
      );
    } else if (isInserting) {
      context.missing(_dailyGoalMeta);
    }
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
      );
    } else if (isInserting) {
      context.missing(_unitMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WaterGoal map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WaterGoal(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      dailyGoal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}daily_goal'],
      )!,
      unit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit'],
      )!,
    );
  }

  @override
  $WaterGoalsTable createAlias(String alias) {
    return $WaterGoalsTable(attachedDatabase, alias);
  }
}

class WaterGoal extends DataClass implements Insertable<WaterGoal> {
  final int id;
  final double dailyGoal;
  final String unit;
  const WaterGoal({
    required this.id,
    required this.dailyGoal,
    required this.unit,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['daily_goal'] = Variable<double>(dailyGoal);
    map['unit'] = Variable<String>(unit);
    return map;
  }

  WaterGoalsCompanion toCompanion(bool nullToAbsent) {
    return WaterGoalsCompanion(
      id: Value(id),
      dailyGoal: Value(dailyGoal),
      unit: Value(unit),
    );
  }

  factory WaterGoal.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WaterGoal(
      id: serializer.fromJson<int>(json['id']),
      dailyGoal: serializer.fromJson<double>(json['dailyGoal']),
      unit: serializer.fromJson<String>(json['unit']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'dailyGoal': serializer.toJson<double>(dailyGoal),
      'unit': serializer.toJson<String>(unit),
    };
  }

  WaterGoal copyWith({int? id, double? dailyGoal, String? unit}) => WaterGoal(
    id: id ?? this.id,
    dailyGoal: dailyGoal ?? this.dailyGoal,
    unit: unit ?? this.unit,
  );
  WaterGoal copyWithCompanion(WaterGoalsCompanion data) {
    return WaterGoal(
      id: data.id.present ? data.id.value : this.id,
      dailyGoal: data.dailyGoal.present ? data.dailyGoal.value : this.dailyGoal,
      unit: data.unit.present ? data.unit.value : this.unit,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WaterGoal(')
          ..write('id: $id, ')
          ..write('dailyGoal: $dailyGoal, ')
          ..write('unit: $unit')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, dailyGoal, unit);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WaterGoal &&
          other.id == this.id &&
          other.dailyGoal == this.dailyGoal &&
          other.unit == this.unit);
}

class WaterGoalsCompanion extends UpdateCompanion<WaterGoal> {
  final Value<int> id;
  final Value<double> dailyGoal;
  final Value<String> unit;
  const WaterGoalsCompanion({
    this.id = const Value.absent(),
    this.dailyGoal = const Value.absent(),
    this.unit = const Value.absent(),
  });
  WaterGoalsCompanion.insert({
    this.id = const Value.absent(),
    required double dailyGoal,
    required String unit,
  }) : dailyGoal = Value(dailyGoal),
       unit = Value(unit);
  static Insertable<WaterGoal> custom({
    Expression<int>? id,
    Expression<double>? dailyGoal,
    Expression<String>? unit,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (dailyGoal != null) 'daily_goal': dailyGoal,
      if (unit != null) 'unit': unit,
    });
  }

  WaterGoalsCompanion copyWith({
    Value<int>? id,
    Value<double>? dailyGoal,
    Value<String>? unit,
  }) {
    return WaterGoalsCompanion(
      id: id ?? this.id,
      dailyGoal: dailyGoal ?? this.dailyGoal,
      unit: unit ?? this.unit,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (dailyGoal.present) {
      map['daily_goal'] = Variable<double>(dailyGoal.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WaterGoalsCompanion(')
          ..write('id: $id, ')
          ..write('dailyGoal: $dailyGoal, ')
          ..write('unit: $unit')
          ..write(')'))
        .toString();
  }
}

class $StepSnapshotsTable extends StepSnapshots
    with TableInfo<$StepSnapshotsTable, StepSnapshot> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StepSnapshotsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _dayMeta = const VerificationMeta('day');
  @override
  late final GeneratedColumn<DateTime> day = GeneratedColumn<DateTime>(
    'day',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _stepsMeta = const VerificationMeta('steps');
  @override
  late final GeneratedColumn<int> steps = GeneratedColumn<int>(
    'steps',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, day, steps, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'step_snapshots';
  @override
  VerificationContext validateIntegrity(
    Insertable<StepSnapshot> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('day')) {
      context.handle(
        _dayMeta,
        day.isAcceptableOrUnknown(data['day']!, _dayMeta),
      );
    } else if (isInserting) {
      context.missing(_dayMeta);
    }
    if (data.containsKey('steps')) {
      context.handle(
        _stepsMeta,
        steps.isAcceptableOrUnknown(data['steps']!, _stepsMeta),
      );
    } else if (isInserting) {
      context.missing(_stepsMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StepSnapshot map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StepSnapshot(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      day: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}day'],
      )!,
      steps: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}steps'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $StepSnapshotsTable createAlias(String alias) {
    return $StepSnapshotsTable(attachedDatabase, alias);
  }
}

class StepSnapshot extends DataClass implements Insertable<StepSnapshot> {
  final int id;

  /// Start des Tages (00:00)
  final DateTime day;

  /// Gesamt-Schritte des Tages
  final int steps;

  /// Wann zuletzt synchronisiert
  final DateTime updatedAt;
  const StepSnapshot({
    required this.id,
    required this.day,
    required this.steps,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['day'] = Variable<DateTime>(day);
    map['steps'] = Variable<int>(steps);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  StepSnapshotsCompanion toCompanion(bool nullToAbsent) {
    return StepSnapshotsCompanion(
      id: Value(id),
      day: Value(day),
      steps: Value(steps),
      updatedAt: Value(updatedAt),
    );
  }

  factory StepSnapshot.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StepSnapshot(
      id: serializer.fromJson<int>(json['id']),
      day: serializer.fromJson<DateTime>(json['day']),
      steps: serializer.fromJson<int>(json['steps']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'day': serializer.toJson<DateTime>(day),
      'steps': serializer.toJson<int>(steps),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  StepSnapshot copyWith({
    int? id,
    DateTime? day,
    int? steps,
    DateTime? updatedAt,
  }) => StepSnapshot(
    id: id ?? this.id,
    day: day ?? this.day,
    steps: steps ?? this.steps,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  StepSnapshot copyWithCompanion(StepSnapshotsCompanion data) {
    return StepSnapshot(
      id: data.id.present ? data.id.value : this.id,
      day: data.day.present ? data.day.value : this.day,
      steps: data.steps.present ? data.steps.value : this.steps,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StepSnapshot(')
          ..write('id: $id, ')
          ..write('day: $day, ')
          ..write('steps: $steps, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, day, steps, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StepSnapshot &&
          other.id == this.id &&
          other.day == this.day &&
          other.steps == this.steps &&
          other.updatedAt == this.updatedAt);
}

class StepSnapshotsCompanion extends UpdateCompanion<StepSnapshot> {
  final Value<int> id;
  final Value<DateTime> day;
  final Value<int> steps;
  final Value<DateTime> updatedAt;
  const StepSnapshotsCompanion({
    this.id = const Value.absent(),
    this.day = const Value.absent(),
    this.steps = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  StepSnapshotsCompanion.insert({
    this.id = const Value.absent(),
    required DateTime day,
    required int steps,
    required DateTime updatedAt,
  }) : day = Value(day),
       steps = Value(steps),
       updatedAt = Value(updatedAt);
  static Insertable<StepSnapshot> custom({
    Expression<int>? id,
    Expression<DateTime>? day,
    Expression<int>? steps,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (day != null) 'day': day,
      if (steps != null) 'steps': steps,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  StepSnapshotsCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? day,
    Value<int>? steps,
    Value<DateTime>? updatedAt,
  }) {
    return StepSnapshotsCompanion(
      id: id ?? this.id,
      day: day ?? this.day,
      steps: steps ?? this.steps,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (day.present) {
      map['day'] = Variable<DateTime>(day.value);
    }
    if (steps.present) {
      map['steps'] = Variable<int>(steps.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StepSnapshotsCompanion(')
          ..write('id: $id, ')
          ..write('day: $day, ')
          ..write('steps: $steps, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $StepGoalsTable extends StepGoals
    with TableInfo<$StepGoalsTable, StepGoal> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StepGoalsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _dailyGoalMeta = const VerificationMeta(
    'dailyGoal',
  );
  @override
  late final GeneratedColumn<int> dailyGoal = GeneratedColumn<int>(
    'daily_goal',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(10000),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, dailyGoal, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'step_goals';
  @override
  VerificationContext validateIntegrity(
    Insertable<StepGoal> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('daily_goal')) {
      context.handle(
        _dailyGoalMeta,
        dailyGoal.isAcceptableOrUnknown(data['daily_goal']!, _dailyGoalMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StepGoal map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StepGoal(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      dailyGoal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}daily_goal'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $StepGoalsTable createAlias(String alias) {
    return $StepGoalsTable(attachedDatabase, alias);
  }
}

class StepGoal extends DataClass implements Insertable<StepGoal> {
  final int id;
  final int dailyGoal;
  final DateTime updatedAt;
  const StepGoal({
    required this.id,
    required this.dailyGoal,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['daily_goal'] = Variable<int>(dailyGoal);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  StepGoalsCompanion toCompanion(bool nullToAbsent) {
    return StepGoalsCompanion(
      id: Value(id),
      dailyGoal: Value(dailyGoal),
      updatedAt: Value(updatedAt),
    );
  }

  factory StepGoal.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StepGoal(
      id: serializer.fromJson<int>(json['id']),
      dailyGoal: serializer.fromJson<int>(json['dailyGoal']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'dailyGoal': serializer.toJson<int>(dailyGoal),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  StepGoal copyWith({int? id, int? dailyGoal, DateTime? updatedAt}) => StepGoal(
    id: id ?? this.id,
    dailyGoal: dailyGoal ?? this.dailyGoal,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  StepGoal copyWithCompanion(StepGoalsCompanion data) {
    return StepGoal(
      id: data.id.present ? data.id.value : this.id,
      dailyGoal: data.dailyGoal.present ? data.dailyGoal.value : this.dailyGoal,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StepGoal(')
          ..write('id: $id, ')
          ..write('dailyGoal: $dailyGoal, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, dailyGoal, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StepGoal &&
          other.id == this.id &&
          other.dailyGoal == this.dailyGoal &&
          other.updatedAt == this.updatedAt);
}

class StepGoalsCompanion extends UpdateCompanion<StepGoal> {
  final Value<int> id;
  final Value<int> dailyGoal;
  final Value<DateTime> updatedAt;
  const StepGoalsCompanion({
    this.id = const Value.absent(),
    this.dailyGoal = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  StepGoalsCompanion.insert({
    this.id = const Value.absent(),
    this.dailyGoal = const Value.absent(),
    required DateTime updatedAt,
  }) : updatedAt = Value(updatedAt);
  static Insertable<StepGoal> custom({
    Expression<int>? id,
    Expression<int>? dailyGoal,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (dailyGoal != null) 'daily_goal': dailyGoal,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  StepGoalsCompanion copyWith({
    Value<int>? id,
    Value<int>? dailyGoal,
    Value<DateTime>? updatedAt,
  }) {
    return StepGoalsCompanion(
      id: id ?? this.id,
      dailyGoal: dailyGoal ?? this.dailyGoal,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (dailyGoal.present) {
      map['daily_goal'] = Variable<int>(dailyGoal.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StepGoalsCompanion(')
          ..write('id: $id, ')
          ..write('dailyGoal: $dailyGoal, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $WaterEntriesTable waterEntries = $WaterEntriesTable(this);
  late final $WaterGoalsTable waterGoals = $WaterGoalsTable(this);
  late final $StepSnapshotsTable stepSnapshots = $StepSnapshotsTable(this);
  late final $StepGoalsTable stepGoals = $StepGoalsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    waterEntries,
    waterGoals,
    stepSnapshots,
    stepGoals,
  ];
}

typedef $$WaterEntriesTableCreateCompanionBuilder =
    WaterEntriesCompanion Function({
      required String id,
      required double amount,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$WaterEntriesTableUpdateCompanionBuilder =
    WaterEntriesCompanion Function({
      Value<String> id,
      Value<double> amount,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$WaterEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $WaterEntriesTable> {
  $$WaterEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WaterEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $WaterEntriesTable> {
  $$WaterEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WaterEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $WaterEntriesTable> {
  $$WaterEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$WaterEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WaterEntriesTable,
          WaterEntry,
          $$WaterEntriesTableFilterComposer,
          $$WaterEntriesTableOrderingComposer,
          $$WaterEntriesTableAnnotationComposer,
          $$WaterEntriesTableCreateCompanionBuilder,
          $$WaterEntriesTableUpdateCompanionBuilder,
          (
            WaterEntry,
            BaseReferences<_$AppDatabase, $WaterEntriesTable, WaterEntry>,
          ),
          WaterEntry,
          PrefetchHooks Function()
        > {
  $$WaterEntriesTableTableManager(_$AppDatabase db, $WaterEntriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WaterEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WaterEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WaterEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WaterEntriesCompanion(
                id: id,
                amount: amount,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required double amount,
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => WaterEntriesCompanion.insert(
                id: id,
                amount: amount,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WaterEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WaterEntriesTable,
      WaterEntry,
      $$WaterEntriesTableFilterComposer,
      $$WaterEntriesTableOrderingComposer,
      $$WaterEntriesTableAnnotationComposer,
      $$WaterEntriesTableCreateCompanionBuilder,
      $$WaterEntriesTableUpdateCompanionBuilder,
      (
        WaterEntry,
        BaseReferences<_$AppDatabase, $WaterEntriesTable, WaterEntry>,
      ),
      WaterEntry,
      PrefetchHooks Function()
    >;
typedef $$WaterGoalsTableCreateCompanionBuilder =
    WaterGoalsCompanion Function({
      Value<int> id,
      required double dailyGoal,
      required String unit,
    });
typedef $$WaterGoalsTableUpdateCompanionBuilder =
    WaterGoalsCompanion Function({
      Value<int> id,
      Value<double> dailyGoal,
      Value<String> unit,
    });

class $$WaterGoalsTableFilterComposer
    extends Composer<_$AppDatabase, $WaterGoalsTable> {
  $$WaterGoalsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get dailyGoal => $composableBuilder(
    column: $table.dailyGoal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WaterGoalsTableOrderingComposer
    extends Composer<_$AppDatabase, $WaterGoalsTable> {
  $$WaterGoalsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get dailyGoal => $composableBuilder(
    column: $table.dailyGoal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WaterGoalsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WaterGoalsTable> {
  $$WaterGoalsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get dailyGoal =>
      $composableBuilder(column: $table.dailyGoal, builder: (column) => column);

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);
}

class $$WaterGoalsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WaterGoalsTable,
          WaterGoal,
          $$WaterGoalsTableFilterComposer,
          $$WaterGoalsTableOrderingComposer,
          $$WaterGoalsTableAnnotationComposer,
          $$WaterGoalsTableCreateCompanionBuilder,
          $$WaterGoalsTableUpdateCompanionBuilder,
          (
            WaterGoal,
            BaseReferences<_$AppDatabase, $WaterGoalsTable, WaterGoal>,
          ),
          WaterGoal,
          PrefetchHooks Function()
        > {
  $$WaterGoalsTableTableManager(_$AppDatabase db, $WaterGoalsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WaterGoalsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WaterGoalsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WaterGoalsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<double> dailyGoal = const Value.absent(),
                Value<String> unit = const Value.absent(),
              }) =>
                  WaterGoalsCompanion(id: id, dailyGoal: dailyGoal, unit: unit),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required double dailyGoal,
                required String unit,
              }) => WaterGoalsCompanion.insert(
                id: id,
                dailyGoal: dailyGoal,
                unit: unit,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WaterGoalsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WaterGoalsTable,
      WaterGoal,
      $$WaterGoalsTableFilterComposer,
      $$WaterGoalsTableOrderingComposer,
      $$WaterGoalsTableAnnotationComposer,
      $$WaterGoalsTableCreateCompanionBuilder,
      $$WaterGoalsTableUpdateCompanionBuilder,
      (WaterGoal, BaseReferences<_$AppDatabase, $WaterGoalsTable, WaterGoal>),
      WaterGoal,
      PrefetchHooks Function()
    >;
typedef $$StepSnapshotsTableCreateCompanionBuilder =
    StepSnapshotsCompanion Function({
      Value<int> id,
      required DateTime day,
      required int steps,
      required DateTime updatedAt,
    });
typedef $$StepSnapshotsTableUpdateCompanionBuilder =
    StepSnapshotsCompanion Function({
      Value<int> id,
      Value<DateTime> day,
      Value<int> steps,
      Value<DateTime> updatedAt,
    });

class $$StepSnapshotsTableFilterComposer
    extends Composer<_$AppDatabase, $StepSnapshotsTable> {
  $$StepSnapshotsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get day => $composableBuilder(
    column: $table.day,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get steps => $composableBuilder(
    column: $table.steps,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StepSnapshotsTableOrderingComposer
    extends Composer<_$AppDatabase, $StepSnapshotsTable> {
  $$StepSnapshotsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get day => $composableBuilder(
    column: $table.day,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get steps => $composableBuilder(
    column: $table.steps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StepSnapshotsTableAnnotationComposer
    extends Composer<_$AppDatabase, $StepSnapshotsTable> {
  $$StepSnapshotsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get day =>
      $composableBuilder(column: $table.day, builder: (column) => column);

  GeneratedColumn<int> get steps =>
      $composableBuilder(column: $table.steps, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$StepSnapshotsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StepSnapshotsTable,
          StepSnapshot,
          $$StepSnapshotsTableFilterComposer,
          $$StepSnapshotsTableOrderingComposer,
          $$StepSnapshotsTableAnnotationComposer,
          $$StepSnapshotsTableCreateCompanionBuilder,
          $$StepSnapshotsTableUpdateCompanionBuilder,
          (
            StepSnapshot,
            BaseReferences<_$AppDatabase, $StepSnapshotsTable, StepSnapshot>,
          ),
          StepSnapshot,
          PrefetchHooks Function()
        > {
  $$StepSnapshotsTableTableManager(_$AppDatabase db, $StepSnapshotsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StepSnapshotsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StepSnapshotsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StepSnapshotsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> day = const Value.absent(),
                Value<int> steps = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => StepSnapshotsCompanion(
                id: id,
                day: day,
                steps: steps,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime day,
                required int steps,
                required DateTime updatedAt,
              }) => StepSnapshotsCompanion.insert(
                id: id,
                day: day,
                steps: steps,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StepSnapshotsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StepSnapshotsTable,
      StepSnapshot,
      $$StepSnapshotsTableFilterComposer,
      $$StepSnapshotsTableOrderingComposer,
      $$StepSnapshotsTableAnnotationComposer,
      $$StepSnapshotsTableCreateCompanionBuilder,
      $$StepSnapshotsTableUpdateCompanionBuilder,
      (
        StepSnapshot,
        BaseReferences<_$AppDatabase, $StepSnapshotsTable, StepSnapshot>,
      ),
      StepSnapshot,
      PrefetchHooks Function()
    >;
typedef $$StepGoalsTableCreateCompanionBuilder =
    StepGoalsCompanion Function({
      Value<int> id,
      Value<int> dailyGoal,
      required DateTime updatedAt,
    });
typedef $$StepGoalsTableUpdateCompanionBuilder =
    StepGoalsCompanion Function({
      Value<int> id,
      Value<int> dailyGoal,
      Value<DateTime> updatedAt,
    });

class $$StepGoalsTableFilterComposer
    extends Composer<_$AppDatabase, $StepGoalsTable> {
  $$StepGoalsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dailyGoal => $composableBuilder(
    column: $table.dailyGoal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StepGoalsTableOrderingComposer
    extends Composer<_$AppDatabase, $StepGoalsTable> {
  $$StepGoalsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dailyGoal => $composableBuilder(
    column: $table.dailyGoal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StepGoalsTableAnnotationComposer
    extends Composer<_$AppDatabase, $StepGoalsTable> {
  $$StepGoalsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get dailyGoal =>
      $composableBuilder(column: $table.dailyGoal, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$StepGoalsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StepGoalsTable,
          StepGoal,
          $$StepGoalsTableFilterComposer,
          $$StepGoalsTableOrderingComposer,
          $$StepGoalsTableAnnotationComposer,
          $$StepGoalsTableCreateCompanionBuilder,
          $$StepGoalsTableUpdateCompanionBuilder,
          (StepGoal, BaseReferences<_$AppDatabase, $StepGoalsTable, StepGoal>),
          StepGoal,
          PrefetchHooks Function()
        > {
  $$StepGoalsTableTableManager(_$AppDatabase db, $StepGoalsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StepGoalsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StepGoalsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StepGoalsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> dailyGoal = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => StepGoalsCompanion(
                id: id,
                dailyGoal: dailyGoal,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> dailyGoal = const Value.absent(),
                required DateTime updatedAt,
              }) => StepGoalsCompanion.insert(
                id: id,
                dailyGoal: dailyGoal,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StepGoalsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StepGoalsTable,
      StepGoal,
      $$StepGoalsTableFilterComposer,
      $$StepGoalsTableOrderingComposer,
      $$StepGoalsTableAnnotationComposer,
      $$StepGoalsTableCreateCompanionBuilder,
      $$StepGoalsTableUpdateCompanionBuilder,
      (StepGoal, BaseReferences<_$AppDatabase, $StepGoalsTable, StepGoal>),
      StepGoal,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$WaterEntriesTableTableManager get waterEntries =>
      $$WaterEntriesTableTableManager(_db, _db.waterEntries);
  $$WaterGoalsTableTableManager get waterGoals =>
      $$WaterGoalsTableTableManager(_db, _db.waterGoals);
  $$StepSnapshotsTableTableManager get stepSnapshots =>
      $$StepSnapshotsTableTableManager(_db, _db.stepSnapshots);
  $$StepGoalsTableTableManager get stepGoals =>
      $$StepGoalsTableTableManager(_db, _db.stepGoals);
}
