// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $FoodItemsTable extends FoodItems
    with TableInfo<$FoodItemsTable, FoodItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FoodItemsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 200,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _caloriesMeta = const VerificationMeta(
    'calories',
  );
  @override
  late final GeneratedColumn<int> calories = GeneratedColumn<int>(
    'calories',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _recordedAtMeta = const VerificationMeta(
    'recordedAt',
  );
  @override
  late final GeneratedColumn<DateTime> recordedAt = GeneratedColumn<DateTime>(
    'recorded_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, title, calories, recordedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'food_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<FoodItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('calories')) {
      context.handle(
        _caloriesMeta,
        calories.isAcceptableOrUnknown(data['calories']!, _caloriesMeta),
      );
    }
    if (data.containsKey('recorded_at')) {
      context.handle(
        _recordedAtMeta,
        recordedAt.isAcceptableOrUnknown(data['recorded_at']!, _recordedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FoodItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FoodItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      calories: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}calories'],
      )!,
      recordedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}recorded_at'],
      )!,
    );
  }

  @override
  $FoodItemsTable createAlias(String alias) {
    return $FoodItemsTable(attachedDatabase, alias);
  }
}

class FoodItem extends DataClass implements Insertable<FoodItem> {
  final int id;
  final String title;
  final int calories;
  final DateTime recordedAt;
  const FoodItem({
    required this.id,
    required this.title,
    required this.calories,
    required this.recordedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['calories'] = Variable<int>(calories);
    map['recorded_at'] = Variable<DateTime>(recordedAt);
    return map;
  }

  FoodItemsCompanion toCompanion(bool nullToAbsent) {
    return FoodItemsCompanion(
      id: Value(id),
      title: Value(title),
      calories: Value(calories),
      recordedAt: Value(recordedAt),
    );
  }

  factory FoodItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FoodItem(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      calories: serializer.fromJson<int>(json['calories']),
      recordedAt: serializer.fromJson<DateTime>(json['recordedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'calories': serializer.toJson<int>(calories),
      'recordedAt': serializer.toJson<DateTime>(recordedAt),
    };
  }

  FoodItem copyWith({
    int? id,
    String? title,
    int? calories,
    DateTime? recordedAt,
  }) => FoodItem(
    id: id ?? this.id,
    title: title ?? this.title,
    calories: calories ?? this.calories,
    recordedAt: recordedAt ?? this.recordedAt,
  );
  FoodItem copyWithCompanion(FoodItemsCompanion data) {
    return FoodItem(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      calories: data.calories.present ? data.calories.value : this.calories,
      recordedAt: data.recordedAt.present
          ? data.recordedAt.value
          : this.recordedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FoodItem(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('calories: $calories, ')
          ..write('recordedAt: $recordedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, calories, recordedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FoodItem &&
          other.id == this.id &&
          other.title == this.title &&
          other.calories == this.calories &&
          other.recordedAt == this.recordedAt);
}

class FoodItemsCompanion extends UpdateCompanion<FoodItem> {
  final Value<int> id;
  final Value<String> title;
  final Value<int> calories;
  final Value<DateTime> recordedAt;
  const FoodItemsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.calories = const Value.absent(),
    this.recordedAt = const Value.absent(),
  });
  FoodItemsCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.calories = const Value.absent(),
    this.recordedAt = const Value.absent(),
  }) : title = Value(title);
  static Insertable<FoodItem> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<int>? calories,
    Expression<DateTime>? recordedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (calories != null) 'calories': calories,
      if (recordedAt != null) 'recorded_at': recordedAt,
    });
  }

  FoodItemsCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<int>? calories,
    Value<DateTime>? recordedAt,
  }) {
    return FoodItemsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      calories: calories ?? this.calories,
      recordedAt: recordedAt ?? this.recordedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (calories.present) {
      map['calories'] = Variable<int>(calories.value);
    }
    if (recordedAt.present) {
      map['recorded_at'] = Variable<DateTime>(recordedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FoodItemsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('calories: $calories, ')
          ..write('recordedAt: $recordedAt')
          ..write(')'))
        .toString();
  }
}

class $NutrientsTable extends Nutrients
    with TableInfo<$NutrientsTable, Nutrient> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NutrientsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
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
  static const VerificationMeta _nutrientTypeMeta = const VerificationMeta(
    'nutrientType',
  );
  @override
  late final GeneratedColumn<String> nutrientType = GeneratedColumn<String>(
    'nutrient_type',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 32),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    code,
    name,
    unit,
    nutrientType,
    description,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'nutrients';
  @override
  VerificationContext validateIntegrity(
    Insertable<Nutrient> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
      );
    } else if (isInserting) {
      context.missing(_unitMeta);
    }
    if (data.containsKey('nutrient_type')) {
      context.handle(
        _nutrientTypeMeta,
        nutrientType.isAcceptableOrUnknown(
          data['nutrient_type']!,
          _nutrientTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_nutrientTypeMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Nutrient map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Nutrient(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      unit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit'],
      )!,
      nutrientType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nutrient_type'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
    );
  }

  @override
  $NutrientsTable createAlias(String alias) {
    return $NutrientsTable(attachedDatabase, alias);
  }
}

class Nutrient extends DataClass implements Insertable<Nutrient> {
  final int id;
  final String code;
  final String name;
  final String unit;

  /// macro | micro | vitamin | mineral | other
  final String nutrientType;
  final String? description;
  const Nutrient({
    required this.id,
    required this.code,
    required this.name,
    required this.unit,
    required this.nutrientType,
    this.description,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['code'] = Variable<String>(code);
    map['name'] = Variable<String>(name);
    map['unit'] = Variable<String>(unit);
    map['nutrient_type'] = Variable<String>(nutrientType);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    return map;
  }

  NutrientsCompanion toCompanion(bool nullToAbsent) {
    return NutrientsCompanion(
      id: Value(id),
      code: Value(code),
      name: Value(name),
      unit: Value(unit),
      nutrientType: Value(nutrientType),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
    );
  }

  factory Nutrient.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Nutrient(
      id: serializer.fromJson<int>(json['id']),
      code: serializer.fromJson<String>(json['code']),
      name: serializer.fromJson<String>(json['name']),
      unit: serializer.fromJson<String>(json['unit']),
      nutrientType: serializer.fromJson<String>(json['nutrientType']),
      description: serializer.fromJson<String?>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'code': serializer.toJson<String>(code),
      'name': serializer.toJson<String>(name),
      'unit': serializer.toJson<String>(unit),
      'nutrientType': serializer.toJson<String>(nutrientType),
      'description': serializer.toJson<String?>(description),
    };
  }

  Nutrient copyWith({
    int? id,
    String? code,
    String? name,
    String? unit,
    String? nutrientType,
    Value<String?> description = const Value.absent(),
  }) => Nutrient(
    id: id ?? this.id,
    code: code ?? this.code,
    name: name ?? this.name,
    unit: unit ?? this.unit,
    nutrientType: nutrientType ?? this.nutrientType,
    description: description.present ? description.value : this.description,
  );
  Nutrient copyWithCompanion(NutrientsCompanion data) {
    return Nutrient(
      id: data.id.present ? data.id.value : this.id,
      code: data.code.present ? data.code.value : this.code,
      name: data.name.present ? data.name.value : this.name,
      unit: data.unit.present ? data.unit.value : this.unit,
      nutrientType: data.nutrientType.present
          ? data.nutrientType.value
          : this.nutrientType,
      description: data.description.present
          ? data.description.value
          : this.description,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Nutrient(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('unit: $unit, ')
          ..write('nutrientType: $nutrientType, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, code, name, unit, nutrientType, description);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Nutrient &&
          other.id == this.id &&
          other.code == this.code &&
          other.name == this.name &&
          other.unit == this.unit &&
          other.nutrientType == this.nutrientType &&
          other.description == this.description);
}

class NutrientsCompanion extends UpdateCompanion<Nutrient> {
  final Value<int> id;
  final Value<String> code;
  final Value<String> name;
  final Value<String> unit;
  final Value<String> nutrientType;
  final Value<String?> description;
  const NutrientsCompanion({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.unit = const Value.absent(),
    this.nutrientType = const Value.absent(),
    this.description = const Value.absent(),
  });
  NutrientsCompanion.insert({
    this.id = const Value.absent(),
    required String code,
    required String name,
    required String unit,
    required String nutrientType,
    this.description = const Value.absent(),
  }) : code = Value(code),
       name = Value(name),
       unit = Value(unit),
       nutrientType = Value(nutrientType);
  static Insertable<Nutrient> custom({
    Expression<int>? id,
    Expression<String>? code,
    Expression<String>? name,
    Expression<String>? unit,
    Expression<String>? nutrientType,
    Expression<String>? description,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (name != null) 'name': name,
      if (unit != null) 'unit': unit,
      if (nutrientType != null) 'nutrient_type': nutrientType,
      if (description != null) 'description': description,
    });
  }

  NutrientsCompanion copyWith({
    Value<int>? id,
    Value<String>? code,
    Value<String>? name,
    Value<String>? unit,
    Value<String>? nutrientType,
    Value<String?>? description,
  }) {
    return NutrientsCompanion(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      unit: unit ?? this.unit,
      nutrientType: nutrientType ?? this.nutrientType,
      description: description ?? this.description,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (nutrientType.present) {
      map['nutrient_type'] = Variable<String>(nutrientType.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NutrientsCompanion(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('unit: $unit, ')
          ..write('nutrientType: $nutrientType, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }
}

class $ProductsTable extends Products with TableInfo<$ProductsTable, Product> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _normalizedNameMeta = const VerificationMeta(
    'normalizedName',
  );
  @override
  late final GeneratedColumn<String> normalizedName = GeneratedColumn<String>(
    'normalized_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _subcategoryMeta = const VerificationMeta(
    'subcategory',
  );
  @override
  late final GeneratedColumn<String> subcategory = GeneratedColumn<String>(
    'subcategory',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _defaultPortionGramsMeta =
      const VerificationMeta('defaultPortionGrams');
  @override
  late final GeneratedColumn<double> defaultPortionGrams =
      GeneratedColumn<double>(
        'default_portion_grams',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _ediblePartPercentMeta = const VerificationMeta(
    'ediblePartPercent',
  );
  @override
  late final GeneratedColumn<double> ediblePartPercent =
      GeneratedColumn<double>(
        'edible_part_percent',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 32),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceRefMeta = const VerificationMeta(
    'sourceRef',
  );
  @override
  late final GeneratedColumn<String> sourceRef = GeneratedColumn<String>(
    'source_ref',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    normalizedName,
    category,
    subcategory,
    description,
    defaultPortionGrams,
    ediblePartPercent,
    source,
    sourceRef,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'products';
  @override
  VerificationContext validateIntegrity(
    Insertable<Product> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('normalized_name')) {
      context.handle(
        _normalizedNameMeta,
        normalizedName.isAcceptableOrUnknown(
          data['normalized_name']!,
          _normalizedNameMeta,
        ),
      );
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    }
    if (data.containsKey('subcategory')) {
      context.handle(
        _subcategoryMeta,
        subcategory.isAcceptableOrUnknown(
          data['subcategory']!,
          _subcategoryMeta,
        ),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('default_portion_grams')) {
      context.handle(
        _defaultPortionGramsMeta,
        defaultPortionGrams.isAcceptableOrUnknown(
          data['default_portion_grams']!,
          _defaultPortionGramsMeta,
        ),
      );
    }
    if (data.containsKey('edible_part_percent')) {
      context.handle(
        _ediblePartPercentMeta,
        ediblePartPercent.isAcceptableOrUnknown(
          data['edible_part_percent']!,
          _ediblePartPercentMeta,
        ),
      );
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceMeta);
    }
    if (data.containsKey('source_ref')) {
      context.handle(
        _sourceRefMeta,
        sourceRef.isAcceptableOrUnknown(data['source_ref']!, _sourceRefMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Product map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Product(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      normalizedName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}normalized_name'],
      ),
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      ),
      subcategory: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}subcategory'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      defaultPortionGrams: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}default_portion_grams'],
      ),
      ediblePartPercent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}edible_part_percent'],
      ),
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
      sourceRef: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_ref'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $ProductsTable createAlias(String alias) {
    return $ProductsTable(attachedDatabase, alias);
  }
}

class Product extends DataClass implements Insertable<Product> {
  final int id;
  final String name;
  final String? normalizedName;
  final String? category;
  final String? subcategory;
  final String? description;
  final double? defaultPortionGrams;
  final double? ediblePartPercent;

  /// book_example | external | user_defined
  final String source;
  final String? sourceRef;
  final String? notes;
  const Product({
    required this.id,
    required this.name,
    this.normalizedName,
    this.category,
    this.subcategory,
    this.description,
    this.defaultPortionGrams,
    this.ediblePartPercent,
    required this.source,
    this.sourceRef,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || normalizedName != null) {
      map['normalized_name'] = Variable<String>(normalizedName);
    }
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<String>(category);
    }
    if (!nullToAbsent || subcategory != null) {
      map['subcategory'] = Variable<String>(subcategory);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || defaultPortionGrams != null) {
      map['default_portion_grams'] = Variable<double>(defaultPortionGrams);
    }
    if (!nullToAbsent || ediblePartPercent != null) {
      map['edible_part_percent'] = Variable<double>(ediblePartPercent);
    }
    map['source'] = Variable<String>(source);
    if (!nullToAbsent || sourceRef != null) {
      map['source_ref'] = Variable<String>(sourceRef);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  ProductsCompanion toCompanion(bool nullToAbsent) {
    return ProductsCompanion(
      id: Value(id),
      name: Value(name),
      normalizedName: normalizedName == null && nullToAbsent
          ? const Value.absent()
          : Value(normalizedName),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
      subcategory: subcategory == null && nullToAbsent
          ? const Value.absent()
          : Value(subcategory),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      defaultPortionGrams: defaultPortionGrams == null && nullToAbsent
          ? const Value.absent()
          : Value(defaultPortionGrams),
      ediblePartPercent: ediblePartPercent == null && nullToAbsent
          ? const Value.absent()
          : Value(ediblePartPercent),
      source: Value(source),
      sourceRef: sourceRef == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceRef),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory Product.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Product(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      normalizedName: serializer.fromJson<String?>(json['normalizedName']),
      category: serializer.fromJson<String?>(json['category']),
      subcategory: serializer.fromJson<String?>(json['subcategory']),
      description: serializer.fromJson<String?>(json['description']),
      defaultPortionGrams: serializer.fromJson<double?>(
        json['defaultPortionGrams'],
      ),
      ediblePartPercent: serializer.fromJson<double?>(
        json['ediblePartPercent'],
      ),
      source: serializer.fromJson<String>(json['source']),
      sourceRef: serializer.fromJson<String?>(json['sourceRef']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'normalizedName': serializer.toJson<String?>(normalizedName),
      'category': serializer.toJson<String?>(category),
      'subcategory': serializer.toJson<String?>(subcategory),
      'description': serializer.toJson<String?>(description),
      'defaultPortionGrams': serializer.toJson<double?>(defaultPortionGrams),
      'ediblePartPercent': serializer.toJson<double?>(ediblePartPercent),
      'source': serializer.toJson<String>(source),
      'sourceRef': serializer.toJson<String?>(sourceRef),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  Product copyWith({
    int? id,
    String? name,
    Value<String?> normalizedName = const Value.absent(),
    Value<String?> category = const Value.absent(),
    Value<String?> subcategory = const Value.absent(),
    Value<String?> description = const Value.absent(),
    Value<double?> defaultPortionGrams = const Value.absent(),
    Value<double?> ediblePartPercent = const Value.absent(),
    String? source,
    Value<String?> sourceRef = const Value.absent(),
    Value<String?> notes = const Value.absent(),
  }) => Product(
    id: id ?? this.id,
    name: name ?? this.name,
    normalizedName: normalizedName.present
        ? normalizedName.value
        : this.normalizedName,
    category: category.present ? category.value : this.category,
    subcategory: subcategory.present ? subcategory.value : this.subcategory,
    description: description.present ? description.value : this.description,
    defaultPortionGrams: defaultPortionGrams.present
        ? defaultPortionGrams.value
        : this.defaultPortionGrams,
    ediblePartPercent: ediblePartPercent.present
        ? ediblePartPercent.value
        : this.ediblePartPercent,
    source: source ?? this.source,
    sourceRef: sourceRef.present ? sourceRef.value : this.sourceRef,
    notes: notes.present ? notes.value : this.notes,
  );
  Product copyWithCompanion(ProductsCompanion data) {
    return Product(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      normalizedName: data.normalizedName.present
          ? data.normalizedName.value
          : this.normalizedName,
      category: data.category.present ? data.category.value : this.category,
      subcategory: data.subcategory.present
          ? data.subcategory.value
          : this.subcategory,
      description: data.description.present
          ? data.description.value
          : this.description,
      defaultPortionGrams: data.defaultPortionGrams.present
          ? data.defaultPortionGrams.value
          : this.defaultPortionGrams,
      ediblePartPercent: data.ediblePartPercent.present
          ? data.ediblePartPercent.value
          : this.ediblePartPercent,
      source: data.source.present ? data.source.value : this.source,
      sourceRef: data.sourceRef.present ? data.sourceRef.value : this.sourceRef,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Product(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('normalizedName: $normalizedName, ')
          ..write('category: $category, ')
          ..write('subcategory: $subcategory, ')
          ..write('description: $description, ')
          ..write('defaultPortionGrams: $defaultPortionGrams, ')
          ..write('ediblePartPercent: $ediblePartPercent, ')
          ..write('source: $source, ')
          ..write('sourceRef: $sourceRef, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    normalizedName,
    category,
    subcategory,
    description,
    defaultPortionGrams,
    ediblePartPercent,
    source,
    sourceRef,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Product &&
          other.id == this.id &&
          other.name == this.name &&
          other.normalizedName == this.normalizedName &&
          other.category == this.category &&
          other.subcategory == this.subcategory &&
          other.description == this.description &&
          other.defaultPortionGrams == this.defaultPortionGrams &&
          other.ediblePartPercent == this.ediblePartPercent &&
          other.source == this.source &&
          other.sourceRef == this.sourceRef &&
          other.notes == this.notes);
}

class ProductsCompanion extends UpdateCompanion<Product> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> normalizedName;
  final Value<String?> category;
  final Value<String?> subcategory;
  final Value<String?> description;
  final Value<double?> defaultPortionGrams;
  final Value<double?> ediblePartPercent;
  final Value<String> source;
  final Value<String?> sourceRef;
  final Value<String?> notes;
  const ProductsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.normalizedName = const Value.absent(),
    this.category = const Value.absent(),
    this.subcategory = const Value.absent(),
    this.description = const Value.absent(),
    this.defaultPortionGrams = const Value.absent(),
    this.ediblePartPercent = const Value.absent(),
    this.source = const Value.absent(),
    this.sourceRef = const Value.absent(),
    this.notes = const Value.absent(),
  });
  ProductsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.normalizedName = const Value.absent(),
    this.category = const Value.absent(),
    this.subcategory = const Value.absent(),
    this.description = const Value.absent(),
    this.defaultPortionGrams = const Value.absent(),
    this.ediblePartPercent = const Value.absent(),
    required String source,
    this.sourceRef = const Value.absent(),
    this.notes = const Value.absent(),
  }) : name = Value(name),
       source = Value(source);
  static Insertable<Product> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? normalizedName,
    Expression<String>? category,
    Expression<String>? subcategory,
    Expression<String>? description,
    Expression<double>? defaultPortionGrams,
    Expression<double>? ediblePartPercent,
    Expression<String>? source,
    Expression<String>? sourceRef,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (normalizedName != null) 'normalized_name': normalizedName,
      if (category != null) 'category': category,
      if (subcategory != null) 'subcategory': subcategory,
      if (description != null) 'description': description,
      if (defaultPortionGrams != null)
        'default_portion_grams': defaultPortionGrams,
      if (ediblePartPercent != null) 'edible_part_percent': ediblePartPercent,
      if (source != null) 'source': source,
      if (sourceRef != null) 'source_ref': sourceRef,
      if (notes != null) 'notes': notes,
    });
  }

  ProductsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? normalizedName,
    Value<String?>? category,
    Value<String?>? subcategory,
    Value<String?>? description,
    Value<double?>? defaultPortionGrams,
    Value<double?>? ediblePartPercent,
    Value<String>? source,
    Value<String?>? sourceRef,
    Value<String?>? notes,
  }) {
    return ProductsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      normalizedName: normalizedName ?? this.normalizedName,
      category: category ?? this.category,
      subcategory: subcategory ?? this.subcategory,
      description: description ?? this.description,
      defaultPortionGrams: defaultPortionGrams ?? this.defaultPortionGrams,
      ediblePartPercent: ediblePartPercent ?? this.ediblePartPercent,
      source: source ?? this.source,
      sourceRef: sourceRef ?? this.sourceRef,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (normalizedName.present) {
      map['normalized_name'] = Variable<String>(normalizedName.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (subcategory.present) {
      map['subcategory'] = Variable<String>(subcategory.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (defaultPortionGrams.present) {
      map['default_portion_grams'] = Variable<double>(
        defaultPortionGrams.value,
      );
    }
    if (ediblePartPercent.present) {
      map['edible_part_percent'] = Variable<double>(ediblePartPercent.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (sourceRef.present) {
      map['source_ref'] = Variable<String>(sourceRef.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('normalizedName: $normalizedName, ')
          ..write('category: $category, ')
          ..write('subcategory: $subcategory, ')
          ..write('description: $description, ')
          ..write('defaultPortionGrams: $defaultPortionGrams, ')
          ..write('ediblePartPercent: $ediblePartPercent, ')
          ..write('source: $source, ')
          ..write('sourceRef: $sourceRef, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

class $ProductNutrientValuesTable extends ProductNutrientValues
    with TableInfo<$ProductNutrientValuesTable, ProductNutrientValue> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductNutrientValuesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES products (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _nutrientIdMeta = const VerificationMeta(
    'nutrientId',
  );
  @override
  late final GeneratedColumn<int> nutrientId = GeneratedColumn<int>(
    'nutrient_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES nutrients (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<double> value = GeneratedColumn<double>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _basisTypeMeta = const VerificationMeta(
    'basisType',
  );
  @override
  late final GeneratedColumn<String> basisType = GeneratedColumn<String>(
    'basis_type',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 32),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _basisGramsMeta = const VerificationMeta(
    'basisGrams',
  );
  @override
  late final GeneratedColumn<double> basisGrams = GeneratedColumn<double>(
    'basis_grams',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _unitOverrideMeta = const VerificationMeta(
    'unitOverride',
  );
  @override
  late final GeneratedColumn<String> unitOverride = GeneratedColumn<String>(
    'unit_override',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    productId,
    nutrientId,
    value,
    basisType,
    basisGrams,
    unitOverride,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'product_nutrient_values';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProductNutrientValue> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('nutrient_id')) {
      context.handle(
        _nutrientIdMeta,
        nutrientId.isAcceptableOrUnknown(data['nutrient_id']!, _nutrientIdMeta),
      );
    } else if (isInserting) {
      context.missing(_nutrientIdMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('basis_type')) {
      context.handle(
        _basisTypeMeta,
        basisType.isAcceptableOrUnknown(data['basis_type']!, _basisTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_basisTypeMeta);
    }
    if (data.containsKey('basis_grams')) {
      context.handle(
        _basisGramsMeta,
        basisGrams.isAcceptableOrUnknown(data['basis_grams']!, _basisGramsMeta),
      );
    }
    if (data.containsKey('unit_override')) {
      context.handle(
        _unitOverrideMeta,
        unitOverride.isAcceptableOrUnknown(
          data['unit_override']!,
          _unitOverrideMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductNutrientValue map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductNutrientValue(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}product_id'],
      )!,
      nutrientId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}nutrient_id'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}value'],
      )!,
      basisType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}basis_type'],
      )!,
      basisGrams: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}basis_grams'],
      ),
      unitOverride: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit_override'],
      ),
    );
  }

  @override
  $ProductNutrientValuesTable createAlias(String alias) {
    return $ProductNutrientValuesTable(attachedDatabase, alias);
  }
}

class ProductNutrientValue extends DataClass
    implements Insertable<ProductNutrientValue> {
  final int id;
  final int productId;
  final int nutrientId;
  final double value;

  /// per_100g | per_serving
  final String basisType;
  final double? basisGrams;
  final String? unitOverride;
  const ProductNutrientValue({
    required this.id,
    required this.productId,
    required this.nutrientId,
    required this.value,
    required this.basisType,
    this.basisGrams,
    this.unitOverride,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['product_id'] = Variable<int>(productId);
    map['nutrient_id'] = Variable<int>(nutrientId);
    map['value'] = Variable<double>(value);
    map['basis_type'] = Variable<String>(basisType);
    if (!nullToAbsent || basisGrams != null) {
      map['basis_grams'] = Variable<double>(basisGrams);
    }
    if (!nullToAbsent || unitOverride != null) {
      map['unit_override'] = Variable<String>(unitOverride);
    }
    return map;
  }

  ProductNutrientValuesCompanion toCompanion(bool nullToAbsent) {
    return ProductNutrientValuesCompanion(
      id: Value(id),
      productId: Value(productId),
      nutrientId: Value(nutrientId),
      value: Value(value),
      basisType: Value(basisType),
      basisGrams: basisGrams == null && nullToAbsent
          ? const Value.absent()
          : Value(basisGrams),
      unitOverride: unitOverride == null && nullToAbsent
          ? const Value.absent()
          : Value(unitOverride),
    );
  }

  factory ProductNutrientValue.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductNutrientValue(
      id: serializer.fromJson<int>(json['id']),
      productId: serializer.fromJson<int>(json['productId']),
      nutrientId: serializer.fromJson<int>(json['nutrientId']),
      value: serializer.fromJson<double>(json['value']),
      basisType: serializer.fromJson<String>(json['basisType']),
      basisGrams: serializer.fromJson<double?>(json['basisGrams']),
      unitOverride: serializer.fromJson<String?>(json['unitOverride']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'productId': serializer.toJson<int>(productId),
      'nutrientId': serializer.toJson<int>(nutrientId),
      'value': serializer.toJson<double>(value),
      'basisType': serializer.toJson<String>(basisType),
      'basisGrams': serializer.toJson<double?>(basisGrams),
      'unitOverride': serializer.toJson<String?>(unitOverride),
    };
  }

  ProductNutrientValue copyWith({
    int? id,
    int? productId,
    int? nutrientId,
    double? value,
    String? basisType,
    Value<double?> basisGrams = const Value.absent(),
    Value<String?> unitOverride = const Value.absent(),
  }) => ProductNutrientValue(
    id: id ?? this.id,
    productId: productId ?? this.productId,
    nutrientId: nutrientId ?? this.nutrientId,
    value: value ?? this.value,
    basisType: basisType ?? this.basisType,
    basisGrams: basisGrams.present ? basisGrams.value : this.basisGrams,
    unitOverride: unitOverride.present ? unitOverride.value : this.unitOverride,
  );
  ProductNutrientValue copyWithCompanion(ProductNutrientValuesCompanion data) {
    return ProductNutrientValue(
      id: data.id.present ? data.id.value : this.id,
      productId: data.productId.present ? data.productId.value : this.productId,
      nutrientId: data.nutrientId.present
          ? data.nutrientId.value
          : this.nutrientId,
      value: data.value.present ? data.value.value : this.value,
      basisType: data.basisType.present ? data.basisType.value : this.basisType,
      basisGrams: data.basisGrams.present
          ? data.basisGrams.value
          : this.basisGrams,
      unitOverride: data.unitOverride.present
          ? data.unitOverride.value
          : this.unitOverride,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductNutrientValue(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('nutrientId: $nutrientId, ')
          ..write('value: $value, ')
          ..write('basisType: $basisType, ')
          ..write('basisGrams: $basisGrams, ')
          ..write('unitOverride: $unitOverride')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    productId,
    nutrientId,
    value,
    basisType,
    basisGrams,
    unitOverride,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductNutrientValue &&
          other.id == this.id &&
          other.productId == this.productId &&
          other.nutrientId == this.nutrientId &&
          other.value == this.value &&
          other.basisType == this.basisType &&
          other.basisGrams == this.basisGrams &&
          other.unitOverride == this.unitOverride);
}

class ProductNutrientValuesCompanion
    extends UpdateCompanion<ProductNutrientValue> {
  final Value<int> id;
  final Value<int> productId;
  final Value<int> nutrientId;
  final Value<double> value;
  final Value<String> basisType;
  final Value<double?> basisGrams;
  final Value<String?> unitOverride;
  const ProductNutrientValuesCompanion({
    this.id = const Value.absent(),
    this.productId = const Value.absent(),
    this.nutrientId = const Value.absent(),
    this.value = const Value.absent(),
    this.basisType = const Value.absent(),
    this.basisGrams = const Value.absent(),
    this.unitOverride = const Value.absent(),
  });
  ProductNutrientValuesCompanion.insert({
    this.id = const Value.absent(),
    required int productId,
    required int nutrientId,
    required double value,
    required String basisType,
    this.basisGrams = const Value.absent(),
    this.unitOverride = const Value.absent(),
  }) : productId = Value(productId),
       nutrientId = Value(nutrientId),
       value = Value(value),
       basisType = Value(basisType);
  static Insertable<ProductNutrientValue> custom({
    Expression<int>? id,
    Expression<int>? productId,
    Expression<int>? nutrientId,
    Expression<double>? value,
    Expression<String>? basisType,
    Expression<double>? basisGrams,
    Expression<String>? unitOverride,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productId != null) 'product_id': productId,
      if (nutrientId != null) 'nutrient_id': nutrientId,
      if (value != null) 'value': value,
      if (basisType != null) 'basis_type': basisType,
      if (basisGrams != null) 'basis_grams': basisGrams,
      if (unitOverride != null) 'unit_override': unitOverride,
    });
  }

  ProductNutrientValuesCompanion copyWith({
    Value<int>? id,
    Value<int>? productId,
    Value<int>? nutrientId,
    Value<double>? value,
    Value<String>? basisType,
    Value<double?>? basisGrams,
    Value<String?>? unitOverride,
  }) {
    return ProductNutrientValuesCompanion(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      nutrientId: nutrientId ?? this.nutrientId,
      value: value ?? this.value,
      basisType: basisType ?? this.basisType,
      basisGrams: basisGrams ?? this.basisGrams,
      unitOverride: unitOverride ?? this.unitOverride,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (nutrientId.present) {
      map['nutrient_id'] = Variable<int>(nutrientId.value);
    }
    if (value.present) {
      map['value'] = Variable<double>(value.value);
    }
    if (basisType.present) {
      map['basis_type'] = Variable<String>(basisType.value);
    }
    if (basisGrams.present) {
      map['basis_grams'] = Variable<double>(basisGrams.value);
    }
    if (unitOverride.present) {
      map['unit_override'] = Variable<String>(unitOverride.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductNutrientValuesCompanion(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('nutrientId: $nutrientId, ')
          ..write('value: $value, ')
          ..write('basisType: $basisType, ')
          ..write('basisGrams: $basisGrams, ')
          ..write('unitOverride: $unitOverride')
          ..write(')'))
        .toString();
  }
}

class $FormulaDefinitionsTable extends FormulaDefinitions
    with TableInfo<$FormulaDefinitionsTable, FormulaDefinition> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FormulaDefinitionsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _expressionTemplateMeta =
      const VerificationMeta('expressionTemplate');
  @override
  late final GeneratedColumn<String> expressionTemplate =
      GeneratedColumn<String>(
        'expression_template',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _variableDescriptionMeta =
      const VerificationMeta('variableDescription');
  @override
  late final GeneratedColumn<String> variableDescription =
      GeneratedColumn<String>(
        'variable_description',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _applicationNotesMeta = const VerificationMeta(
    'applicationNotes',
  );
  @override
  late final GeneratedColumn<String> applicationNotes = GeneratedColumn<String>(
    'application_notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    code,
    name,
    expressionTemplate,
    variableDescription,
    applicationNotes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'formula_definitions';
  @override
  VerificationContext validateIntegrity(
    Insertable<FormulaDefinition> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('expression_template')) {
      context.handle(
        _expressionTemplateMeta,
        expressionTemplate.isAcceptableOrUnknown(
          data['expression_template']!,
          _expressionTemplateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_expressionTemplateMeta);
    }
    if (data.containsKey('variable_description')) {
      context.handle(
        _variableDescriptionMeta,
        variableDescription.isAcceptableOrUnknown(
          data['variable_description']!,
          _variableDescriptionMeta,
        ),
      );
    }
    if (data.containsKey('application_notes')) {
      context.handle(
        _applicationNotesMeta,
        applicationNotes.isAcceptableOrUnknown(
          data['application_notes']!,
          _applicationNotesMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FormulaDefinition map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FormulaDefinition(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      expressionTemplate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}expression_template'],
      )!,
      variableDescription: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}variable_description'],
      ),
      applicationNotes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}application_notes'],
      ),
    );
  }

  @override
  $FormulaDefinitionsTable createAlias(String alias) {
    return $FormulaDefinitionsTable(attachedDatabase, alias);
  }
}

class FormulaDefinition extends DataClass
    implements Insertable<FormulaDefinition> {
  final int id;
  final String code;
  final String name;

  /// Human-readable template, e.g. "[9.99*weight_kg]+[6.25*height_cm]-[4.92*age_years]+5"
  final String expressionTemplate;
  final String? variableDescription;
  final String? applicationNotes;
  const FormulaDefinition({
    required this.id,
    required this.code,
    required this.name,
    required this.expressionTemplate,
    this.variableDescription,
    this.applicationNotes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['code'] = Variable<String>(code);
    map['name'] = Variable<String>(name);
    map['expression_template'] = Variable<String>(expressionTemplate);
    if (!nullToAbsent || variableDescription != null) {
      map['variable_description'] = Variable<String>(variableDescription);
    }
    if (!nullToAbsent || applicationNotes != null) {
      map['application_notes'] = Variable<String>(applicationNotes);
    }
    return map;
  }

  FormulaDefinitionsCompanion toCompanion(bool nullToAbsent) {
    return FormulaDefinitionsCompanion(
      id: Value(id),
      code: Value(code),
      name: Value(name),
      expressionTemplate: Value(expressionTemplate),
      variableDescription: variableDescription == null && nullToAbsent
          ? const Value.absent()
          : Value(variableDescription),
      applicationNotes: applicationNotes == null && nullToAbsent
          ? const Value.absent()
          : Value(applicationNotes),
    );
  }

  factory FormulaDefinition.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FormulaDefinition(
      id: serializer.fromJson<int>(json['id']),
      code: serializer.fromJson<String>(json['code']),
      name: serializer.fromJson<String>(json['name']),
      expressionTemplate: serializer.fromJson<String>(
        json['expressionTemplate'],
      ),
      variableDescription: serializer.fromJson<String?>(
        json['variableDescription'],
      ),
      applicationNotes: serializer.fromJson<String?>(json['applicationNotes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'code': serializer.toJson<String>(code),
      'name': serializer.toJson<String>(name),
      'expressionTemplate': serializer.toJson<String>(expressionTemplate),
      'variableDescription': serializer.toJson<String?>(variableDescription),
      'applicationNotes': serializer.toJson<String?>(applicationNotes),
    };
  }

  FormulaDefinition copyWith({
    int? id,
    String? code,
    String? name,
    String? expressionTemplate,
    Value<String?> variableDescription = const Value.absent(),
    Value<String?> applicationNotes = const Value.absent(),
  }) => FormulaDefinition(
    id: id ?? this.id,
    code: code ?? this.code,
    name: name ?? this.name,
    expressionTemplate: expressionTemplate ?? this.expressionTemplate,
    variableDescription: variableDescription.present
        ? variableDescription.value
        : this.variableDescription,
    applicationNotes: applicationNotes.present
        ? applicationNotes.value
        : this.applicationNotes,
  );
  FormulaDefinition copyWithCompanion(FormulaDefinitionsCompanion data) {
    return FormulaDefinition(
      id: data.id.present ? data.id.value : this.id,
      code: data.code.present ? data.code.value : this.code,
      name: data.name.present ? data.name.value : this.name,
      expressionTemplate: data.expressionTemplate.present
          ? data.expressionTemplate.value
          : this.expressionTemplate,
      variableDescription: data.variableDescription.present
          ? data.variableDescription.value
          : this.variableDescription,
      applicationNotes: data.applicationNotes.present
          ? data.applicationNotes.value
          : this.applicationNotes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FormulaDefinition(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('expressionTemplate: $expressionTemplate, ')
          ..write('variableDescription: $variableDescription, ')
          ..write('applicationNotes: $applicationNotes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    code,
    name,
    expressionTemplate,
    variableDescription,
    applicationNotes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FormulaDefinition &&
          other.id == this.id &&
          other.code == this.code &&
          other.name == this.name &&
          other.expressionTemplate == this.expressionTemplate &&
          other.variableDescription == this.variableDescription &&
          other.applicationNotes == this.applicationNotes);
}

class FormulaDefinitionsCompanion extends UpdateCompanion<FormulaDefinition> {
  final Value<int> id;
  final Value<String> code;
  final Value<String> name;
  final Value<String> expressionTemplate;
  final Value<String?> variableDescription;
  final Value<String?> applicationNotes;
  const FormulaDefinitionsCompanion({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.expressionTemplate = const Value.absent(),
    this.variableDescription = const Value.absent(),
    this.applicationNotes = const Value.absent(),
  });
  FormulaDefinitionsCompanion.insert({
    this.id = const Value.absent(),
    required String code,
    required String name,
    required String expressionTemplate,
    this.variableDescription = const Value.absent(),
    this.applicationNotes = const Value.absent(),
  }) : code = Value(code),
       name = Value(name),
       expressionTemplate = Value(expressionTemplate);
  static Insertable<FormulaDefinition> custom({
    Expression<int>? id,
    Expression<String>? code,
    Expression<String>? name,
    Expression<String>? expressionTemplate,
    Expression<String>? variableDescription,
    Expression<String>? applicationNotes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (name != null) 'name': name,
      if (expressionTemplate != null) 'expression_template': expressionTemplate,
      if (variableDescription != null)
        'variable_description': variableDescription,
      if (applicationNotes != null) 'application_notes': applicationNotes,
    });
  }

  FormulaDefinitionsCompanion copyWith({
    Value<int>? id,
    Value<String>? code,
    Value<String>? name,
    Value<String>? expressionTemplate,
    Value<String?>? variableDescription,
    Value<String?>? applicationNotes,
  }) {
    return FormulaDefinitionsCompanion(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      expressionTemplate: expressionTemplate ?? this.expressionTemplate,
      variableDescription: variableDescription ?? this.variableDescription,
      applicationNotes: applicationNotes ?? this.applicationNotes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (expressionTemplate.present) {
      map['expression_template'] = Variable<String>(expressionTemplate.value);
    }
    if (variableDescription.present) {
      map['variable_description'] = Variable<String>(variableDescription.value);
    }
    if (applicationNotes.present) {
      map['application_notes'] = Variable<String>(applicationNotes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FormulaDefinitionsCompanion(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('expressionTemplate: $expressionTemplate, ')
          ..write('variableDescription: $variableDescription, ')
          ..write('applicationNotes: $applicationNotes')
          ..write(')'))
        .toString();
  }
}

class $ActivityLevelsTable extends ActivityLevels
    with TableInfo<$ActivityLevelsTable, ActivityLevel> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ActivityLevelsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _multiplierMinMeta = const VerificationMeta(
    'multiplierMin',
  );
  @override
  late final GeneratedColumn<double> multiplierMin = GeneratedColumn<double>(
    'multiplier_min',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _multiplierMaxMeta = const VerificationMeta(
    'multiplierMax',
  );
  @override
  late final GeneratedColumn<double> multiplierMax = GeneratedColumn<double>(
    'multiplier_max',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    code,
    multiplierMin,
    multiplierMax,
    description,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'activity_levels';
  @override
  VerificationContext validateIntegrity(
    Insertable<ActivityLevel> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('multiplier_min')) {
      context.handle(
        _multiplierMinMeta,
        multiplierMin.isAcceptableOrUnknown(
          data['multiplier_min']!,
          _multiplierMinMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_multiplierMinMeta);
    }
    if (data.containsKey('multiplier_max')) {
      context.handle(
        _multiplierMaxMeta,
        multiplierMax.isAcceptableOrUnknown(
          data['multiplier_max']!,
          _multiplierMaxMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_multiplierMaxMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ActivityLevel map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ActivityLevel(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      multiplierMin: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}multiplier_min'],
      )!,
      multiplierMax: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}multiplier_max'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $ActivityLevelsTable createAlias(String alias) {
    return $ActivityLevelsTable(attachedDatabase, alias);
  }
}

class ActivityLevel extends DataClass implements Insertable<ActivityLevel> {
  final int id;
  final String code;
  final double multiplierMin;
  final double multiplierMax;
  final String description;
  final int sortOrder;
  const ActivityLevel({
    required this.id,
    required this.code,
    required this.multiplierMin,
    required this.multiplierMax,
    required this.description,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['code'] = Variable<String>(code);
    map['multiplier_min'] = Variable<double>(multiplierMin);
    map['multiplier_max'] = Variable<double>(multiplierMax);
    map['description'] = Variable<String>(description);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  ActivityLevelsCompanion toCompanion(bool nullToAbsent) {
    return ActivityLevelsCompanion(
      id: Value(id),
      code: Value(code),
      multiplierMin: Value(multiplierMin),
      multiplierMax: Value(multiplierMax),
      description: Value(description),
      sortOrder: Value(sortOrder),
    );
  }

  factory ActivityLevel.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ActivityLevel(
      id: serializer.fromJson<int>(json['id']),
      code: serializer.fromJson<String>(json['code']),
      multiplierMin: serializer.fromJson<double>(json['multiplierMin']),
      multiplierMax: serializer.fromJson<double>(json['multiplierMax']),
      description: serializer.fromJson<String>(json['description']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'code': serializer.toJson<String>(code),
      'multiplierMin': serializer.toJson<double>(multiplierMin),
      'multiplierMax': serializer.toJson<double>(multiplierMax),
      'description': serializer.toJson<String>(description),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  ActivityLevel copyWith({
    int? id,
    String? code,
    double? multiplierMin,
    double? multiplierMax,
    String? description,
    int? sortOrder,
  }) => ActivityLevel(
    id: id ?? this.id,
    code: code ?? this.code,
    multiplierMin: multiplierMin ?? this.multiplierMin,
    multiplierMax: multiplierMax ?? this.multiplierMax,
    description: description ?? this.description,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  ActivityLevel copyWithCompanion(ActivityLevelsCompanion data) {
    return ActivityLevel(
      id: data.id.present ? data.id.value : this.id,
      code: data.code.present ? data.code.value : this.code,
      multiplierMin: data.multiplierMin.present
          ? data.multiplierMin.value
          : this.multiplierMin,
      multiplierMax: data.multiplierMax.present
          ? data.multiplierMax.value
          : this.multiplierMax,
      description: data.description.present
          ? data.description.value
          : this.description,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ActivityLevel(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('multiplierMin: $multiplierMin, ')
          ..write('multiplierMax: $multiplierMax, ')
          ..write('description: $description, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    code,
    multiplierMin,
    multiplierMax,
    description,
    sortOrder,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ActivityLevel &&
          other.id == this.id &&
          other.code == this.code &&
          other.multiplierMin == this.multiplierMin &&
          other.multiplierMax == this.multiplierMax &&
          other.description == this.description &&
          other.sortOrder == this.sortOrder);
}

class ActivityLevelsCompanion extends UpdateCompanion<ActivityLevel> {
  final Value<int> id;
  final Value<String> code;
  final Value<double> multiplierMin;
  final Value<double> multiplierMax;
  final Value<String> description;
  final Value<int> sortOrder;
  const ActivityLevelsCompanion({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.multiplierMin = const Value.absent(),
    this.multiplierMax = const Value.absent(),
    this.description = const Value.absent(),
    this.sortOrder = const Value.absent(),
  });
  ActivityLevelsCompanion.insert({
    this.id = const Value.absent(),
    required String code,
    required double multiplierMin,
    required double multiplierMax,
    required String description,
    this.sortOrder = const Value.absent(),
  }) : code = Value(code),
       multiplierMin = Value(multiplierMin),
       multiplierMax = Value(multiplierMax),
       description = Value(description);
  static Insertable<ActivityLevel> custom({
    Expression<int>? id,
    Expression<String>? code,
    Expression<double>? multiplierMin,
    Expression<double>? multiplierMax,
    Expression<String>? description,
    Expression<int>? sortOrder,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (multiplierMin != null) 'multiplier_min': multiplierMin,
      if (multiplierMax != null) 'multiplier_max': multiplierMax,
      if (description != null) 'description': description,
      if (sortOrder != null) 'sort_order': sortOrder,
    });
  }

  ActivityLevelsCompanion copyWith({
    Value<int>? id,
    Value<String>? code,
    Value<double>? multiplierMin,
    Value<double>? multiplierMax,
    Value<String>? description,
    Value<int>? sortOrder,
  }) {
    return ActivityLevelsCompanion(
      id: id ?? this.id,
      code: code ?? this.code,
      multiplierMin: multiplierMin ?? this.multiplierMin,
      multiplierMax: multiplierMax ?? this.multiplierMax,
      description: description ?? this.description,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (multiplierMin.present) {
      map['multiplier_min'] = Variable<double>(multiplierMin.value);
    }
    if (multiplierMax.present) {
      map['multiplier_max'] = Variable<double>(multiplierMax.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ActivityLevelsCompanion(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('multiplierMin: $multiplierMin, ')
          ..write('multiplierMax: $multiplierMax, ')
          ..write('description: $description, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }
}

class $MacroNormTemplatesTable extends MacroNormTemplates
    with TableInfo<$MacroNormTemplatesTable, MacroNormTemplate> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MacroNormTemplatesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _normTypeMeta = const VerificationMeta(
    'normType',
  );
  @override
  late final GeneratedColumn<String> normType = GeneratedColumn<String>(
    'norm_type',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 48),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sexMeta = const VerificationMeta('sex');
  @override
  late final GeneratedColumn<String> sex = GeneratedColumn<String>(
    'sex',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 16),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _carbMinPctMeta = const VerificationMeta(
    'carbMinPct',
  );
  @override
  late final GeneratedColumn<double> carbMinPct = GeneratedColumn<double>(
    'carb_min_pct',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _carbMaxPctMeta = const VerificationMeta(
    'carbMaxPct',
  );
  @override
  late final GeneratedColumn<double> carbMaxPct = GeneratedColumn<double>(
    'carb_max_pct',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fatMinPctMeta = const VerificationMeta(
    'fatMinPct',
  );
  @override
  late final GeneratedColumn<double> fatMinPct = GeneratedColumn<double>(
    'fat_min_pct',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fatMaxPctMeta = const VerificationMeta(
    'fatMaxPct',
  );
  @override
  late final GeneratedColumn<double> fatMaxPct = GeneratedColumn<double>(
    'fat_max_pct',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _proteinMinPctMeta = const VerificationMeta(
    'proteinMinPct',
  );
  @override
  late final GeneratedColumn<double> proteinMinPct = GeneratedColumn<double>(
    'protein_min_pct',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _proteinMaxPctMeta = const VerificationMeta(
    'proteinMaxPct',
  );
  @override
  late final GeneratedColumn<double> proteinMaxPct = GeneratedColumn<double>(
    'protein_max_pct',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _proteinGPerKgMinMeta = const VerificationMeta(
    'proteinGPerKgMin',
  );
  @override
  late final GeneratedColumn<double> proteinGPerKgMin = GeneratedColumn<double>(
    'protein_g_per_kg_min',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _proteinGPerKgMaxMeta = const VerificationMeta(
    'proteinGPerKgMax',
  );
  @override
  late final GeneratedColumn<double> proteinGPerKgMax = GeneratedColumn<double>(
    'protein_g_per_kg_max',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fatGPerKgMinMeta = const VerificationMeta(
    'fatGPerKgMin',
  );
  @override
  late final GeneratedColumn<double> fatGPerKgMin = GeneratedColumn<double>(
    'fat_g_per_kg_min',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fatGPerKgMaxMeta = const VerificationMeta(
    'fatGPerKgMax',
  );
  @override
  late final GeneratedColumn<double> fatGPerKgMax = GeneratedColumn<double>(
    'fat_g_per_kg_max',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _kcalPerGramProteinMeta =
      const VerificationMeta('kcalPerGramProtein');
  @override
  late final GeneratedColumn<double> kcalPerGramProtein =
      GeneratedColumn<double>(
        'kcal_per_gram_protein',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _kcalPerGramCarbMeta = const VerificationMeta(
    'kcalPerGramCarb',
  );
  @override
  late final GeneratedColumn<double> kcalPerGramCarb = GeneratedColumn<double>(
    'kcal_per_gram_carb',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _kcalPerGramFatMeta = const VerificationMeta(
    'kcalPerGramFat',
  );
  @override
  late final GeneratedColumn<double> kcalPerGramFat = GeneratedColumn<double>(
    'kcal_per_gram_fat',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    code,
    normType,
    sex,
    carbMinPct,
    carbMaxPct,
    fatMinPct,
    fatMaxPct,
    proteinMinPct,
    proteinMaxPct,
    proteinGPerKgMin,
    proteinGPerKgMax,
    fatGPerKgMin,
    fatGPerKgMax,
    kcalPerGramProtein,
    kcalPerGramCarb,
    kcalPerGramFat,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'macro_norm_templates';
  @override
  VerificationContext validateIntegrity(
    Insertable<MacroNormTemplate> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('norm_type')) {
      context.handle(
        _normTypeMeta,
        normType.isAcceptableOrUnknown(data['norm_type']!, _normTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_normTypeMeta);
    }
    if (data.containsKey('sex')) {
      context.handle(
        _sexMeta,
        sex.isAcceptableOrUnknown(data['sex']!, _sexMeta),
      );
    }
    if (data.containsKey('carb_min_pct')) {
      context.handle(
        _carbMinPctMeta,
        carbMinPct.isAcceptableOrUnknown(
          data['carb_min_pct']!,
          _carbMinPctMeta,
        ),
      );
    }
    if (data.containsKey('carb_max_pct')) {
      context.handle(
        _carbMaxPctMeta,
        carbMaxPct.isAcceptableOrUnknown(
          data['carb_max_pct']!,
          _carbMaxPctMeta,
        ),
      );
    }
    if (data.containsKey('fat_min_pct')) {
      context.handle(
        _fatMinPctMeta,
        fatMinPct.isAcceptableOrUnknown(data['fat_min_pct']!, _fatMinPctMeta),
      );
    }
    if (data.containsKey('fat_max_pct')) {
      context.handle(
        _fatMaxPctMeta,
        fatMaxPct.isAcceptableOrUnknown(data['fat_max_pct']!, _fatMaxPctMeta),
      );
    }
    if (data.containsKey('protein_min_pct')) {
      context.handle(
        _proteinMinPctMeta,
        proteinMinPct.isAcceptableOrUnknown(
          data['protein_min_pct']!,
          _proteinMinPctMeta,
        ),
      );
    }
    if (data.containsKey('protein_max_pct')) {
      context.handle(
        _proteinMaxPctMeta,
        proteinMaxPct.isAcceptableOrUnknown(
          data['protein_max_pct']!,
          _proteinMaxPctMeta,
        ),
      );
    }
    if (data.containsKey('protein_g_per_kg_min')) {
      context.handle(
        _proteinGPerKgMinMeta,
        proteinGPerKgMin.isAcceptableOrUnknown(
          data['protein_g_per_kg_min']!,
          _proteinGPerKgMinMeta,
        ),
      );
    }
    if (data.containsKey('protein_g_per_kg_max')) {
      context.handle(
        _proteinGPerKgMaxMeta,
        proteinGPerKgMax.isAcceptableOrUnknown(
          data['protein_g_per_kg_max']!,
          _proteinGPerKgMaxMeta,
        ),
      );
    }
    if (data.containsKey('fat_g_per_kg_min')) {
      context.handle(
        _fatGPerKgMinMeta,
        fatGPerKgMin.isAcceptableOrUnknown(
          data['fat_g_per_kg_min']!,
          _fatGPerKgMinMeta,
        ),
      );
    }
    if (data.containsKey('fat_g_per_kg_max')) {
      context.handle(
        _fatGPerKgMaxMeta,
        fatGPerKgMax.isAcceptableOrUnknown(
          data['fat_g_per_kg_max']!,
          _fatGPerKgMaxMeta,
        ),
      );
    }
    if (data.containsKey('kcal_per_gram_protein')) {
      context.handle(
        _kcalPerGramProteinMeta,
        kcalPerGramProtein.isAcceptableOrUnknown(
          data['kcal_per_gram_protein']!,
          _kcalPerGramProteinMeta,
        ),
      );
    }
    if (data.containsKey('kcal_per_gram_carb')) {
      context.handle(
        _kcalPerGramCarbMeta,
        kcalPerGramCarb.isAcceptableOrUnknown(
          data['kcal_per_gram_carb']!,
          _kcalPerGramCarbMeta,
        ),
      );
    }
    if (data.containsKey('kcal_per_gram_fat')) {
      context.handle(
        _kcalPerGramFatMeta,
        kcalPerGramFat.isAcceptableOrUnknown(
          data['kcal_per_gram_fat']!,
          _kcalPerGramFatMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MacroNormTemplate map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MacroNormTemplate(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      normType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}norm_type'],
      )!,
      sex: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sex'],
      ),
      carbMinPct: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}carb_min_pct'],
      ),
      carbMaxPct: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}carb_max_pct'],
      ),
      fatMinPct: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fat_min_pct'],
      ),
      fatMaxPct: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fat_max_pct'],
      ),
      proteinMinPct: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}protein_min_pct'],
      ),
      proteinMaxPct: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}protein_max_pct'],
      ),
      proteinGPerKgMin: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}protein_g_per_kg_min'],
      ),
      proteinGPerKgMax: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}protein_g_per_kg_max'],
      ),
      fatGPerKgMin: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fat_g_per_kg_min'],
      ),
      fatGPerKgMax: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fat_g_per_kg_max'],
      ),
      kcalPerGramProtein: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}kcal_per_gram_protein'],
      ),
      kcalPerGramCarb: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}kcal_per_gram_carb'],
      ),
      kcalPerGramFat: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}kcal_per_gram_fat'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $MacroNormTemplatesTable createAlias(String alias) {
    return $MacroNormTemplatesTable(attachedDatabase, alias);
  }
}

class MacroNormTemplate extends DataClass
    implements Insertable<MacroNormTemplate> {
  final int id;
  final String code;

  /// who_percent | athlete_percent | g_per_kg_remainder_carbs
  final String normType;

  /// male | female | any
  final String? sex;
  final double? carbMinPct;
  final double? carbMaxPct;
  final double? fatMinPct;
  final double? fatMaxPct;
  final double? proteinMinPct;
  final double? proteinMaxPct;
  final double? proteinGPerKgMin;
  final double? proteinGPerKgMax;
  final double? fatGPerKgMin;
  final double? fatGPerKgMax;

  /// kcal per gram protein/carbs (book: 4.1) and fat (9.3)
  final double? kcalPerGramProtein;
  final double? kcalPerGramCarb;
  final double? kcalPerGramFat;
  final String? notes;
  const MacroNormTemplate({
    required this.id,
    required this.code,
    required this.normType,
    this.sex,
    this.carbMinPct,
    this.carbMaxPct,
    this.fatMinPct,
    this.fatMaxPct,
    this.proteinMinPct,
    this.proteinMaxPct,
    this.proteinGPerKgMin,
    this.proteinGPerKgMax,
    this.fatGPerKgMin,
    this.fatGPerKgMax,
    this.kcalPerGramProtein,
    this.kcalPerGramCarb,
    this.kcalPerGramFat,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['code'] = Variable<String>(code);
    map['norm_type'] = Variable<String>(normType);
    if (!nullToAbsent || sex != null) {
      map['sex'] = Variable<String>(sex);
    }
    if (!nullToAbsent || carbMinPct != null) {
      map['carb_min_pct'] = Variable<double>(carbMinPct);
    }
    if (!nullToAbsent || carbMaxPct != null) {
      map['carb_max_pct'] = Variable<double>(carbMaxPct);
    }
    if (!nullToAbsent || fatMinPct != null) {
      map['fat_min_pct'] = Variable<double>(fatMinPct);
    }
    if (!nullToAbsent || fatMaxPct != null) {
      map['fat_max_pct'] = Variable<double>(fatMaxPct);
    }
    if (!nullToAbsent || proteinMinPct != null) {
      map['protein_min_pct'] = Variable<double>(proteinMinPct);
    }
    if (!nullToAbsent || proteinMaxPct != null) {
      map['protein_max_pct'] = Variable<double>(proteinMaxPct);
    }
    if (!nullToAbsent || proteinGPerKgMin != null) {
      map['protein_g_per_kg_min'] = Variable<double>(proteinGPerKgMin);
    }
    if (!nullToAbsent || proteinGPerKgMax != null) {
      map['protein_g_per_kg_max'] = Variable<double>(proteinGPerKgMax);
    }
    if (!nullToAbsent || fatGPerKgMin != null) {
      map['fat_g_per_kg_min'] = Variable<double>(fatGPerKgMin);
    }
    if (!nullToAbsent || fatGPerKgMax != null) {
      map['fat_g_per_kg_max'] = Variable<double>(fatGPerKgMax);
    }
    if (!nullToAbsent || kcalPerGramProtein != null) {
      map['kcal_per_gram_protein'] = Variable<double>(kcalPerGramProtein);
    }
    if (!nullToAbsent || kcalPerGramCarb != null) {
      map['kcal_per_gram_carb'] = Variable<double>(kcalPerGramCarb);
    }
    if (!nullToAbsent || kcalPerGramFat != null) {
      map['kcal_per_gram_fat'] = Variable<double>(kcalPerGramFat);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  MacroNormTemplatesCompanion toCompanion(bool nullToAbsent) {
    return MacroNormTemplatesCompanion(
      id: Value(id),
      code: Value(code),
      normType: Value(normType),
      sex: sex == null && nullToAbsent ? const Value.absent() : Value(sex),
      carbMinPct: carbMinPct == null && nullToAbsent
          ? const Value.absent()
          : Value(carbMinPct),
      carbMaxPct: carbMaxPct == null && nullToAbsent
          ? const Value.absent()
          : Value(carbMaxPct),
      fatMinPct: fatMinPct == null && nullToAbsent
          ? const Value.absent()
          : Value(fatMinPct),
      fatMaxPct: fatMaxPct == null && nullToAbsent
          ? const Value.absent()
          : Value(fatMaxPct),
      proteinMinPct: proteinMinPct == null && nullToAbsent
          ? const Value.absent()
          : Value(proteinMinPct),
      proteinMaxPct: proteinMaxPct == null && nullToAbsent
          ? const Value.absent()
          : Value(proteinMaxPct),
      proteinGPerKgMin: proteinGPerKgMin == null && nullToAbsent
          ? const Value.absent()
          : Value(proteinGPerKgMin),
      proteinGPerKgMax: proteinGPerKgMax == null && nullToAbsent
          ? const Value.absent()
          : Value(proteinGPerKgMax),
      fatGPerKgMin: fatGPerKgMin == null && nullToAbsent
          ? const Value.absent()
          : Value(fatGPerKgMin),
      fatGPerKgMax: fatGPerKgMax == null && nullToAbsent
          ? const Value.absent()
          : Value(fatGPerKgMax),
      kcalPerGramProtein: kcalPerGramProtein == null && nullToAbsent
          ? const Value.absent()
          : Value(kcalPerGramProtein),
      kcalPerGramCarb: kcalPerGramCarb == null && nullToAbsent
          ? const Value.absent()
          : Value(kcalPerGramCarb),
      kcalPerGramFat: kcalPerGramFat == null && nullToAbsent
          ? const Value.absent()
          : Value(kcalPerGramFat),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory MacroNormTemplate.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MacroNormTemplate(
      id: serializer.fromJson<int>(json['id']),
      code: serializer.fromJson<String>(json['code']),
      normType: serializer.fromJson<String>(json['normType']),
      sex: serializer.fromJson<String?>(json['sex']),
      carbMinPct: serializer.fromJson<double?>(json['carbMinPct']),
      carbMaxPct: serializer.fromJson<double?>(json['carbMaxPct']),
      fatMinPct: serializer.fromJson<double?>(json['fatMinPct']),
      fatMaxPct: serializer.fromJson<double?>(json['fatMaxPct']),
      proteinMinPct: serializer.fromJson<double?>(json['proteinMinPct']),
      proteinMaxPct: serializer.fromJson<double?>(json['proteinMaxPct']),
      proteinGPerKgMin: serializer.fromJson<double?>(json['proteinGPerKgMin']),
      proteinGPerKgMax: serializer.fromJson<double?>(json['proteinGPerKgMax']),
      fatGPerKgMin: serializer.fromJson<double?>(json['fatGPerKgMin']),
      fatGPerKgMax: serializer.fromJson<double?>(json['fatGPerKgMax']),
      kcalPerGramProtein: serializer.fromJson<double?>(
        json['kcalPerGramProtein'],
      ),
      kcalPerGramCarb: serializer.fromJson<double?>(json['kcalPerGramCarb']),
      kcalPerGramFat: serializer.fromJson<double?>(json['kcalPerGramFat']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'code': serializer.toJson<String>(code),
      'normType': serializer.toJson<String>(normType),
      'sex': serializer.toJson<String?>(sex),
      'carbMinPct': serializer.toJson<double?>(carbMinPct),
      'carbMaxPct': serializer.toJson<double?>(carbMaxPct),
      'fatMinPct': serializer.toJson<double?>(fatMinPct),
      'fatMaxPct': serializer.toJson<double?>(fatMaxPct),
      'proteinMinPct': serializer.toJson<double?>(proteinMinPct),
      'proteinMaxPct': serializer.toJson<double?>(proteinMaxPct),
      'proteinGPerKgMin': serializer.toJson<double?>(proteinGPerKgMin),
      'proteinGPerKgMax': serializer.toJson<double?>(proteinGPerKgMax),
      'fatGPerKgMin': serializer.toJson<double?>(fatGPerKgMin),
      'fatGPerKgMax': serializer.toJson<double?>(fatGPerKgMax),
      'kcalPerGramProtein': serializer.toJson<double?>(kcalPerGramProtein),
      'kcalPerGramCarb': serializer.toJson<double?>(kcalPerGramCarb),
      'kcalPerGramFat': serializer.toJson<double?>(kcalPerGramFat),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  MacroNormTemplate copyWith({
    int? id,
    String? code,
    String? normType,
    Value<String?> sex = const Value.absent(),
    Value<double?> carbMinPct = const Value.absent(),
    Value<double?> carbMaxPct = const Value.absent(),
    Value<double?> fatMinPct = const Value.absent(),
    Value<double?> fatMaxPct = const Value.absent(),
    Value<double?> proteinMinPct = const Value.absent(),
    Value<double?> proteinMaxPct = const Value.absent(),
    Value<double?> proteinGPerKgMin = const Value.absent(),
    Value<double?> proteinGPerKgMax = const Value.absent(),
    Value<double?> fatGPerKgMin = const Value.absent(),
    Value<double?> fatGPerKgMax = const Value.absent(),
    Value<double?> kcalPerGramProtein = const Value.absent(),
    Value<double?> kcalPerGramCarb = const Value.absent(),
    Value<double?> kcalPerGramFat = const Value.absent(),
    Value<String?> notes = const Value.absent(),
  }) => MacroNormTemplate(
    id: id ?? this.id,
    code: code ?? this.code,
    normType: normType ?? this.normType,
    sex: sex.present ? sex.value : this.sex,
    carbMinPct: carbMinPct.present ? carbMinPct.value : this.carbMinPct,
    carbMaxPct: carbMaxPct.present ? carbMaxPct.value : this.carbMaxPct,
    fatMinPct: fatMinPct.present ? fatMinPct.value : this.fatMinPct,
    fatMaxPct: fatMaxPct.present ? fatMaxPct.value : this.fatMaxPct,
    proteinMinPct: proteinMinPct.present
        ? proteinMinPct.value
        : this.proteinMinPct,
    proteinMaxPct: proteinMaxPct.present
        ? proteinMaxPct.value
        : this.proteinMaxPct,
    proteinGPerKgMin: proteinGPerKgMin.present
        ? proteinGPerKgMin.value
        : this.proteinGPerKgMin,
    proteinGPerKgMax: proteinGPerKgMax.present
        ? proteinGPerKgMax.value
        : this.proteinGPerKgMax,
    fatGPerKgMin: fatGPerKgMin.present ? fatGPerKgMin.value : this.fatGPerKgMin,
    fatGPerKgMax: fatGPerKgMax.present ? fatGPerKgMax.value : this.fatGPerKgMax,
    kcalPerGramProtein: kcalPerGramProtein.present
        ? kcalPerGramProtein.value
        : this.kcalPerGramProtein,
    kcalPerGramCarb: kcalPerGramCarb.present
        ? kcalPerGramCarb.value
        : this.kcalPerGramCarb,
    kcalPerGramFat: kcalPerGramFat.present
        ? kcalPerGramFat.value
        : this.kcalPerGramFat,
    notes: notes.present ? notes.value : this.notes,
  );
  MacroNormTemplate copyWithCompanion(MacroNormTemplatesCompanion data) {
    return MacroNormTemplate(
      id: data.id.present ? data.id.value : this.id,
      code: data.code.present ? data.code.value : this.code,
      normType: data.normType.present ? data.normType.value : this.normType,
      sex: data.sex.present ? data.sex.value : this.sex,
      carbMinPct: data.carbMinPct.present
          ? data.carbMinPct.value
          : this.carbMinPct,
      carbMaxPct: data.carbMaxPct.present
          ? data.carbMaxPct.value
          : this.carbMaxPct,
      fatMinPct: data.fatMinPct.present ? data.fatMinPct.value : this.fatMinPct,
      fatMaxPct: data.fatMaxPct.present ? data.fatMaxPct.value : this.fatMaxPct,
      proteinMinPct: data.proteinMinPct.present
          ? data.proteinMinPct.value
          : this.proteinMinPct,
      proteinMaxPct: data.proteinMaxPct.present
          ? data.proteinMaxPct.value
          : this.proteinMaxPct,
      proteinGPerKgMin: data.proteinGPerKgMin.present
          ? data.proteinGPerKgMin.value
          : this.proteinGPerKgMin,
      proteinGPerKgMax: data.proteinGPerKgMax.present
          ? data.proteinGPerKgMax.value
          : this.proteinGPerKgMax,
      fatGPerKgMin: data.fatGPerKgMin.present
          ? data.fatGPerKgMin.value
          : this.fatGPerKgMin,
      fatGPerKgMax: data.fatGPerKgMax.present
          ? data.fatGPerKgMax.value
          : this.fatGPerKgMax,
      kcalPerGramProtein: data.kcalPerGramProtein.present
          ? data.kcalPerGramProtein.value
          : this.kcalPerGramProtein,
      kcalPerGramCarb: data.kcalPerGramCarb.present
          ? data.kcalPerGramCarb.value
          : this.kcalPerGramCarb,
      kcalPerGramFat: data.kcalPerGramFat.present
          ? data.kcalPerGramFat.value
          : this.kcalPerGramFat,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MacroNormTemplate(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('normType: $normType, ')
          ..write('sex: $sex, ')
          ..write('carbMinPct: $carbMinPct, ')
          ..write('carbMaxPct: $carbMaxPct, ')
          ..write('fatMinPct: $fatMinPct, ')
          ..write('fatMaxPct: $fatMaxPct, ')
          ..write('proteinMinPct: $proteinMinPct, ')
          ..write('proteinMaxPct: $proteinMaxPct, ')
          ..write('proteinGPerKgMin: $proteinGPerKgMin, ')
          ..write('proteinGPerKgMax: $proteinGPerKgMax, ')
          ..write('fatGPerKgMin: $fatGPerKgMin, ')
          ..write('fatGPerKgMax: $fatGPerKgMax, ')
          ..write('kcalPerGramProtein: $kcalPerGramProtein, ')
          ..write('kcalPerGramCarb: $kcalPerGramCarb, ')
          ..write('kcalPerGramFat: $kcalPerGramFat, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    code,
    normType,
    sex,
    carbMinPct,
    carbMaxPct,
    fatMinPct,
    fatMaxPct,
    proteinMinPct,
    proteinMaxPct,
    proteinGPerKgMin,
    proteinGPerKgMax,
    fatGPerKgMin,
    fatGPerKgMax,
    kcalPerGramProtein,
    kcalPerGramCarb,
    kcalPerGramFat,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MacroNormTemplate &&
          other.id == this.id &&
          other.code == this.code &&
          other.normType == this.normType &&
          other.sex == this.sex &&
          other.carbMinPct == this.carbMinPct &&
          other.carbMaxPct == this.carbMaxPct &&
          other.fatMinPct == this.fatMinPct &&
          other.fatMaxPct == this.fatMaxPct &&
          other.proteinMinPct == this.proteinMinPct &&
          other.proteinMaxPct == this.proteinMaxPct &&
          other.proteinGPerKgMin == this.proteinGPerKgMin &&
          other.proteinGPerKgMax == this.proteinGPerKgMax &&
          other.fatGPerKgMin == this.fatGPerKgMin &&
          other.fatGPerKgMax == this.fatGPerKgMax &&
          other.kcalPerGramProtein == this.kcalPerGramProtein &&
          other.kcalPerGramCarb == this.kcalPerGramCarb &&
          other.kcalPerGramFat == this.kcalPerGramFat &&
          other.notes == this.notes);
}

class MacroNormTemplatesCompanion extends UpdateCompanion<MacroNormTemplate> {
  final Value<int> id;
  final Value<String> code;
  final Value<String> normType;
  final Value<String?> sex;
  final Value<double?> carbMinPct;
  final Value<double?> carbMaxPct;
  final Value<double?> fatMinPct;
  final Value<double?> fatMaxPct;
  final Value<double?> proteinMinPct;
  final Value<double?> proteinMaxPct;
  final Value<double?> proteinGPerKgMin;
  final Value<double?> proteinGPerKgMax;
  final Value<double?> fatGPerKgMin;
  final Value<double?> fatGPerKgMax;
  final Value<double?> kcalPerGramProtein;
  final Value<double?> kcalPerGramCarb;
  final Value<double?> kcalPerGramFat;
  final Value<String?> notes;
  const MacroNormTemplatesCompanion({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.normType = const Value.absent(),
    this.sex = const Value.absent(),
    this.carbMinPct = const Value.absent(),
    this.carbMaxPct = const Value.absent(),
    this.fatMinPct = const Value.absent(),
    this.fatMaxPct = const Value.absent(),
    this.proteinMinPct = const Value.absent(),
    this.proteinMaxPct = const Value.absent(),
    this.proteinGPerKgMin = const Value.absent(),
    this.proteinGPerKgMax = const Value.absent(),
    this.fatGPerKgMin = const Value.absent(),
    this.fatGPerKgMax = const Value.absent(),
    this.kcalPerGramProtein = const Value.absent(),
    this.kcalPerGramCarb = const Value.absent(),
    this.kcalPerGramFat = const Value.absent(),
    this.notes = const Value.absent(),
  });
  MacroNormTemplatesCompanion.insert({
    this.id = const Value.absent(),
    required String code,
    required String normType,
    this.sex = const Value.absent(),
    this.carbMinPct = const Value.absent(),
    this.carbMaxPct = const Value.absent(),
    this.fatMinPct = const Value.absent(),
    this.fatMaxPct = const Value.absent(),
    this.proteinMinPct = const Value.absent(),
    this.proteinMaxPct = const Value.absent(),
    this.proteinGPerKgMin = const Value.absent(),
    this.proteinGPerKgMax = const Value.absent(),
    this.fatGPerKgMin = const Value.absent(),
    this.fatGPerKgMax = const Value.absent(),
    this.kcalPerGramProtein = const Value.absent(),
    this.kcalPerGramCarb = const Value.absent(),
    this.kcalPerGramFat = const Value.absent(),
    this.notes = const Value.absent(),
  }) : code = Value(code),
       normType = Value(normType);
  static Insertable<MacroNormTemplate> custom({
    Expression<int>? id,
    Expression<String>? code,
    Expression<String>? normType,
    Expression<String>? sex,
    Expression<double>? carbMinPct,
    Expression<double>? carbMaxPct,
    Expression<double>? fatMinPct,
    Expression<double>? fatMaxPct,
    Expression<double>? proteinMinPct,
    Expression<double>? proteinMaxPct,
    Expression<double>? proteinGPerKgMin,
    Expression<double>? proteinGPerKgMax,
    Expression<double>? fatGPerKgMin,
    Expression<double>? fatGPerKgMax,
    Expression<double>? kcalPerGramProtein,
    Expression<double>? kcalPerGramCarb,
    Expression<double>? kcalPerGramFat,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (normType != null) 'norm_type': normType,
      if (sex != null) 'sex': sex,
      if (carbMinPct != null) 'carb_min_pct': carbMinPct,
      if (carbMaxPct != null) 'carb_max_pct': carbMaxPct,
      if (fatMinPct != null) 'fat_min_pct': fatMinPct,
      if (fatMaxPct != null) 'fat_max_pct': fatMaxPct,
      if (proteinMinPct != null) 'protein_min_pct': proteinMinPct,
      if (proteinMaxPct != null) 'protein_max_pct': proteinMaxPct,
      if (proteinGPerKgMin != null) 'protein_g_per_kg_min': proteinGPerKgMin,
      if (proteinGPerKgMax != null) 'protein_g_per_kg_max': proteinGPerKgMax,
      if (fatGPerKgMin != null) 'fat_g_per_kg_min': fatGPerKgMin,
      if (fatGPerKgMax != null) 'fat_g_per_kg_max': fatGPerKgMax,
      if (kcalPerGramProtein != null)
        'kcal_per_gram_protein': kcalPerGramProtein,
      if (kcalPerGramCarb != null) 'kcal_per_gram_carb': kcalPerGramCarb,
      if (kcalPerGramFat != null) 'kcal_per_gram_fat': kcalPerGramFat,
      if (notes != null) 'notes': notes,
    });
  }

  MacroNormTemplatesCompanion copyWith({
    Value<int>? id,
    Value<String>? code,
    Value<String>? normType,
    Value<String?>? sex,
    Value<double?>? carbMinPct,
    Value<double?>? carbMaxPct,
    Value<double?>? fatMinPct,
    Value<double?>? fatMaxPct,
    Value<double?>? proteinMinPct,
    Value<double?>? proteinMaxPct,
    Value<double?>? proteinGPerKgMin,
    Value<double?>? proteinGPerKgMax,
    Value<double?>? fatGPerKgMin,
    Value<double?>? fatGPerKgMax,
    Value<double?>? kcalPerGramProtein,
    Value<double?>? kcalPerGramCarb,
    Value<double?>? kcalPerGramFat,
    Value<String?>? notes,
  }) {
    return MacroNormTemplatesCompanion(
      id: id ?? this.id,
      code: code ?? this.code,
      normType: normType ?? this.normType,
      sex: sex ?? this.sex,
      carbMinPct: carbMinPct ?? this.carbMinPct,
      carbMaxPct: carbMaxPct ?? this.carbMaxPct,
      fatMinPct: fatMinPct ?? this.fatMinPct,
      fatMaxPct: fatMaxPct ?? this.fatMaxPct,
      proteinMinPct: proteinMinPct ?? this.proteinMinPct,
      proteinMaxPct: proteinMaxPct ?? this.proteinMaxPct,
      proteinGPerKgMin: proteinGPerKgMin ?? this.proteinGPerKgMin,
      proteinGPerKgMax: proteinGPerKgMax ?? this.proteinGPerKgMax,
      fatGPerKgMin: fatGPerKgMin ?? this.fatGPerKgMin,
      fatGPerKgMax: fatGPerKgMax ?? this.fatGPerKgMax,
      kcalPerGramProtein: kcalPerGramProtein ?? this.kcalPerGramProtein,
      kcalPerGramCarb: kcalPerGramCarb ?? this.kcalPerGramCarb,
      kcalPerGramFat: kcalPerGramFat ?? this.kcalPerGramFat,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (normType.present) {
      map['norm_type'] = Variable<String>(normType.value);
    }
    if (sex.present) {
      map['sex'] = Variable<String>(sex.value);
    }
    if (carbMinPct.present) {
      map['carb_min_pct'] = Variable<double>(carbMinPct.value);
    }
    if (carbMaxPct.present) {
      map['carb_max_pct'] = Variable<double>(carbMaxPct.value);
    }
    if (fatMinPct.present) {
      map['fat_min_pct'] = Variable<double>(fatMinPct.value);
    }
    if (fatMaxPct.present) {
      map['fat_max_pct'] = Variable<double>(fatMaxPct.value);
    }
    if (proteinMinPct.present) {
      map['protein_min_pct'] = Variable<double>(proteinMinPct.value);
    }
    if (proteinMaxPct.present) {
      map['protein_max_pct'] = Variable<double>(proteinMaxPct.value);
    }
    if (proteinGPerKgMin.present) {
      map['protein_g_per_kg_min'] = Variable<double>(proteinGPerKgMin.value);
    }
    if (proteinGPerKgMax.present) {
      map['protein_g_per_kg_max'] = Variable<double>(proteinGPerKgMax.value);
    }
    if (fatGPerKgMin.present) {
      map['fat_g_per_kg_min'] = Variable<double>(fatGPerKgMin.value);
    }
    if (fatGPerKgMax.present) {
      map['fat_g_per_kg_max'] = Variable<double>(fatGPerKgMax.value);
    }
    if (kcalPerGramProtein.present) {
      map['kcal_per_gram_protein'] = Variable<double>(kcalPerGramProtein.value);
    }
    if (kcalPerGramCarb.present) {
      map['kcal_per_gram_carb'] = Variable<double>(kcalPerGramCarb.value);
    }
    if (kcalPerGramFat.present) {
      map['kcal_per_gram_fat'] = Variable<double>(kcalPerGramFat.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MacroNormTemplatesCompanion(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('normType: $normType, ')
          ..write('sex: $sex, ')
          ..write('carbMinPct: $carbMinPct, ')
          ..write('carbMaxPct: $carbMaxPct, ')
          ..write('fatMinPct: $fatMinPct, ')
          ..write('fatMaxPct: $fatMaxPct, ')
          ..write('proteinMinPct: $proteinMinPct, ')
          ..write('proteinMaxPct: $proteinMaxPct, ')
          ..write('proteinGPerKgMin: $proteinGPerKgMin, ')
          ..write('proteinGPerKgMax: $proteinGPerKgMax, ')
          ..write('fatGPerKgMin: $fatGPerKgMin, ')
          ..write('fatGPerKgMax: $fatGPerKgMax, ')
          ..write('kcalPerGramProtein: $kcalPerGramProtein, ')
          ..write('kcalPerGramCarb: $kcalPerGramCarb, ')
          ..write('kcalPerGramFat: $kcalPerGramFat, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

class $CalorieDeficitPoliciesTable extends CalorieDeficitPolicies
    with TableInfo<$CalorieDeficitPoliciesTable, CalorieDeficitPolicy> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CalorieDeficitPoliciesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _deficitPercentMinMeta = const VerificationMeta(
    'deficitPercentMin',
  );
  @override
  late final GeneratedColumn<double> deficitPercentMin =
      GeneratedColumn<double>(
        'deficit_percent_min',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _deficitPercentMaxMeta = const VerificationMeta(
    'deficitPercentMax',
  );
  @override
  late final GeneratedColumn<double> deficitPercentMax =
      GeneratedColumn<double>(
        'deficit_percent_max',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _rollingAverageDaysMinMeta =
      const VerificationMeta('rollingAverageDaysMin');
  @override
  late final GeneratedColumn<int> rollingAverageDaysMin = GeneratedColumn<int>(
    'rolling_average_days_min',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _rollingAverageDaysRecommendedMeta =
      const VerificationMeta('rollingAverageDaysRecommended');
  @override
  late final GeneratedColumn<int> rollingAverageDaysRecommended =
      GeneratedColumn<int>(
        'rolling_average_days_recommended',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _weeklyWeightLossOkKgMeta =
      const VerificationMeta('weeklyWeightLossOkKg');
  @override
  late final GeneratedColumn<double> weeklyWeightLossOkKg =
      GeneratedColumn<double>(
        'weekly_weight_loss_ok_kg',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _weeklyWeightLossTooFastKgMeta =
      const VerificationMeta('weeklyWeightLossTooFastKg');
  @override
  late final GeneratedColumn<double> weeklyWeightLossTooFastKg =
      GeneratedColumn<double>(
        'weekly_weight_loss_too_fast_kg',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _adjustmentAddCaloriesWhenTooFastMeta =
      const VerificationMeta('adjustmentAddCaloriesWhenTooFast');
  @override
  late final GeneratedColumn<int> adjustmentAddCaloriesWhenTooFast =
      GeneratedColumn<int>(
        'adjustment_add_calories_when_too_fast',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _adjustmentExtraDeficitPercentWhenSlowMeta =
      const VerificationMeta('adjustmentExtraDeficitPercentWhenSlow');
  @override
  late final GeneratedColumn<double> adjustmentExtraDeficitPercentWhenSlow =
      GeneratedColumn<double>(
        'adjustment_extra_deficit_percent_when_slow',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _rationaleTextMeta = const VerificationMeta(
    'rationaleText',
  );
  @override
  late final GeneratedColumn<String> rationaleText = GeneratedColumn<String>(
    'rationale_text',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    code,
    deficitPercentMin,
    deficitPercentMax,
    rollingAverageDaysMin,
    rollingAverageDaysRecommended,
    weeklyWeightLossOkKg,
    weeklyWeightLossTooFastKg,
    adjustmentAddCaloriesWhenTooFast,
    adjustmentExtraDeficitPercentWhenSlow,
    rationaleText,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'calorie_deficit_policies';
  @override
  VerificationContext validateIntegrity(
    Insertable<CalorieDeficitPolicy> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('deficit_percent_min')) {
      context.handle(
        _deficitPercentMinMeta,
        deficitPercentMin.isAcceptableOrUnknown(
          data['deficit_percent_min']!,
          _deficitPercentMinMeta,
        ),
      );
    }
    if (data.containsKey('deficit_percent_max')) {
      context.handle(
        _deficitPercentMaxMeta,
        deficitPercentMax.isAcceptableOrUnknown(
          data['deficit_percent_max']!,
          _deficitPercentMaxMeta,
        ),
      );
    }
    if (data.containsKey('rolling_average_days_min')) {
      context.handle(
        _rollingAverageDaysMinMeta,
        rollingAverageDaysMin.isAcceptableOrUnknown(
          data['rolling_average_days_min']!,
          _rollingAverageDaysMinMeta,
        ),
      );
    }
    if (data.containsKey('rolling_average_days_recommended')) {
      context.handle(
        _rollingAverageDaysRecommendedMeta,
        rollingAverageDaysRecommended.isAcceptableOrUnknown(
          data['rolling_average_days_recommended']!,
          _rollingAverageDaysRecommendedMeta,
        ),
      );
    }
    if (data.containsKey('weekly_weight_loss_ok_kg')) {
      context.handle(
        _weeklyWeightLossOkKgMeta,
        weeklyWeightLossOkKg.isAcceptableOrUnknown(
          data['weekly_weight_loss_ok_kg']!,
          _weeklyWeightLossOkKgMeta,
        ),
      );
    }
    if (data.containsKey('weekly_weight_loss_too_fast_kg')) {
      context.handle(
        _weeklyWeightLossTooFastKgMeta,
        weeklyWeightLossTooFastKg.isAcceptableOrUnknown(
          data['weekly_weight_loss_too_fast_kg']!,
          _weeklyWeightLossTooFastKgMeta,
        ),
      );
    }
    if (data.containsKey('adjustment_add_calories_when_too_fast')) {
      context.handle(
        _adjustmentAddCaloriesWhenTooFastMeta,
        adjustmentAddCaloriesWhenTooFast.isAcceptableOrUnknown(
          data['adjustment_add_calories_when_too_fast']!,
          _adjustmentAddCaloriesWhenTooFastMeta,
        ),
      );
    }
    if (data.containsKey('adjustment_extra_deficit_percent_when_slow')) {
      context.handle(
        _adjustmentExtraDeficitPercentWhenSlowMeta,
        adjustmentExtraDeficitPercentWhenSlow.isAcceptableOrUnknown(
          data['adjustment_extra_deficit_percent_when_slow']!,
          _adjustmentExtraDeficitPercentWhenSlowMeta,
        ),
      );
    }
    if (data.containsKey('rationale_text')) {
      context.handle(
        _rationaleTextMeta,
        rationaleText.isAcceptableOrUnknown(
          data['rationale_text']!,
          _rationaleTextMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CalorieDeficitPolicy map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CalorieDeficitPolicy(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      deficitPercentMin: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}deficit_percent_min'],
      ),
      deficitPercentMax: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}deficit_percent_max'],
      ),
      rollingAverageDaysMin: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rolling_average_days_min'],
      ),
      rollingAverageDaysRecommended: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rolling_average_days_recommended'],
      ),
      weeklyWeightLossOkKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weekly_weight_loss_ok_kg'],
      ),
      weeklyWeightLossTooFastKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weekly_weight_loss_too_fast_kg'],
      ),
      adjustmentAddCaloriesWhenTooFast: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}adjustment_add_calories_when_too_fast'],
      ),
      adjustmentExtraDeficitPercentWhenSlow: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}adjustment_extra_deficit_percent_when_slow'],
      ),
      rationaleText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rationale_text'],
      ),
    );
  }

  @override
  $CalorieDeficitPoliciesTable createAlias(String alias) {
    return $CalorieDeficitPoliciesTable(attachedDatabase, alias);
  }
}

class CalorieDeficitPolicy extends DataClass
    implements Insertable<CalorieDeficitPolicy> {
  final int id;
  final String code;
  final double? deficitPercentMin;
  final double? deficitPercentMax;
  final int? rollingAverageDaysMin;
  final int? rollingAverageDaysRecommended;
  final double? weeklyWeightLossOkKg;
  final double? weeklyWeightLossTooFastKg;
  final int? adjustmentAddCaloriesWhenTooFast;
  final double? adjustmentExtraDeficitPercentWhenSlow;
  final String? rationaleText;
  const CalorieDeficitPolicy({
    required this.id,
    required this.code,
    this.deficitPercentMin,
    this.deficitPercentMax,
    this.rollingAverageDaysMin,
    this.rollingAverageDaysRecommended,
    this.weeklyWeightLossOkKg,
    this.weeklyWeightLossTooFastKg,
    this.adjustmentAddCaloriesWhenTooFast,
    this.adjustmentExtraDeficitPercentWhenSlow,
    this.rationaleText,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['code'] = Variable<String>(code);
    if (!nullToAbsent || deficitPercentMin != null) {
      map['deficit_percent_min'] = Variable<double>(deficitPercentMin);
    }
    if (!nullToAbsent || deficitPercentMax != null) {
      map['deficit_percent_max'] = Variable<double>(deficitPercentMax);
    }
    if (!nullToAbsent || rollingAverageDaysMin != null) {
      map['rolling_average_days_min'] = Variable<int>(rollingAverageDaysMin);
    }
    if (!nullToAbsent || rollingAverageDaysRecommended != null) {
      map['rolling_average_days_recommended'] = Variable<int>(
        rollingAverageDaysRecommended,
      );
    }
    if (!nullToAbsent || weeklyWeightLossOkKg != null) {
      map['weekly_weight_loss_ok_kg'] = Variable<double>(weeklyWeightLossOkKg);
    }
    if (!nullToAbsent || weeklyWeightLossTooFastKg != null) {
      map['weekly_weight_loss_too_fast_kg'] = Variable<double>(
        weeklyWeightLossTooFastKg,
      );
    }
    if (!nullToAbsent || adjustmentAddCaloriesWhenTooFast != null) {
      map['adjustment_add_calories_when_too_fast'] = Variable<int>(
        adjustmentAddCaloriesWhenTooFast,
      );
    }
    if (!nullToAbsent || adjustmentExtraDeficitPercentWhenSlow != null) {
      map['adjustment_extra_deficit_percent_when_slow'] = Variable<double>(
        adjustmentExtraDeficitPercentWhenSlow,
      );
    }
    if (!nullToAbsent || rationaleText != null) {
      map['rationale_text'] = Variable<String>(rationaleText);
    }
    return map;
  }

  CalorieDeficitPoliciesCompanion toCompanion(bool nullToAbsent) {
    return CalorieDeficitPoliciesCompanion(
      id: Value(id),
      code: Value(code),
      deficitPercentMin: deficitPercentMin == null && nullToAbsent
          ? const Value.absent()
          : Value(deficitPercentMin),
      deficitPercentMax: deficitPercentMax == null && nullToAbsent
          ? const Value.absent()
          : Value(deficitPercentMax),
      rollingAverageDaysMin: rollingAverageDaysMin == null && nullToAbsent
          ? const Value.absent()
          : Value(rollingAverageDaysMin),
      rollingAverageDaysRecommended:
          rollingAverageDaysRecommended == null && nullToAbsent
          ? const Value.absent()
          : Value(rollingAverageDaysRecommended),
      weeklyWeightLossOkKg: weeklyWeightLossOkKg == null && nullToAbsent
          ? const Value.absent()
          : Value(weeklyWeightLossOkKg),
      weeklyWeightLossTooFastKg:
          weeklyWeightLossTooFastKg == null && nullToAbsent
          ? const Value.absent()
          : Value(weeklyWeightLossTooFastKg),
      adjustmentAddCaloriesWhenTooFast:
          adjustmentAddCaloriesWhenTooFast == null && nullToAbsent
          ? const Value.absent()
          : Value(adjustmentAddCaloriesWhenTooFast),
      adjustmentExtraDeficitPercentWhenSlow:
          adjustmentExtraDeficitPercentWhenSlow == null && nullToAbsent
          ? const Value.absent()
          : Value(adjustmentExtraDeficitPercentWhenSlow),
      rationaleText: rationaleText == null && nullToAbsent
          ? const Value.absent()
          : Value(rationaleText),
    );
  }

  factory CalorieDeficitPolicy.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CalorieDeficitPolicy(
      id: serializer.fromJson<int>(json['id']),
      code: serializer.fromJson<String>(json['code']),
      deficitPercentMin: serializer.fromJson<double?>(
        json['deficitPercentMin'],
      ),
      deficitPercentMax: serializer.fromJson<double?>(
        json['deficitPercentMax'],
      ),
      rollingAverageDaysMin: serializer.fromJson<int?>(
        json['rollingAverageDaysMin'],
      ),
      rollingAverageDaysRecommended: serializer.fromJson<int?>(
        json['rollingAverageDaysRecommended'],
      ),
      weeklyWeightLossOkKg: serializer.fromJson<double?>(
        json['weeklyWeightLossOkKg'],
      ),
      weeklyWeightLossTooFastKg: serializer.fromJson<double?>(
        json['weeklyWeightLossTooFastKg'],
      ),
      adjustmentAddCaloriesWhenTooFast: serializer.fromJson<int?>(
        json['adjustmentAddCaloriesWhenTooFast'],
      ),
      adjustmentExtraDeficitPercentWhenSlow: serializer.fromJson<double?>(
        json['adjustmentExtraDeficitPercentWhenSlow'],
      ),
      rationaleText: serializer.fromJson<String?>(json['rationaleText']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'code': serializer.toJson<String>(code),
      'deficitPercentMin': serializer.toJson<double?>(deficitPercentMin),
      'deficitPercentMax': serializer.toJson<double?>(deficitPercentMax),
      'rollingAverageDaysMin': serializer.toJson<int?>(rollingAverageDaysMin),
      'rollingAverageDaysRecommended': serializer.toJson<int?>(
        rollingAverageDaysRecommended,
      ),
      'weeklyWeightLossOkKg': serializer.toJson<double?>(weeklyWeightLossOkKg),
      'weeklyWeightLossTooFastKg': serializer.toJson<double?>(
        weeklyWeightLossTooFastKg,
      ),
      'adjustmentAddCaloriesWhenTooFast': serializer.toJson<int?>(
        adjustmentAddCaloriesWhenTooFast,
      ),
      'adjustmentExtraDeficitPercentWhenSlow': serializer.toJson<double?>(
        adjustmentExtraDeficitPercentWhenSlow,
      ),
      'rationaleText': serializer.toJson<String?>(rationaleText),
    };
  }

  CalorieDeficitPolicy copyWith({
    int? id,
    String? code,
    Value<double?> deficitPercentMin = const Value.absent(),
    Value<double?> deficitPercentMax = const Value.absent(),
    Value<int?> rollingAverageDaysMin = const Value.absent(),
    Value<int?> rollingAverageDaysRecommended = const Value.absent(),
    Value<double?> weeklyWeightLossOkKg = const Value.absent(),
    Value<double?> weeklyWeightLossTooFastKg = const Value.absent(),
    Value<int?> adjustmentAddCaloriesWhenTooFast = const Value.absent(),
    Value<double?> adjustmentExtraDeficitPercentWhenSlow = const Value.absent(),
    Value<String?> rationaleText = const Value.absent(),
  }) => CalorieDeficitPolicy(
    id: id ?? this.id,
    code: code ?? this.code,
    deficitPercentMin: deficitPercentMin.present
        ? deficitPercentMin.value
        : this.deficitPercentMin,
    deficitPercentMax: deficitPercentMax.present
        ? deficitPercentMax.value
        : this.deficitPercentMax,
    rollingAverageDaysMin: rollingAverageDaysMin.present
        ? rollingAverageDaysMin.value
        : this.rollingAverageDaysMin,
    rollingAverageDaysRecommended: rollingAverageDaysRecommended.present
        ? rollingAverageDaysRecommended.value
        : this.rollingAverageDaysRecommended,
    weeklyWeightLossOkKg: weeklyWeightLossOkKg.present
        ? weeklyWeightLossOkKg.value
        : this.weeklyWeightLossOkKg,
    weeklyWeightLossTooFastKg: weeklyWeightLossTooFastKg.present
        ? weeklyWeightLossTooFastKg.value
        : this.weeklyWeightLossTooFastKg,
    adjustmentAddCaloriesWhenTooFast: adjustmentAddCaloriesWhenTooFast.present
        ? adjustmentAddCaloriesWhenTooFast.value
        : this.adjustmentAddCaloriesWhenTooFast,
    adjustmentExtraDeficitPercentWhenSlow:
        adjustmentExtraDeficitPercentWhenSlow.present
        ? adjustmentExtraDeficitPercentWhenSlow.value
        : this.adjustmentExtraDeficitPercentWhenSlow,
    rationaleText: rationaleText.present
        ? rationaleText.value
        : this.rationaleText,
  );
  CalorieDeficitPolicy copyWithCompanion(CalorieDeficitPoliciesCompanion data) {
    return CalorieDeficitPolicy(
      id: data.id.present ? data.id.value : this.id,
      code: data.code.present ? data.code.value : this.code,
      deficitPercentMin: data.deficitPercentMin.present
          ? data.deficitPercentMin.value
          : this.deficitPercentMin,
      deficitPercentMax: data.deficitPercentMax.present
          ? data.deficitPercentMax.value
          : this.deficitPercentMax,
      rollingAverageDaysMin: data.rollingAverageDaysMin.present
          ? data.rollingAverageDaysMin.value
          : this.rollingAverageDaysMin,
      rollingAverageDaysRecommended: data.rollingAverageDaysRecommended.present
          ? data.rollingAverageDaysRecommended.value
          : this.rollingAverageDaysRecommended,
      weeklyWeightLossOkKg: data.weeklyWeightLossOkKg.present
          ? data.weeklyWeightLossOkKg.value
          : this.weeklyWeightLossOkKg,
      weeklyWeightLossTooFastKg: data.weeklyWeightLossTooFastKg.present
          ? data.weeklyWeightLossTooFastKg.value
          : this.weeklyWeightLossTooFastKg,
      adjustmentAddCaloriesWhenTooFast:
          data.adjustmentAddCaloriesWhenTooFast.present
          ? data.adjustmentAddCaloriesWhenTooFast.value
          : this.adjustmentAddCaloriesWhenTooFast,
      adjustmentExtraDeficitPercentWhenSlow:
          data.adjustmentExtraDeficitPercentWhenSlow.present
          ? data.adjustmentExtraDeficitPercentWhenSlow.value
          : this.adjustmentExtraDeficitPercentWhenSlow,
      rationaleText: data.rationaleText.present
          ? data.rationaleText.value
          : this.rationaleText,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CalorieDeficitPolicy(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('deficitPercentMin: $deficitPercentMin, ')
          ..write('deficitPercentMax: $deficitPercentMax, ')
          ..write('rollingAverageDaysMin: $rollingAverageDaysMin, ')
          ..write(
            'rollingAverageDaysRecommended: $rollingAverageDaysRecommended, ',
          )
          ..write('weeklyWeightLossOkKg: $weeklyWeightLossOkKg, ')
          ..write('weeklyWeightLossTooFastKg: $weeklyWeightLossTooFastKg, ')
          ..write(
            'adjustmentAddCaloriesWhenTooFast: $adjustmentAddCaloriesWhenTooFast, ',
          )
          ..write(
            'adjustmentExtraDeficitPercentWhenSlow: $adjustmentExtraDeficitPercentWhenSlow, ',
          )
          ..write('rationaleText: $rationaleText')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    code,
    deficitPercentMin,
    deficitPercentMax,
    rollingAverageDaysMin,
    rollingAverageDaysRecommended,
    weeklyWeightLossOkKg,
    weeklyWeightLossTooFastKg,
    adjustmentAddCaloriesWhenTooFast,
    adjustmentExtraDeficitPercentWhenSlow,
    rationaleText,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CalorieDeficitPolicy &&
          other.id == this.id &&
          other.code == this.code &&
          other.deficitPercentMin == this.deficitPercentMin &&
          other.deficitPercentMax == this.deficitPercentMax &&
          other.rollingAverageDaysMin == this.rollingAverageDaysMin &&
          other.rollingAverageDaysRecommended ==
              this.rollingAverageDaysRecommended &&
          other.weeklyWeightLossOkKg == this.weeklyWeightLossOkKg &&
          other.weeklyWeightLossTooFastKg == this.weeklyWeightLossTooFastKg &&
          other.adjustmentAddCaloriesWhenTooFast ==
              this.adjustmentAddCaloriesWhenTooFast &&
          other.adjustmentExtraDeficitPercentWhenSlow ==
              this.adjustmentExtraDeficitPercentWhenSlow &&
          other.rationaleText == this.rationaleText);
}

class CalorieDeficitPoliciesCompanion
    extends UpdateCompanion<CalorieDeficitPolicy> {
  final Value<int> id;
  final Value<String> code;
  final Value<double?> deficitPercentMin;
  final Value<double?> deficitPercentMax;
  final Value<int?> rollingAverageDaysMin;
  final Value<int?> rollingAverageDaysRecommended;
  final Value<double?> weeklyWeightLossOkKg;
  final Value<double?> weeklyWeightLossTooFastKg;
  final Value<int?> adjustmentAddCaloriesWhenTooFast;
  final Value<double?> adjustmentExtraDeficitPercentWhenSlow;
  final Value<String?> rationaleText;
  const CalorieDeficitPoliciesCompanion({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.deficitPercentMin = const Value.absent(),
    this.deficitPercentMax = const Value.absent(),
    this.rollingAverageDaysMin = const Value.absent(),
    this.rollingAverageDaysRecommended = const Value.absent(),
    this.weeklyWeightLossOkKg = const Value.absent(),
    this.weeklyWeightLossTooFastKg = const Value.absent(),
    this.adjustmentAddCaloriesWhenTooFast = const Value.absent(),
    this.adjustmentExtraDeficitPercentWhenSlow = const Value.absent(),
    this.rationaleText = const Value.absent(),
  });
  CalorieDeficitPoliciesCompanion.insert({
    this.id = const Value.absent(),
    required String code,
    this.deficitPercentMin = const Value.absent(),
    this.deficitPercentMax = const Value.absent(),
    this.rollingAverageDaysMin = const Value.absent(),
    this.rollingAverageDaysRecommended = const Value.absent(),
    this.weeklyWeightLossOkKg = const Value.absent(),
    this.weeklyWeightLossTooFastKg = const Value.absent(),
    this.adjustmentAddCaloriesWhenTooFast = const Value.absent(),
    this.adjustmentExtraDeficitPercentWhenSlow = const Value.absent(),
    this.rationaleText = const Value.absent(),
  }) : code = Value(code);
  static Insertable<CalorieDeficitPolicy> custom({
    Expression<int>? id,
    Expression<String>? code,
    Expression<double>? deficitPercentMin,
    Expression<double>? deficitPercentMax,
    Expression<int>? rollingAverageDaysMin,
    Expression<int>? rollingAverageDaysRecommended,
    Expression<double>? weeklyWeightLossOkKg,
    Expression<double>? weeklyWeightLossTooFastKg,
    Expression<int>? adjustmentAddCaloriesWhenTooFast,
    Expression<double>? adjustmentExtraDeficitPercentWhenSlow,
    Expression<String>? rationaleText,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (deficitPercentMin != null) 'deficit_percent_min': deficitPercentMin,
      if (deficitPercentMax != null) 'deficit_percent_max': deficitPercentMax,
      if (rollingAverageDaysMin != null)
        'rolling_average_days_min': rollingAverageDaysMin,
      if (rollingAverageDaysRecommended != null)
        'rolling_average_days_recommended': rollingAverageDaysRecommended,
      if (weeklyWeightLossOkKg != null)
        'weekly_weight_loss_ok_kg': weeklyWeightLossOkKg,
      if (weeklyWeightLossTooFastKg != null)
        'weekly_weight_loss_too_fast_kg': weeklyWeightLossTooFastKg,
      if (adjustmentAddCaloriesWhenTooFast != null)
        'adjustment_add_calories_when_too_fast':
            adjustmentAddCaloriesWhenTooFast,
      if (adjustmentExtraDeficitPercentWhenSlow != null)
        'adjustment_extra_deficit_percent_when_slow':
            adjustmentExtraDeficitPercentWhenSlow,
      if (rationaleText != null) 'rationale_text': rationaleText,
    });
  }

  CalorieDeficitPoliciesCompanion copyWith({
    Value<int>? id,
    Value<String>? code,
    Value<double?>? deficitPercentMin,
    Value<double?>? deficitPercentMax,
    Value<int?>? rollingAverageDaysMin,
    Value<int?>? rollingAverageDaysRecommended,
    Value<double?>? weeklyWeightLossOkKg,
    Value<double?>? weeklyWeightLossTooFastKg,
    Value<int?>? adjustmentAddCaloriesWhenTooFast,
    Value<double?>? adjustmentExtraDeficitPercentWhenSlow,
    Value<String?>? rationaleText,
  }) {
    return CalorieDeficitPoliciesCompanion(
      id: id ?? this.id,
      code: code ?? this.code,
      deficitPercentMin: deficitPercentMin ?? this.deficitPercentMin,
      deficitPercentMax: deficitPercentMax ?? this.deficitPercentMax,
      rollingAverageDaysMin:
          rollingAverageDaysMin ?? this.rollingAverageDaysMin,
      rollingAverageDaysRecommended:
          rollingAverageDaysRecommended ?? this.rollingAverageDaysRecommended,
      weeklyWeightLossOkKg: weeklyWeightLossOkKg ?? this.weeklyWeightLossOkKg,
      weeklyWeightLossTooFastKg:
          weeklyWeightLossTooFastKg ?? this.weeklyWeightLossTooFastKg,
      adjustmentAddCaloriesWhenTooFast:
          adjustmentAddCaloriesWhenTooFast ??
          this.adjustmentAddCaloriesWhenTooFast,
      adjustmentExtraDeficitPercentWhenSlow:
          adjustmentExtraDeficitPercentWhenSlow ??
          this.adjustmentExtraDeficitPercentWhenSlow,
      rationaleText: rationaleText ?? this.rationaleText,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (deficitPercentMin.present) {
      map['deficit_percent_min'] = Variable<double>(deficitPercentMin.value);
    }
    if (deficitPercentMax.present) {
      map['deficit_percent_max'] = Variable<double>(deficitPercentMax.value);
    }
    if (rollingAverageDaysMin.present) {
      map['rolling_average_days_min'] = Variable<int>(
        rollingAverageDaysMin.value,
      );
    }
    if (rollingAverageDaysRecommended.present) {
      map['rolling_average_days_recommended'] = Variable<int>(
        rollingAverageDaysRecommended.value,
      );
    }
    if (weeklyWeightLossOkKg.present) {
      map['weekly_weight_loss_ok_kg'] = Variable<double>(
        weeklyWeightLossOkKg.value,
      );
    }
    if (weeklyWeightLossTooFastKg.present) {
      map['weekly_weight_loss_too_fast_kg'] = Variable<double>(
        weeklyWeightLossTooFastKg.value,
      );
    }
    if (adjustmentAddCaloriesWhenTooFast.present) {
      map['adjustment_add_calories_when_too_fast'] = Variable<int>(
        adjustmentAddCaloriesWhenTooFast.value,
      );
    }
    if (adjustmentExtraDeficitPercentWhenSlow.present) {
      map['adjustment_extra_deficit_percent_when_slow'] = Variable<double>(
        adjustmentExtraDeficitPercentWhenSlow.value,
      );
    }
    if (rationaleText.present) {
      map['rationale_text'] = Variable<String>(rationaleText.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CalorieDeficitPoliciesCompanion(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('deficitPercentMin: $deficitPercentMin, ')
          ..write('deficitPercentMax: $deficitPercentMax, ')
          ..write('rollingAverageDaysMin: $rollingAverageDaysMin, ')
          ..write(
            'rollingAverageDaysRecommended: $rollingAverageDaysRecommended, ',
          )
          ..write('weeklyWeightLossOkKg: $weeklyWeightLossOkKg, ')
          ..write('weeklyWeightLossTooFastKg: $weeklyWeightLossTooFastKg, ')
          ..write(
            'adjustmentAddCaloriesWhenTooFast: $adjustmentAddCaloriesWhenTooFast, ',
          )
          ..write(
            'adjustmentExtraDeficitPercentWhenSlow: $adjustmentExtraDeficitPercentWhenSlow, ',
          )
          ..write('rationaleText: $rationaleText')
          ..write(')'))
        .toString();
  }
}

class $CookingYieldFactorsTable extends CookingYieldFactors
    with TableInfo<$CookingYieldFactorsTable, CookingYieldFactor> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CookingYieldFactorsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _ingredientKeyMeta = const VerificationMeta(
    'ingredientKey',
  );
  @override
  late final GeneratedColumn<String> ingredientKey = GeneratedColumn<String>(
    'ingredient_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 32),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _yieldLossPercentMeta = const VerificationMeta(
    'yieldLossPercent',
  );
  @override
  late final GeneratedColumn<double> yieldLossPercent = GeneratedColumn<double>(
    'yield_loss_percent',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _yieldLossPercentMinMeta =
      const VerificationMeta('yieldLossPercentMin');
  @override
  late final GeneratedColumn<double> yieldLossPercentMin =
      GeneratedColumn<double>(
        'yield_loss_percent_min',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _yieldLossPercentMaxMeta =
      const VerificationMeta('yieldLossPercentMax');
  @override
  late final GeneratedColumn<double> yieldLossPercentMax =
      GeneratedColumn<double>(
        'yield_loss_percent_max',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    ingredientKey,
    category,
    yieldLossPercent,
    yieldLossPercentMin,
    yieldLossPercentMax,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cooking_yield_factors';
  @override
  VerificationContext validateIntegrity(
    Insertable<CookingYieldFactor> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('ingredient_key')) {
      context.handle(
        _ingredientKeyMeta,
        ingredientKey.isAcceptableOrUnknown(
          data['ingredient_key']!,
          _ingredientKeyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_ingredientKeyMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('yield_loss_percent')) {
      context.handle(
        _yieldLossPercentMeta,
        yieldLossPercent.isAcceptableOrUnknown(
          data['yield_loss_percent']!,
          _yieldLossPercentMeta,
        ),
      );
    }
    if (data.containsKey('yield_loss_percent_min')) {
      context.handle(
        _yieldLossPercentMinMeta,
        yieldLossPercentMin.isAcceptableOrUnknown(
          data['yield_loss_percent_min']!,
          _yieldLossPercentMinMeta,
        ),
      );
    }
    if (data.containsKey('yield_loss_percent_max')) {
      context.handle(
        _yieldLossPercentMaxMeta,
        yieldLossPercentMax.isAcceptableOrUnknown(
          data['yield_loss_percent_max']!,
          _yieldLossPercentMaxMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CookingYieldFactor map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CookingYieldFactor(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      ingredientKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ingredient_key'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      yieldLossPercent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}yield_loss_percent'],
      ),
      yieldLossPercentMin: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}yield_loss_percent_min'],
      ),
      yieldLossPercentMax: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}yield_loss_percent_max'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $CookingYieldFactorsTable createAlias(String alias) {
    return $CookingYieldFactorsTable(attachedDatabase, alias);
  }
}

class CookingYieldFactor extends DataClass
    implements Insertable<CookingYieldFactor> {
  final int id;

  /// Stable key, e.g. onion, fish, poultry
  final String ingredientKey;

  /// vegetable | meat | fish | poultry | other
  final String category;
  final double? yieldLossPercent;
  final double? yieldLossPercentMin;
  final double? yieldLossPercentMax;
  final String? notes;
  const CookingYieldFactor({
    required this.id,
    required this.ingredientKey,
    required this.category,
    this.yieldLossPercent,
    this.yieldLossPercentMin,
    this.yieldLossPercentMax,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['ingredient_key'] = Variable<String>(ingredientKey);
    map['category'] = Variable<String>(category);
    if (!nullToAbsent || yieldLossPercent != null) {
      map['yield_loss_percent'] = Variable<double>(yieldLossPercent);
    }
    if (!nullToAbsent || yieldLossPercentMin != null) {
      map['yield_loss_percent_min'] = Variable<double>(yieldLossPercentMin);
    }
    if (!nullToAbsent || yieldLossPercentMax != null) {
      map['yield_loss_percent_max'] = Variable<double>(yieldLossPercentMax);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  CookingYieldFactorsCompanion toCompanion(bool nullToAbsent) {
    return CookingYieldFactorsCompanion(
      id: Value(id),
      ingredientKey: Value(ingredientKey),
      category: Value(category),
      yieldLossPercent: yieldLossPercent == null && nullToAbsent
          ? const Value.absent()
          : Value(yieldLossPercent),
      yieldLossPercentMin: yieldLossPercentMin == null && nullToAbsent
          ? const Value.absent()
          : Value(yieldLossPercentMin),
      yieldLossPercentMax: yieldLossPercentMax == null && nullToAbsent
          ? const Value.absent()
          : Value(yieldLossPercentMax),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory CookingYieldFactor.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CookingYieldFactor(
      id: serializer.fromJson<int>(json['id']),
      ingredientKey: serializer.fromJson<String>(json['ingredientKey']),
      category: serializer.fromJson<String>(json['category']),
      yieldLossPercent: serializer.fromJson<double?>(json['yieldLossPercent']),
      yieldLossPercentMin: serializer.fromJson<double?>(
        json['yieldLossPercentMin'],
      ),
      yieldLossPercentMax: serializer.fromJson<double?>(
        json['yieldLossPercentMax'],
      ),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'ingredientKey': serializer.toJson<String>(ingredientKey),
      'category': serializer.toJson<String>(category),
      'yieldLossPercent': serializer.toJson<double?>(yieldLossPercent),
      'yieldLossPercentMin': serializer.toJson<double?>(yieldLossPercentMin),
      'yieldLossPercentMax': serializer.toJson<double?>(yieldLossPercentMax),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  CookingYieldFactor copyWith({
    int? id,
    String? ingredientKey,
    String? category,
    Value<double?> yieldLossPercent = const Value.absent(),
    Value<double?> yieldLossPercentMin = const Value.absent(),
    Value<double?> yieldLossPercentMax = const Value.absent(),
    Value<String?> notes = const Value.absent(),
  }) => CookingYieldFactor(
    id: id ?? this.id,
    ingredientKey: ingredientKey ?? this.ingredientKey,
    category: category ?? this.category,
    yieldLossPercent: yieldLossPercent.present
        ? yieldLossPercent.value
        : this.yieldLossPercent,
    yieldLossPercentMin: yieldLossPercentMin.present
        ? yieldLossPercentMin.value
        : this.yieldLossPercentMin,
    yieldLossPercentMax: yieldLossPercentMax.present
        ? yieldLossPercentMax.value
        : this.yieldLossPercentMax,
    notes: notes.present ? notes.value : this.notes,
  );
  CookingYieldFactor copyWithCompanion(CookingYieldFactorsCompanion data) {
    return CookingYieldFactor(
      id: data.id.present ? data.id.value : this.id,
      ingredientKey: data.ingredientKey.present
          ? data.ingredientKey.value
          : this.ingredientKey,
      category: data.category.present ? data.category.value : this.category,
      yieldLossPercent: data.yieldLossPercent.present
          ? data.yieldLossPercent.value
          : this.yieldLossPercent,
      yieldLossPercentMin: data.yieldLossPercentMin.present
          ? data.yieldLossPercentMin.value
          : this.yieldLossPercentMin,
      yieldLossPercentMax: data.yieldLossPercentMax.present
          ? data.yieldLossPercentMax.value
          : this.yieldLossPercentMax,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CookingYieldFactor(')
          ..write('id: $id, ')
          ..write('ingredientKey: $ingredientKey, ')
          ..write('category: $category, ')
          ..write('yieldLossPercent: $yieldLossPercent, ')
          ..write('yieldLossPercentMin: $yieldLossPercentMin, ')
          ..write('yieldLossPercentMax: $yieldLossPercentMax, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    ingredientKey,
    category,
    yieldLossPercent,
    yieldLossPercentMin,
    yieldLossPercentMax,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CookingYieldFactor &&
          other.id == this.id &&
          other.ingredientKey == this.ingredientKey &&
          other.category == this.category &&
          other.yieldLossPercent == this.yieldLossPercent &&
          other.yieldLossPercentMin == this.yieldLossPercentMin &&
          other.yieldLossPercentMax == this.yieldLossPercentMax &&
          other.notes == this.notes);
}

class CookingYieldFactorsCompanion extends UpdateCompanion<CookingYieldFactor> {
  final Value<int> id;
  final Value<String> ingredientKey;
  final Value<String> category;
  final Value<double?> yieldLossPercent;
  final Value<double?> yieldLossPercentMin;
  final Value<double?> yieldLossPercentMax;
  final Value<String?> notes;
  const CookingYieldFactorsCompanion({
    this.id = const Value.absent(),
    this.ingredientKey = const Value.absent(),
    this.category = const Value.absent(),
    this.yieldLossPercent = const Value.absent(),
    this.yieldLossPercentMin = const Value.absent(),
    this.yieldLossPercentMax = const Value.absent(),
    this.notes = const Value.absent(),
  });
  CookingYieldFactorsCompanion.insert({
    this.id = const Value.absent(),
    required String ingredientKey,
    required String category,
    this.yieldLossPercent = const Value.absent(),
    this.yieldLossPercentMin = const Value.absent(),
    this.yieldLossPercentMax = const Value.absent(),
    this.notes = const Value.absent(),
  }) : ingredientKey = Value(ingredientKey),
       category = Value(category);
  static Insertable<CookingYieldFactor> custom({
    Expression<int>? id,
    Expression<String>? ingredientKey,
    Expression<String>? category,
    Expression<double>? yieldLossPercent,
    Expression<double>? yieldLossPercentMin,
    Expression<double>? yieldLossPercentMax,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ingredientKey != null) 'ingredient_key': ingredientKey,
      if (category != null) 'category': category,
      if (yieldLossPercent != null) 'yield_loss_percent': yieldLossPercent,
      if (yieldLossPercentMin != null)
        'yield_loss_percent_min': yieldLossPercentMin,
      if (yieldLossPercentMax != null)
        'yield_loss_percent_max': yieldLossPercentMax,
      if (notes != null) 'notes': notes,
    });
  }

  CookingYieldFactorsCompanion copyWith({
    Value<int>? id,
    Value<String>? ingredientKey,
    Value<String>? category,
    Value<double?>? yieldLossPercent,
    Value<double?>? yieldLossPercentMin,
    Value<double?>? yieldLossPercentMax,
    Value<String?>? notes,
  }) {
    return CookingYieldFactorsCompanion(
      id: id ?? this.id,
      ingredientKey: ingredientKey ?? this.ingredientKey,
      category: category ?? this.category,
      yieldLossPercent: yieldLossPercent ?? this.yieldLossPercent,
      yieldLossPercentMin: yieldLossPercentMin ?? this.yieldLossPercentMin,
      yieldLossPercentMax: yieldLossPercentMax ?? this.yieldLossPercentMax,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (ingredientKey.present) {
      map['ingredient_key'] = Variable<String>(ingredientKey.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (yieldLossPercent.present) {
      map['yield_loss_percent'] = Variable<double>(yieldLossPercent.value);
    }
    if (yieldLossPercentMin.present) {
      map['yield_loss_percent_min'] = Variable<double>(
        yieldLossPercentMin.value,
      );
    }
    if (yieldLossPercentMax.present) {
      map['yield_loss_percent_max'] = Variable<double>(
        yieldLossPercentMax.value,
      );
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CookingYieldFactorsCompanion(')
          ..write('id: $id, ')
          ..write('ingredientKey: $ingredientKey, ')
          ..write('category: $category, ')
          ..write('yieldLossPercent: $yieldLossPercent, ')
          ..write('yieldLossPercentMin: $yieldLossPercentMin, ')
          ..write('yieldLossPercentMax: $yieldLossPercentMax, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

class $AdvisoryRulesTable extends AdvisoryRules
    with TableInfo<$AdvisoryRulesTable, AdvisoryRule> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AdvisoryRulesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _ruleTypeMeta = const VerificationMeta(
    'ruleType',
  );
  @override
  late final GeneratedColumn<String> ruleType = GeneratedColumn<String>(
    'rule_type',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 64),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contextTagsMeta = const VerificationMeta(
    'contextTags',
  );
  @override
  late final GeneratedColumn<String> contextTags = GeneratedColumn<String>(
    'context_tags',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _conditionTextMeta = const VerificationMeta(
    'conditionText',
  );
  @override
  late final GeneratedColumn<String> conditionText = GeneratedColumn<String>(
    'condition_text',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _severityMeta = const VerificationMeta(
    'severity',
  );
  @override
  late final GeneratedColumn<String> severity = GeneratedColumn<String>(
    'severity',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 32),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _recommendationMeta = const VerificationMeta(
    'recommendation',
  );
  @override
  late final GeneratedColumn<String> recommendation = GeneratedColumn<String>(
    'recommendation',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isAutomatableMeta = const VerificationMeta(
    'isAutomatable',
  );
  @override
  late final GeneratedColumn<bool> isAutomatable = GeneratedColumn<bool>(
    'is_automatable',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_automatable" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _sourceRefMeta = const VerificationMeta(
    'sourceRef',
  );
  @override
  late final GeneratedColumn<String> sourceRef = GeneratedColumn<String>(
    'source_ref',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    ruleType,
    contextTags,
    conditionText,
    severity,
    recommendation,
    isAutomatable,
    sourceRef,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'advisory_rules';
  @override
  VerificationContext validateIntegrity(
    Insertable<AdvisoryRule> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('rule_type')) {
      context.handle(
        _ruleTypeMeta,
        ruleType.isAcceptableOrUnknown(data['rule_type']!, _ruleTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_ruleTypeMeta);
    }
    if (data.containsKey('context_tags')) {
      context.handle(
        _contextTagsMeta,
        contextTags.isAcceptableOrUnknown(
          data['context_tags']!,
          _contextTagsMeta,
        ),
      );
    }
    if (data.containsKey('condition_text')) {
      context.handle(
        _conditionTextMeta,
        conditionText.isAcceptableOrUnknown(
          data['condition_text']!,
          _conditionTextMeta,
        ),
      );
    }
    if (data.containsKey('severity')) {
      context.handle(
        _severityMeta,
        severity.isAcceptableOrUnknown(data['severity']!, _severityMeta),
      );
    }
    if (data.containsKey('recommendation')) {
      context.handle(
        _recommendationMeta,
        recommendation.isAcceptableOrUnknown(
          data['recommendation']!,
          _recommendationMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_recommendationMeta);
    }
    if (data.containsKey('is_automatable')) {
      context.handle(
        _isAutomatableMeta,
        isAutomatable.isAcceptableOrUnknown(
          data['is_automatable']!,
          _isAutomatableMeta,
        ),
      );
    }
    if (data.containsKey('source_ref')) {
      context.handle(
        _sourceRefMeta,
        sourceRef.isAcceptableOrUnknown(data['source_ref']!, _sourceRefMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AdvisoryRule map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AdvisoryRule(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      ruleType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rule_type'],
      )!,
      contextTags: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}context_tags'],
      ),
      conditionText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}condition_text'],
      ),
      severity: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}severity'],
      ),
      recommendation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}recommendation'],
      )!,
      isAutomatable: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_automatable'],
      )!,
      sourceRef: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_ref'],
      ),
    );
  }

  @override
  $AdvisoryRulesTable createAlias(String alias) {
    return $AdvisoryRulesTable(attachedDatabase, alias);
  }
}

class AdvisoryRule extends DataClass implements Insertable<AdvisoryRule> {
  final int id;
  final String ruleType;

  /// JSON array of tags, e.g. ["vacation","restaurant"]
  final String? contextTags;
  final String? conditionText;
  final String? severity;
  final String recommendation;
  final bool isAutomatable;
  final String? sourceRef;
  const AdvisoryRule({
    required this.id,
    required this.ruleType,
    this.contextTags,
    this.conditionText,
    this.severity,
    required this.recommendation,
    required this.isAutomatable,
    this.sourceRef,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['rule_type'] = Variable<String>(ruleType);
    if (!nullToAbsent || contextTags != null) {
      map['context_tags'] = Variable<String>(contextTags);
    }
    if (!nullToAbsent || conditionText != null) {
      map['condition_text'] = Variable<String>(conditionText);
    }
    if (!nullToAbsent || severity != null) {
      map['severity'] = Variable<String>(severity);
    }
    map['recommendation'] = Variable<String>(recommendation);
    map['is_automatable'] = Variable<bool>(isAutomatable);
    if (!nullToAbsent || sourceRef != null) {
      map['source_ref'] = Variable<String>(sourceRef);
    }
    return map;
  }

  AdvisoryRulesCompanion toCompanion(bool nullToAbsent) {
    return AdvisoryRulesCompanion(
      id: Value(id),
      ruleType: Value(ruleType),
      contextTags: contextTags == null && nullToAbsent
          ? const Value.absent()
          : Value(contextTags),
      conditionText: conditionText == null && nullToAbsent
          ? const Value.absent()
          : Value(conditionText),
      severity: severity == null && nullToAbsent
          ? const Value.absent()
          : Value(severity),
      recommendation: Value(recommendation),
      isAutomatable: Value(isAutomatable),
      sourceRef: sourceRef == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceRef),
    );
  }

  factory AdvisoryRule.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AdvisoryRule(
      id: serializer.fromJson<int>(json['id']),
      ruleType: serializer.fromJson<String>(json['ruleType']),
      contextTags: serializer.fromJson<String?>(json['contextTags']),
      conditionText: serializer.fromJson<String?>(json['conditionText']),
      severity: serializer.fromJson<String?>(json['severity']),
      recommendation: serializer.fromJson<String>(json['recommendation']),
      isAutomatable: serializer.fromJson<bool>(json['isAutomatable']),
      sourceRef: serializer.fromJson<String?>(json['sourceRef']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'ruleType': serializer.toJson<String>(ruleType),
      'contextTags': serializer.toJson<String?>(contextTags),
      'conditionText': serializer.toJson<String?>(conditionText),
      'severity': serializer.toJson<String?>(severity),
      'recommendation': serializer.toJson<String>(recommendation),
      'isAutomatable': serializer.toJson<bool>(isAutomatable),
      'sourceRef': serializer.toJson<String?>(sourceRef),
    };
  }

  AdvisoryRule copyWith({
    int? id,
    String? ruleType,
    Value<String?> contextTags = const Value.absent(),
    Value<String?> conditionText = const Value.absent(),
    Value<String?> severity = const Value.absent(),
    String? recommendation,
    bool? isAutomatable,
    Value<String?> sourceRef = const Value.absent(),
  }) => AdvisoryRule(
    id: id ?? this.id,
    ruleType: ruleType ?? this.ruleType,
    contextTags: contextTags.present ? contextTags.value : this.contextTags,
    conditionText: conditionText.present
        ? conditionText.value
        : this.conditionText,
    severity: severity.present ? severity.value : this.severity,
    recommendation: recommendation ?? this.recommendation,
    isAutomatable: isAutomatable ?? this.isAutomatable,
    sourceRef: sourceRef.present ? sourceRef.value : this.sourceRef,
  );
  AdvisoryRule copyWithCompanion(AdvisoryRulesCompanion data) {
    return AdvisoryRule(
      id: data.id.present ? data.id.value : this.id,
      ruleType: data.ruleType.present ? data.ruleType.value : this.ruleType,
      contextTags: data.contextTags.present
          ? data.contextTags.value
          : this.contextTags,
      conditionText: data.conditionText.present
          ? data.conditionText.value
          : this.conditionText,
      severity: data.severity.present ? data.severity.value : this.severity,
      recommendation: data.recommendation.present
          ? data.recommendation.value
          : this.recommendation,
      isAutomatable: data.isAutomatable.present
          ? data.isAutomatable.value
          : this.isAutomatable,
      sourceRef: data.sourceRef.present ? data.sourceRef.value : this.sourceRef,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AdvisoryRule(')
          ..write('id: $id, ')
          ..write('ruleType: $ruleType, ')
          ..write('contextTags: $contextTags, ')
          ..write('conditionText: $conditionText, ')
          ..write('severity: $severity, ')
          ..write('recommendation: $recommendation, ')
          ..write('isAutomatable: $isAutomatable, ')
          ..write('sourceRef: $sourceRef')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    ruleType,
    contextTags,
    conditionText,
    severity,
    recommendation,
    isAutomatable,
    sourceRef,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AdvisoryRule &&
          other.id == this.id &&
          other.ruleType == this.ruleType &&
          other.contextTags == this.contextTags &&
          other.conditionText == this.conditionText &&
          other.severity == this.severity &&
          other.recommendation == this.recommendation &&
          other.isAutomatable == this.isAutomatable &&
          other.sourceRef == this.sourceRef);
}

class AdvisoryRulesCompanion extends UpdateCompanion<AdvisoryRule> {
  final Value<int> id;
  final Value<String> ruleType;
  final Value<String?> contextTags;
  final Value<String?> conditionText;
  final Value<String?> severity;
  final Value<String> recommendation;
  final Value<bool> isAutomatable;
  final Value<String?> sourceRef;
  const AdvisoryRulesCompanion({
    this.id = const Value.absent(),
    this.ruleType = const Value.absent(),
    this.contextTags = const Value.absent(),
    this.conditionText = const Value.absent(),
    this.severity = const Value.absent(),
    this.recommendation = const Value.absent(),
    this.isAutomatable = const Value.absent(),
    this.sourceRef = const Value.absent(),
  });
  AdvisoryRulesCompanion.insert({
    this.id = const Value.absent(),
    required String ruleType,
    this.contextTags = const Value.absent(),
    this.conditionText = const Value.absent(),
    this.severity = const Value.absent(),
    required String recommendation,
    this.isAutomatable = const Value.absent(),
    this.sourceRef = const Value.absent(),
  }) : ruleType = Value(ruleType),
       recommendation = Value(recommendation);
  static Insertable<AdvisoryRule> custom({
    Expression<int>? id,
    Expression<String>? ruleType,
    Expression<String>? contextTags,
    Expression<String>? conditionText,
    Expression<String>? severity,
    Expression<String>? recommendation,
    Expression<bool>? isAutomatable,
    Expression<String>? sourceRef,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ruleType != null) 'rule_type': ruleType,
      if (contextTags != null) 'context_tags': contextTags,
      if (conditionText != null) 'condition_text': conditionText,
      if (severity != null) 'severity': severity,
      if (recommendation != null) 'recommendation': recommendation,
      if (isAutomatable != null) 'is_automatable': isAutomatable,
      if (sourceRef != null) 'source_ref': sourceRef,
    });
  }

  AdvisoryRulesCompanion copyWith({
    Value<int>? id,
    Value<String>? ruleType,
    Value<String?>? contextTags,
    Value<String?>? conditionText,
    Value<String?>? severity,
    Value<String>? recommendation,
    Value<bool>? isAutomatable,
    Value<String?>? sourceRef,
  }) {
    return AdvisoryRulesCompanion(
      id: id ?? this.id,
      ruleType: ruleType ?? this.ruleType,
      contextTags: contextTags ?? this.contextTags,
      conditionText: conditionText ?? this.conditionText,
      severity: severity ?? this.severity,
      recommendation: recommendation ?? this.recommendation,
      isAutomatable: isAutomatable ?? this.isAutomatable,
      sourceRef: sourceRef ?? this.sourceRef,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (ruleType.present) {
      map['rule_type'] = Variable<String>(ruleType.value);
    }
    if (contextTags.present) {
      map['context_tags'] = Variable<String>(contextTags.value);
    }
    if (conditionText.present) {
      map['condition_text'] = Variable<String>(conditionText.value);
    }
    if (severity.present) {
      map['severity'] = Variable<String>(severity.value);
    }
    if (recommendation.present) {
      map['recommendation'] = Variable<String>(recommendation.value);
    }
    if (isAutomatable.present) {
      map['is_automatable'] = Variable<bool>(isAutomatable.value);
    }
    if (sourceRef.present) {
      map['source_ref'] = Variable<String>(sourceRef.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AdvisoryRulesCompanion(')
          ..write('id: $id, ')
          ..write('ruleType: $ruleType, ')
          ..write('contextTags: $contextTags, ')
          ..write('conditionText: $conditionText, ')
          ..write('severity: $severity, ')
          ..write('recommendation: $recommendation, ')
          ..write('isAutomatable: $isAutomatable, ')
          ..write('sourceRef: $sourceRef')
          ..write(')'))
        .toString();
  }
}

class $MealPlanTemplatesTable extends MealPlanTemplates
    with TableInfo<$MealPlanTemplatesTable, MealPlanTemplate> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MealPlanTemplatesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceBookMeta = const VerificationMeta(
    'sourceBook',
  );
  @override
  late final GeneratedColumn<String> sourceBook = GeneratedColumn<String>(
    'source_book',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _chapterRefMeta = const VerificationMeta(
    'chapterRef',
  );
  @override
  late final GeneratedColumn<String> chapterRef = GeneratedColumn<String>(
    'chapter_ref',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _exampleNumberMeta = const VerificationMeta(
    'exampleNumber',
  );
  @override
  late final GeneratedColumn<int> exampleNumber = GeneratedColumn<int>(
    'example_number',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dayNumberMeta = const VerificationMeta(
    'dayNumber',
  );
  @override
  late final GeneratedColumn<int> dayNumber = GeneratedColumn<int>(
    'day_number',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _targetCaloriesMeta = const VerificationMeta(
    'targetCalories',
  );
  @override
  late final GeneratedColumn<double> targetCalories = GeneratedColumn<double>(
    'target_calories',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _targetProteinGMeta = const VerificationMeta(
    'targetProteinG',
  );
  @override
  late final GeneratedColumn<double> targetProteinG = GeneratedColumn<double>(
    'target_protein_g',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _targetFatGMeta = const VerificationMeta(
    'targetFatG',
  );
  @override
  late final GeneratedColumn<double> targetFatG = GeneratedColumn<double>(
    'target_fat_g',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _targetCarbGMeta = const VerificationMeta(
    'targetCarbG',
  );
  @override
  late final GeneratedColumn<double> targetCarbG = GeneratedColumn<double>(
    'target_carb_g',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    code,
    title,
    sourceBook,
    chapterRef,
    exampleNumber,
    dayNumber,
    targetCalories,
    targetProteinG,
    targetFatG,
    targetCarbG,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'meal_plan_templates';
  @override
  VerificationContext validateIntegrity(
    Insertable<MealPlanTemplate> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('source_book')) {
      context.handle(
        _sourceBookMeta,
        sourceBook.isAcceptableOrUnknown(data['source_book']!, _sourceBookMeta),
      );
    }
    if (data.containsKey('chapter_ref')) {
      context.handle(
        _chapterRefMeta,
        chapterRef.isAcceptableOrUnknown(data['chapter_ref']!, _chapterRefMeta),
      );
    }
    if (data.containsKey('example_number')) {
      context.handle(
        _exampleNumberMeta,
        exampleNumber.isAcceptableOrUnknown(
          data['example_number']!,
          _exampleNumberMeta,
        ),
      );
    }
    if (data.containsKey('day_number')) {
      context.handle(
        _dayNumberMeta,
        dayNumber.isAcceptableOrUnknown(data['day_number']!, _dayNumberMeta),
      );
    }
    if (data.containsKey('target_calories')) {
      context.handle(
        _targetCaloriesMeta,
        targetCalories.isAcceptableOrUnknown(
          data['target_calories']!,
          _targetCaloriesMeta,
        ),
      );
    }
    if (data.containsKey('target_protein_g')) {
      context.handle(
        _targetProteinGMeta,
        targetProteinG.isAcceptableOrUnknown(
          data['target_protein_g']!,
          _targetProteinGMeta,
        ),
      );
    }
    if (data.containsKey('target_fat_g')) {
      context.handle(
        _targetFatGMeta,
        targetFatG.isAcceptableOrUnknown(
          data['target_fat_g']!,
          _targetFatGMeta,
        ),
      );
    }
    if (data.containsKey('target_carb_g')) {
      context.handle(
        _targetCarbGMeta,
        targetCarbG.isAcceptableOrUnknown(
          data['target_carb_g']!,
          _targetCarbGMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MealPlanTemplate map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MealPlanTemplate(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      sourceBook: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_book'],
      ),
      chapterRef: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}chapter_ref'],
      ),
      exampleNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}example_number'],
      ),
      dayNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}day_number'],
      ),
      targetCalories: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}target_calories'],
      ),
      targetProteinG: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}target_protein_g'],
      ),
      targetFatG: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}target_fat_g'],
      ),
      targetCarbG: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}target_carb_g'],
      ),
    );
  }

  @override
  $MealPlanTemplatesTable createAlias(String alias) {
    return $MealPlanTemplatesTable(attachedDatabase, alias);
  }
}

class MealPlanTemplate extends DataClass
    implements Insertable<MealPlanTemplate> {
  final int id;
  final String code;
  final String title;
  final String? sourceBook;
  final String? chapterRef;
  final int? exampleNumber;
  final int? dayNumber;
  final double? targetCalories;
  final double? targetProteinG;
  final double? targetFatG;
  final double? targetCarbG;
  const MealPlanTemplate({
    required this.id,
    required this.code,
    required this.title,
    this.sourceBook,
    this.chapterRef,
    this.exampleNumber,
    this.dayNumber,
    this.targetCalories,
    this.targetProteinG,
    this.targetFatG,
    this.targetCarbG,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['code'] = Variable<String>(code);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || sourceBook != null) {
      map['source_book'] = Variable<String>(sourceBook);
    }
    if (!nullToAbsent || chapterRef != null) {
      map['chapter_ref'] = Variable<String>(chapterRef);
    }
    if (!nullToAbsent || exampleNumber != null) {
      map['example_number'] = Variable<int>(exampleNumber);
    }
    if (!nullToAbsent || dayNumber != null) {
      map['day_number'] = Variable<int>(dayNumber);
    }
    if (!nullToAbsent || targetCalories != null) {
      map['target_calories'] = Variable<double>(targetCalories);
    }
    if (!nullToAbsent || targetProteinG != null) {
      map['target_protein_g'] = Variable<double>(targetProteinG);
    }
    if (!nullToAbsent || targetFatG != null) {
      map['target_fat_g'] = Variable<double>(targetFatG);
    }
    if (!nullToAbsent || targetCarbG != null) {
      map['target_carb_g'] = Variable<double>(targetCarbG);
    }
    return map;
  }

  MealPlanTemplatesCompanion toCompanion(bool nullToAbsent) {
    return MealPlanTemplatesCompanion(
      id: Value(id),
      code: Value(code),
      title: Value(title),
      sourceBook: sourceBook == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceBook),
      chapterRef: chapterRef == null && nullToAbsent
          ? const Value.absent()
          : Value(chapterRef),
      exampleNumber: exampleNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(exampleNumber),
      dayNumber: dayNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(dayNumber),
      targetCalories: targetCalories == null && nullToAbsent
          ? const Value.absent()
          : Value(targetCalories),
      targetProteinG: targetProteinG == null && nullToAbsent
          ? const Value.absent()
          : Value(targetProteinG),
      targetFatG: targetFatG == null && nullToAbsent
          ? const Value.absent()
          : Value(targetFatG),
      targetCarbG: targetCarbG == null && nullToAbsent
          ? const Value.absent()
          : Value(targetCarbG),
    );
  }

  factory MealPlanTemplate.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MealPlanTemplate(
      id: serializer.fromJson<int>(json['id']),
      code: serializer.fromJson<String>(json['code']),
      title: serializer.fromJson<String>(json['title']),
      sourceBook: serializer.fromJson<String?>(json['sourceBook']),
      chapterRef: serializer.fromJson<String?>(json['chapterRef']),
      exampleNumber: serializer.fromJson<int?>(json['exampleNumber']),
      dayNumber: serializer.fromJson<int?>(json['dayNumber']),
      targetCalories: serializer.fromJson<double?>(json['targetCalories']),
      targetProteinG: serializer.fromJson<double?>(json['targetProteinG']),
      targetFatG: serializer.fromJson<double?>(json['targetFatG']),
      targetCarbG: serializer.fromJson<double?>(json['targetCarbG']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'code': serializer.toJson<String>(code),
      'title': serializer.toJson<String>(title),
      'sourceBook': serializer.toJson<String?>(sourceBook),
      'chapterRef': serializer.toJson<String?>(chapterRef),
      'exampleNumber': serializer.toJson<int?>(exampleNumber),
      'dayNumber': serializer.toJson<int?>(dayNumber),
      'targetCalories': serializer.toJson<double?>(targetCalories),
      'targetProteinG': serializer.toJson<double?>(targetProteinG),
      'targetFatG': serializer.toJson<double?>(targetFatG),
      'targetCarbG': serializer.toJson<double?>(targetCarbG),
    };
  }

  MealPlanTemplate copyWith({
    int? id,
    String? code,
    String? title,
    Value<String?> sourceBook = const Value.absent(),
    Value<String?> chapterRef = const Value.absent(),
    Value<int?> exampleNumber = const Value.absent(),
    Value<int?> dayNumber = const Value.absent(),
    Value<double?> targetCalories = const Value.absent(),
    Value<double?> targetProteinG = const Value.absent(),
    Value<double?> targetFatG = const Value.absent(),
    Value<double?> targetCarbG = const Value.absent(),
  }) => MealPlanTemplate(
    id: id ?? this.id,
    code: code ?? this.code,
    title: title ?? this.title,
    sourceBook: sourceBook.present ? sourceBook.value : this.sourceBook,
    chapterRef: chapterRef.present ? chapterRef.value : this.chapterRef,
    exampleNumber: exampleNumber.present
        ? exampleNumber.value
        : this.exampleNumber,
    dayNumber: dayNumber.present ? dayNumber.value : this.dayNumber,
    targetCalories: targetCalories.present
        ? targetCalories.value
        : this.targetCalories,
    targetProteinG: targetProteinG.present
        ? targetProteinG.value
        : this.targetProteinG,
    targetFatG: targetFatG.present ? targetFatG.value : this.targetFatG,
    targetCarbG: targetCarbG.present ? targetCarbG.value : this.targetCarbG,
  );
  MealPlanTemplate copyWithCompanion(MealPlanTemplatesCompanion data) {
    return MealPlanTemplate(
      id: data.id.present ? data.id.value : this.id,
      code: data.code.present ? data.code.value : this.code,
      title: data.title.present ? data.title.value : this.title,
      sourceBook: data.sourceBook.present
          ? data.sourceBook.value
          : this.sourceBook,
      chapterRef: data.chapterRef.present
          ? data.chapterRef.value
          : this.chapterRef,
      exampleNumber: data.exampleNumber.present
          ? data.exampleNumber.value
          : this.exampleNumber,
      dayNumber: data.dayNumber.present ? data.dayNumber.value : this.dayNumber,
      targetCalories: data.targetCalories.present
          ? data.targetCalories.value
          : this.targetCalories,
      targetProteinG: data.targetProteinG.present
          ? data.targetProteinG.value
          : this.targetProteinG,
      targetFatG: data.targetFatG.present
          ? data.targetFatG.value
          : this.targetFatG,
      targetCarbG: data.targetCarbG.present
          ? data.targetCarbG.value
          : this.targetCarbG,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MealPlanTemplate(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('title: $title, ')
          ..write('sourceBook: $sourceBook, ')
          ..write('chapterRef: $chapterRef, ')
          ..write('exampleNumber: $exampleNumber, ')
          ..write('dayNumber: $dayNumber, ')
          ..write('targetCalories: $targetCalories, ')
          ..write('targetProteinG: $targetProteinG, ')
          ..write('targetFatG: $targetFatG, ')
          ..write('targetCarbG: $targetCarbG')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    code,
    title,
    sourceBook,
    chapterRef,
    exampleNumber,
    dayNumber,
    targetCalories,
    targetProteinG,
    targetFatG,
    targetCarbG,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MealPlanTemplate &&
          other.id == this.id &&
          other.code == this.code &&
          other.title == this.title &&
          other.sourceBook == this.sourceBook &&
          other.chapterRef == this.chapterRef &&
          other.exampleNumber == this.exampleNumber &&
          other.dayNumber == this.dayNumber &&
          other.targetCalories == this.targetCalories &&
          other.targetProteinG == this.targetProteinG &&
          other.targetFatG == this.targetFatG &&
          other.targetCarbG == this.targetCarbG);
}

class MealPlanTemplatesCompanion extends UpdateCompanion<MealPlanTemplate> {
  final Value<int> id;
  final Value<String> code;
  final Value<String> title;
  final Value<String?> sourceBook;
  final Value<String?> chapterRef;
  final Value<int?> exampleNumber;
  final Value<int?> dayNumber;
  final Value<double?> targetCalories;
  final Value<double?> targetProteinG;
  final Value<double?> targetFatG;
  final Value<double?> targetCarbG;
  const MealPlanTemplatesCompanion({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.title = const Value.absent(),
    this.sourceBook = const Value.absent(),
    this.chapterRef = const Value.absent(),
    this.exampleNumber = const Value.absent(),
    this.dayNumber = const Value.absent(),
    this.targetCalories = const Value.absent(),
    this.targetProteinG = const Value.absent(),
    this.targetFatG = const Value.absent(),
    this.targetCarbG = const Value.absent(),
  });
  MealPlanTemplatesCompanion.insert({
    this.id = const Value.absent(),
    required String code,
    required String title,
    this.sourceBook = const Value.absent(),
    this.chapterRef = const Value.absent(),
    this.exampleNumber = const Value.absent(),
    this.dayNumber = const Value.absent(),
    this.targetCalories = const Value.absent(),
    this.targetProteinG = const Value.absent(),
    this.targetFatG = const Value.absent(),
    this.targetCarbG = const Value.absent(),
  }) : code = Value(code),
       title = Value(title);
  static Insertable<MealPlanTemplate> custom({
    Expression<int>? id,
    Expression<String>? code,
    Expression<String>? title,
    Expression<String>? sourceBook,
    Expression<String>? chapterRef,
    Expression<int>? exampleNumber,
    Expression<int>? dayNumber,
    Expression<double>? targetCalories,
    Expression<double>? targetProteinG,
    Expression<double>? targetFatG,
    Expression<double>? targetCarbG,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (title != null) 'title': title,
      if (sourceBook != null) 'source_book': sourceBook,
      if (chapterRef != null) 'chapter_ref': chapterRef,
      if (exampleNumber != null) 'example_number': exampleNumber,
      if (dayNumber != null) 'day_number': dayNumber,
      if (targetCalories != null) 'target_calories': targetCalories,
      if (targetProteinG != null) 'target_protein_g': targetProteinG,
      if (targetFatG != null) 'target_fat_g': targetFatG,
      if (targetCarbG != null) 'target_carb_g': targetCarbG,
    });
  }

  MealPlanTemplatesCompanion copyWith({
    Value<int>? id,
    Value<String>? code,
    Value<String>? title,
    Value<String?>? sourceBook,
    Value<String?>? chapterRef,
    Value<int?>? exampleNumber,
    Value<int?>? dayNumber,
    Value<double?>? targetCalories,
    Value<double?>? targetProteinG,
    Value<double?>? targetFatG,
    Value<double?>? targetCarbG,
  }) {
    return MealPlanTemplatesCompanion(
      id: id ?? this.id,
      code: code ?? this.code,
      title: title ?? this.title,
      sourceBook: sourceBook ?? this.sourceBook,
      chapterRef: chapterRef ?? this.chapterRef,
      exampleNumber: exampleNumber ?? this.exampleNumber,
      dayNumber: dayNumber ?? this.dayNumber,
      targetCalories: targetCalories ?? this.targetCalories,
      targetProteinG: targetProteinG ?? this.targetProteinG,
      targetFatG: targetFatG ?? this.targetFatG,
      targetCarbG: targetCarbG ?? this.targetCarbG,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (sourceBook.present) {
      map['source_book'] = Variable<String>(sourceBook.value);
    }
    if (chapterRef.present) {
      map['chapter_ref'] = Variable<String>(chapterRef.value);
    }
    if (exampleNumber.present) {
      map['example_number'] = Variable<int>(exampleNumber.value);
    }
    if (dayNumber.present) {
      map['day_number'] = Variable<int>(dayNumber.value);
    }
    if (targetCalories.present) {
      map['target_calories'] = Variable<double>(targetCalories.value);
    }
    if (targetProteinG.present) {
      map['target_protein_g'] = Variable<double>(targetProteinG.value);
    }
    if (targetFatG.present) {
      map['target_fat_g'] = Variable<double>(targetFatG.value);
    }
    if (targetCarbG.present) {
      map['target_carb_g'] = Variable<double>(targetCarbG.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MealPlanTemplatesCompanion(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('title: $title, ')
          ..write('sourceBook: $sourceBook, ')
          ..write('chapterRef: $chapterRef, ')
          ..write('exampleNumber: $exampleNumber, ')
          ..write('dayNumber: $dayNumber, ')
          ..write('targetCalories: $targetCalories, ')
          ..write('targetProteinG: $targetProteinG, ')
          ..write('targetFatG: $targetFatG, ')
          ..write('targetCarbG: $targetCarbG')
          ..write(')'))
        .toString();
  }
}

class $MealPlanMealsTable extends MealPlanMeals
    with TableInfo<$MealPlanMealsTable, MealPlanMeal> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MealPlanMealsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _templateIdMeta = const VerificationMeta(
    'templateId',
  );
  @override
  late final GeneratedColumn<int> templateId = GeneratedColumn<int>(
    'template_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES meal_plan_templates (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mealLabelMeta = const VerificationMeta(
    'mealLabel',
  );
  @override
  late final GeneratedColumn<String> mealLabel = GeneratedColumn<String>(
    'meal_label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _caloriesMeta = const VerificationMeta(
    'calories',
  );
  @override
  late final GeneratedColumn<double> calories = GeneratedColumn<double>(
    'calories',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _proteinGMeta = const VerificationMeta(
    'proteinG',
  );
  @override
  late final GeneratedColumn<double> proteinG = GeneratedColumn<double>(
    'protein_g',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fatGMeta = const VerificationMeta('fatG');
  @override
  late final GeneratedColumn<double> fatG = GeneratedColumn<double>(
    'fat_g',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _carbGMeta = const VerificationMeta('carbG');
  @override
  late final GeneratedColumn<double> carbG = GeneratedColumn<double>(
    'carb_g',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    templateId,
    sortOrder,
    mealLabel,
    calories,
    proteinG,
    fatG,
    carbG,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'meal_plan_meals';
  @override
  VerificationContext validateIntegrity(
    Insertable<MealPlanMeal> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('template_id')) {
      context.handle(
        _templateIdMeta,
        templateId.isAcceptableOrUnknown(data['template_id']!, _templateIdMeta),
      );
    } else if (isInserting) {
      context.missing(_templateIdMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    if (data.containsKey('meal_label')) {
      context.handle(
        _mealLabelMeta,
        mealLabel.isAcceptableOrUnknown(data['meal_label']!, _mealLabelMeta),
      );
    } else if (isInserting) {
      context.missing(_mealLabelMeta);
    }
    if (data.containsKey('calories')) {
      context.handle(
        _caloriesMeta,
        calories.isAcceptableOrUnknown(data['calories']!, _caloriesMeta),
      );
    }
    if (data.containsKey('protein_g')) {
      context.handle(
        _proteinGMeta,
        proteinG.isAcceptableOrUnknown(data['protein_g']!, _proteinGMeta),
      );
    }
    if (data.containsKey('fat_g')) {
      context.handle(
        _fatGMeta,
        fatG.isAcceptableOrUnknown(data['fat_g']!, _fatGMeta),
      );
    }
    if (data.containsKey('carb_g')) {
      context.handle(
        _carbGMeta,
        carbG.isAcceptableOrUnknown(data['carb_g']!, _carbGMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MealPlanMeal map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MealPlanMeal(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      templateId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}template_id'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      mealLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}meal_label'],
      )!,
      calories: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}calories'],
      ),
      proteinG: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}protein_g'],
      ),
      fatG: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fat_g'],
      ),
      carbG: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}carb_g'],
      ),
    );
  }

  @override
  $MealPlanMealsTable createAlias(String alias) {
    return $MealPlanMealsTable(attachedDatabase, alias);
  }
}

class MealPlanMeal extends DataClass implements Insertable<MealPlanMeal> {
  final int id;
  final int templateId;
  final int sortOrder;
  final String mealLabel;
  final double? calories;
  final double? proteinG;
  final double? fatG;
  final double? carbG;
  const MealPlanMeal({
    required this.id,
    required this.templateId,
    required this.sortOrder,
    required this.mealLabel,
    this.calories,
    this.proteinG,
    this.fatG,
    this.carbG,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['template_id'] = Variable<int>(templateId);
    map['sort_order'] = Variable<int>(sortOrder);
    map['meal_label'] = Variable<String>(mealLabel);
    if (!nullToAbsent || calories != null) {
      map['calories'] = Variable<double>(calories);
    }
    if (!nullToAbsent || proteinG != null) {
      map['protein_g'] = Variable<double>(proteinG);
    }
    if (!nullToAbsent || fatG != null) {
      map['fat_g'] = Variable<double>(fatG);
    }
    if (!nullToAbsent || carbG != null) {
      map['carb_g'] = Variable<double>(carbG);
    }
    return map;
  }

  MealPlanMealsCompanion toCompanion(bool nullToAbsent) {
    return MealPlanMealsCompanion(
      id: Value(id),
      templateId: Value(templateId),
      sortOrder: Value(sortOrder),
      mealLabel: Value(mealLabel),
      calories: calories == null && nullToAbsent
          ? const Value.absent()
          : Value(calories),
      proteinG: proteinG == null && nullToAbsent
          ? const Value.absent()
          : Value(proteinG),
      fatG: fatG == null && nullToAbsent ? const Value.absent() : Value(fatG),
      carbG: carbG == null && nullToAbsent
          ? const Value.absent()
          : Value(carbG),
    );
  }

  factory MealPlanMeal.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MealPlanMeal(
      id: serializer.fromJson<int>(json['id']),
      templateId: serializer.fromJson<int>(json['templateId']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      mealLabel: serializer.fromJson<String>(json['mealLabel']),
      calories: serializer.fromJson<double?>(json['calories']),
      proteinG: serializer.fromJson<double?>(json['proteinG']),
      fatG: serializer.fromJson<double?>(json['fatG']),
      carbG: serializer.fromJson<double?>(json['carbG']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'templateId': serializer.toJson<int>(templateId),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'mealLabel': serializer.toJson<String>(mealLabel),
      'calories': serializer.toJson<double?>(calories),
      'proteinG': serializer.toJson<double?>(proteinG),
      'fatG': serializer.toJson<double?>(fatG),
      'carbG': serializer.toJson<double?>(carbG),
    };
  }

  MealPlanMeal copyWith({
    int? id,
    int? templateId,
    int? sortOrder,
    String? mealLabel,
    Value<double?> calories = const Value.absent(),
    Value<double?> proteinG = const Value.absent(),
    Value<double?> fatG = const Value.absent(),
    Value<double?> carbG = const Value.absent(),
  }) => MealPlanMeal(
    id: id ?? this.id,
    templateId: templateId ?? this.templateId,
    sortOrder: sortOrder ?? this.sortOrder,
    mealLabel: mealLabel ?? this.mealLabel,
    calories: calories.present ? calories.value : this.calories,
    proteinG: proteinG.present ? proteinG.value : this.proteinG,
    fatG: fatG.present ? fatG.value : this.fatG,
    carbG: carbG.present ? carbG.value : this.carbG,
  );
  MealPlanMeal copyWithCompanion(MealPlanMealsCompanion data) {
    return MealPlanMeal(
      id: data.id.present ? data.id.value : this.id,
      templateId: data.templateId.present
          ? data.templateId.value
          : this.templateId,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      mealLabel: data.mealLabel.present ? data.mealLabel.value : this.mealLabel,
      calories: data.calories.present ? data.calories.value : this.calories,
      proteinG: data.proteinG.present ? data.proteinG.value : this.proteinG,
      fatG: data.fatG.present ? data.fatG.value : this.fatG,
      carbG: data.carbG.present ? data.carbG.value : this.carbG,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MealPlanMeal(')
          ..write('id: $id, ')
          ..write('templateId: $templateId, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('mealLabel: $mealLabel, ')
          ..write('calories: $calories, ')
          ..write('proteinG: $proteinG, ')
          ..write('fatG: $fatG, ')
          ..write('carbG: $carbG')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    templateId,
    sortOrder,
    mealLabel,
    calories,
    proteinG,
    fatG,
    carbG,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MealPlanMeal &&
          other.id == this.id &&
          other.templateId == this.templateId &&
          other.sortOrder == this.sortOrder &&
          other.mealLabel == this.mealLabel &&
          other.calories == this.calories &&
          other.proteinG == this.proteinG &&
          other.fatG == this.fatG &&
          other.carbG == this.carbG);
}

class MealPlanMealsCompanion extends UpdateCompanion<MealPlanMeal> {
  final Value<int> id;
  final Value<int> templateId;
  final Value<int> sortOrder;
  final Value<String> mealLabel;
  final Value<double?> calories;
  final Value<double?> proteinG;
  final Value<double?> fatG;
  final Value<double?> carbG;
  const MealPlanMealsCompanion({
    this.id = const Value.absent(),
    this.templateId = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.mealLabel = const Value.absent(),
    this.calories = const Value.absent(),
    this.proteinG = const Value.absent(),
    this.fatG = const Value.absent(),
    this.carbG = const Value.absent(),
  });
  MealPlanMealsCompanion.insert({
    this.id = const Value.absent(),
    required int templateId,
    required int sortOrder,
    required String mealLabel,
    this.calories = const Value.absent(),
    this.proteinG = const Value.absent(),
    this.fatG = const Value.absent(),
    this.carbG = const Value.absent(),
  }) : templateId = Value(templateId),
       sortOrder = Value(sortOrder),
       mealLabel = Value(mealLabel);
  static Insertable<MealPlanMeal> custom({
    Expression<int>? id,
    Expression<int>? templateId,
    Expression<int>? sortOrder,
    Expression<String>? mealLabel,
    Expression<double>? calories,
    Expression<double>? proteinG,
    Expression<double>? fatG,
    Expression<double>? carbG,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (templateId != null) 'template_id': templateId,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (mealLabel != null) 'meal_label': mealLabel,
      if (calories != null) 'calories': calories,
      if (proteinG != null) 'protein_g': proteinG,
      if (fatG != null) 'fat_g': fatG,
      if (carbG != null) 'carb_g': carbG,
    });
  }

  MealPlanMealsCompanion copyWith({
    Value<int>? id,
    Value<int>? templateId,
    Value<int>? sortOrder,
    Value<String>? mealLabel,
    Value<double?>? calories,
    Value<double?>? proteinG,
    Value<double?>? fatG,
    Value<double?>? carbG,
  }) {
    return MealPlanMealsCompanion(
      id: id ?? this.id,
      templateId: templateId ?? this.templateId,
      sortOrder: sortOrder ?? this.sortOrder,
      mealLabel: mealLabel ?? this.mealLabel,
      calories: calories ?? this.calories,
      proteinG: proteinG ?? this.proteinG,
      fatG: fatG ?? this.fatG,
      carbG: carbG ?? this.carbG,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (templateId.present) {
      map['template_id'] = Variable<int>(templateId.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (mealLabel.present) {
      map['meal_label'] = Variable<String>(mealLabel.value);
    }
    if (calories.present) {
      map['calories'] = Variable<double>(calories.value);
    }
    if (proteinG.present) {
      map['protein_g'] = Variable<double>(proteinG.value);
    }
    if (fatG.present) {
      map['fat_g'] = Variable<double>(fatG.value);
    }
    if (carbG.present) {
      map['carb_g'] = Variable<double>(carbG.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MealPlanMealsCompanion(')
          ..write('id: $id, ')
          ..write('templateId: $templateId, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('mealLabel: $mealLabel, ')
          ..write('calories: $calories, ')
          ..write('proteinG: $proteinG, ')
          ..write('fatG: $fatG, ')
          ..write('carbG: $carbG')
          ..write(')'))
        .toString();
  }
}

class $MealPlanLinesTable extends MealPlanLines
    with TableInfo<$MealPlanLinesTable, MealPlanLine> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MealPlanLinesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _mealIdMeta = const VerificationMeta('mealId');
  @override
  late final GeneratedColumn<int> mealId = GeneratedColumn<int>(
    'meal_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES meal_plan_meals (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lineTypeMeta = const VerificationMeta(
    'lineType',
  );
  @override
  late final GeneratedColumn<String> lineType = GeneratedColumn<String>(
    'line_type',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 32),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountGramsMeta = const VerificationMeta(
    'amountGrams',
  );
  @override
  late final GeneratedColumn<double> amountGrams = GeneratedColumn<double>(
    'amount_grams',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _amountTextMeta = const VerificationMeta(
    'amountText',
  );
  @override
  late final GeneratedColumn<String> amountText = GeneratedColumn<String>(
    'amount_text',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    mealId,
    sortOrder,
    lineType,
    content,
    amountGrams,
    amountText,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'meal_plan_lines';
  @override
  VerificationContext validateIntegrity(
    Insertable<MealPlanLine> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('meal_id')) {
      context.handle(
        _mealIdMeta,
        mealId.isAcceptableOrUnknown(data['meal_id']!, _mealIdMeta),
      );
    } else if (isInserting) {
      context.missing(_mealIdMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    if (data.containsKey('line_type')) {
      context.handle(
        _lineTypeMeta,
        lineType.isAcceptableOrUnknown(data['line_type']!, _lineTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_lineTypeMeta);
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('amount_grams')) {
      context.handle(
        _amountGramsMeta,
        amountGrams.isAcceptableOrUnknown(
          data['amount_grams']!,
          _amountGramsMeta,
        ),
      );
    }
    if (data.containsKey('amount_text')) {
      context.handle(
        _amountTextMeta,
        amountText.isAcceptableOrUnknown(data['amount_text']!, _amountTextMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MealPlanLine map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MealPlanLine(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      mealId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}meal_id'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      lineType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}line_type'],
      )!,
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      )!,
      amountGrams: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount_grams'],
      ),
      amountText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}amount_text'],
      ),
    );
  }

  @override
  $MealPlanLinesTable createAlias(String alias) {
    return $MealPlanLinesTable(attachedDatabase, alias);
  }
}

class MealPlanLine extends DataClass implements Insertable<MealPlanLine> {
  final int id;
  final int mealId;
  final int sortOrder;

  /// dish_title | ingredient | note
  final String lineType;
  final String content;
  final double? amountGrams;
  final String? amountText;
  const MealPlanLine({
    required this.id,
    required this.mealId,
    required this.sortOrder,
    required this.lineType,
    required this.content,
    this.amountGrams,
    this.amountText,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['meal_id'] = Variable<int>(mealId);
    map['sort_order'] = Variable<int>(sortOrder);
    map['line_type'] = Variable<String>(lineType);
    map['content'] = Variable<String>(content);
    if (!nullToAbsent || amountGrams != null) {
      map['amount_grams'] = Variable<double>(amountGrams);
    }
    if (!nullToAbsent || amountText != null) {
      map['amount_text'] = Variable<String>(amountText);
    }
    return map;
  }

  MealPlanLinesCompanion toCompanion(bool nullToAbsent) {
    return MealPlanLinesCompanion(
      id: Value(id),
      mealId: Value(mealId),
      sortOrder: Value(sortOrder),
      lineType: Value(lineType),
      content: Value(content),
      amountGrams: amountGrams == null && nullToAbsent
          ? const Value.absent()
          : Value(amountGrams),
      amountText: amountText == null && nullToAbsent
          ? const Value.absent()
          : Value(amountText),
    );
  }

  factory MealPlanLine.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MealPlanLine(
      id: serializer.fromJson<int>(json['id']),
      mealId: serializer.fromJson<int>(json['mealId']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      lineType: serializer.fromJson<String>(json['lineType']),
      content: serializer.fromJson<String>(json['content']),
      amountGrams: serializer.fromJson<double?>(json['amountGrams']),
      amountText: serializer.fromJson<String?>(json['amountText']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'mealId': serializer.toJson<int>(mealId),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'lineType': serializer.toJson<String>(lineType),
      'content': serializer.toJson<String>(content),
      'amountGrams': serializer.toJson<double?>(amountGrams),
      'amountText': serializer.toJson<String?>(amountText),
    };
  }

  MealPlanLine copyWith({
    int? id,
    int? mealId,
    int? sortOrder,
    String? lineType,
    String? content,
    Value<double?> amountGrams = const Value.absent(),
    Value<String?> amountText = const Value.absent(),
  }) => MealPlanLine(
    id: id ?? this.id,
    mealId: mealId ?? this.mealId,
    sortOrder: sortOrder ?? this.sortOrder,
    lineType: lineType ?? this.lineType,
    content: content ?? this.content,
    amountGrams: amountGrams.present ? amountGrams.value : this.amountGrams,
    amountText: amountText.present ? amountText.value : this.amountText,
  );
  MealPlanLine copyWithCompanion(MealPlanLinesCompanion data) {
    return MealPlanLine(
      id: data.id.present ? data.id.value : this.id,
      mealId: data.mealId.present ? data.mealId.value : this.mealId,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      lineType: data.lineType.present ? data.lineType.value : this.lineType,
      content: data.content.present ? data.content.value : this.content,
      amountGrams: data.amountGrams.present
          ? data.amountGrams.value
          : this.amountGrams,
      amountText: data.amountText.present
          ? data.amountText.value
          : this.amountText,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MealPlanLine(')
          ..write('id: $id, ')
          ..write('mealId: $mealId, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('lineType: $lineType, ')
          ..write('content: $content, ')
          ..write('amountGrams: $amountGrams, ')
          ..write('amountText: $amountText')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    mealId,
    sortOrder,
    lineType,
    content,
    amountGrams,
    amountText,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MealPlanLine &&
          other.id == this.id &&
          other.mealId == this.mealId &&
          other.sortOrder == this.sortOrder &&
          other.lineType == this.lineType &&
          other.content == this.content &&
          other.amountGrams == this.amountGrams &&
          other.amountText == this.amountText);
}

class MealPlanLinesCompanion extends UpdateCompanion<MealPlanLine> {
  final Value<int> id;
  final Value<int> mealId;
  final Value<int> sortOrder;
  final Value<String> lineType;
  final Value<String> content;
  final Value<double?> amountGrams;
  final Value<String?> amountText;
  const MealPlanLinesCompanion({
    this.id = const Value.absent(),
    this.mealId = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.lineType = const Value.absent(),
    this.content = const Value.absent(),
    this.amountGrams = const Value.absent(),
    this.amountText = const Value.absent(),
  });
  MealPlanLinesCompanion.insert({
    this.id = const Value.absent(),
    required int mealId,
    required int sortOrder,
    required String lineType,
    required String content,
    this.amountGrams = const Value.absent(),
    this.amountText = const Value.absent(),
  }) : mealId = Value(mealId),
       sortOrder = Value(sortOrder),
       lineType = Value(lineType),
       content = Value(content);
  static Insertable<MealPlanLine> custom({
    Expression<int>? id,
    Expression<int>? mealId,
    Expression<int>? sortOrder,
    Expression<String>? lineType,
    Expression<String>? content,
    Expression<double>? amountGrams,
    Expression<String>? amountText,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (mealId != null) 'meal_id': mealId,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (lineType != null) 'line_type': lineType,
      if (content != null) 'content': content,
      if (amountGrams != null) 'amount_grams': amountGrams,
      if (amountText != null) 'amount_text': amountText,
    });
  }

  MealPlanLinesCompanion copyWith({
    Value<int>? id,
    Value<int>? mealId,
    Value<int>? sortOrder,
    Value<String>? lineType,
    Value<String>? content,
    Value<double?>? amountGrams,
    Value<String?>? amountText,
  }) {
    return MealPlanLinesCompanion(
      id: id ?? this.id,
      mealId: mealId ?? this.mealId,
      sortOrder: sortOrder ?? this.sortOrder,
      lineType: lineType ?? this.lineType,
      content: content ?? this.content,
      amountGrams: amountGrams ?? this.amountGrams,
      amountText: amountText ?? this.amountText,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (mealId.present) {
      map['meal_id'] = Variable<int>(mealId.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (lineType.present) {
      map['line_type'] = Variable<String>(lineType.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (amountGrams.present) {
      map['amount_grams'] = Variable<double>(amountGrams.value);
    }
    if (amountText.present) {
      map['amount_text'] = Variable<String>(amountText.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MealPlanLinesCompanion(')
          ..write('id: $id, ')
          ..write('mealId: $mealId, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('lineType: $lineType, ')
          ..write('content: $content, ')
          ..write('amountGrams: $amountGrams, ')
          ..write('amountText: $amountText')
          ..write(')'))
        .toString();
  }
}

class $PdfMealPlansTable extends PdfMealPlans
    with TableInfo<$PdfMealPlansTable, PdfMealPlan> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PdfMealPlansTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceFileNameMeta = const VerificationMeta(
    'sourceFileName',
  );
  @override
  late final GeneratedColumn<String> sourceFileName = GeneratedColumn<String>(
    'source_file_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sourceTypeMeta = const VerificationMeta(
    'sourceType',
  );
  @override
  late final GeneratedColumn<String> sourceType = GeneratedColumn<String>(
    'source_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pdf'),
  );
  static const VerificationMeta _authorMeta = const VerificationMeta('author');
  @override
  late final GeneratedColumn<String> author = GeneratedColumn<String>(
    'author',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _daysCountMeta = const VerificationMeta(
    'daysCount',
  );
  @override
  late final GeneratedColumn<int> daysCount = GeneratedColumn<int>(
    'days_count',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _rawSourceReferenceMeta =
      const VerificationMeta('rawSourceReference');
  @override
  late final GeneratedColumn<String> rawSourceReference =
      GeneratedColumn<String>(
        'raw_source_reference',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    sourceFileName,
    sourceType,
    author,
    description,
    daysCount,
    notes,
    rawSourceReference,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'meal_plans';
  @override
  VerificationContext validateIntegrity(
    Insertable<PdfMealPlan> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('source_file_name')) {
      context.handle(
        _sourceFileNameMeta,
        sourceFileName.isAcceptableOrUnknown(
          data['source_file_name']!,
          _sourceFileNameMeta,
        ),
      );
    }
    if (data.containsKey('source_type')) {
      context.handle(
        _sourceTypeMeta,
        sourceType.isAcceptableOrUnknown(data['source_type']!, _sourceTypeMeta),
      );
    }
    if (data.containsKey('author')) {
      context.handle(
        _authorMeta,
        author.isAcceptableOrUnknown(data['author']!, _authorMeta),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('days_count')) {
      context.handle(
        _daysCountMeta,
        daysCount.isAcceptableOrUnknown(data['days_count']!, _daysCountMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('raw_source_reference')) {
      context.handle(
        _rawSourceReferenceMeta,
        rawSourceReference.isAcceptableOrUnknown(
          data['raw_source_reference']!,
          _rawSourceReferenceMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PdfMealPlan map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PdfMealPlan(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      sourceFileName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_file_name'],
      ),
      sourceType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_type'],
      )!,
      author: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}author'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      daysCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}days_count'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      rawSourceReference: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}raw_source_reference'],
      ),
    );
  }

  @override
  $PdfMealPlansTable createAlias(String alias) {
    return $PdfMealPlansTable(attachedDatabase, alias);
  }
}

class PdfMealPlan extends DataClass implements Insertable<PdfMealPlan> {
  final int id;
  final String title;
  final String? sourceFileName;
  final String sourceType;
  final String? author;
  final String? description;
  final int? daysCount;
  final String? notes;
  final String? rawSourceReference;
  const PdfMealPlan({
    required this.id,
    required this.title,
    this.sourceFileName,
    required this.sourceType,
    this.author,
    this.description,
    this.daysCount,
    this.notes,
    this.rawSourceReference,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || sourceFileName != null) {
      map['source_file_name'] = Variable<String>(sourceFileName);
    }
    map['source_type'] = Variable<String>(sourceType);
    if (!nullToAbsent || author != null) {
      map['author'] = Variable<String>(author);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || daysCount != null) {
      map['days_count'] = Variable<int>(daysCount);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || rawSourceReference != null) {
      map['raw_source_reference'] = Variable<String>(rawSourceReference);
    }
    return map;
  }

  PdfMealPlansCompanion toCompanion(bool nullToAbsent) {
    return PdfMealPlansCompanion(
      id: Value(id),
      title: Value(title),
      sourceFileName: sourceFileName == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceFileName),
      sourceType: Value(sourceType),
      author: author == null && nullToAbsent
          ? const Value.absent()
          : Value(author),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      daysCount: daysCount == null && nullToAbsent
          ? const Value.absent()
          : Value(daysCount),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      rawSourceReference: rawSourceReference == null && nullToAbsent
          ? const Value.absent()
          : Value(rawSourceReference),
    );
  }

  factory PdfMealPlan.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PdfMealPlan(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      sourceFileName: serializer.fromJson<String?>(json['sourceFileName']),
      sourceType: serializer.fromJson<String>(json['sourceType']),
      author: serializer.fromJson<String?>(json['author']),
      description: serializer.fromJson<String?>(json['description']),
      daysCount: serializer.fromJson<int?>(json['daysCount']),
      notes: serializer.fromJson<String?>(json['notes']),
      rawSourceReference: serializer.fromJson<String?>(
        json['rawSourceReference'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'sourceFileName': serializer.toJson<String?>(sourceFileName),
      'sourceType': serializer.toJson<String>(sourceType),
      'author': serializer.toJson<String?>(author),
      'description': serializer.toJson<String?>(description),
      'daysCount': serializer.toJson<int?>(daysCount),
      'notes': serializer.toJson<String?>(notes),
      'rawSourceReference': serializer.toJson<String?>(rawSourceReference),
    };
  }

  PdfMealPlan copyWith({
    int? id,
    String? title,
    Value<String?> sourceFileName = const Value.absent(),
    String? sourceType,
    Value<String?> author = const Value.absent(),
    Value<String?> description = const Value.absent(),
    Value<int?> daysCount = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    Value<String?> rawSourceReference = const Value.absent(),
  }) => PdfMealPlan(
    id: id ?? this.id,
    title: title ?? this.title,
    sourceFileName: sourceFileName.present
        ? sourceFileName.value
        : this.sourceFileName,
    sourceType: sourceType ?? this.sourceType,
    author: author.present ? author.value : this.author,
    description: description.present ? description.value : this.description,
    daysCount: daysCount.present ? daysCount.value : this.daysCount,
    notes: notes.present ? notes.value : this.notes,
    rawSourceReference: rawSourceReference.present
        ? rawSourceReference.value
        : this.rawSourceReference,
  );
  PdfMealPlan copyWithCompanion(PdfMealPlansCompanion data) {
    return PdfMealPlan(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      sourceFileName: data.sourceFileName.present
          ? data.sourceFileName.value
          : this.sourceFileName,
      sourceType: data.sourceType.present
          ? data.sourceType.value
          : this.sourceType,
      author: data.author.present ? data.author.value : this.author,
      description: data.description.present
          ? data.description.value
          : this.description,
      daysCount: data.daysCount.present ? data.daysCount.value : this.daysCount,
      notes: data.notes.present ? data.notes.value : this.notes,
      rawSourceReference: data.rawSourceReference.present
          ? data.rawSourceReference.value
          : this.rawSourceReference,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PdfMealPlan(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('sourceFileName: $sourceFileName, ')
          ..write('sourceType: $sourceType, ')
          ..write('author: $author, ')
          ..write('description: $description, ')
          ..write('daysCount: $daysCount, ')
          ..write('notes: $notes, ')
          ..write('rawSourceReference: $rawSourceReference')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    sourceFileName,
    sourceType,
    author,
    description,
    daysCount,
    notes,
    rawSourceReference,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PdfMealPlan &&
          other.id == this.id &&
          other.title == this.title &&
          other.sourceFileName == this.sourceFileName &&
          other.sourceType == this.sourceType &&
          other.author == this.author &&
          other.description == this.description &&
          other.daysCount == this.daysCount &&
          other.notes == this.notes &&
          other.rawSourceReference == this.rawSourceReference);
}

class PdfMealPlansCompanion extends UpdateCompanion<PdfMealPlan> {
  final Value<int> id;
  final Value<String> title;
  final Value<String?> sourceFileName;
  final Value<String> sourceType;
  final Value<String?> author;
  final Value<String?> description;
  final Value<int?> daysCount;
  final Value<String?> notes;
  final Value<String?> rawSourceReference;
  const PdfMealPlansCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.sourceFileName = const Value.absent(),
    this.sourceType = const Value.absent(),
    this.author = const Value.absent(),
    this.description = const Value.absent(),
    this.daysCount = const Value.absent(),
    this.notes = const Value.absent(),
    this.rawSourceReference = const Value.absent(),
  });
  PdfMealPlansCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.sourceFileName = const Value.absent(),
    this.sourceType = const Value.absent(),
    this.author = const Value.absent(),
    this.description = const Value.absent(),
    this.daysCount = const Value.absent(),
    this.notes = const Value.absent(),
    this.rawSourceReference = const Value.absent(),
  }) : title = Value(title);
  static Insertable<PdfMealPlan> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? sourceFileName,
    Expression<String>? sourceType,
    Expression<String>? author,
    Expression<String>? description,
    Expression<int>? daysCount,
    Expression<String>? notes,
    Expression<String>? rawSourceReference,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (sourceFileName != null) 'source_file_name': sourceFileName,
      if (sourceType != null) 'source_type': sourceType,
      if (author != null) 'author': author,
      if (description != null) 'description': description,
      if (daysCount != null) 'days_count': daysCount,
      if (notes != null) 'notes': notes,
      if (rawSourceReference != null)
        'raw_source_reference': rawSourceReference,
    });
  }

  PdfMealPlansCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<String?>? sourceFileName,
    Value<String>? sourceType,
    Value<String?>? author,
    Value<String?>? description,
    Value<int?>? daysCount,
    Value<String?>? notes,
    Value<String?>? rawSourceReference,
  }) {
    return PdfMealPlansCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      sourceFileName: sourceFileName ?? this.sourceFileName,
      sourceType: sourceType ?? this.sourceType,
      author: author ?? this.author,
      description: description ?? this.description,
      daysCount: daysCount ?? this.daysCount,
      notes: notes ?? this.notes,
      rawSourceReference: rawSourceReference ?? this.rawSourceReference,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (sourceFileName.present) {
      map['source_file_name'] = Variable<String>(sourceFileName.value);
    }
    if (sourceType.present) {
      map['source_type'] = Variable<String>(sourceType.value);
    }
    if (author.present) {
      map['author'] = Variable<String>(author.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (daysCount.present) {
      map['days_count'] = Variable<int>(daysCount.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rawSourceReference.present) {
      map['raw_source_reference'] = Variable<String>(rawSourceReference.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PdfMealPlansCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('sourceFileName: $sourceFileName, ')
          ..write('sourceType: $sourceType, ')
          ..write('author: $author, ')
          ..write('description: $description, ')
          ..write('daysCount: $daysCount, ')
          ..write('notes: $notes, ')
          ..write('rawSourceReference: $rawSourceReference')
          ..write(')'))
        .toString();
  }
}

class $PdfMealPlanDaysTable extends PdfMealPlanDays
    with TableInfo<$PdfMealPlanDaysTable, PdfMealPlanDay> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PdfMealPlanDaysTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _mealPlanIdMeta = const VerificationMeta(
    'mealPlanId',
  );
  @override
  late final GeneratedColumn<int> mealPlanId = GeneratedColumn<int>(
    'meal_plan_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES meal_plans (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _dayNumberMeta = const VerificationMeta(
    'dayNumber',
  );
  @override
  late final GeneratedColumn<int> dayNumber = GeneratedColumn<int>(
    'day_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dailyKcalMeta = const VerificationMeta(
    'dailyKcal',
  );
  @override
  late final GeneratedColumn<double> dailyKcal = GeneratedColumn<double>(
    'daily_kcal',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dailyProteinMeta = const VerificationMeta(
    'dailyProtein',
  );
  @override
  late final GeneratedColumn<double> dailyProtein = GeneratedColumn<double>(
    'daily_protein',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dailyFatMeta = const VerificationMeta(
    'dailyFat',
  );
  @override
  late final GeneratedColumn<double> dailyFat = GeneratedColumn<double>(
    'daily_fat',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dailyCarbsMeta = const VerificationMeta(
    'dailyCarbs',
  );
  @override
  late final GeneratedColumn<double> dailyCarbs = GeneratedColumn<double>(
    'daily_carbs',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    mealPlanId,
    dayNumber,
    title,
    dailyKcal,
    dailyProtein,
    dailyFat,
    dailyCarbs,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'meal_plan_days';
  @override
  VerificationContext validateIntegrity(
    Insertable<PdfMealPlanDay> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('meal_plan_id')) {
      context.handle(
        _mealPlanIdMeta,
        mealPlanId.isAcceptableOrUnknown(
          data['meal_plan_id']!,
          _mealPlanIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_mealPlanIdMeta);
    }
    if (data.containsKey('day_number')) {
      context.handle(
        _dayNumberMeta,
        dayNumber.isAcceptableOrUnknown(data['day_number']!, _dayNumberMeta),
      );
    } else if (isInserting) {
      context.missing(_dayNumberMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    }
    if (data.containsKey('daily_kcal')) {
      context.handle(
        _dailyKcalMeta,
        dailyKcal.isAcceptableOrUnknown(data['daily_kcal']!, _dailyKcalMeta),
      );
    }
    if (data.containsKey('daily_protein')) {
      context.handle(
        _dailyProteinMeta,
        dailyProtein.isAcceptableOrUnknown(
          data['daily_protein']!,
          _dailyProteinMeta,
        ),
      );
    }
    if (data.containsKey('daily_fat')) {
      context.handle(
        _dailyFatMeta,
        dailyFat.isAcceptableOrUnknown(data['daily_fat']!, _dailyFatMeta),
      );
    }
    if (data.containsKey('daily_carbs')) {
      context.handle(
        _dailyCarbsMeta,
        dailyCarbs.isAcceptableOrUnknown(data['daily_carbs']!, _dailyCarbsMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {mealPlanId, dayNumber},
  ];
  @override
  PdfMealPlanDay map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PdfMealPlanDay(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      mealPlanId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}meal_plan_id'],
      )!,
      dayNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}day_number'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      ),
      dailyKcal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}daily_kcal'],
      ),
      dailyProtein: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}daily_protein'],
      ),
      dailyFat: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}daily_fat'],
      ),
      dailyCarbs: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}daily_carbs'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $PdfMealPlanDaysTable createAlias(String alias) {
    return $PdfMealPlanDaysTable(attachedDatabase, alias);
  }
}

class PdfMealPlanDay extends DataClass implements Insertable<PdfMealPlanDay> {
  final int id;
  final int mealPlanId;
  final int dayNumber;
  final String? title;
  final double? dailyKcal;
  final double? dailyProtein;
  final double? dailyFat;
  final double? dailyCarbs;
  final String? notes;
  const PdfMealPlanDay({
    required this.id,
    required this.mealPlanId,
    required this.dayNumber,
    this.title,
    this.dailyKcal,
    this.dailyProtein,
    this.dailyFat,
    this.dailyCarbs,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['meal_plan_id'] = Variable<int>(mealPlanId);
    map['day_number'] = Variable<int>(dayNumber);
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || dailyKcal != null) {
      map['daily_kcal'] = Variable<double>(dailyKcal);
    }
    if (!nullToAbsent || dailyProtein != null) {
      map['daily_protein'] = Variable<double>(dailyProtein);
    }
    if (!nullToAbsent || dailyFat != null) {
      map['daily_fat'] = Variable<double>(dailyFat);
    }
    if (!nullToAbsent || dailyCarbs != null) {
      map['daily_carbs'] = Variable<double>(dailyCarbs);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  PdfMealPlanDaysCompanion toCompanion(bool nullToAbsent) {
    return PdfMealPlanDaysCompanion(
      id: Value(id),
      mealPlanId: Value(mealPlanId),
      dayNumber: Value(dayNumber),
      title: title == null && nullToAbsent
          ? const Value.absent()
          : Value(title),
      dailyKcal: dailyKcal == null && nullToAbsent
          ? const Value.absent()
          : Value(dailyKcal),
      dailyProtein: dailyProtein == null && nullToAbsent
          ? const Value.absent()
          : Value(dailyProtein),
      dailyFat: dailyFat == null && nullToAbsent
          ? const Value.absent()
          : Value(dailyFat),
      dailyCarbs: dailyCarbs == null && nullToAbsent
          ? const Value.absent()
          : Value(dailyCarbs),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory PdfMealPlanDay.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PdfMealPlanDay(
      id: serializer.fromJson<int>(json['id']),
      mealPlanId: serializer.fromJson<int>(json['mealPlanId']),
      dayNumber: serializer.fromJson<int>(json['dayNumber']),
      title: serializer.fromJson<String?>(json['title']),
      dailyKcal: serializer.fromJson<double?>(json['dailyKcal']),
      dailyProtein: serializer.fromJson<double?>(json['dailyProtein']),
      dailyFat: serializer.fromJson<double?>(json['dailyFat']),
      dailyCarbs: serializer.fromJson<double?>(json['dailyCarbs']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'mealPlanId': serializer.toJson<int>(mealPlanId),
      'dayNumber': serializer.toJson<int>(dayNumber),
      'title': serializer.toJson<String?>(title),
      'dailyKcal': serializer.toJson<double?>(dailyKcal),
      'dailyProtein': serializer.toJson<double?>(dailyProtein),
      'dailyFat': serializer.toJson<double?>(dailyFat),
      'dailyCarbs': serializer.toJson<double?>(dailyCarbs),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  PdfMealPlanDay copyWith({
    int? id,
    int? mealPlanId,
    int? dayNumber,
    Value<String?> title = const Value.absent(),
    Value<double?> dailyKcal = const Value.absent(),
    Value<double?> dailyProtein = const Value.absent(),
    Value<double?> dailyFat = const Value.absent(),
    Value<double?> dailyCarbs = const Value.absent(),
    Value<String?> notes = const Value.absent(),
  }) => PdfMealPlanDay(
    id: id ?? this.id,
    mealPlanId: mealPlanId ?? this.mealPlanId,
    dayNumber: dayNumber ?? this.dayNumber,
    title: title.present ? title.value : this.title,
    dailyKcal: dailyKcal.present ? dailyKcal.value : this.dailyKcal,
    dailyProtein: dailyProtein.present ? dailyProtein.value : this.dailyProtein,
    dailyFat: dailyFat.present ? dailyFat.value : this.dailyFat,
    dailyCarbs: dailyCarbs.present ? dailyCarbs.value : this.dailyCarbs,
    notes: notes.present ? notes.value : this.notes,
  );
  PdfMealPlanDay copyWithCompanion(PdfMealPlanDaysCompanion data) {
    return PdfMealPlanDay(
      id: data.id.present ? data.id.value : this.id,
      mealPlanId: data.mealPlanId.present
          ? data.mealPlanId.value
          : this.mealPlanId,
      dayNumber: data.dayNumber.present ? data.dayNumber.value : this.dayNumber,
      title: data.title.present ? data.title.value : this.title,
      dailyKcal: data.dailyKcal.present ? data.dailyKcal.value : this.dailyKcal,
      dailyProtein: data.dailyProtein.present
          ? data.dailyProtein.value
          : this.dailyProtein,
      dailyFat: data.dailyFat.present ? data.dailyFat.value : this.dailyFat,
      dailyCarbs: data.dailyCarbs.present
          ? data.dailyCarbs.value
          : this.dailyCarbs,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PdfMealPlanDay(')
          ..write('id: $id, ')
          ..write('mealPlanId: $mealPlanId, ')
          ..write('dayNumber: $dayNumber, ')
          ..write('title: $title, ')
          ..write('dailyKcal: $dailyKcal, ')
          ..write('dailyProtein: $dailyProtein, ')
          ..write('dailyFat: $dailyFat, ')
          ..write('dailyCarbs: $dailyCarbs, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    mealPlanId,
    dayNumber,
    title,
    dailyKcal,
    dailyProtein,
    dailyFat,
    dailyCarbs,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PdfMealPlanDay &&
          other.id == this.id &&
          other.mealPlanId == this.mealPlanId &&
          other.dayNumber == this.dayNumber &&
          other.title == this.title &&
          other.dailyKcal == this.dailyKcal &&
          other.dailyProtein == this.dailyProtein &&
          other.dailyFat == this.dailyFat &&
          other.dailyCarbs == this.dailyCarbs &&
          other.notes == this.notes);
}

class PdfMealPlanDaysCompanion extends UpdateCompanion<PdfMealPlanDay> {
  final Value<int> id;
  final Value<int> mealPlanId;
  final Value<int> dayNumber;
  final Value<String?> title;
  final Value<double?> dailyKcal;
  final Value<double?> dailyProtein;
  final Value<double?> dailyFat;
  final Value<double?> dailyCarbs;
  final Value<String?> notes;
  const PdfMealPlanDaysCompanion({
    this.id = const Value.absent(),
    this.mealPlanId = const Value.absent(),
    this.dayNumber = const Value.absent(),
    this.title = const Value.absent(),
    this.dailyKcal = const Value.absent(),
    this.dailyProtein = const Value.absent(),
    this.dailyFat = const Value.absent(),
    this.dailyCarbs = const Value.absent(),
    this.notes = const Value.absent(),
  });
  PdfMealPlanDaysCompanion.insert({
    this.id = const Value.absent(),
    required int mealPlanId,
    required int dayNumber,
    this.title = const Value.absent(),
    this.dailyKcal = const Value.absent(),
    this.dailyProtein = const Value.absent(),
    this.dailyFat = const Value.absent(),
    this.dailyCarbs = const Value.absent(),
    this.notes = const Value.absent(),
  }) : mealPlanId = Value(mealPlanId),
       dayNumber = Value(dayNumber);
  static Insertable<PdfMealPlanDay> custom({
    Expression<int>? id,
    Expression<int>? mealPlanId,
    Expression<int>? dayNumber,
    Expression<String>? title,
    Expression<double>? dailyKcal,
    Expression<double>? dailyProtein,
    Expression<double>? dailyFat,
    Expression<double>? dailyCarbs,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (mealPlanId != null) 'meal_plan_id': mealPlanId,
      if (dayNumber != null) 'day_number': dayNumber,
      if (title != null) 'title': title,
      if (dailyKcal != null) 'daily_kcal': dailyKcal,
      if (dailyProtein != null) 'daily_protein': dailyProtein,
      if (dailyFat != null) 'daily_fat': dailyFat,
      if (dailyCarbs != null) 'daily_carbs': dailyCarbs,
      if (notes != null) 'notes': notes,
    });
  }

  PdfMealPlanDaysCompanion copyWith({
    Value<int>? id,
    Value<int>? mealPlanId,
    Value<int>? dayNumber,
    Value<String?>? title,
    Value<double?>? dailyKcal,
    Value<double?>? dailyProtein,
    Value<double?>? dailyFat,
    Value<double?>? dailyCarbs,
    Value<String?>? notes,
  }) {
    return PdfMealPlanDaysCompanion(
      id: id ?? this.id,
      mealPlanId: mealPlanId ?? this.mealPlanId,
      dayNumber: dayNumber ?? this.dayNumber,
      title: title ?? this.title,
      dailyKcal: dailyKcal ?? this.dailyKcal,
      dailyProtein: dailyProtein ?? this.dailyProtein,
      dailyFat: dailyFat ?? this.dailyFat,
      dailyCarbs: dailyCarbs ?? this.dailyCarbs,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (mealPlanId.present) {
      map['meal_plan_id'] = Variable<int>(mealPlanId.value);
    }
    if (dayNumber.present) {
      map['day_number'] = Variable<int>(dayNumber.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (dailyKcal.present) {
      map['daily_kcal'] = Variable<double>(dailyKcal.value);
    }
    if (dailyProtein.present) {
      map['daily_protein'] = Variable<double>(dailyProtein.value);
    }
    if (dailyFat.present) {
      map['daily_fat'] = Variable<double>(dailyFat.value);
    }
    if (dailyCarbs.present) {
      map['daily_carbs'] = Variable<double>(dailyCarbs.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PdfMealPlanDaysCompanion(')
          ..write('id: $id, ')
          ..write('mealPlanId: $mealPlanId, ')
          ..write('dayNumber: $dayNumber, ')
          ..write('title: $title, ')
          ..write('dailyKcal: $dailyKcal, ')
          ..write('dailyProtein: $dailyProtein, ')
          ..write('dailyFat: $dailyFat, ')
          ..write('dailyCarbs: $dailyCarbs, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

class $PdfRecipesTable extends PdfRecipes
    with TableInfo<$PdfRecipesTable, PdfRecipe> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PdfRecipesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _canonicalNameMeta = const VerificationMeta(
    'canonicalName',
  );
  @override
  late final GeneratedColumn<String> canonicalName = GeneratedColumn<String>(
    'canonical_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _normalizedNameMeta = const VerificationMeta(
    'normalizedName',
  );
  @override
  late final GeneratedColumn<String> normalizedName = GeneratedColumn<String>(
    'normalized_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _recipeTypeMeta = const VerificationMeta(
    'recipeType',
  );
  @override
  late final GeneratedColumn<String> recipeType = GeneratedColumn<String>(
    'recipe_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _defaultServingsMeta = const VerificationMeta(
    'defaultServings',
  );
  @override
  late final GeneratedColumn<double> defaultServings = GeneratedColumn<double>(
    'default_servings',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _yieldServingsMeta = const VerificationMeta(
    'yieldServings',
  );
  @override
  late final GeneratedColumn<double> yieldServings = GeneratedColumn<double>(
    'yield_servings',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _yieldTextMeta = const VerificationMeta(
    'yieldText',
  );
  @override
  late final GeneratedColumn<String> yieldText = GeneratedColumn<String>(
    'yield_text',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cookTimeMinutesMeta = const VerificationMeta(
    'cookTimeMinutes',
  );
  @override
  late final GeneratedColumn<int> cookTimeMinutes = GeneratedColumn<int>(
    'cook_time_minutes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _prepTimeMinutesMeta = const VerificationMeta(
    'prepTimeMinutes',
  );
  @override
  late final GeneratedColumn<int> prepTimeMinutes = GeneratedColumn<int>(
    'prep_time_minutes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _totalTimeMinutesMeta = const VerificationMeta(
    'totalTimeMinutes',
  );
  @override
  late final GeneratedColumn<int> totalTimeMinutes = GeneratedColumn<int>(
    'total_time_minutes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _difficultyMeta = const VerificationMeta(
    'difficulty',
  );
  @override
  late final GeneratedColumn<String> difficulty = GeneratedColumn<String>(
    'difficulty',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sourceTypeMeta = const VerificationMeta(
    'sourceType',
  );
  @override
  late final GeneratedColumn<String> sourceType = GeneratedColumn<String>(
    'source_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sourceTitleMeta = const VerificationMeta(
    'sourceTitle',
  );
  @override
  late final GeneratedColumn<String> sourceTitle = GeneratedColumn<String>(
    'source_title',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sourcePageStartMeta = const VerificationMeta(
    'sourcePageStart',
  );
  @override
  late final GeneratedColumn<int> sourcePageStart = GeneratedColumn<int>(
    'source_page_start',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sourcePageEndMeta = const VerificationMeta(
    'sourcePageEnd',
  );
  @override
  late final GeneratedColumn<int> sourcePageEnd = GeneratedColumn<int>(
    'source_page_end',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isReusableMeta = const VerificationMeta(
    'isReusable',
  );
  @override
  late final GeneratedColumn<bool> isReusable = GeneratedColumn<bool>(
    'is_reusable',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_reusable" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _deduplicationKeyMeta = const VerificationMeta(
    'deduplicationKey',
  );
  @override
  late final GeneratedColumn<String> deduplicationKey = GeneratedColumn<String>(
    'deduplication_key',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    canonicalName,
    normalizedName,
    recipeType,
    description,
    defaultServings,
    yieldServings,
    yieldText,
    cookTimeMinutes,
    prepTimeMinutes,
    totalTimeMinutes,
    difficulty,
    sourceType,
    sourceTitle,
    sourcePageStart,
    sourcePageEnd,
    isReusable,
    deduplicationKey,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recipes';
  @override
  VerificationContext validateIntegrity(
    Insertable<PdfRecipe> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('canonical_name')) {
      context.handle(
        _canonicalNameMeta,
        canonicalName.isAcceptableOrUnknown(
          data['canonical_name']!,
          _canonicalNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_canonicalNameMeta);
    }
    if (data.containsKey('normalized_name')) {
      context.handle(
        _normalizedNameMeta,
        normalizedName.isAcceptableOrUnknown(
          data['normalized_name']!,
          _normalizedNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_normalizedNameMeta);
    }
    if (data.containsKey('recipe_type')) {
      context.handle(
        _recipeTypeMeta,
        recipeType.isAcceptableOrUnknown(data['recipe_type']!, _recipeTypeMeta),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('default_servings')) {
      context.handle(
        _defaultServingsMeta,
        defaultServings.isAcceptableOrUnknown(
          data['default_servings']!,
          _defaultServingsMeta,
        ),
      );
    }
    if (data.containsKey('yield_servings')) {
      context.handle(
        _yieldServingsMeta,
        yieldServings.isAcceptableOrUnknown(
          data['yield_servings']!,
          _yieldServingsMeta,
        ),
      );
    }
    if (data.containsKey('yield_text')) {
      context.handle(
        _yieldTextMeta,
        yieldText.isAcceptableOrUnknown(data['yield_text']!, _yieldTextMeta),
      );
    }
    if (data.containsKey('cook_time_minutes')) {
      context.handle(
        _cookTimeMinutesMeta,
        cookTimeMinutes.isAcceptableOrUnknown(
          data['cook_time_minutes']!,
          _cookTimeMinutesMeta,
        ),
      );
    }
    if (data.containsKey('prep_time_minutes')) {
      context.handle(
        _prepTimeMinutesMeta,
        prepTimeMinutes.isAcceptableOrUnknown(
          data['prep_time_minutes']!,
          _prepTimeMinutesMeta,
        ),
      );
    }
    if (data.containsKey('total_time_minutes')) {
      context.handle(
        _totalTimeMinutesMeta,
        totalTimeMinutes.isAcceptableOrUnknown(
          data['total_time_minutes']!,
          _totalTimeMinutesMeta,
        ),
      );
    }
    if (data.containsKey('difficulty')) {
      context.handle(
        _difficultyMeta,
        difficulty.isAcceptableOrUnknown(data['difficulty']!, _difficultyMeta),
      );
    }
    if (data.containsKey('source_type')) {
      context.handle(
        _sourceTypeMeta,
        sourceType.isAcceptableOrUnknown(data['source_type']!, _sourceTypeMeta),
      );
    }
    if (data.containsKey('source_title')) {
      context.handle(
        _sourceTitleMeta,
        sourceTitle.isAcceptableOrUnknown(
          data['source_title']!,
          _sourceTitleMeta,
        ),
      );
    }
    if (data.containsKey('source_page_start')) {
      context.handle(
        _sourcePageStartMeta,
        sourcePageStart.isAcceptableOrUnknown(
          data['source_page_start']!,
          _sourcePageStartMeta,
        ),
      );
    }
    if (data.containsKey('source_page_end')) {
      context.handle(
        _sourcePageEndMeta,
        sourcePageEnd.isAcceptableOrUnknown(
          data['source_page_end']!,
          _sourcePageEndMeta,
        ),
      );
    }
    if (data.containsKey('is_reusable')) {
      context.handle(
        _isReusableMeta,
        isReusable.isAcceptableOrUnknown(data['is_reusable']!, _isReusableMeta),
      );
    }
    if (data.containsKey('deduplication_key')) {
      context.handle(
        _deduplicationKeyMeta,
        deduplicationKey.isAcceptableOrUnknown(
          data['deduplication_key']!,
          _deduplicationKeyMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PdfRecipe map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PdfRecipe(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      canonicalName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}canonical_name'],
      )!,
      normalizedName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}normalized_name'],
      )!,
      recipeType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}recipe_type'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      defaultServings: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}default_servings'],
      ),
      yieldServings: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}yield_servings'],
      ),
      yieldText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}yield_text'],
      ),
      cookTimeMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cook_time_minutes'],
      ),
      prepTimeMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}prep_time_minutes'],
      ),
      totalTimeMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_time_minutes'],
      ),
      difficulty: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}difficulty'],
      ),
      sourceType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_type'],
      ),
      sourceTitle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_title'],
      ),
      sourcePageStart: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}source_page_start'],
      ),
      sourcePageEnd: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}source_page_end'],
      ),
      isReusable: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_reusable'],
      )!,
      deduplicationKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}deduplication_key'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $PdfRecipesTable createAlias(String alias) {
    return $PdfRecipesTable(attachedDatabase, alias);
  }
}

class PdfRecipe extends DataClass implements Insertable<PdfRecipe> {
  final int id;
  final String canonicalName;
  final String normalizedName;
  final String? recipeType;
  final String? description;
  final double? defaultServings;
  final double? yieldServings;
  final String? yieldText;
  final int? cookTimeMinutes;
  final int? prepTimeMinutes;
  final int? totalTimeMinutes;
  final String? difficulty;
  final String? sourceType;
  final String? sourceTitle;
  final int? sourcePageStart;
  final int? sourcePageEnd;
  final bool isReusable;
  final String? deduplicationKey;
  final String? notes;
  const PdfRecipe({
    required this.id,
    required this.canonicalName,
    required this.normalizedName,
    this.recipeType,
    this.description,
    this.defaultServings,
    this.yieldServings,
    this.yieldText,
    this.cookTimeMinutes,
    this.prepTimeMinutes,
    this.totalTimeMinutes,
    this.difficulty,
    this.sourceType,
    this.sourceTitle,
    this.sourcePageStart,
    this.sourcePageEnd,
    required this.isReusable,
    this.deduplicationKey,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['canonical_name'] = Variable<String>(canonicalName);
    map['normalized_name'] = Variable<String>(normalizedName);
    if (!nullToAbsent || recipeType != null) {
      map['recipe_type'] = Variable<String>(recipeType);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || defaultServings != null) {
      map['default_servings'] = Variable<double>(defaultServings);
    }
    if (!nullToAbsent || yieldServings != null) {
      map['yield_servings'] = Variable<double>(yieldServings);
    }
    if (!nullToAbsent || yieldText != null) {
      map['yield_text'] = Variable<String>(yieldText);
    }
    if (!nullToAbsent || cookTimeMinutes != null) {
      map['cook_time_minutes'] = Variable<int>(cookTimeMinutes);
    }
    if (!nullToAbsent || prepTimeMinutes != null) {
      map['prep_time_minutes'] = Variable<int>(prepTimeMinutes);
    }
    if (!nullToAbsent || totalTimeMinutes != null) {
      map['total_time_minutes'] = Variable<int>(totalTimeMinutes);
    }
    if (!nullToAbsent || difficulty != null) {
      map['difficulty'] = Variable<String>(difficulty);
    }
    if (!nullToAbsent || sourceType != null) {
      map['source_type'] = Variable<String>(sourceType);
    }
    if (!nullToAbsent || sourceTitle != null) {
      map['source_title'] = Variable<String>(sourceTitle);
    }
    if (!nullToAbsent || sourcePageStart != null) {
      map['source_page_start'] = Variable<int>(sourcePageStart);
    }
    if (!nullToAbsent || sourcePageEnd != null) {
      map['source_page_end'] = Variable<int>(sourcePageEnd);
    }
    map['is_reusable'] = Variable<bool>(isReusable);
    if (!nullToAbsent || deduplicationKey != null) {
      map['deduplication_key'] = Variable<String>(deduplicationKey);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  PdfRecipesCompanion toCompanion(bool nullToAbsent) {
    return PdfRecipesCompanion(
      id: Value(id),
      canonicalName: Value(canonicalName),
      normalizedName: Value(normalizedName),
      recipeType: recipeType == null && nullToAbsent
          ? const Value.absent()
          : Value(recipeType),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      defaultServings: defaultServings == null && nullToAbsent
          ? const Value.absent()
          : Value(defaultServings),
      yieldServings: yieldServings == null && nullToAbsent
          ? const Value.absent()
          : Value(yieldServings),
      yieldText: yieldText == null && nullToAbsent
          ? const Value.absent()
          : Value(yieldText),
      cookTimeMinutes: cookTimeMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(cookTimeMinutes),
      prepTimeMinutes: prepTimeMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(prepTimeMinutes),
      totalTimeMinutes: totalTimeMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(totalTimeMinutes),
      difficulty: difficulty == null && nullToAbsent
          ? const Value.absent()
          : Value(difficulty),
      sourceType: sourceType == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceType),
      sourceTitle: sourceTitle == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceTitle),
      sourcePageStart: sourcePageStart == null && nullToAbsent
          ? const Value.absent()
          : Value(sourcePageStart),
      sourcePageEnd: sourcePageEnd == null && nullToAbsent
          ? const Value.absent()
          : Value(sourcePageEnd),
      isReusable: Value(isReusable),
      deduplicationKey: deduplicationKey == null && nullToAbsent
          ? const Value.absent()
          : Value(deduplicationKey),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory PdfRecipe.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PdfRecipe(
      id: serializer.fromJson<int>(json['id']),
      canonicalName: serializer.fromJson<String>(json['canonicalName']),
      normalizedName: serializer.fromJson<String>(json['normalizedName']),
      recipeType: serializer.fromJson<String?>(json['recipeType']),
      description: serializer.fromJson<String?>(json['description']),
      defaultServings: serializer.fromJson<double?>(json['defaultServings']),
      yieldServings: serializer.fromJson<double?>(json['yieldServings']),
      yieldText: serializer.fromJson<String?>(json['yieldText']),
      cookTimeMinutes: serializer.fromJson<int?>(json['cookTimeMinutes']),
      prepTimeMinutes: serializer.fromJson<int?>(json['prepTimeMinutes']),
      totalTimeMinutes: serializer.fromJson<int?>(json['totalTimeMinutes']),
      difficulty: serializer.fromJson<String?>(json['difficulty']),
      sourceType: serializer.fromJson<String?>(json['sourceType']),
      sourceTitle: serializer.fromJson<String?>(json['sourceTitle']),
      sourcePageStart: serializer.fromJson<int?>(json['sourcePageStart']),
      sourcePageEnd: serializer.fromJson<int?>(json['sourcePageEnd']),
      isReusable: serializer.fromJson<bool>(json['isReusable']),
      deduplicationKey: serializer.fromJson<String?>(json['deduplicationKey']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'canonicalName': serializer.toJson<String>(canonicalName),
      'normalizedName': serializer.toJson<String>(normalizedName),
      'recipeType': serializer.toJson<String?>(recipeType),
      'description': serializer.toJson<String?>(description),
      'defaultServings': serializer.toJson<double?>(defaultServings),
      'yieldServings': serializer.toJson<double?>(yieldServings),
      'yieldText': serializer.toJson<String?>(yieldText),
      'cookTimeMinutes': serializer.toJson<int?>(cookTimeMinutes),
      'prepTimeMinutes': serializer.toJson<int?>(prepTimeMinutes),
      'totalTimeMinutes': serializer.toJson<int?>(totalTimeMinutes),
      'difficulty': serializer.toJson<String?>(difficulty),
      'sourceType': serializer.toJson<String?>(sourceType),
      'sourceTitle': serializer.toJson<String?>(sourceTitle),
      'sourcePageStart': serializer.toJson<int?>(sourcePageStart),
      'sourcePageEnd': serializer.toJson<int?>(sourcePageEnd),
      'isReusable': serializer.toJson<bool>(isReusable),
      'deduplicationKey': serializer.toJson<String?>(deduplicationKey),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  PdfRecipe copyWith({
    int? id,
    String? canonicalName,
    String? normalizedName,
    Value<String?> recipeType = const Value.absent(),
    Value<String?> description = const Value.absent(),
    Value<double?> defaultServings = const Value.absent(),
    Value<double?> yieldServings = const Value.absent(),
    Value<String?> yieldText = const Value.absent(),
    Value<int?> cookTimeMinutes = const Value.absent(),
    Value<int?> prepTimeMinutes = const Value.absent(),
    Value<int?> totalTimeMinutes = const Value.absent(),
    Value<String?> difficulty = const Value.absent(),
    Value<String?> sourceType = const Value.absent(),
    Value<String?> sourceTitle = const Value.absent(),
    Value<int?> sourcePageStart = const Value.absent(),
    Value<int?> sourcePageEnd = const Value.absent(),
    bool? isReusable,
    Value<String?> deduplicationKey = const Value.absent(),
    Value<String?> notes = const Value.absent(),
  }) => PdfRecipe(
    id: id ?? this.id,
    canonicalName: canonicalName ?? this.canonicalName,
    normalizedName: normalizedName ?? this.normalizedName,
    recipeType: recipeType.present ? recipeType.value : this.recipeType,
    description: description.present ? description.value : this.description,
    defaultServings: defaultServings.present
        ? defaultServings.value
        : this.defaultServings,
    yieldServings: yieldServings.present
        ? yieldServings.value
        : this.yieldServings,
    yieldText: yieldText.present ? yieldText.value : this.yieldText,
    cookTimeMinutes: cookTimeMinutes.present
        ? cookTimeMinutes.value
        : this.cookTimeMinutes,
    prepTimeMinutes: prepTimeMinutes.present
        ? prepTimeMinutes.value
        : this.prepTimeMinutes,
    totalTimeMinutes: totalTimeMinutes.present
        ? totalTimeMinutes.value
        : this.totalTimeMinutes,
    difficulty: difficulty.present ? difficulty.value : this.difficulty,
    sourceType: sourceType.present ? sourceType.value : this.sourceType,
    sourceTitle: sourceTitle.present ? sourceTitle.value : this.sourceTitle,
    sourcePageStart: sourcePageStart.present
        ? sourcePageStart.value
        : this.sourcePageStart,
    sourcePageEnd: sourcePageEnd.present
        ? sourcePageEnd.value
        : this.sourcePageEnd,
    isReusable: isReusable ?? this.isReusable,
    deduplicationKey: deduplicationKey.present
        ? deduplicationKey.value
        : this.deduplicationKey,
    notes: notes.present ? notes.value : this.notes,
  );
  PdfRecipe copyWithCompanion(PdfRecipesCompanion data) {
    return PdfRecipe(
      id: data.id.present ? data.id.value : this.id,
      canonicalName: data.canonicalName.present
          ? data.canonicalName.value
          : this.canonicalName,
      normalizedName: data.normalizedName.present
          ? data.normalizedName.value
          : this.normalizedName,
      recipeType: data.recipeType.present
          ? data.recipeType.value
          : this.recipeType,
      description: data.description.present
          ? data.description.value
          : this.description,
      defaultServings: data.defaultServings.present
          ? data.defaultServings.value
          : this.defaultServings,
      yieldServings: data.yieldServings.present
          ? data.yieldServings.value
          : this.yieldServings,
      yieldText: data.yieldText.present ? data.yieldText.value : this.yieldText,
      cookTimeMinutes: data.cookTimeMinutes.present
          ? data.cookTimeMinutes.value
          : this.cookTimeMinutes,
      prepTimeMinutes: data.prepTimeMinutes.present
          ? data.prepTimeMinutes.value
          : this.prepTimeMinutes,
      totalTimeMinutes: data.totalTimeMinutes.present
          ? data.totalTimeMinutes.value
          : this.totalTimeMinutes,
      difficulty: data.difficulty.present
          ? data.difficulty.value
          : this.difficulty,
      sourceType: data.sourceType.present
          ? data.sourceType.value
          : this.sourceType,
      sourceTitle: data.sourceTitle.present
          ? data.sourceTitle.value
          : this.sourceTitle,
      sourcePageStart: data.sourcePageStart.present
          ? data.sourcePageStart.value
          : this.sourcePageStart,
      sourcePageEnd: data.sourcePageEnd.present
          ? data.sourcePageEnd.value
          : this.sourcePageEnd,
      isReusable: data.isReusable.present
          ? data.isReusable.value
          : this.isReusable,
      deduplicationKey: data.deduplicationKey.present
          ? data.deduplicationKey.value
          : this.deduplicationKey,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PdfRecipe(')
          ..write('id: $id, ')
          ..write('canonicalName: $canonicalName, ')
          ..write('normalizedName: $normalizedName, ')
          ..write('recipeType: $recipeType, ')
          ..write('description: $description, ')
          ..write('defaultServings: $defaultServings, ')
          ..write('yieldServings: $yieldServings, ')
          ..write('yieldText: $yieldText, ')
          ..write('cookTimeMinutes: $cookTimeMinutes, ')
          ..write('prepTimeMinutes: $prepTimeMinutes, ')
          ..write('totalTimeMinutes: $totalTimeMinutes, ')
          ..write('difficulty: $difficulty, ')
          ..write('sourceType: $sourceType, ')
          ..write('sourceTitle: $sourceTitle, ')
          ..write('sourcePageStart: $sourcePageStart, ')
          ..write('sourcePageEnd: $sourcePageEnd, ')
          ..write('isReusable: $isReusable, ')
          ..write('deduplicationKey: $deduplicationKey, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    canonicalName,
    normalizedName,
    recipeType,
    description,
    defaultServings,
    yieldServings,
    yieldText,
    cookTimeMinutes,
    prepTimeMinutes,
    totalTimeMinutes,
    difficulty,
    sourceType,
    sourceTitle,
    sourcePageStart,
    sourcePageEnd,
    isReusable,
    deduplicationKey,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PdfRecipe &&
          other.id == this.id &&
          other.canonicalName == this.canonicalName &&
          other.normalizedName == this.normalizedName &&
          other.recipeType == this.recipeType &&
          other.description == this.description &&
          other.defaultServings == this.defaultServings &&
          other.yieldServings == this.yieldServings &&
          other.yieldText == this.yieldText &&
          other.cookTimeMinutes == this.cookTimeMinutes &&
          other.prepTimeMinutes == this.prepTimeMinutes &&
          other.totalTimeMinutes == this.totalTimeMinutes &&
          other.difficulty == this.difficulty &&
          other.sourceType == this.sourceType &&
          other.sourceTitle == this.sourceTitle &&
          other.sourcePageStart == this.sourcePageStart &&
          other.sourcePageEnd == this.sourcePageEnd &&
          other.isReusable == this.isReusable &&
          other.deduplicationKey == this.deduplicationKey &&
          other.notes == this.notes);
}

class PdfRecipesCompanion extends UpdateCompanion<PdfRecipe> {
  final Value<int> id;
  final Value<String> canonicalName;
  final Value<String> normalizedName;
  final Value<String?> recipeType;
  final Value<String?> description;
  final Value<double?> defaultServings;
  final Value<double?> yieldServings;
  final Value<String?> yieldText;
  final Value<int?> cookTimeMinutes;
  final Value<int?> prepTimeMinutes;
  final Value<int?> totalTimeMinutes;
  final Value<String?> difficulty;
  final Value<String?> sourceType;
  final Value<String?> sourceTitle;
  final Value<int?> sourcePageStart;
  final Value<int?> sourcePageEnd;
  final Value<bool> isReusable;
  final Value<String?> deduplicationKey;
  final Value<String?> notes;
  const PdfRecipesCompanion({
    this.id = const Value.absent(),
    this.canonicalName = const Value.absent(),
    this.normalizedName = const Value.absent(),
    this.recipeType = const Value.absent(),
    this.description = const Value.absent(),
    this.defaultServings = const Value.absent(),
    this.yieldServings = const Value.absent(),
    this.yieldText = const Value.absent(),
    this.cookTimeMinutes = const Value.absent(),
    this.prepTimeMinutes = const Value.absent(),
    this.totalTimeMinutes = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.sourceType = const Value.absent(),
    this.sourceTitle = const Value.absent(),
    this.sourcePageStart = const Value.absent(),
    this.sourcePageEnd = const Value.absent(),
    this.isReusable = const Value.absent(),
    this.deduplicationKey = const Value.absent(),
    this.notes = const Value.absent(),
  });
  PdfRecipesCompanion.insert({
    this.id = const Value.absent(),
    required String canonicalName,
    required String normalizedName,
    this.recipeType = const Value.absent(),
    this.description = const Value.absent(),
    this.defaultServings = const Value.absent(),
    this.yieldServings = const Value.absent(),
    this.yieldText = const Value.absent(),
    this.cookTimeMinutes = const Value.absent(),
    this.prepTimeMinutes = const Value.absent(),
    this.totalTimeMinutes = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.sourceType = const Value.absent(),
    this.sourceTitle = const Value.absent(),
    this.sourcePageStart = const Value.absent(),
    this.sourcePageEnd = const Value.absent(),
    this.isReusable = const Value.absent(),
    this.deduplicationKey = const Value.absent(),
    this.notes = const Value.absent(),
  }) : canonicalName = Value(canonicalName),
       normalizedName = Value(normalizedName);
  static Insertable<PdfRecipe> custom({
    Expression<int>? id,
    Expression<String>? canonicalName,
    Expression<String>? normalizedName,
    Expression<String>? recipeType,
    Expression<String>? description,
    Expression<double>? defaultServings,
    Expression<double>? yieldServings,
    Expression<String>? yieldText,
    Expression<int>? cookTimeMinutes,
    Expression<int>? prepTimeMinutes,
    Expression<int>? totalTimeMinutes,
    Expression<String>? difficulty,
    Expression<String>? sourceType,
    Expression<String>? sourceTitle,
    Expression<int>? sourcePageStart,
    Expression<int>? sourcePageEnd,
    Expression<bool>? isReusable,
    Expression<String>? deduplicationKey,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (canonicalName != null) 'canonical_name': canonicalName,
      if (normalizedName != null) 'normalized_name': normalizedName,
      if (recipeType != null) 'recipe_type': recipeType,
      if (description != null) 'description': description,
      if (defaultServings != null) 'default_servings': defaultServings,
      if (yieldServings != null) 'yield_servings': yieldServings,
      if (yieldText != null) 'yield_text': yieldText,
      if (cookTimeMinutes != null) 'cook_time_minutes': cookTimeMinutes,
      if (prepTimeMinutes != null) 'prep_time_minutes': prepTimeMinutes,
      if (totalTimeMinutes != null) 'total_time_minutes': totalTimeMinutes,
      if (difficulty != null) 'difficulty': difficulty,
      if (sourceType != null) 'source_type': sourceType,
      if (sourceTitle != null) 'source_title': sourceTitle,
      if (sourcePageStart != null) 'source_page_start': sourcePageStart,
      if (sourcePageEnd != null) 'source_page_end': sourcePageEnd,
      if (isReusable != null) 'is_reusable': isReusable,
      if (deduplicationKey != null) 'deduplication_key': deduplicationKey,
      if (notes != null) 'notes': notes,
    });
  }

  PdfRecipesCompanion copyWith({
    Value<int>? id,
    Value<String>? canonicalName,
    Value<String>? normalizedName,
    Value<String?>? recipeType,
    Value<String?>? description,
    Value<double?>? defaultServings,
    Value<double?>? yieldServings,
    Value<String?>? yieldText,
    Value<int?>? cookTimeMinutes,
    Value<int?>? prepTimeMinutes,
    Value<int?>? totalTimeMinutes,
    Value<String?>? difficulty,
    Value<String?>? sourceType,
    Value<String?>? sourceTitle,
    Value<int?>? sourcePageStart,
    Value<int?>? sourcePageEnd,
    Value<bool>? isReusable,
    Value<String?>? deduplicationKey,
    Value<String?>? notes,
  }) {
    return PdfRecipesCompanion(
      id: id ?? this.id,
      canonicalName: canonicalName ?? this.canonicalName,
      normalizedName: normalizedName ?? this.normalizedName,
      recipeType: recipeType ?? this.recipeType,
      description: description ?? this.description,
      defaultServings: defaultServings ?? this.defaultServings,
      yieldServings: yieldServings ?? this.yieldServings,
      yieldText: yieldText ?? this.yieldText,
      cookTimeMinutes: cookTimeMinutes ?? this.cookTimeMinutes,
      prepTimeMinutes: prepTimeMinutes ?? this.prepTimeMinutes,
      totalTimeMinutes: totalTimeMinutes ?? this.totalTimeMinutes,
      difficulty: difficulty ?? this.difficulty,
      sourceType: sourceType ?? this.sourceType,
      sourceTitle: sourceTitle ?? this.sourceTitle,
      sourcePageStart: sourcePageStart ?? this.sourcePageStart,
      sourcePageEnd: sourcePageEnd ?? this.sourcePageEnd,
      isReusable: isReusable ?? this.isReusable,
      deduplicationKey: deduplicationKey ?? this.deduplicationKey,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (canonicalName.present) {
      map['canonical_name'] = Variable<String>(canonicalName.value);
    }
    if (normalizedName.present) {
      map['normalized_name'] = Variable<String>(normalizedName.value);
    }
    if (recipeType.present) {
      map['recipe_type'] = Variable<String>(recipeType.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (defaultServings.present) {
      map['default_servings'] = Variable<double>(defaultServings.value);
    }
    if (yieldServings.present) {
      map['yield_servings'] = Variable<double>(yieldServings.value);
    }
    if (yieldText.present) {
      map['yield_text'] = Variable<String>(yieldText.value);
    }
    if (cookTimeMinutes.present) {
      map['cook_time_minutes'] = Variable<int>(cookTimeMinutes.value);
    }
    if (prepTimeMinutes.present) {
      map['prep_time_minutes'] = Variable<int>(prepTimeMinutes.value);
    }
    if (totalTimeMinutes.present) {
      map['total_time_minutes'] = Variable<int>(totalTimeMinutes.value);
    }
    if (difficulty.present) {
      map['difficulty'] = Variable<String>(difficulty.value);
    }
    if (sourceType.present) {
      map['source_type'] = Variable<String>(sourceType.value);
    }
    if (sourceTitle.present) {
      map['source_title'] = Variable<String>(sourceTitle.value);
    }
    if (sourcePageStart.present) {
      map['source_page_start'] = Variable<int>(sourcePageStart.value);
    }
    if (sourcePageEnd.present) {
      map['source_page_end'] = Variable<int>(sourcePageEnd.value);
    }
    if (isReusable.present) {
      map['is_reusable'] = Variable<bool>(isReusable.value);
    }
    if (deduplicationKey.present) {
      map['deduplication_key'] = Variable<String>(deduplicationKey.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PdfRecipesCompanion(')
          ..write('id: $id, ')
          ..write('canonicalName: $canonicalName, ')
          ..write('normalizedName: $normalizedName, ')
          ..write('recipeType: $recipeType, ')
          ..write('description: $description, ')
          ..write('defaultServings: $defaultServings, ')
          ..write('yieldServings: $yieldServings, ')
          ..write('yieldText: $yieldText, ')
          ..write('cookTimeMinutes: $cookTimeMinutes, ')
          ..write('prepTimeMinutes: $prepTimeMinutes, ')
          ..write('totalTimeMinutes: $totalTimeMinutes, ')
          ..write('difficulty: $difficulty, ')
          ..write('sourceType: $sourceType, ')
          ..write('sourceTitle: $sourceTitle, ')
          ..write('sourcePageStart: $sourcePageStart, ')
          ..write('sourcePageEnd: $sourcePageEnd, ')
          ..write('isReusable: $isReusable, ')
          ..write('deduplicationKey: $deduplicationKey, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

class $PdfSimpleProductsTable extends PdfSimpleProducts
    with TableInfo<$PdfSimpleProductsTable, PdfSimpleProduct> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PdfSimpleProductsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _normalizedNameMeta = const VerificationMeta(
    'normalizedName',
  );
  @override
  late final GeneratedColumn<String> normalizedName = GeneratedColumn<String>(
    'normalized_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _defaultUnitMeta = const VerificationMeta(
    'defaultUnit',
  );
  @override
  late final GeneratedColumn<String> defaultUnit = GeneratedColumn<String>(
    'default_unit',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    normalizedName,
    category,
    defaultUnit,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'simple_products';
  @override
  VerificationContext validateIntegrity(
    Insertable<PdfSimpleProduct> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('normalized_name')) {
      context.handle(
        _normalizedNameMeta,
        normalizedName.isAcceptableOrUnknown(
          data['normalized_name']!,
          _normalizedNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_normalizedNameMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    }
    if (data.containsKey('default_unit')) {
      context.handle(
        _defaultUnitMeta,
        defaultUnit.isAcceptableOrUnknown(
          data['default_unit']!,
          _defaultUnitMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PdfSimpleProduct map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PdfSimpleProduct(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      normalizedName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}normalized_name'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      ),
      defaultUnit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}default_unit'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $PdfSimpleProductsTable createAlias(String alias) {
    return $PdfSimpleProductsTable(attachedDatabase, alias);
  }
}

class PdfSimpleProduct extends DataClass
    implements Insertable<PdfSimpleProduct> {
  final int id;
  final String name;
  final String normalizedName;
  final String? category;
  final String? defaultUnit;
  final String? notes;
  const PdfSimpleProduct({
    required this.id,
    required this.name,
    required this.normalizedName,
    this.category,
    this.defaultUnit,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['normalized_name'] = Variable<String>(normalizedName);
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<String>(category);
    }
    if (!nullToAbsent || defaultUnit != null) {
      map['default_unit'] = Variable<String>(defaultUnit);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  PdfSimpleProductsCompanion toCompanion(bool nullToAbsent) {
    return PdfSimpleProductsCompanion(
      id: Value(id),
      name: Value(name),
      normalizedName: Value(normalizedName),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
      defaultUnit: defaultUnit == null && nullToAbsent
          ? const Value.absent()
          : Value(defaultUnit),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory PdfSimpleProduct.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PdfSimpleProduct(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      normalizedName: serializer.fromJson<String>(json['normalizedName']),
      category: serializer.fromJson<String?>(json['category']),
      defaultUnit: serializer.fromJson<String?>(json['defaultUnit']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'normalizedName': serializer.toJson<String>(normalizedName),
      'category': serializer.toJson<String?>(category),
      'defaultUnit': serializer.toJson<String?>(defaultUnit),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  PdfSimpleProduct copyWith({
    int? id,
    String? name,
    String? normalizedName,
    Value<String?> category = const Value.absent(),
    Value<String?> defaultUnit = const Value.absent(),
    Value<String?> notes = const Value.absent(),
  }) => PdfSimpleProduct(
    id: id ?? this.id,
    name: name ?? this.name,
    normalizedName: normalizedName ?? this.normalizedName,
    category: category.present ? category.value : this.category,
    defaultUnit: defaultUnit.present ? defaultUnit.value : this.defaultUnit,
    notes: notes.present ? notes.value : this.notes,
  );
  PdfSimpleProduct copyWithCompanion(PdfSimpleProductsCompanion data) {
    return PdfSimpleProduct(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      normalizedName: data.normalizedName.present
          ? data.normalizedName.value
          : this.normalizedName,
      category: data.category.present ? data.category.value : this.category,
      defaultUnit: data.defaultUnit.present
          ? data.defaultUnit.value
          : this.defaultUnit,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PdfSimpleProduct(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('normalizedName: $normalizedName, ')
          ..write('category: $category, ')
          ..write('defaultUnit: $defaultUnit, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, normalizedName, category, defaultUnit, notes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PdfSimpleProduct &&
          other.id == this.id &&
          other.name == this.name &&
          other.normalizedName == this.normalizedName &&
          other.category == this.category &&
          other.defaultUnit == this.defaultUnit &&
          other.notes == this.notes);
}

class PdfSimpleProductsCompanion extends UpdateCompanion<PdfSimpleProduct> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> normalizedName;
  final Value<String?> category;
  final Value<String?> defaultUnit;
  final Value<String?> notes;
  const PdfSimpleProductsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.normalizedName = const Value.absent(),
    this.category = const Value.absent(),
    this.defaultUnit = const Value.absent(),
    this.notes = const Value.absent(),
  });
  PdfSimpleProductsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String normalizedName,
    this.category = const Value.absent(),
    this.defaultUnit = const Value.absent(),
    this.notes = const Value.absent(),
  }) : name = Value(name),
       normalizedName = Value(normalizedName);
  static Insertable<PdfSimpleProduct> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? normalizedName,
    Expression<String>? category,
    Expression<String>? defaultUnit,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (normalizedName != null) 'normalized_name': normalizedName,
      if (category != null) 'category': category,
      if (defaultUnit != null) 'default_unit': defaultUnit,
      if (notes != null) 'notes': notes,
    });
  }

  PdfSimpleProductsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? normalizedName,
    Value<String?>? category,
    Value<String?>? defaultUnit,
    Value<String?>? notes,
  }) {
    return PdfSimpleProductsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      normalizedName: normalizedName ?? this.normalizedName,
      category: category ?? this.category,
      defaultUnit: defaultUnit ?? this.defaultUnit,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (normalizedName.present) {
      map['normalized_name'] = Variable<String>(normalizedName.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (defaultUnit.present) {
      map['default_unit'] = Variable<String>(defaultUnit.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PdfSimpleProductsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('normalizedName: $normalizedName, ')
          ..write('category: $category, ')
          ..write('defaultUnit: $defaultUnit, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

class $PdfMediaAssetsTable extends PdfMediaAssets
    with TableInfo<$PdfMediaAssetsTable, PdfMediaAsset> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PdfMediaAssetsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _sourceFileIdMeta = const VerificationMeta(
    'sourceFileId',
  );
  @override
  late final GeneratedColumn<String> sourceFileId = GeneratedColumn<String>(
    'source_file_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sourcePageMeta = const VerificationMeta(
    'sourcePage',
  );
  @override
  late final GeneratedColumn<int> sourcePage = GeneratedColumn<int>(
    'source_page',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _mediaTypeMeta = const VerificationMeta(
    'mediaType',
  );
  @override
  late final GeneratedColumn<String> mediaType = GeneratedColumn<String>(
    'media_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('image'),
  );
  static const VerificationMeta _fileNameMeta = const VerificationMeta(
    'fileName',
  );
  @override
  late final GeneratedColumn<String> fileName = GeneratedColumn<String>(
    'file_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _relativePathMeta = const VerificationMeta(
    'relativePath',
  );
  @override
  late final GeneratedColumn<String> relativePath = GeneratedColumn<String>(
    'relative_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _storageUriMeta = const VerificationMeta(
    'storageUri',
  );
  @override
  late final GeneratedColumn<String> storageUri = GeneratedColumn<String>(
    'storage_uri',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _captionMeta = const VerificationMeta(
    'caption',
  );
  @override
  late final GeneratedColumn<String> caption = GeneratedColumn<String>(
    'caption',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _altTextMeta = const VerificationMeta(
    'altText',
  );
  @override
  late final GeneratedColumn<String> altText = GeneratedColumn<String>(
    'alt_text',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _widthMeta = const VerificationMeta('width');
  @override
  late final GeneratedColumn<int> width = GeneratedColumn<int>(
    'width',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _heightMeta = const VerificationMeta('height');
  @override
  late final GeneratedColumn<int> height = GeneratedColumn<int>(
    'height',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _hashMeta = const VerificationMeta('hash');
  @override
  late final GeneratedColumn<String> hash = GeneratedColumn<String>(
    'hash',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sourceFileId,
    sourcePage,
    mediaType,
    fileName,
    relativePath,
    storageUri,
    caption,
    altText,
    width,
    height,
    hash,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'media_assets';
  @override
  VerificationContext validateIntegrity(
    Insertable<PdfMediaAsset> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('source_file_id')) {
      context.handle(
        _sourceFileIdMeta,
        sourceFileId.isAcceptableOrUnknown(
          data['source_file_id']!,
          _sourceFileIdMeta,
        ),
      );
    }
    if (data.containsKey('source_page')) {
      context.handle(
        _sourcePageMeta,
        sourcePage.isAcceptableOrUnknown(data['source_page']!, _sourcePageMeta),
      );
    }
    if (data.containsKey('media_type')) {
      context.handle(
        _mediaTypeMeta,
        mediaType.isAcceptableOrUnknown(data['media_type']!, _mediaTypeMeta),
      );
    }
    if (data.containsKey('file_name')) {
      context.handle(
        _fileNameMeta,
        fileName.isAcceptableOrUnknown(data['file_name']!, _fileNameMeta),
      );
    }
    if (data.containsKey('relative_path')) {
      context.handle(
        _relativePathMeta,
        relativePath.isAcceptableOrUnknown(
          data['relative_path']!,
          _relativePathMeta,
        ),
      );
    }
    if (data.containsKey('storage_uri')) {
      context.handle(
        _storageUriMeta,
        storageUri.isAcceptableOrUnknown(data['storage_uri']!, _storageUriMeta),
      );
    }
    if (data.containsKey('caption')) {
      context.handle(
        _captionMeta,
        caption.isAcceptableOrUnknown(data['caption']!, _captionMeta),
      );
    }
    if (data.containsKey('alt_text')) {
      context.handle(
        _altTextMeta,
        altText.isAcceptableOrUnknown(data['alt_text']!, _altTextMeta),
      );
    }
    if (data.containsKey('width')) {
      context.handle(
        _widthMeta,
        width.isAcceptableOrUnknown(data['width']!, _widthMeta),
      );
    }
    if (data.containsKey('height')) {
      context.handle(
        _heightMeta,
        height.isAcceptableOrUnknown(data['height']!, _heightMeta),
      );
    }
    if (data.containsKey('hash')) {
      context.handle(
        _hashMeta,
        hash.isAcceptableOrUnknown(data['hash']!, _hashMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PdfMediaAsset map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PdfMediaAsset(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      sourceFileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_file_id'],
      ),
      sourcePage: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}source_page'],
      ),
      mediaType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}media_type'],
      )!,
      fileName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_name'],
      ),
      relativePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}relative_path'],
      ),
      storageUri: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}storage_uri'],
      ),
      caption: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}caption'],
      ),
      altText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}alt_text'],
      ),
      width: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}width'],
      ),
      height: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}height'],
      ),
      hash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}hash'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $PdfMediaAssetsTable createAlias(String alias) {
    return $PdfMediaAssetsTable(attachedDatabase, alias);
  }
}

class PdfMediaAsset extends DataClass implements Insertable<PdfMediaAsset> {
  final int id;
  final String? sourceFileId;
  final int? sourcePage;
  final String mediaType;
  final String? fileName;
  final String? relativePath;
  final String? storageUri;
  final String? caption;
  final String? altText;
  final int? width;
  final int? height;
  final String? hash;
  final String? notes;
  const PdfMediaAsset({
    required this.id,
    this.sourceFileId,
    this.sourcePage,
    required this.mediaType,
    this.fileName,
    this.relativePath,
    this.storageUri,
    this.caption,
    this.altText,
    this.width,
    this.height,
    this.hash,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || sourceFileId != null) {
      map['source_file_id'] = Variable<String>(sourceFileId);
    }
    if (!nullToAbsent || sourcePage != null) {
      map['source_page'] = Variable<int>(sourcePage);
    }
    map['media_type'] = Variable<String>(mediaType);
    if (!nullToAbsent || fileName != null) {
      map['file_name'] = Variable<String>(fileName);
    }
    if (!nullToAbsent || relativePath != null) {
      map['relative_path'] = Variable<String>(relativePath);
    }
    if (!nullToAbsent || storageUri != null) {
      map['storage_uri'] = Variable<String>(storageUri);
    }
    if (!nullToAbsent || caption != null) {
      map['caption'] = Variable<String>(caption);
    }
    if (!nullToAbsent || altText != null) {
      map['alt_text'] = Variable<String>(altText);
    }
    if (!nullToAbsent || width != null) {
      map['width'] = Variable<int>(width);
    }
    if (!nullToAbsent || height != null) {
      map['height'] = Variable<int>(height);
    }
    if (!nullToAbsent || hash != null) {
      map['hash'] = Variable<String>(hash);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  PdfMediaAssetsCompanion toCompanion(bool nullToAbsent) {
    return PdfMediaAssetsCompanion(
      id: Value(id),
      sourceFileId: sourceFileId == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceFileId),
      sourcePage: sourcePage == null && nullToAbsent
          ? const Value.absent()
          : Value(sourcePage),
      mediaType: Value(mediaType),
      fileName: fileName == null && nullToAbsent
          ? const Value.absent()
          : Value(fileName),
      relativePath: relativePath == null && nullToAbsent
          ? const Value.absent()
          : Value(relativePath),
      storageUri: storageUri == null && nullToAbsent
          ? const Value.absent()
          : Value(storageUri),
      caption: caption == null && nullToAbsent
          ? const Value.absent()
          : Value(caption),
      altText: altText == null && nullToAbsent
          ? const Value.absent()
          : Value(altText),
      width: width == null && nullToAbsent
          ? const Value.absent()
          : Value(width),
      height: height == null && nullToAbsent
          ? const Value.absent()
          : Value(height),
      hash: hash == null && nullToAbsent ? const Value.absent() : Value(hash),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory PdfMediaAsset.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PdfMediaAsset(
      id: serializer.fromJson<int>(json['id']),
      sourceFileId: serializer.fromJson<String?>(json['sourceFileId']),
      sourcePage: serializer.fromJson<int?>(json['sourcePage']),
      mediaType: serializer.fromJson<String>(json['mediaType']),
      fileName: serializer.fromJson<String?>(json['fileName']),
      relativePath: serializer.fromJson<String?>(json['relativePath']),
      storageUri: serializer.fromJson<String?>(json['storageUri']),
      caption: serializer.fromJson<String?>(json['caption']),
      altText: serializer.fromJson<String?>(json['altText']),
      width: serializer.fromJson<int?>(json['width']),
      height: serializer.fromJson<int?>(json['height']),
      hash: serializer.fromJson<String?>(json['hash']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sourceFileId': serializer.toJson<String?>(sourceFileId),
      'sourcePage': serializer.toJson<int?>(sourcePage),
      'mediaType': serializer.toJson<String>(mediaType),
      'fileName': serializer.toJson<String?>(fileName),
      'relativePath': serializer.toJson<String?>(relativePath),
      'storageUri': serializer.toJson<String?>(storageUri),
      'caption': serializer.toJson<String?>(caption),
      'altText': serializer.toJson<String?>(altText),
      'width': serializer.toJson<int?>(width),
      'height': serializer.toJson<int?>(height),
      'hash': serializer.toJson<String?>(hash),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  PdfMediaAsset copyWith({
    int? id,
    Value<String?> sourceFileId = const Value.absent(),
    Value<int?> sourcePage = const Value.absent(),
    String? mediaType,
    Value<String?> fileName = const Value.absent(),
    Value<String?> relativePath = const Value.absent(),
    Value<String?> storageUri = const Value.absent(),
    Value<String?> caption = const Value.absent(),
    Value<String?> altText = const Value.absent(),
    Value<int?> width = const Value.absent(),
    Value<int?> height = const Value.absent(),
    Value<String?> hash = const Value.absent(),
    Value<String?> notes = const Value.absent(),
  }) => PdfMediaAsset(
    id: id ?? this.id,
    sourceFileId: sourceFileId.present ? sourceFileId.value : this.sourceFileId,
    sourcePage: sourcePage.present ? sourcePage.value : this.sourcePage,
    mediaType: mediaType ?? this.mediaType,
    fileName: fileName.present ? fileName.value : this.fileName,
    relativePath: relativePath.present ? relativePath.value : this.relativePath,
    storageUri: storageUri.present ? storageUri.value : this.storageUri,
    caption: caption.present ? caption.value : this.caption,
    altText: altText.present ? altText.value : this.altText,
    width: width.present ? width.value : this.width,
    height: height.present ? height.value : this.height,
    hash: hash.present ? hash.value : this.hash,
    notes: notes.present ? notes.value : this.notes,
  );
  PdfMediaAsset copyWithCompanion(PdfMediaAssetsCompanion data) {
    return PdfMediaAsset(
      id: data.id.present ? data.id.value : this.id,
      sourceFileId: data.sourceFileId.present
          ? data.sourceFileId.value
          : this.sourceFileId,
      sourcePage: data.sourcePage.present
          ? data.sourcePage.value
          : this.sourcePage,
      mediaType: data.mediaType.present ? data.mediaType.value : this.mediaType,
      fileName: data.fileName.present ? data.fileName.value : this.fileName,
      relativePath: data.relativePath.present
          ? data.relativePath.value
          : this.relativePath,
      storageUri: data.storageUri.present
          ? data.storageUri.value
          : this.storageUri,
      caption: data.caption.present ? data.caption.value : this.caption,
      altText: data.altText.present ? data.altText.value : this.altText,
      width: data.width.present ? data.width.value : this.width,
      height: data.height.present ? data.height.value : this.height,
      hash: data.hash.present ? data.hash.value : this.hash,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PdfMediaAsset(')
          ..write('id: $id, ')
          ..write('sourceFileId: $sourceFileId, ')
          ..write('sourcePage: $sourcePage, ')
          ..write('mediaType: $mediaType, ')
          ..write('fileName: $fileName, ')
          ..write('relativePath: $relativePath, ')
          ..write('storageUri: $storageUri, ')
          ..write('caption: $caption, ')
          ..write('altText: $altText, ')
          ..write('width: $width, ')
          ..write('height: $height, ')
          ..write('hash: $hash, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    sourceFileId,
    sourcePage,
    mediaType,
    fileName,
    relativePath,
    storageUri,
    caption,
    altText,
    width,
    height,
    hash,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PdfMediaAsset &&
          other.id == this.id &&
          other.sourceFileId == this.sourceFileId &&
          other.sourcePage == this.sourcePage &&
          other.mediaType == this.mediaType &&
          other.fileName == this.fileName &&
          other.relativePath == this.relativePath &&
          other.storageUri == this.storageUri &&
          other.caption == this.caption &&
          other.altText == this.altText &&
          other.width == this.width &&
          other.height == this.height &&
          other.hash == this.hash &&
          other.notes == this.notes);
}

class PdfMediaAssetsCompanion extends UpdateCompanion<PdfMediaAsset> {
  final Value<int> id;
  final Value<String?> sourceFileId;
  final Value<int?> sourcePage;
  final Value<String> mediaType;
  final Value<String?> fileName;
  final Value<String?> relativePath;
  final Value<String?> storageUri;
  final Value<String?> caption;
  final Value<String?> altText;
  final Value<int?> width;
  final Value<int?> height;
  final Value<String?> hash;
  final Value<String?> notes;
  const PdfMediaAssetsCompanion({
    this.id = const Value.absent(),
    this.sourceFileId = const Value.absent(),
    this.sourcePage = const Value.absent(),
    this.mediaType = const Value.absent(),
    this.fileName = const Value.absent(),
    this.relativePath = const Value.absent(),
    this.storageUri = const Value.absent(),
    this.caption = const Value.absent(),
    this.altText = const Value.absent(),
    this.width = const Value.absent(),
    this.height = const Value.absent(),
    this.hash = const Value.absent(),
    this.notes = const Value.absent(),
  });
  PdfMediaAssetsCompanion.insert({
    this.id = const Value.absent(),
    this.sourceFileId = const Value.absent(),
    this.sourcePage = const Value.absent(),
    this.mediaType = const Value.absent(),
    this.fileName = const Value.absent(),
    this.relativePath = const Value.absent(),
    this.storageUri = const Value.absent(),
    this.caption = const Value.absent(),
    this.altText = const Value.absent(),
    this.width = const Value.absent(),
    this.height = const Value.absent(),
    this.hash = const Value.absent(),
    this.notes = const Value.absent(),
  });
  static Insertable<PdfMediaAsset> custom({
    Expression<int>? id,
    Expression<String>? sourceFileId,
    Expression<int>? sourcePage,
    Expression<String>? mediaType,
    Expression<String>? fileName,
    Expression<String>? relativePath,
    Expression<String>? storageUri,
    Expression<String>? caption,
    Expression<String>? altText,
    Expression<int>? width,
    Expression<int>? height,
    Expression<String>? hash,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sourceFileId != null) 'source_file_id': sourceFileId,
      if (sourcePage != null) 'source_page': sourcePage,
      if (mediaType != null) 'media_type': mediaType,
      if (fileName != null) 'file_name': fileName,
      if (relativePath != null) 'relative_path': relativePath,
      if (storageUri != null) 'storage_uri': storageUri,
      if (caption != null) 'caption': caption,
      if (altText != null) 'alt_text': altText,
      if (width != null) 'width': width,
      if (height != null) 'height': height,
      if (hash != null) 'hash': hash,
      if (notes != null) 'notes': notes,
    });
  }

  PdfMediaAssetsCompanion copyWith({
    Value<int>? id,
    Value<String?>? sourceFileId,
    Value<int?>? sourcePage,
    Value<String>? mediaType,
    Value<String?>? fileName,
    Value<String?>? relativePath,
    Value<String?>? storageUri,
    Value<String?>? caption,
    Value<String?>? altText,
    Value<int?>? width,
    Value<int?>? height,
    Value<String?>? hash,
    Value<String?>? notes,
  }) {
    return PdfMediaAssetsCompanion(
      id: id ?? this.id,
      sourceFileId: sourceFileId ?? this.sourceFileId,
      sourcePage: sourcePage ?? this.sourcePage,
      mediaType: mediaType ?? this.mediaType,
      fileName: fileName ?? this.fileName,
      relativePath: relativePath ?? this.relativePath,
      storageUri: storageUri ?? this.storageUri,
      caption: caption ?? this.caption,
      altText: altText ?? this.altText,
      width: width ?? this.width,
      height: height ?? this.height,
      hash: hash ?? this.hash,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sourceFileId.present) {
      map['source_file_id'] = Variable<String>(sourceFileId.value);
    }
    if (sourcePage.present) {
      map['source_page'] = Variable<int>(sourcePage.value);
    }
    if (mediaType.present) {
      map['media_type'] = Variable<String>(mediaType.value);
    }
    if (fileName.present) {
      map['file_name'] = Variable<String>(fileName.value);
    }
    if (relativePath.present) {
      map['relative_path'] = Variable<String>(relativePath.value);
    }
    if (storageUri.present) {
      map['storage_uri'] = Variable<String>(storageUri.value);
    }
    if (caption.present) {
      map['caption'] = Variable<String>(caption.value);
    }
    if (altText.present) {
      map['alt_text'] = Variable<String>(altText.value);
    }
    if (width.present) {
      map['width'] = Variable<int>(width.value);
    }
    if (height.present) {
      map['height'] = Variable<int>(height.value);
    }
    if (hash.present) {
      map['hash'] = Variable<String>(hash.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PdfMediaAssetsCompanion(')
          ..write('id: $id, ')
          ..write('sourceFileId: $sourceFileId, ')
          ..write('sourcePage: $sourcePage, ')
          ..write('mediaType: $mediaType, ')
          ..write('fileName: $fileName, ')
          ..write('relativePath: $relativePath, ')
          ..write('storageUri: $storageUri, ')
          ..write('caption: $caption, ')
          ..write('altText: $altText, ')
          ..write('width: $width, ')
          ..write('height: $height, ')
          ..write('hash: $hash, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

class $PdfMealSlotsTable extends PdfMealSlots
    with TableInfo<$PdfMealSlotsTable, PdfMealSlot> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PdfMealSlotsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _mealPlanDayIdMeta = const VerificationMeta(
    'mealPlanDayId',
  );
  @override
  late final GeneratedColumn<int> mealPlanDayId = GeneratedColumn<int>(
    'meal_plan_day_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES meal_plan_days (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _mealTypeMeta = const VerificationMeta(
    'mealType',
  );
  @override
  late final GeneratedColumn<String> mealType = GeneratedColumn<String>(
    'meal_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _displayNameMeta = const VerificationMeta(
    'displayName',
  );
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
    'display_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _orderIndexMeta = const VerificationMeta(
    'orderIndex',
  );
  @override
  late final GeneratedColumn<int> orderIndex = GeneratedColumn<int>(
    'order_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _slotKcalMeta = const VerificationMeta(
    'slotKcal',
  );
  @override
  late final GeneratedColumn<double> slotKcal = GeneratedColumn<double>(
    'slot_kcal',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _slotProteinMeta = const VerificationMeta(
    'slotProtein',
  );
  @override
  late final GeneratedColumn<double> slotProtein = GeneratedColumn<double>(
    'slot_protein',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _slotFatMeta = const VerificationMeta(
    'slotFat',
  );
  @override
  late final GeneratedColumn<double> slotFat = GeneratedColumn<double>(
    'slot_fat',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _slotCarbsMeta = const VerificationMeta(
    'slotCarbs',
  );
  @override
  late final GeneratedColumn<double> slotCarbs = GeneratedColumn<double>(
    'slot_carbs',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    mealPlanDayId,
    mealType,
    displayName,
    orderIndex,
    slotKcal,
    slotProtein,
    slotFat,
    slotCarbs,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'meal_slots';
  @override
  VerificationContext validateIntegrity(
    Insertable<PdfMealSlot> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('meal_plan_day_id')) {
      context.handle(
        _mealPlanDayIdMeta,
        mealPlanDayId.isAcceptableOrUnknown(
          data['meal_plan_day_id']!,
          _mealPlanDayIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_mealPlanDayIdMeta);
    }
    if (data.containsKey('meal_type')) {
      context.handle(
        _mealTypeMeta,
        mealType.isAcceptableOrUnknown(data['meal_type']!, _mealTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_mealTypeMeta);
    }
    if (data.containsKey('display_name')) {
      context.handle(
        _displayNameMeta,
        displayName.isAcceptableOrUnknown(
          data['display_name']!,
          _displayNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_displayNameMeta);
    }
    if (data.containsKey('order_index')) {
      context.handle(
        _orderIndexMeta,
        orderIndex.isAcceptableOrUnknown(data['order_index']!, _orderIndexMeta),
      );
    } else if (isInserting) {
      context.missing(_orderIndexMeta);
    }
    if (data.containsKey('slot_kcal')) {
      context.handle(
        _slotKcalMeta,
        slotKcal.isAcceptableOrUnknown(data['slot_kcal']!, _slotKcalMeta),
      );
    }
    if (data.containsKey('slot_protein')) {
      context.handle(
        _slotProteinMeta,
        slotProtein.isAcceptableOrUnknown(
          data['slot_protein']!,
          _slotProteinMeta,
        ),
      );
    }
    if (data.containsKey('slot_fat')) {
      context.handle(
        _slotFatMeta,
        slotFat.isAcceptableOrUnknown(data['slot_fat']!, _slotFatMeta),
      );
    }
    if (data.containsKey('slot_carbs')) {
      context.handle(
        _slotCarbsMeta,
        slotCarbs.isAcceptableOrUnknown(data['slot_carbs']!, _slotCarbsMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PdfMealSlot map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PdfMealSlot(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      mealPlanDayId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}meal_plan_day_id'],
      )!,
      mealType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}meal_type'],
      )!,
      displayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name'],
      )!,
      orderIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}order_index'],
      )!,
      slotKcal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}slot_kcal'],
      ),
      slotProtein: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}slot_protein'],
      ),
      slotFat: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}slot_fat'],
      ),
      slotCarbs: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}slot_carbs'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $PdfMealSlotsTable createAlias(String alias) {
    return $PdfMealSlotsTable(attachedDatabase, alias);
  }
}

class PdfMealSlot extends DataClass implements Insertable<PdfMealSlot> {
  final int id;
  final int mealPlanDayId;

  /// breakfast | lunch | snack | dinner | other
  final String mealType;
  final String displayName;
  final int orderIndex;
  final double? slotKcal;
  final double? slotProtein;
  final double? slotFat;
  final double? slotCarbs;
  final String? notes;
  const PdfMealSlot({
    required this.id,
    required this.mealPlanDayId,
    required this.mealType,
    required this.displayName,
    required this.orderIndex,
    this.slotKcal,
    this.slotProtein,
    this.slotFat,
    this.slotCarbs,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['meal_plan_day_id'] = Variable<int>(mealPlanDayId);
    map['meal_type'] = Variable<String>(mealType);
    map['display_name'] = Variable<String>(displayName);
    map['order_index'] = Variable<int>(orderIndex);
    if (!nullToAbsent || slotKcal != null) {
      map['slot_kcal'] = Variable<double>(slotKcal);
    }
    if (!nullToAbsent || slotProtein != null) {
      map['slot_protein'] = Variable<double>(slotProtein);
    }
    if (!nullToAbsent || slotFat != null) {
      map['slot_fat'] = Variable<double>(slotFat);
    }
    if (!nullToAbsent || slotCarbs != null) {
      map['slot_carbs'] = Variable<double>(slotCarbs);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  PdfMealSlotsCompanion toCompanion(bool nullToAbsent) {
    return PdfMealSlotsCompanion(
      id: Value(id),
      mealPlanDayId: Value(mealPlanDayId),
      mealType: Value(mealType),
      displayName: Value(displayName),
      orderIndex: Value(orderIndex),
      slotKcal: slotKcal == null && nullToAbsent
          ? const Value.absent()
          : Value(slotKcal),
      slotProtein: slotProtein == null && nullToAbsent
          ? const Value.absent()
          : Value(slotProtein),
      slotFat: slotFat == null && nullToAbsent
          ? const Value.absent()
          : Value(slotFat),
      slotCarbs: slotCarbs == null && nullToAbsent
          ? const Value.absent()
          : Value(slotCarbs),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory PdfMealSlot.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PdfMealSlot(
      id: serializer.fromJson<int>(json['id']),
      mealPlanDayId: serializer.fromJson<int>(json['mealPlanDayId']),
      mealType: serializer.fromJson<String>(json['mealType']),
      displayName: serializer.fromJson<String>(json['displayName']),
      orderIndex: serializer.fromJson<int>(json['orderIndex']),
      slotKcal: serializer.fromJson<double?>(json['slotKcal']),
      slotProtein: serializer.fromJson<double?>(json['slotProtein']),
      slotFat: serializer.fromJson<double?>(json['slotFat']),
      slotCarbs: serializer.fromJson<double?>(json['slotCarbs']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'mealPlanDayId': serializer.toJson<int>(mealPlanDayId),
      'mealType': serializer.toJson<String>(mealType),
      'displayName': serializer.toJson<String>(displayName),
      'orderIndex': serializer.toJson<int>(orderIndex),
      'slotKcal': serializer.toJson<double?>(slotKcal),
      'slotProtein': serializer.toJson<double?>(slotProtein),
      'slotFat': serializer.toJson<double?>(slotFat),
      'slotCarbs': serializer.toJson<double?>(slotCarbs),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  PdfMealSlot copyWith({
    int? id,
    int? mealPlanDayId,
    String? mealType,
    String? displayName,
    int? orderIndex,
    Value<double?> slotKcal = const Value.absent(),
    Value<double?> slotProtein = const Value.absent(),
    Value<double?> slotFat = const Value.absent(),
    Value<double?> slotCarbs = const Value.absent(),
    Value<String?> notes = const Value.absent(),
  }) => PdfMealSlot(
    id: id ?? this.id,
    mealPlanDayId: mealPlanDayId ?? this.mealPlanDayId,
    mealType: mealType ?? this.mealType,
    displayName: displayName ?? this.displayName,
    orderIndex: orderIndex ?? this.orderIndex,
    slotKcal: slotKcal.present ? slotKcal.value : this.slotKcal,
    slotProtein: slotProtein.present ? slotProtein.value : this.slotProtein,
    slotFat: slotFat.present ? slotFat.value : this.slotFat,
    slotCarbs: slotCarbs.present ? slotCarbs.value : this.slotCarbs,
    notes: notes.present ? notes.value : this.notes,
  );
  PdfMealSlot copyWithCompanion(PdfMealSlotsCompanion data) {
    return PdfMealSlot(
      id: data.id.present ? data.id.value : this.id,
      mealPlanDayId: data.mealPlanDayId.present
          ? data.mealPlanDayId.value
          : this.mealPlanDayId,
      mealType: data.mealType.present ? data.mealType.value : this.mealType,
      displayName: data.displayName.present
          ? data.displayName.value
          : this.displayName,
      orderIndex: data.orderIndex.present
          ? data.orderIndex.value
          : this.orderIndex,
      slotKcal: data.slotKcal.present ? data.slotKcal.value : this.slotKcal,
      slotProtein: data.slotProtein.present
          ? data.slotProtein.value
          : this.slotProtein,
      slotFat: data.slotFat.present ? data.slotFat.value : this.slotFat,
      slotCarbs: data.slotCarbs.present ? data.slotCarbs.value : this.slotCarbs,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PdfMealSlot(')
          ..write('id: $id, ')
          ..write('mealPlanDayId: $mealPlanDayId, ')
          ..write('mealType: $mealType, ')
          ..write('displayName: $displayName, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('slotKcal: $slotKcal, ')
          ..write('slotProtein: $slotProtein, ')
          ..write('slotFat: $slotFat, ')
          ..write('slotCarbs: $slotCarbs, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    mealPlanDayId,
    mealType,
    displayName,
    orderIndex,
    slotKcal,
    slotProtein,
    slotFat,
    slotCarbs,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PdfMealSlot &&
          other.id == this.id &&
          other.mealPlanDayId == this.mealPlanDayId &&
          other.mealType == this.mealType &&
          other.displayName == this.displayName &&
          other.orderIndex == this.orderIndex &&
          other.slotKcal == this.slotKcal &&
          other.slotProtein == this.slotProtein &&
          other.slotFat == this.slotFat &&
          other.slotCarbs == this.slotCarbs &&
          other.notes == this.notes);
}

class PdfMealSlotsCompanion extends UpdateCompanion<PdfMealSlot> {
  final Value<int> id;
  final Value<int> mealPlanDayId;
  final Value<String> mealType;
  final Value<String> displayName;
  final Value<int> orderIndex;
  final Value<double?> slotKcal;
  final Value<double?> slotProtein;
  final Value<double?> slotFat;
  final Value<double?> slotCarbs;
  final Value<String?> notes;
  const PdfMealSlotsCompanion({
    this.id = const Value.absent(),
    this.mealPlanDayId = const Value.absent(),
    this.mealType = const Value.absent(),
    this.displayName = const Value.absent(),
    this.orderIndex = const Value.absent(),
    this.slotKcal = const Value.absent(),
    this.slotProtein = const Value.absent(),
    this.slotFat = const Value.absent(),
    this.slotCarbs = const Value.absent(),
    this.notes = const Value.absent(),
  });
  PdfMealSlotsCompanion.insert({
    this.id = const Value.absent(),
    required int mealPlanDayId,
    required String mealType,
    required String displayName,
    required int orderIndex,
    this.slotKcal = const Value.absent(),
    this.slotProtein = const Value.absent(),
    this.slotFat = const Value.absent(),
    this.slotCarbs = const Value.absent(),
    this.notes = const Value.absent(),
  }) : mealPlanDayId = Value(mealPlanDayId),
       mealType = Value(mealType),
       displayName = Value(displayName),
       orderIndex = Value(orderIndex);
  static Insertable<PdfMealSlot> custom({
    Expression<int>? id,
    Expression<int>? mealPlanDayId,
    Expression<String>? mealType,
    Expression<String>? displayName,
    Expression<int>? orderIndex,
    Expression<double>? slotKcal,
    Expression<double>? slotProtein,
    Expression<double>? slotFat,
    Expression<double>? slotCarbs,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (mealPlanDayId != null) 'meal_plan_day_id': mealPlanDayId,
      if (mealType != null) 'meal_type': mealType,
      if (displayName != null) 'display_name': displayName,
      if (orderIndex != null) 'order_index': orderIndex,
      if (slotKcal != null) 'slot_kcal': slotKcal,
      if (slotProtein != null) 'slot_protein': slotProtein,
      if (slotFat != null) 'slot_fat': slotFat,
      if (slotCarbs != null) 'slot_carbs': slotCarbs,
      if (notes != null) 'notes': notes,
    });
  }

  PdfMealSlotsCompanion copyWith({
    Value<int>? id,
    Value<int>? mealPlanDayId,
    Value<String>? mealType,
    Value<String>? displayName,
    Value<int>? orderIndex,
    Value<double?>? slotKcal,
    Value<double?>? slotProtein,
    Value<double?>? slotFat,
    Value<double?>? slotCarbs,
    Value<String?>? notes,
  }) {
    return PdfMealSlotsCompanion(
      id: id ?? this.id,
      mealPlanDayId: mealPlanDayId ?? this.mealPlanDayId,
      mealType: mealType ?? this.mealType,
      displayName: displayName ?? this.displayName,
      orderIndex: orderIndex ?? this.orderIndex,
      slotKcal: slotKcal ?? this.slotKcal,
      slotProtein: slotProtein ?? this.slotProtein,
      slotFat: slotFat ?? this.slotFat,
      slotCarbs: slotCarbs ?? this.slotCarbs,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (mealPlanDayId.present) {
      map['meal_plan_day_id'] = Variable<int>(mealPlanDayId.value);
    }
    if (mealType.present) {
      map['meal_type'] = Variable<String>(mealType.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (orderIndex.present) {
      map['order_index'] = Variable<int>(orderIndex.value);
    }
    if (slotKcal.present) {
      map['slot_kcal'] = Variable<double>(slotKcal.value);
    }
    if (slotProtein.present) {
      map['slot_protein'] = Variable<double>(slotProtein.value);
    }
    if (slotFat.present) {
      map['slot_fat'] = Variable<double>(slotFat.value);
    }
    if (slotCarbs.present) {
      map['slot_carbs'] = Variable<double>(slotCarbs.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PdfMealSlotsCompanion(')
          ..write('id: $id, ')
          ..write('mealPlanDayId: $mealPlanDayId, ')
          ..write('mealType: $mealType, ')
          ..write('displayName: $displayName, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('slotKcal: $slotKcal, ')
          ..write('slotProtein: $slotProtein, ')
          ..write('slotFat: $slotFat, ')
          ..write('slotCarbs: $slotCarbs, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

class $PdfRecipeIngredientsTable extends PdfRecipeIngredients
    with TableInfo<$PdfRecipeIngredientsTable, PdfRecipeIngredient> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PdfRecipeIngredientsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _recipeIdMeta = const VerificationMeta(
    'recipeId',
  );
  @override
  late final GeneratedColumn<int> recipeId = GeneratedColumn<int>(
    'recipe_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES recipes (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _ingredientNameRawMeta = const VerificationMeta(
    'ingredientNameRaw',
  );
  @override
  late final GeneratedColumn<String> ingredientNameRaw =
      GeneratedColumn<String>(
        'ingredient_name_raw',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _ingredientNameNormalizedMeta =
      const VerificationMeta('ingredientNameNormalized');
  @override
  late final GeneratedColumn<String> ingredientNameNormalized =
      GeneratedColumn<String>(
        'ingredient_name_normalized',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
    'unit',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _amountTextMeta = const VerificationMeta(
    'amountText',
  );
  @override
  late final GeneratedColumn<String> amountText = GeneratedColumn<String>(
    'amount_text',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _preparationStateMeta = const VerificationMeta(
    'preparationState',
  );
  @override
  late final GeneratedColumn<String> preparationState = GeneratedColumn<String>(
    'preparation_state',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _optionalFlagMeta = const VerificationMeta(
    'optionalFlag',
  );
  @override
  late final GeneratedColumn<bool> optionalFlag = GeneratedColumn<bool>(
    'optional_flag',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("optional_flag" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    recipeId,
    ingredientNameRaw,
    ingredientNameNormalized,
    amount,
    unit,
    amountText,
    preparationState,
    optionalFlag,
    sortOrder,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recipe_ingredients';
  @override
  VerificationContext validateIntegrity(
    Insertable<PdfRecipeIngredient> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('recipe_id')) {
      context.handle(
        _recipeIdMeta,
        recipeId.isAcceptableOrUnknown(data['recipe_id']!, _recipeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_recipeIdMeta);
    }
    if (data.containsKey('ingredient_name_raw')) {
      context.handle(
        _ingredientNameRawMeta,
        ingredientNameRaw.isAcceptableOrUnknown(
          data['ingredient_name_raw']!,
          _ingredientNameRawMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_ingredientNameRawMeta);
    }
    if (data.containsKey('ingredient_name_normalized')) {
      context.handle(
        _ingredientNameNormalizedMeta,
        ingredientNameNormalized.isAcceptableOrUnknown(
          data['ingredient_name_normalized']!,
          _ingredientNameNormalizedMeta,
        ),
      );
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    }
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
      );
    }
    if (data.containsKey('amount_text')) {
      context.handle(
        _amountTextMeta,
        amountText.isAcceptableOrUnknown(data['amount_text']!, _amountTextMeta),
      );
    }
    if (data.containsKey('preparation_state')) {
      context.handle(
        _preparationStateMeta,
        preparationState.isAcceptableOrUnknown(
          data['preparation_state']!,
          _preparationStateMeta,
        ),
      );
    }
    if (data.containsKey('optional_flag')) {
      context.handle(
        _optionalFlagMeta,
        optionalFlag.isAcceptableOrUnknown(
          data['optional_flag']!,
          _optionalFlagMeta,
        ),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PdfRecipeIngredient map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PdfRecipeIngredient(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      recipeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}recipe_id'],
      )!,
      ingredientNameRaw: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ingredient_name_raw'],
      )!,
      ingredientNameNormalized: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ingredient_name_normalized'],
      ),
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      ),
      unit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit'],
      ),
      amountText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}amount_text'],
      ),
      preparationState: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}preparation_state'],
      ),
      optionalFlag: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}optional_flag'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $PdfRecipeIngredientsTable createAlias(String alias) {
    return $PdfRecipeIngredientsTable(attachedDatabase, alias);
  }
}

class PdfRecipeIngredient extends DataClass
    implements Insertable<PdfRecipeIngredient> {
  final int id;
  final int recipeId;
  final String ingredientNameRaw;
  final String? ingredientNameNormalized;
  final double? amount;
  final String? unit;
  final String? amountText;
  final String? preparationState;
  final bool optionalFlag;
  final int sortOrder;
  final String? notes;
  const PdfRecipeIngredient({
    required this.id,
    required this.recipeId,
    required this.ingredientNameRaw,
    this.ingredientNameNormalized,
    this.amount,
    this.unit,
    this.amountText,
    this.preparationState,
    required this.optionalFlag,
    required this.sortOrder,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['recipe_id'] = Variable<int>(recipeId);
    map['ingredient_name_raw'] = Variable<String>(ingredientNameRaw);
    if (!nullToAbsent || ingredientNameNormalized != null) {
      map['ingredient_name_normalized'] = Variable<String>(
        ingredientNameNormalized,
      );
    }
    if (!nullToAbsent || amount != null) {
      map['amount'] = Variable<double>(amount);
    }
    if (!nullToAbsent || unit != null) {
      map['unit'] = Variable<String>(unit);
    }
    if (!nullToAbsent || amountText != null) {
      map['amount_text'] = Variable<String>(amountText);
    }
    if (!nullToAbsent || preparationState != null) {
      map['preparation_state'] = Variable<String>(preparationState);
    }
    map['optional_flag'] = Variable<bool>(optionalFlag);
    map['sort_order'] = Variable<int>(sortOrder);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  PdfRecipeIngredientsCompanion toCompanion(bool nullToAbsent) {
    return PdfRecipeIngredientsCompanion(
      id: Value(id),
      recipeId: Value(recipeId),
      ingredientNameRaw: Value(ingredientNameRaw),
      ingredientNameNormalized: ingredientNameNormalized == null && nullToAbsent
          ? const Value.absent()
          : Value(ingredientNameNormalized),
      amount: amount == null && nullToAbsent
          ? const Value.absent()
          : Value(amount),
      unit: unit == null && nullToAbsent ? const Value.absent() : Value(unit),
      amountText: amountText == null && nullToAbsent
          ? const Value.absent()
          : Value(amountText),
      preparationState: preparationState == null && nullToAbsent
          ? const Value.absent()
          : Value(preparationState),
      optionalFlag: Value(optionalFlag),
      sortOrder: Value(sortOrder),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory PdfRecipeIngredient.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PdfRecipeIngredient(
      id: serializer.fromJson<int>(json['id']),
      recipeId: serializer.fromJson<int>(json['recipeId']),
      ingredientNameRaw: serializer.fromJson<String>(json['ingredientNameRaw']),
      ingredientNameNormalized: serializer.fromJson<String?>(
        json['ingredientNameNormalized'],
      ),
      amount: serializer.fromJson<double?>(json['amount']),
      unit: serializer.fromJson<String?>(json['unit']),
      amountText: serializer.fromJson<String?>(json['amountText']),
      preparationState: serializer.fromJson<String?>(json['preparationState']),
      optionalFlag: serializer.fromJson<bool>(json['optionalFlag']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'recipeId': serializer.toJson<int>(recipeId),
      'ingredientNameRaw': serializer.toJson<String>(ingredientNameRaw),
      'ingredientNameNormalized': serializer.toJson<String?>(
        ingredientNameNormalized,
      ),
      'amount': serializer.toJson<double?>(amount),
      'unit': serializer.toJson<String?>(unit),
      'amountText': serializer.toJson<String?>(amountText),
      'preparationState': serializer.toJson<String?>(preparationState),
      'optionalFlag': serializer.toJson<bool>(optionalFlag),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  PdfRecipeIngredient copyWith({
    int? id,
    int? recipeId,
    String? ingredientNameRaw,
    Value<String?> ingredientNameNormalized = const Value.absent(),
    Value<double?> amount = const Value.absent(),
    Value<String?> unit = const Value.absent(),
    Value<String?> amountText = const Value.absent(),
    Value<String?> preparationState = const Value.absent(),
    bool? optionalFlag,
    int? sortOrder,
    Value<String?> notes = const Value.absent(),
  }) => PdfRecipeIngredient(
    id: id ?? this.id,
    recipeId: recipeId ?? this.recipeId,
    ingredientNameRaw: ingredientNameRaw ?? this.ingredientNameRaw,
    ingredientNameNormalized: ingredientNameNormalized.present
        ? ingredientNameNormalized.value
        : this.ingredientNameNormalized,
    amount: amount.present ? amount.value : this.amount,
    unit: unit.present ? unit.value : this.unit,
    amountText: amountText.present ? amountText.value : this.amountText,
    preparationState: preparationState.present
        ? preparationState.value
        : this.preparationState,
    optionalFlag: optionalFlag ?? this.optionalFlag,
    sortOrder: sortOrder ?? this.sortOrder,
    notes: notes.present ? notes.value : this.notes,
  );
  PdfRecipeIngredient copyWithCompanion(PdfRecipeIngredientsCompanion data) {
    return PdfRecipeIngredient(
      id: data.id.present ? data.id.value : this.id,
      recipeId: data.recipeId.present ? data.recipeId.value : this.recipeId,
      ingredientNameRaw: data.ingredientNameRaw.present
          ? data.ingredientNameRaw.value
          : this.ingredientNameRaw,
      ingredientNameNormalized: data.ingredientNameNormalized.present
          ? data.ingredientNameNormalized.value
          : this.ingredientNameNormalized,
      amount: data.amount.present ? data.amount.value : this.amount,
      unit: data.unit.present ? data.unit.value : this.unit,
      amountText: data.amountText.present
          ? data.amountText.value
          : this.amountText,
      preparationState: data.preparationState.present
          ? data.preparationState.value
          : this.preparationState,
      optionalFlag: data.optionalFlag.present
          ? data.optionalFlag.value
          : this.optionalFlag,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PdfRecipeIngredient(')
          ..write('id: $id, ')
          ..write('recipeId: $recipeId, ')
          ..write('ingredientNameRaw: $ingredientNameRaw, ')
          ..write('ingredientNameNormalized: $ingredientNameNormalized, ')
          ..write('amount: $amount, ')
          ..write('unit: $unit, ')
          ..write('amountText: $amountText, ')
          ..write('preparationState: $preparationState, ')
          ..write('optionalFlag: $optionalFlag, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    recipeId,
    ingredientNameRaw,
    ingredientNameNormalized,
    amount,
    unit,
    amountText,
    preparationState,
    optionalFlag,
    sortOrder,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PdfRecipeIngredient &&
          other.id == this.id &&
          other.recipeId == this.recipeId &&
          other.ingredientNameRaw == this.ingredientNameRaw &&
          other.ingredientNameNormalized == this.ingredientNameNormalized &&
          other.amount == this.amount &&
          other.unit == this.unit &&
          other.amountText == this.amountText &&
          other.preparationState == this.preparationState &&
          other.optionalFlag == this.optionalFlag &&
          other.sortOrder == this.sortOrder &&
          other.notes == this.notes);
}

class PdfRecipeIngredientsCompanion
    extends UpdateCompanion<PdfRecipeIngredient> {
  final Value<int> id;
  final Value<int> recipeId;
  final Value<String> ingredientNameRaw;
  final Value<String?> ingredientNameNormalized;
  final Value<double?> amount;
  final Value<String?> unit;
  final Value<String?> amountText;
  final Value<String?> preparationState;
  final Value<bool> optionalFlag;
  final Value<int> sortOrder;
  final Value<String?> notes;
  const PdfRecipeIngredientsCompanion({
    this.id = const Value.absent(),
    this.recipeId = const Value.absent(),
    this.ingredientNameRaw = const Value.absent(),
    this.ingredientNameNormalized = const Value.absent(),
    this.amount = const Value.absent(),
    this.unit = const Value.absent(),
    this.amountText = const Value.absent(),
    this.preparationState = const Value.absent(),
    this.optionalFlag = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.notes = const Value.absent(),
  });
  PdfRecipeIngredientsCompanion.insert({
    this.id = const Value.absent(),
    required int recipeId,
    required String ingredientNameRaw,
    this.ingredientNameNormalized = const Value.absent(),
    this.amount = const Value.absent(),
    this.unit = const Value.absent(),
    this.amountText = const Value.absent(),
    this.preparationState = const Value.absent(),
    this.optionalFlag = const Value.absent(),
    required int sortOrder,
    this.notes = const Value.absent(),
  }) : recipeId = Value(recipeId),
       ingredientNameRaw = Value(ingredientNameRaw),
       sortOrder = Value(sortOrder);
  static Insertable<PdfRecipeIngredient> custom({
    Expression<int>? id,
    Expression<int>? recipeId,
    Expression<String>? ingredientNameRaw,
    Expression<String>? ingredientNameNormalized,
    Expression<double>? amount,
    Expression<String>? unit,
    Expression<String>? amountText,
    Expression<String>? preparationState,
    Expression<bool>? optionalFlag,
    Expression<int>? sortOrder,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (recipeId != null) 'recipe_id': recipeId,
      if (ingredientNameRaw != null) 'ingredient_name_raw': ingredientNameRaw,
      if (ingredientNameNormalized != null)
        'ingredient_name_normalized': ingredientNameNormalized,
      if (amount != null) 'amount': amount,
      if (unit != null) 'unit': unit,
      if (amountText != null) 'amount_text': amountText,
      if (preparationState != null) 'preparation_state': preparationState,
      if (optionalFlag != null) 'optional_flag': optionalFlag,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (notes != null) 'notes': notes,
    });
  }

  PdfRecipeIngredientsCompanion copyWith({
    Value<int>? id,
    Value<int>? recipeId,
    Value<String>? ingredientNameRaw,
    Value<String?>? ingredientNameNormalized,
    Value<double?>? amount,
    Value<String?>? unit,
    Value<String?>? amountText,
    Value<String?>? preparationState,
    Value<bool>? optionalFlag,
    Value<int>? sortOrder,
    Value<String?>? notes,
  }) {
    return PdfRecipeIngredientsCompanion(
      id: id ?? this.id,
      recipeId: recipeId ?? this.recipeId,
      ingredientNameRaw: ingredientNameRaw ?? this.ingredientNameRaw,
      ingredientNameNormalized:
          ingredientNameNormalized ?? this.ingredientNameNormalized,
      amount: amount ?? this.amount,
      unit: unit ?? this.unit,
      amountText: amountText ?? this.amountText,
      preparationState: preparationState ?? this.preparationState,
      optionalFlag: optionalFlag ?? this.optionalFlag,
      sortOrder: sortOrder ?? this.sortOrder,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (recipeId.present) {
      map['recipe_id'] = Variable<int>(recipeId.value);
    }
    if (ingredientNameRaw.present) {
      map['ingredient_name_raw'] = Variable<String>(ingredientNameRaw.value);
    }
    if (ingredientNameNormalized.present) {
      map['ingredient_name_normalized'] = Variable<String>(
        ingredientNameNormalized.value,
      );
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (amountText.present) {
      map['amount_text'] = Variable<String>(amountText.value);
    }
    if (preparationState.present) {
      map['preparation_state'] = Variable<String>(preparationState.value);
    }
    if (optionalFlag.present) {
      map['optional_flag'] = Variable<bool>(optionalFlag.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PdfRecipeIngredientsCompanion(')
          ..write('id: $id, ')
          ..write('recipeId: $recipeId, ')
          ..write('ingredientNameRaw: $ingredientNameRaw, ')
          ..write('ingredientNameNormalized: $ingredientNameNormalized, ')
          ..write('amount: $amount, ')
          ..write('unit: $unit, ')
          ..write('amountText: $amountText, ')
          ..write('preparationState: $preparationState, ')
          ..write('optionalFlag: $optionalFlag, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

class $PdfRecipeStepsTable extends PdfRecipeSteps
    with TableInfo<$PdfRecipeStepsTable, PdfRecipeStep> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PdfRecipeStepsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _recipeIdMeta = const VerificationMeta(
    'recipeId',
  );
  @override
  late final GeneratedColumn<int> recipeId = GeneratedColumn<int>(
    'recipe_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES recipes (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _stepNumberMeta = const VerificationMeta(
    'stepNumber',
  );
  @override
  late final GeneratedColumn<int> stepNumber = GeneratedColumn<int>(
    'step_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _instructionTextMeta = const VerificationMeta(
    'instructionText',
  );
  @override
  late final GeneratedColumn<String> instructionText = GeneratedColumn<String>(
    'instruction_text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timeMinutesMeta = const VerificationMeta(
    'timeMinutes',
  );
  @override
  late final GeneratedColumn<int> timeMinutes = GeneratedColumn<int>(
    'time_minutes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _temperatureCMeta = const VerificationMeta(
    'temperatureC',
  );
  @override
  late final GeneratedColumn<int> temperatureC = GeneratedColumn<int>(
    'temperature_c',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    recipeId,
    stepNumber,
    instructionText,
    timeMinutes,
    temperatureC,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recipe_steps';
  @override
  VerificationContext validateIntegrity(
    Insertable<PdfRecipeStep> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('recipe_id')) {
      context.handle(
        _recipeIdMeta,
        recipeId.isAcceptableOrUnknown(data['recipe_id']!, _recipeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_recipeIdMeta);
    }
    if (data.containsKey('step_number')) {
      context.handle(
        _stepNumberMeta,
        stepNumber.isAcceptableOrUnknown(data['step_number']!, _stepNumberMeta),
      );
    } else if (isInserting) {
      context.missing(_stepNumberMeta);
    }
    if (data.containsKey('instruction_text')) {
      context.handle(
        _instructionTextMeta,
        instructionText.isAcceptableOrUnknown(
          data['instruction_text']!,
          _instructionTextMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_instructionTextMeta);
    }
    if (data.containsKey('time_minutes')) {
      context.handle(
        _timeMinutesMeta,
        timeMinutes.isAcceptableOrUnknown(
          data['time_minutes']!,
          _timeMinutesMeta,
        ),
      );
    }
    if (data.containsKey('temperature_c')) {
      context.handle(
        _temperatureCMeta,
        temperatureC.isAcceptableOrUnknown(
          data['temperature_c']!,
          _temperatureCMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {recipeId, stepNumber},
  ];
  @override
  PdfRecipeStep map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PdfRecipeStep(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      recipeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}recipe_id'],
      )!,
      stepNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}step_number'],
      )!,
      instructionText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}instruction_text'],
      )!,
      timeMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}time_minutes'],
      ),
      temperatureC: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}temperature_c'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $PdfRecipeStepsTable createAlias(String alias) {
    return $PdfRecipeStepsTable(attachedDatabase, alias);
  }
}

class PdfRecipeStep extends DataClass implements Insertable<PdfRecipeStep> {
  final int id;
  final int recipeId;
  final int stepNumber;
  final String instructionText;
  final int? timeMinutes;
  final int? temperatureC;
  final String? notes;
  const PdfRecipeStep({
    required this.id,
    required this.recipeId,
    required this.stepNumber,
    required this.instructionText,
    this.timeMinutes,
    this.temperatureC,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['recipe_id'] = Variable<int>(recipeId);
    map['step_number'] = Variable<int>(stepNumber);
    map['instruction_text'] = Variable<String>(instructionText);
    if (!nullToAbsent || timeMinutes != null) {
      map['time_minutes'] = Variable<int>(timeMinutes);
    }
    if (!nullToAbsent || temperatureC != null) {
      map['temperature_c'] = Variable<int>(temperatureC);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  PdfRecipeStepsCompanion toCompanion(bool nullToAbsent) {
    return PdfRecipeStepsCompanion(
      id: Value(id),
      recipeId: Value(recipeId),
      stepNumber: Value(stepNumber),
      instructionText: Value(instructionText),
      timeMinutes: timeMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(timeMinutes),
      temperatureC: temperatureC == null && nullToAbsent
          ? const Value.absent()
          : Value(temperatureC),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory PdfRecipeStep.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PdfRecipeStep(
      id: serializer.fromJson<int>(json['id']),
      recipeId: serializer.fromJson<int>(json['recipeId']),
      stepNumber: serializer.fromJson<int>(json['stepNumber']),
      instructionText: serializer.fromJson<String>(json['instructionText']),
      timeMinutes: serializer.fromJson<int?>(json['timeMinutes']),
      temperatureC: serializer.fromJson<int?>(json['temperatureC']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'recipeId': serializer.toJson<int>(recipeId),
      'stepNumber': serializer.toJson<int>(stepNumber),
      'instructionText': serializer.toJson<String>(instructionText),
      'timeMinutes': serializer.toJson<int?>(timeMinutes),
      'temperatureC': serializer.toJson<int?>(temperatureC),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  PdfRecipeStep copyWith({
    int? id,
    int? recipeId,
    int? stepNumber,
    String? instructionText,
    Value<int?> timeMinutes = const Value.absent(),
    Value<int?> temperatureC = const Value.absent(),
    Value<String?> notes = const Value.absent(),
  }) => PdfRecipeStep(
    id: id ?? this.id,
    recipeId: recipeId ?? this.recipeId,
    stepNumber: stepNumber ?? this.stepNumber,
    instructionText: instructionText ?? this.instructionText,
    timeMinutes: timeMinutes.present ? timeMinutes.value : this.timeMinutes,
    temperatureC: temperatureC.present ? temperatureC.value : this.temperatureC,
    notes: notes.present ? notes.value : this.notes,
  );
  PdfRecipeStep copyWithCompanion(PdfRecipeStepsCompanion data) {
    return PdfRecipeStep(
      id: data.id.present ? data.id.value : this.id,
      recipeId: data.recipeId.present ? data.recipeId.value : this.recipeId,
      stepNumber: data.stepNumber.present
          ? data.stepNumber.value
          : this.stepNumber,
      instructionText: data.instructionText.present
          ? data.instructionText.value
          : this.instructionText,
      timeMinutes: data.timeMinutes.present
          ? data.timeMinutes.value
          : this.timeMinutes,
      temperatureC: data.temperatureC.present
          ? data.temperatureC.value
          : this.temperatureC,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PdfRecipeStep(')
          ..write('id: $id, ')
          ..write('recipeId: $recipeId, ')
          ..write('stepNumber: $stepNumber, ')
          ..write('instructionText: $instructionText, ')
          ..write('timeMinutes: $timeMinutes, ')
          ..write('temperatureC: $temperatureC, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    recipeId,
    stepNumber,
    instructionText,
    timeMinutes,
    temperatureC,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PdfRecipeStep &&
          other.id == this.id &&
          other.recipeId == this.recipeId &&
          other.stepNumber == this.stepNumber &&
          other.instructionText == this.instructionText &&
          other.timeMinutes == this.timeMinutes &&
          other.temperatureC == this.temperatureC &&
          other.notes == this.notes);
}

class PdfRecipeStepsCompanion extends UpdateCompanion<PdfRecipeStep> {
  final Value<int> id;
  final Value<int> recipeId;
  final Value<int> stepNumber;
  final Value<String> instructionText;
  final Value<int?> timeMinutes;
  final Value<int?> temperatureC;
  final Value<String?> notes;
  const PdfRecipeStepsCompanion({
    this.id = const Value.absent(),
    this.recipeId = const Value.absent(),
    this.stepNumber = const Value.absent(),
    this.instructionText = const Value.absent(),
    this.timeMinutes = const Value.absent(),
    this.temperatureC = const Value.absent(),
    this.notes = const Value.absent(),
  });
  PdfRecipeStepsCompanion.insert({
    this.id = const Value.absent(),
    required int recipeId,
    required int stepNumber,
    required String instructionText,
    this.timeMinutes = const Value.absent(),
    this.temperatureC = const Value.absent(),
    this.notes = const Value.absent(),
  }) : recipeId = Value(recipeId),
       stepNumber = Value(stepNumber),
       instructionText = Value(instructionText);
  static Insertable<PdfRecipeStep> custom({
    Expression<int>? id,
    Expression<int>? recipeId,
    Expression<int>? stepNumber,
    Expression<String>? instructionText,
    Expression<int>? timeMinutes,
    Expression<int>? temperatureC,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (recipeId != null) 'recipe_id': recipeId,
      if (stepNumber != null) 'step_number': stepNumber,
      if (instructionText != null) 'instruction_text': instructionText,
      if (timeMinutes != null) 'time_minutes': timeMinutes,
      if (temperatureC != null) 'temperature_c': temperatureC,
      if (notes != null) 'notes': notes,
    });
  }

  PdfRecipeStepsCompanion copyWith({
    Value<int>? id,
    Value<int>? recipeId,
    Value<int>? stepNumber,
    Value<String>? instructionText,
    Value<int?>? timeMinutes,
    Value<int?>? temperatureC,
    Value<String?>? notes,
  }) {
    return PdfRecipeStepsCompanion(
      id: id ?? this.id,
      recipeId: recipeId ?? this.recipeId,
      stepNumber: stepNumber ?? this.stepNumber,
      instructionText: instructionText ?? this.instructionText,
      timeMinutes: timeMinutes ?? this.timeMinutes,
      temperatureC: temperatureC ?? this.temperatureC,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (recipeId.present) {
      map['recipe_id'] = Variable<int>(recipeId.value);
    }
    if (stepNumber.present) {
      map['step_number'] = Variable<int>(stepNumber.value);
    }
    if (instructionText.present) {
      map['instruction_text'] = Variable<String>(instructionText.value);
    }
    if (timeMinutes.present) {
      map['time_minutes'] = Variable<int>(timeMinutes.value);
    }
    if (temperatureC.present) {
      map['temperature_c'] = Variable<int>(temperatureC.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PdfRecipeStepsCompanion(')
          ..write('id: $id, ')
          ..write('recipeId: $recipeId, ')
          ..write('stepNumber: $stepNumber, ')
          ..write('instructionText: $instructionText, ')
          ..write('timeMinutes: $timeMinutes, ')
          ..write('temperatureC: $temperatureC, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

class $PdfRecipeNutritionTable extends PdfRecipeNutrition
    with TableInfo<$PdfRecipeNutritionTable, PdfRecipeNutritionData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PdfRecipeNutritionTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _recipeIdMeta = const VerificationMeta(
    'recipeId',
  );
  @override
  late final GeneratedColumn<int> recipeId = GeneratedColumn<int>(
    'recipe_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES recipes (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _basisTypeMeta = const VerificationMeta(
    'basisType',
  );
  @override
  late final GeneratedColumn<String> basisType = GeneratedColumn<String>(
    'basis_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _basisValueMeta = const VerificationMeta(
    'basisValue',
  );
  @override
  late final GeneratedColumn<double> basisValue = GeneratedColumn<double>(
    'basis_value',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _kcalMeta = const VerificationMeta('kcal');
  @override
  late final GeneratedColumn<double> kcal = GeneratedColumn<double>(
    'kcal',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _proteinMeta = const VerificationMeta(
    'protein',
  );
  @override
  late final GeneratedColumn<double> protein = GeneratedColumn<double>(
    'protein',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fatMeta = const VerificationMeta('fat');
  @override
  late final GeneratedColumn<double> fat = GeneratedColumn<double>(
    'fat',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _carbsMeta = const VerificationMeta('carbs');
  @override
  late final GeneratedColumn<double> carbs = GeneratedColumn<double>(
    'carbs',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fiberMeta = const VerificationMeta('fiber');
  @override
  late final GeneratedColumn<double> fiber = GeneratedColumn<double>(
    'fiber',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _provenanceMeta = const VerificationMeta(
    'provenance',
  );
  @override
  late final GeneratedColumn<String> provenance = GeneratedColumn<String>(
    'provenance',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('declared'),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    recipeId,
    basisType,
    basisValue,
    kcal,
    protein,
    fat,
    carbs,
    fiber,
    provenance,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recipe_nutrition';
  @override
  VerificationContext validateIntegrity(
    Insertable<PdfRecipeNutritionData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('recipe_id')) {
      context.handle(
        _recipeIdMeta,
        recipeId.isAcceptableOrUnknown(data['recipe_id']!, _recipeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_recipeIdMeta);
    }
    if (data.containsKey('basis_type')) {
      context.handle(
        _basisTypeMeta,
        basisType.isAcceptableOrUnknown(data['basis_type']!, _basisTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_basisTypeMeta);
    }
    if (data.containsKey('basis_value')) {
      context.handle(
        _basisValueMeta,
        basisValue.isAcceptableOrUnknown(data['basis_value']!, _basisValueMeta),
      );
    }
    if (data.containsKey('kcal')) {
      context.handle(
        _kcalMeta,
        kcal.isAcceptableOrUnknown(data['kcal']!, _kcalMeta),
      );
    }
    if (data.containsKey('protein')) {
      context.handle(
        _proteinMeta,
        protein.isAcceptableOrUnknown(data['protein']!, _proteinMeta),
      );
    }
    if (data.containsKey('fat')) {
      context.handle(
        _fatMeta,
        fat.isAcceptableOrUnknown(data['fat']!, _fatMeta),
      );
    }
    if (data.containsKey('carbs')) {
      context.handle(
        _carbsMeta,
        carbs.isAcceptableOrUnknown(data['carbs']!, _carbsMeta),
      );
    }
    if (data.containsKey('fiber')) {
      context.handle(
        _fiberMeta,
        fiber.isAcceptableOrUnknown(data['fiber']!, _fiberMeta),
      );
    }
    if (data.containsKey('provenance')) {
      context.handle(
        _provenanceMeta,
        provenance.isAcceptableOrUnknown(data['provenance']!, _provenanceMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PdfRecipeNutritionData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PdfRecipeNutritionData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      recipeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}recipe_id'],
      )!,
      basisType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}basis_type'],
      )!,
      basisValue: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}basis_value'],
      ),
      kcal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}kcal'],
      ),
      protein: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}protein'],
      ),
      fat: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fat'],
      ),
      carbs: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}carbs'],
      ),
      fiber: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fiber'],
      ),
      provenance: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}provenance'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $PdfRecipeNutritionTable createAlias(String alias) {
    return $PdfRecipeNutritionTable(attachedDatabase, alias);
  }
}

class PdfRecipeNutritionData extends DataClass
    implements Insertable<PdfRecipeNutritionData> {
  final int id;
  final int recipeId;
  final String basisType;
  final double? basisValue;
  final double? kcal;
  final double? protein;
  final double? fat;
  final double? carbs;
  final double? fiber;
  final String provenance;
  final String? notes;
  const PdfRecipeNutritionData({
    required this.id,
    required this.recipeId,
    required this.basisType,
    this.basisValue,
    this.kcal,
    this.protein,
    this.fat,
    this.carbs,
    this.fiber,
    required this.provenance,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['recipe_id'] = Variable<int>(recipeId);
    map['basis_type'] = Variable<String>(basisType);
    if (!nullToAbsent || basisValue != null) {
      map['basis_value'] = Variable<double>(basisValue);
    }
    if (!nullToAbsent || kcal != null) {
      map['kcal'] = Variable<double>(kcal);
    }
    if (!nullToAbsent || protein != null) {
      map['protein'] = Variable<double>(protein);
    }
    if (!nullToAbsent || fat != null) {
      map['fat'] = Variable<double>(fat);
    }
    if (!nullToAbsent || carbs != null) {
      map['carbs'] = Variable<double>(carbs);
    }
    if (!nullToAbsent || fiber != null) {
      map['fiber'] = Variable<double>(fiber);
    }
    map['provenance'] = Variable<String>(provenance);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  PdfRecipeNutritionCompanion toCompanion(bool nullToAbsent) {
    return PdfRecipeNutritionCompanion(
      id: Value(id),
      recipeId: Value(recipeId),
      basisType: Value(basisType),
      basisValue: basisValue == null && nullToAbsent
          ? const Value.absent()
          : Value(basisValue),
      kcal: kcal == null && nullToAbsent ? const Value.absent() : Value(kcal),
      protein: protein == null && nullToAbsent
          ? const Value.absent()
          : Value(protein),
      fat: fat == null && nullToAbsent ? const Value.absent() : Value(fat),
      carbs: carbs == null && nullToAbsent
          ? const Value.absent()
          : Value(carbs),
      fiber: fiber == null && nullToAbsent
          ? const Value.absent()
          : Value(fiber),
      provenance: Value(provenance),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory PdfRecipeNutritionData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PdfRecipeNutritionData(
      id: serializer.fromJson<int>(json['id']),
      recipeId: serializer.fromJson<int>(json['recipeId']),
      basisType: serializer.fromJson<String>(json['basisType']),
      basisValue: serializer.fromJson<double?>(json['basisValue']),
      kcal: serializer.fromJson<double?>(json['kcal']),
      protein: serializer.fromJson<double?>(json['protein']),
      fat: serializer.fromJson<double?>(json['fat']),
      carbs: serializer.fromJson<double?>(json['carbs']),
      fiber: serializer.fromJson<double?>(json['fiber']),
      provenance: serializer.fromJson<String>(json['provenance']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'recipeId': serializer.toJson<int>(recipeId),
      'basisType': serializer.toJson<String>(basisType),
      'basisValue': serializer.toJson<double?>(basisValue),
      'kcal': serializer.toJson<double?>(kcal),
      'protein': serializer.toJson<double?>(protein),
      'fat': serializer.toJson<double?>(fat),
      'carbs': serializer.toJson<double?>(carbs),
      'fiber': serializer.toJson<double?>(fiber),
      'provenance': serializer.toJson<String>(provenance),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  PdfRecipeNutritionData copyWith({
    int? id,
    int? recipeId,
    String? basisType,
    Value<double?> basisValue = const Value.absent(),
    Value<double?> kcal = const Value.absent(),
    Value<double?> protein = const Value.absent(),
    Value<double?> fat = const Value.absent(),
    Value<double?> carbs = const Value.absent(),
    Value<double?> fiber = const Value.absent(),
    String? provenance,
    Value<String?> notes = const Value.absent(),
  }) => PdfRecipeNutritionData(
    id: id ?? this.id,
    recipeId: recipeId ?? this.recipeId,
    basisType: basisType ?? this.basisType,
    basisValue: basisValue.present ? basisValue.value : this.basisValue,
    kcal: kcal.present ? kcal.value : this.kcal,
    protein: protein.present ? protein.value : this.protein,
    fat: fat.present ? fat.value : this.fat,
    carbs: carbs.present ? carbs.value : this.carbs,
    fiber: fiber.present ? fiber.value : this.fiber,
    provenance: provenance ?? this.provenance,
    notes: notes.present ? notes.value : this.notes,
  );
  PdfRecipeNutritionData copyWithCompanion(PdfRecipeNutritionCompanion data) {
    return PdfRecipeNutritionData(
      id: data.id.present ? data.id.value : this.id,
      recipeId: data.recipeId.present ? data.recipeId.value : this.recipeId,
      basisType: data.basisType.present ? data.basisType.value : this.basisType,
      basisValue: data.basisValue.present
          ? data.basisValue.value
          : this.basisValue,
      kcal: data.kcal.present ? data.kcal.value : this.kcal,
      protein: data.protein.present ? data.protein.value : this.protein,
      fat: data.fat.present ? data.fat.value : this.fat,
      carbs: data.carbs.present ? data.carbs.value : this.carbs,
      fiber: data.fiber.present ? data.fiber.value : this.fiber,
      provenance: data.provenance.present
          ? data.provenance.value
          : this.provenance,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PdfRecipeNutritionData(')
          ..write('id: $id, ')
          ..write('recipeId: $recipeId, ')
          ..write('basisType: $basisType, ')
          ..write('basisValue: $basisValue, ')
          ..write('kcal: $kcal, ')
          ..write('protein: $protein, ')
          ..write('fat: $fat, ')
          ..write('carbs: $carbs, ')
          ..write('fiber: $fiber, ')
          ..write('provenance: $provenance, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    recipeId,
    basisType,
    basisValue,
    kcal,
    protein,
    fat,
    carbs,
    fiber,
    provenance,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PdfRecipeNutritionData &&
          other.id == this.id &&
          other.recipeId == this.recipeId &&
          other.basisType == this.basisType &&
          other.basisValue == this.basisValue &&
          other.kcal == this.kcal &&
          other.protein == this.protein &&
          other.fat == this.fat &&
          other.carbs == this.carbs &&
          other.fiber == this.fiber &&
          other.provenance == this.provenance &&
          other.notes == this.notes);
}

class PdfRecipeNutritionCompanion
    extends UpdateCompanion<PdfRecipeNutritionData> {
  final Value<int> id;
  final Value<int> recipeId;
  final Value<String> basisType;
  final Value<double?> basisValue;
  final Value<double?> kcal;
  final Value<double?> protein;
  final Value<double?> fat;
  final Value<double?> carbs;
  final Value<double?> fiber;
  final Value<String> provenance;
  final Value<String?> notes;
  const PdfRecipeNutritionCompanion({
    this.id = const Value.absent(),
    this.recipeId = const Value.absent(),
    this.basisType = const Value.absent(),
    this.basisValue = const Value.absent(),
    this.kcal = const Value.absent(),
    this.protein = const Value.absent(),
    this.fat = const Value.absent(),
    this.carbs = const Value.absent(),
    this.fiber = const Value.absent(),
    this.provenance = const Value.absent(),
    this.notes = const Value.absent(),
  });
  PdfRecipeNutritionCompanion.insert({
    this.id = const Value.absent(),
    required int recipeId,
    required String basisType,
    this.basisValue = const Value.absent(),
    this.kcal = const Value.absent(),
    this.protein = const Value.absent(),
    this.fat = const Value.absent(),
    this.carbs = const Value.absent(),
    this.fiber = const Value.absent(),
    this.provenance = const Value.absent(),
    this.notes = const Value.absent(),
  }) : recipeId = Value(recipeId),
       basisType = Value(basisType);
  static Insertable<PdfRecipeNutritionData> custom({
    Expression<int>? id,
    Expression<int>? recipeId,
    Expression<String>? basisType,
    Expression<double>? basisValue,
    Expression<double>? kcal,
    Expression<double>? protein,
    Expression<double>? fat,
    Expression<double>? carbs,
    Expression<double>? fiber,
    Expression<String>? provenance,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (recipeId != null) 'recipe_id': recipeId,
      if (basisType != null) 'basis_type': basisType,
      if (basisValue != null) 'basis_value': basisValue,
      if (kcal != null) 'kcal': kcal,
      if (protein != null) 'protein': protein,
      if (fat != null) 'fat': fat,
      if (carbs != null) 'carbs': carbs,
      if (fiber != null) 'fiber': fiber,
      if (provenance != null) 'provenance': provenance,
      if (notes != null) 'notes': notes,
    });
  }

  PdfRecipeNutritionCompanion copyWith({
    Value<int>? id,
    Value<int>? recipeId,
    Value<String>? basisType,
    Value<double?>? basisValue,
    Value<double?>? kcal,
    Value<double?>? protein,
    Value<double?>? fat,
    Value<double?>? carbs,
    Value<double?>? fiber,
    Value<String>? provenance,
    Value<String?>? notes,
  }) {
    return PdfRecipeNutritionCompanion(
      id: id ?? this.id,
      recipeId: recipeId ?? this.recipeId,
      basisType: basisType ?? this.basisType,
      basisValue: basisValue ?? this.basisValue,
      kcal: kcal ?? this.kcal,
      protein: protein ?? this.protein,
      fat: fat ?? this.fat,
      carbs: carbs ?? this.carbs,
      fiber: fiber ?? this.fiber,
      provenance: provenance ?? this.provenance,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (recipeId.present) {
      map['recipe_id'] = Variable<int>(recipeId.value);
    }
    if (basisType.present) {
      map['basis_type'] = Variable<String>(basisType.value);
    }
    if (basisValue.present) {
      map['basis_value'] = Variable<double>(basisValue.value);
    }
    if (kcal.present) {
      map['kcal'] = Variable<double>(kcal.value);
    }
    if (protein.present) {
      map['protein'] = Variable<double>(protein.value);
    }
    if (fat.present) {
      map['fat'] = Variable<double>(fat.value);
    }
    if (carbs.present) {
      map['carbs'] = Variable<double>(carbs.value);
    }
    if (fiber.present) {
      map['fiber'] = Variable<double>(fiber.value);
    }
    if (provenance.present) {
      map['provenance'] = Variable<String>(provenance.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PdfRecipeNutritionCompanion(')
          ..write('id: $id, ')
          ..write('recipeId: $recipeId, ')
          ..write('basisType: $basisType, ')
          ..write('basisValue: $basisValue, ')
          ..write('kcal: $kcal, ')
          ..write('protein: $protein, ')
          ..write('fat: $fat, ')
          ..write('carbs: $carbs, ')
          ..write('fiber: $fiber, ')
          ..write('provenance: $provenance, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

class $PdfRecipeMediaTable extends PdfRecipeMedia
    with TableInfo<$PdfRecipeMediaTable, PdfRecipeMediaData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PdfRecipeMediaTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _recipeIdMeta = const VerificationMeta(
    'recipeId',
  );
  @override
  late final GeneratedColumn<int> recipeId = GeneratedColumn<int>(
    'recipe_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES recipes (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _mediaAssetIdMeta = const VerificationMeta(
    'mediaAssetId',
  );
  @override
  late final GeneratedColumn<int> mediaAssetId = GeneratedColumn<int>(
    'media_asset_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES media_assets (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _isPrimaryMeta = const VerificationMeta(
    'isPrimary',
  );
  @override
  late final GeneratedColumn<bool> isPrimary = GeneratedColumn<bool>(
    'is_primary',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_primary" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    recipeId,
    mediaAssetId,
    isPrimary,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recipe_media';
  @override
  VerificationContext validateIntegrity(
    Insertable<PdfRecipeMediaData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('recipe_id')) {
      context.handle(
        _recipeIdMeta,
        recipeId.isAcceptableOrUnknown(data['recipe_id']!, _recipeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_recipeIdMeta);
    }
    if (data.containsKey('media_asset_id')) {
      context.handle(
        _mediaAssetIdMeta,
        mediaAssetId.isAcceptableOrUnknown(
          data['media_asset_id']!,
          _mediaAssetIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_mediaAssetIdMeta);
    }
    if (data.containsKey('is_primary')) {
      context.handle(
        _isPrimaryMeta,
        isPrimary.isAcceptableOrUnknown(data['is_primary']!, _isPrimaryMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {recipeId, mediaAssetId};
  @override
  PdfRecipeMediaData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PdfRecipeMediaData(
      recipeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}recipe_id'],
      )!,
      mediaAssetId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}media_asset_id'],
      )!,
      isPrimary: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_primary'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $PdfRecipeMediaTable createAlias(String alias) {
    return $PdfRecipeMediaTable(attachedDatabase, alias);
  }
}

class PdfRecipeMediaData extends DataClass
    implements Insertable<PdfRecipeMediaData> {
  final int recipeId;
  final int mediaAssetId;
  final bool isPrimary;
  final int sortOrder;
  const PdfRecipeMediaData({
    required this.recipeId,
    required this.mediaAssetId,
    required this.isPrimary,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['recipe_id'] = Variable<int>(recipeId);
    map['media_asset_id'] = Variable<int>(mediaAssetId);
    map['is_primary'] = Variable<bool>(isPrimary);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  PdfRecipeMediaCompanion toCompanion(bool nullToAbsent) {
    return PdfRecipeMediaCompanion(
      recipeId: Value(recipeId),
      mediaAssetId: Value(mediaAssetId),
      isPrimary: Value(isPrimary),
      sortOrder: Value(sortOrder),
    );
  }

  factory PdfRecipeMediaData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PdfRecipeMediaData(
      recipeId: serializer.fromJson<int>(json['recipeId']),
      mediaAssetId: serializer.fromJson<int>(json['mediaAssetId']),
      isPrimary: serializer.fromJson<bool>(json['isPrimary']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'recipeId': serializer.toJson<int>(recipeId),
      'mediaAssetId': serializer.toJson<int>(mediaAssetId),
      'isPrimary': serializer.toJson<bool>(isPrimary),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  PdfRecipeMediaData copyWith({
    int? recipeId,
    int? mediaAssetId,
    bool? isPrimary,
    int? sortOrder,
  }) => PdfRecipeMediaData(
    recipeId: recipeId ?? this.recipeId,
    mediaAssetId: mediaAssetId ?? this.mediaAssetId,
    isPrimary: isPrimary ?? this.isPrimary,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  PdfRecipeMediaData copyWithCompanion(PdfRecipeMediaCompanion data) {
    return PdfRecipeMediaData(
      recipeId: data.recipeId.present ? data.recipeId.value : this.recipeId,
      mediaAssetId: data.mediaAssetId.present
          ? data.mediaAssetId.value
          : this.mediaAssetId,
      isPrimary: data.isPrimary.present ? data.isPrimary.value : this.isPrimary,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PdfRecipeMediaData(')
          ..write('recipeId: $recipeId, ')
          ..write('mediaAssetId: $mediaAssetId, ')
          ..write('isPrimary: $isPrimary, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(recipeId, mediaAssetId, isPrimary, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PdfRecipeMediaData &&
          other.recipeId == this.recipeId &&
          other.mediaAssetId == this.mediaAssetId &&
          other.isPrimary == this.isPrimary &&
          other.sortOrder == this.sortOrder);
}

class PdfRecipeMediaCompanion extends UpdateCompanion<PdfRecipeMediaData> {
  final Value<int> recipeId;
  final Value<int> mediaAssetId;
  final Value<bool> isPrimary;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const PdfRecipeMediaCompanion({
    this.recipeId = const Value.absent(),
    this.mediaAssetId = const Value.absent(),
    this.isPrimary = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PdfRecipeMediaCompanion.insert({
    required int recipeId,
    required int mediaAssetId,
    this.isPrimary = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : recipeId = Value(recipeId),
       mediaAssetId = Value(mediaAssetId);
  static Insertable<PdfRecipeMediaData> custom({
    Expression<int>? recipeId,
    Expression<int>? mediaAssetId,
    Expression<bool>? isPrimary,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (recipeId != null) 'recipe_id': recipeId,
      if (mediaAssetId != null) 'media_asset_id': mediaAssetId,
      if (isPrimary != null) 'is_primary': isPrimary,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PdfRecipeMediaCompanion copyWith({
    Value<int>? recipeId,
    Value<int>? mediaAssetId,
    Value<bool>? isPrimary,
    Value<int>? sortOrder,
    Value<int>? rowid,
  }) {
    return PdfRecipeMediaCompanion(
      recipeId: recipeId ?? this.recipeId,
      mediaAssetId: mediaAssetId ?? this.mediaAssetId,
      isPrimary: isPrimary ?? this.isPrimary,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (recipeId.present) {
      map['recipe_id'] = Variable<int>(recipeId.value);
    }
    if (mediaAssetId.present) {
      map['media_asset_id'] = Variable<int>(mediaAssetId.value);
    }
    if (isPrimary.present) {
      map['is_primary'] = Variable<bool>(isPrimary.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PdfRecipeMediaCompanion(')
          ..write('recipeId: $recipeId, ')
          ..write('mediaAssetId: $mediaAssetId, ')
          ..write('isPrimary: $isPrimary, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PdfSimpleProductNutritionTable extends PdfSimpleProductNutrition
    with
        TableInfo<
          $PdfSimpleProductNutritionTable,
          PdfSimpleProductNutritionData
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PdfSimpleProductNutritionTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _simpleProductIdMeta = const VerificationMeta(
    'simpleProductId',
  );
  @override
  late final GeneratedColumn<int> simpleProductId = GeneratedColumn<int>(
    'simple_product_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES simple_products (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _basisTypeMeta = const VerificationMeta(
    'basisType',
  );
  @override
  late final GeneratedColumn<String> basisType = GeneratedColumn<String>(
    'basis_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _basisValueMeta = const VerificationMeta(
    'basisValue',
  );
  @override
  late final GeneratedColumn<double> basisValue = GeneratedColumn<double>(
    'basis_value',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _kcalMeta = const VerificationMeta('kcal');
  @override
  late final GeneratedColumn<double> kcal = GeneratedColumn<double>(
    'kcal',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _proteinMeta = const VerificationMeta(
    'protein',
  );
  @override
  late final GeneratedColumn<double> protein = GeneratedColumn<double>(
    'protein',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fatMeta = const VerificationMeta('fat');
  @override
  late final GeneratedColumn<double> fat = GeneratedColumn<double>(
    'fat',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _carbsMeta = const VerificationMeta('carbs');
  @override
  late final GeneratedColumn<double> carbs = GeneratedColumn<double>(
    'carbs',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _provenanceMeta = const VerificationMeta(
    'provenance',
  );
  @override
  late final GeneratedColumn<String> provenance = GeneratedColumn<String>(
    'provenance',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('declared'),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    simpleProductId,
    basisType,
    basisValue,
    kcal,
    protein,
    fat,
    carbs,
    provenance,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'simple_product_nutrition';
  @override
  VerificationContext validateIntegrity(
    Insertable<PdfSimpleProductNutritionData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('simple_product_id')) {
      context.handle(
        _simpleProductIdMeta,
        simpleProductId.isAcceptableOrUnknown(
          data['simple_product_id']!,
          _simpleProductIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_simpleProductIdMeta);
    }
    if (data.containsKey('basis_type')) {
      context.handle(
        _basisTypeMeta,
        basisType.isAcceptableOrUnknown(data['basis_type']!, _basisTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_basisTypeMeta);
    }
    if (data.containsKey('basis_value')) {
      context.handle(
        _basisValueMeta,
        basisValue.isAcceptableOrUnknown(data['basis_value']!, _basisValueMeta),
      );
    }
    if (data.containsKey('kcal')) {
      context.handle(
        _kcalMeta,
        kcal.isAcceptableOrUnknown(data['kcal']!, _kcalMeta),
      );
    }
    if (data.containsKey('protein')) {
      context.handle(
        _proteinMeta,
        protein.isAcceptableOrUnknown(data['protein']!, _proteinMeta),
      );
    }
    if (data.containsKey('fat')) {
      context.handle(
        _fatMeta,
        fat.isAcceptableOrUnknown(data['fat']!, _fatMeta),
      );
    }
    if (data.containsKey('carbs')) {
      context.handle(
        _carbsMeta,
        carbs.isAcceptableOrUnknown(data['carbs']!, _carbsMeta),
      );
    }
    if (data.containsKey('provenance')) {
      context.handle(
        _provenanceMeta,
        provenance.isAcceptableOrUnknown(data['provenance']!, _provenanceMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PdfSimpleProductNutritionData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PdfSimpleProductNutritionData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      simpleProductId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}simple_product_id'],
      )!,
      basisType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}basis_type'],
      )!,
      basisValue: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}basis_value'],
      ),
      kcal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}kcal'],
      ),
      protein: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}protein'],
      ),
      fat: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fat'],
      ),
      carbs: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}carbs'],
      ),
      provenance: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}provenance'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $PdfSimpleProductNutritionTable createAlias(String alias) {
    return $PdfSimpleProductNutritionTable(attachedDatabase, alias);
  }
}

class PdfSimpleProductNutritionData extends DataClass
    implements Insertable<PdfSimpleProductNutritionData> {
  final int id;
  final int simpleProductId;
  final String basisType;
  final double? basisValue;
  final double? kcal;
  final double? protein;
  final double? fat;
  final double? carbs;
  final String provenance;
  final String? notes;
  const PdfSimpleProductNutritionData({
    required this.id,
    required this.simpleProductId,
    required this.basisType,
    this.basisValue,
    this.kcal,
    this.protein,
    this.fat,
    this.carbs,
    required this.provenance,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['simple_product_id'] = Variable<int>(simpleProductId);
    map['basis_type'] = Variable<String>(basisType);
    if (!nullToAbsent || basisValue != null) {
      map['basis_value'] = Variable<double>(basisValue);
    }
    if (!nullToAbsent || kcal != null) {
      map['kcal'] = Variable<double>(kcal);
    }
    if (!nullToAbsent || protein != null) {
      map['protein'] = Variable<double>(protein);
    }
    if (!nullToAbsent || fat != null) {
      map['fat'] = Variable<double>(fat);
    }
    if (!nullToAbsent || carbs != null) {
      map['carbs'] = Variable<double>(carbs);
    }
    map['provenance'] = Variable<String>(provenance);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  PdfSimpleProductNutritionCompanion toCompanion(bool nullToAbsent) {
    return PdfSimpleProductNutritionCompanion(
      id: Value(id),
      simpleProductId: Value(simpleProductId),
      basisType: Value(basisType),
      basisValue: basisValue == null && nullToAbsent
          ? const Value.absent()
          : Value(basisValue),
      kcal: kcal == null && nullToAbsent ? const Value.absent() : Value(kcal),
      protein: protein == null && nullToAbsent
          ? const Value.absent()
          : Value(protein),
      fat: fat == null && nullToAbsent ? const Value.absent() : Value(fat),
      carbs: carbs == null && nullToAbsent
          ? const Value.absent()
          : Value(carbs),
      provenance: Value(provenance),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory PdfSimpleProductNutritionData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PdfSimpleProductNutritionData(
      id: serializer.fromJson<int>(json['id']),
      simpleProductId: serializer.fromJson<int>(json['simpleProductId']),
      basisType: serializer.fromJson<String>(json['basisType']),
      basisValue: serializer.fromJson<double?>(json['basisValue']),
      kcal: serializer.fromJson<double?>(json['kcal']),
      protein: serializer.fromJson<double?>(json['protein']),
      fat: serializer.fromJson<double?>(json['fat']),
      carbs: serializer.fromJson<double?>(json['carbs']),
      provenance: serializer.fromJson<String>(json['provenance']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'simpleProductId': serializer.toJson<int>(simpleProductId),
      'basisType': serializer.toJson<String>(basisType),
      'basisValue': serializer.toJson<double?>(basisValue),
      'kcal': serializer.toJson<double?>(kcal),
      'protein': serializer.toJson<double?>(protein),
      'fat': serializer.toJson<double?>(fat),
      'carbs': serializer.toJson<double?>(carbs),
      'provenance': serializer.toJson<String>(provenance),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  PdfSimpleProductNutritionData copyWith({
    int? id,
    int? simpleProductId,
    String? basisType,
    Value<double?> basisValue = const Value.absent(),
    Value<double?> kcal = const Value.absent(),
    Value<double?> protein = const Value.absent(),
    Value<double?> fat = const Value.absent(),
    Value<double?> carbs = const Value.absent(),
    String? provenance,
    Value<String?> notes = const Value.absent(),
  }) => PdfSimpleProductNutritionData(
    id: id ?? this.id,
    simpleProductId: simpleProductId ?? this.simpleProductId,
    basisType: basisType ?? this.basisType,
    basisValue: basisValue.present ? basisValue.value : this.basisValue,
    kcal: kcal.present ? kcal.value : this.kcal,
    protein: protein.present ? protein.value : this.protein,
    fat: fat.present ? fat.value : this.fat,
    carbs: carbs.present ? carbs.value : this.carbs,
    provenance: provenance ?? this.provenance,
    notes: notes.present ? notes.value : this.notes,
  );
  PdfSimpleProductNutritionData copyWithCompanion(
    PdfSimpleProductNutritionCompanion data,
  ) {
    return PdfSimpleProductNutritionData(
      id: data.id.present ? data.id.value : this.id,
      simpleProductId: data.simpleProductId.present
          ? data.simpleProductId.value
          : this.simpleProductId,
      basisType: data.basisType.present ? data.basisType.value : this.basisType,
      basisValue: data.basisValue.present
          ? data.basisValue.value
          : this.basisValue,
      kcal: data.kcal.present ? data.kcal.value : this.kcal,
      protein: data.protein.present ? data.protein.value : this.protein,
      fat: data.fat.present ? data.fat.value : this.fat,
      carbs: data.carbs.present ? data.carbs.value : this.carbs,
      provenance: data.provenance.present
          ? data.provenance.value
          : this.provenance,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PdfSimpleProductNutritionData(')
          ..write('id: $id, ')
          ..write('simpleProductId: $simpleProductId, ')
          ..write('basisType: $basisType, ')
          ..write('basisValue: $basisValue, ')
          ..write('kcal: $kcal, ')
          ..write('protein: $protein, ')
          ..write('fat: $fat, ')
          ..write('carbs: $carbs, ')
          ..write('provenance: $provenance, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    simpleProductId,
    basisType,
    basisValue,
    kcal,
    protein,
    fat,
    carbs,
    provenance,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PdfSimpleProductNutritionData &&
          other.id == this.id &&
          other.simpleProductId == this.simpleProductId &&
          other.basisType == this.basisType &&
          other.basisValue == this.basisValue &&
          other.kcal == this.kcal &&
          other.protein == this.protein &&
          other.fat == this.fat &&
          other.carbs == this.carbs &&
          other.provenance == this.provenance &&
          other.notes == this.notes);
}

class PdfSimpleProductNutritionCompanion
    extends UpdateCompanion<PdfSimpleProductNutritionData> {
  final Value<int> id;
  final Value<int> simpleProductId;
  final Value<String> basisType;
  final Value<double?> basisValue;
  final Value<double?> kcal;
  final Value<double?> protein;
  final Value<double?> fat;
  final Value<double?> carbs;
  final Value<String> provenance;
  final Value<String?> notes;
  const PdfSimpleProductNutritionCompanion({
    this.id = const Value.absent(),
    this.simpleProductId = const Value.absent(),
    this.basisType = const Value.absent(),
    this.basisValue = const Value.absent(),
    this.kcal = const Value.absent(),
    this.protein = const Value.absent(),
    this.fat = const Value.absent(),
    this.carbs = const Value.absent(),
    this.provenance = const Value.absent(),
    this.notes = const Value.absent(),
  });
  PdfSimpleProductNutritionCompanion.insert({
    this.id = const Value.absent(),
    required int simpleProductId,
    required String basisType,
    this.basisValue = const Value.absent(),
    this.kcal = const Value.absent(),
    this.protein = const Value.absent(),
    this.fat = const Value.absent(),
    this.carbs = const Value.absent(),
    this.provenance = const Value.absent(),
    this.notes = const Value.absent(),
  }) : simpleProductId = Value(simpleProductId),
       basisType = Value(basisType);
  static Insertable<PdfSimpleProductNutritionData> custom({
    Expression<int>? id,
    Expression<int>? simpleProductId,
    Expression<String>? basisType,
    Expression<double>? basisValue,
    Expression<double>? kcal,
    Expression<double>? protein,
    Expression<double>? fat,
    Expression<double>? carbs,
    Expression<String>? provenance,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (simpleProductId != null) 'simple_product_id': simpleProductId,
      if (basisType != null) 'basis_type': basisType,
      if (basisValue != null) 'basis_value': basisValue,
      if (kcal != null) 'kcal': kcal,
      if (protein != null) 'protein': protein,
      if (fat != null) 'fat': fat,
      if (carbs != null) 'carbs': carbs,
      if (provenance != null) 'provenance': provenance,
      if (notes != null) 'notes': notes,
    });
  }

  PdfSimpleProductNutritionCompanion copyWith({
    Value<int>? id,
    Value<int>? simpleProductId,
    Value<String>? basisType,
    Value<double?>? basisValue,
    Value<double?>? kcal,
    Value<double?>? protein,
    Value<double?>? fat,
    Value<double?>? carbs,
    Value<String>? provenance,
    Value<String?>? notes,
  }) {
    return PdfSimpleProductNutritionCompanion(
      id: id ?? this.id,
      simpleProductId: simpleProductId ?? this.simpleProductId,
      basisType: basisType ?? this.basisType,
      basisValue: basisValue ?? this.basisValue,
      kcal: kcal ?? this.kcal,
      protein: protein ?? this.protein,
      fat: fat ?? this.fat,
      carbs: carbs ?? this.carbs,
      provenance: provenance ?? this.provenance,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (simpleProductId.present) {
      map['simple_product_id'] = Variable<int>(simpleProductId.value);
    }
    if (basisType.present) {
      map['basis_type'] = Variable<String>(basisType.value);
    }
    if (basisValue.present) {
      map['basis_value'] = Variable<double>(basisValue.value);
    }
    if (kcal.present) {
      map['kcal'] = Variable<double>(kcal.value);
    }
    if (protein.present) {
      map['protein'] = Variable<double>(protein.value);
    }
    if (fat.present) {
      map['fat'] = Variable<double>(fat.value);
    }
    if (carbs.present) {
      map['carbs'] = Variable<double>(carbs.value);
    }
    if (provenance.present) {
      map['provenance'] = Variable<String>(provenance.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PdfSimpleProductNutritionCompanion(')
          ..write('id: $id, ')
          ..write('simpleProductId: $simpleProductId, ')
          ..write('basisType: $basisType, ')
          ..write('basisValue: $basisValue, ')
          ..write('kcal: $kcal, ')
          ..write('protein: $protein, ')
          ..write('fat: $fat, ')
          ..write('carbs: $carbs, ')
          ..write('provenance: $provenance, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

class $PdfMealSlotItemsTable extends PdfMealSlotItems
    with TableInfo<$PdfMealSlotItemsTable, PdfMealSlotItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PdfMealSlotItemsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _mealSlotIdMeta = const VerificationMeta(
    'mealSlotId',
  );
  @override
  late final GeneratedColumn<int> mealSlotId = GeneratedColumn<int>(
    'meal_slot_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES meal_slots (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _itemTypeMeta = const VerificationMeta(
    'itemType',
  );
  @override
  late final GeneratedColumn<String> itemType = GeneratedColumn<String>(
    'item_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _recipeIdMeta = const VerificationMeta(
    'recipeId',
  );
  @override
  late final GeneratedColumn<int> recipeId = GeneratedColumn<int>(
    'recipe_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES recipes (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _simpleProductIdMeta = const VerificationMeta(
    'simpleProductId',
  );
  @override
  late final GeneratedColumn<int> simpleProductId = GeneratedColumn<int>(
    'simple_product_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES simple_products (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _displayNameMeta = const VerificationMeta(
    'displayName',
  );
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
    'display_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _servingsMeta = const VerificationMeta(
    'servings',
  );
  @override
  late final GeneratedColumn<double> servings = GeneratedColumn<double>(
    'servings',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _portionFractionMeta = const VerificationMeta(
    'portionFraction',
  );
  @override
  late final GeneratedColumn<double> portionFraction = GeneratedColumn<double>(
    'portion_fraction',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _amountTextMeta = const VerificationMeta(
    'amountText',
  );
  @override
  late final GeneratedColumn<String> amountText = GeneratedColumn<String>(
    'amount_text',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _itemKcalMeta = const VerificationMeta(
    'itemKcal',
  );
  @override
  late final GeneratedColumn<double> itemKcal = GeneratedColumn<double>(
    'item_kcal',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _itemProteinMeta = const VerificationMeta(
    'itemProtein',
  );
  @override
  late final GeneratedColumn<double> itemProtein = GeneratedColumn<double>(
    'item_protein',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _itemFatMeta = const VerificationMeta(
    'itemFat',
  );
  @override
  late final GeneratedColumn<double> itemFat = GeneratedColumn<double>(
    'item_fat',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _itemCarbsMeta = const VerificationMeta(
    'itemCarbs',
  );
  @override
  late final GeneratedColumn<double> itemCarbs = GeneratedColumn<double>(
    'item_carbs',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    mealSlotId,
    itemType,
    recipeId,
    simpleProductId,
    displayName,
    servings,
    portionFraction,
    amountText,
    itemKcal,
    itemProtein,
    itemFat,
    itemCarbs,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'meal_slot_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<PdfMealSlotItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('meal_slot_id')) {
      context.handle(
        _mealSlotIdMeta,
        mealSlotId.isAcceptableOrUnknown(
          data['meal_slot_id']!,
          _mealSlotIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_mealSlotIdMeta);
    }
    if (data.containsKey('item_type')) {
      context.handle(
        _itemTypeMeta,
        itemType.isAcceptableOrUnknown(data['item_type']!, _itemTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_itemTypeMeta);
    }
    if (data.containsKey('recipe_id')) {
      context.handle(
        _recipeIdMeta,
        recipeId.isAcceptableOrUnknown(data['recipe_id']!, _recipeIdMeta),
      );
    }
    if (data.containsKey('simple_product_id')) {
      context.handle(
        _simpleProductIdMeta,
        simpleProductId.isAcceptableOrUnknown(
          data['simple_product_id']!,
          _simpleProductIdMeta,
        ),
      );
    }
    if (data.containsKey('display_name')) {
      context.handle(
        _displayNameMeta,
        displayName.isAcceptableOrUnknown(
          data['display_name']!,
          _displayNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_displayNameMeta);
    }
    if (data.containsKey('servings')) {
      context.handle(
        _servingsMeta,
        servings.isAcceptableOrUnknown(data['servings']!, _servingsMeta),
      );
    }
    if (data.containsKey('portion_fraction')) {
      context.handle(
        _portionFractionMeta,
        portionFraction.isAcceptableOrUnknown(
          data['portion_fraction']!,
          _portionFractionMeta,
        ),
      );
    }
    if (data.containsKey('amount_text')) {
      context.handle(
        _amountTextMeta,
        amountText.isAcceptableOrUnknown(data['amount_text']!, _amountTextMeta),
      );
    }
    if (data.containsKey('item_kcal')) {
      context.handle(
        _itemKcalMeta,
        itemKcal.isAcceptableOrUnknown(data['item_kcal']!, _itemKcalMeta),
      );
    }
    if (data.containsKey('item_protein')) {
      context.handle(
        _itemProteinMeta,
        itemProtein.isAcceptableOrUnknown(
          data['item_protein']!,
          _itemProteinMeta,
        ),
      );
    }
    if (data.containsKey('item_fat')) {
      context.handle(
        _itemFatMeta,
        itemFat.isAcceptableOrUnknown(data['item_fat']!, _itemFatMeta),
      );
    }
    if (data.containsKey('item_carbs')) {
      context.handle(
        _itemCarbsMeta,
        itemCarbs.isAcceptableOrUnknown(data['item_carbs']!, _itemCarbsMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PdfMealSlotItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PdfMealSlotItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      mealSlotId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}meal_slot_id'],
      )!,
      itemType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}item_type'],
      )!,
      recipeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}recipe_id'],
      ),
      simpleProductId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}simple_product_id'],
      ),
      displayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name'],
      )!,
      servings: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}servings'],
      ),
      portionFraction: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}portion_fraction'],
      ),
      amountText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}amount_text'],
      ),
      itemKcal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}item_kcal'],
      ),
      itemProtein: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}item_protein'],
      ),
      itemFat: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}item_fat'],
      ),
      itemCarbs: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}item_carbs'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $PdfMealSlotItemsTable createAlias(String alias) {
    return $PdfMealSlotItemsTable(attachedDatabase, alias);
  }
}

class PdfMealSlotItem extends DataClass implements Insertable<PdfMealSlotItem> {
  final int id;
  final int mealSlotId;

  /// recipe | simple_product | combo
  final String itemType;
  final int? recipeId;
  final int? simpleProductId;
  final String displayName;
  final double? servings;
  final double? portionFraction;
  final String? amountText;
  final double? itemKcal;
  final double? itemProtein;
  final double? itemFat;
  final double? itemCarbs;
  final String? notes;
  const PdfMealSlotItem({
    required this.id,
    required this.mealSlotId,
    required this.itemType,
    this.recipeId,
    this.simpleProductId,
    required this.displayName,
    this.servings,
    this.portionFraction,
    this.amountText,
    this.itemKcal,
    this.itemProtein,
    this.itemFat,
    this.itemCarbs,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['meal_slot_id'] = Variable<int>(mealSlotId);
    map['item_type'] = Variable<String>(itemType);
    if (!nullToAbsent || recipeId != null) {
      map['recipe_id'] = Variable<int>(recipeId);
    }
    if (!nullToAbsent || simpleProductId != null) {
      map['simple_product_id'] = Variable<int>(simpleProductId);
    }
    map['display_name'] = Variable<String>(displayName);
    if (!nullToAbsent || servings != null) {
      map['servings'] = Variable<double>(servings);
    }
    if (!nullToAbsent || portionFraction != null) {
      map['portion_fraction'] = Variable<double>(portionFraction);
    }
    if (!nullToAbsent || amountText != null) {
      map['amount_text'] = Variable<String>(amountText);
    }
    if (!nullToAbsent || itemKcal != null) {
      map['item_kcal'] = Variable<double>(itemKcal);
    }
    if (!nullToAbsent || itemProtein != null) {
      map['item_protein'] = Variable<double>(itemProtein);
    }
    if (!nullToAbsent || itemFat != null) {
      map['item_fat'] = Variable<double>(itemFat);
    }
    if (!nullToAbsent || itemCarbs != null) {
      map['item_carbs'] = Variable<double>(itemCarbs);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  PdfMealSlotItemsCompanion toCompanion(bool nullToAbsent) {
    return PdfMealSlotItemsCompanion(
      id: Value(id),
      mealSlotId: Value(mealSlotId),
      itemType: Value(itemType),
      recipeId: recipeId == null && nullToAbsent
          ? const Value.absent()
          : Value(recipeId),
      simpleProductId: simpleProductId == null && nullToAbsent
          ? const Value.absent()
          : Value(simpleProductId),
      displayName: Value(displayName),
      servings: servings == null && nullToAbsent
          ? const Value.absent()
          : Value(servings),
      portionFraction: portionFraction == null && nullToAbsent
          ? const Value.absent()
          : Value(portionFraction),
      amountText: amountText == null && nullToAbsent
          ? const Value.absent()
          : Value(amountText),
      itemKcal: itemKcal == null && nullToAbsent
          ? const Value.absent()
          : Value(itemKcal),
      itemProtein: itemProtein == null && nullToAbsent
          ? const Value.absent()
          : Value(itemProtein),
      itemFat: itemFat == null && nullToAbsent
          ? const Value.absent()
          : Value(itemFat),
      itemCarbs: itemCarbs == null && nullToAbsent
          ? const Value.absent()
          : Value(itemCarbs),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory PdfMealSlotItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PdfMealSlotItem(
      id: serializer.fromJson<int>(json['id']),
      mealSlotId: serializer.fromJson<int>(json['mealSlotId']),
      itemType: serializer.fromJson<String>(json['itemType']),
      recipeId: serializer.fromJson<int?>(json['recipeId']),
      simpleProductId: serializer.fromJson<int?>(json['simpleProductId']),
      displayName: serializer.fromJson<String>(json['displayName']),
      servings: serializer.fromJson<double?>(json['servings']),
      portionFraction: serializer.fromJson<double?>(json['portionFraction']),
      amountText: serializer.fromJson<String?>(json['amountText']),
      itemKcal: serializer.fromJson<double?>(json['itemKcal']),
      itemProtein: serializer.fromJson<double?>(json['itemProtein']),
      itemFat: serializer.fromJson<double?>(json['itemFat']),
      itemCarbs: serializer.fromJson<double?>(json['itemCarbs']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'mealSlotId': serializer.toJson<int>(mealSlotId),
      'itemType': serializer.toJson<String>(itemType),
      'recipeId': serializer.toJson<int?>(recipeId),
      'simpleProductId': serializer.toJson<int?>(simpleProductId),
      'displayName': serializer.toJson<String>(displayName),
      'servings': serializer.toJson<double?>(servings),
      'portionFraction': serializer.toJson<double?>(portionFraction),
      'amountText': serializer.toJson<String?>(amountText),
      'itemKcal': serializer.toJson<double?>(itemKcal),
      'itemProtein': serializer.toJson<double?>(itemProtein),
      'itemFat': serializer.toJson<double?>(itemFat),
      'itemCarbs': serializer.toJson<double?>(itemCarbs),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  PdfMealSlotItem copyWith({
    int? id,
    int? mealSlotId,
    String? itemType,
    Value<int?> recipeId = const Value.absent(),
    Value<int?> simpleProductId = const Value.absent(),
    String? displayName,
    Value<double?> servings = const Value.absent(),
    Value<double?> portionFraction = const Value.absent(),
    Value<String?> amountText = const Value.absent(),
    Value<double?> itemKcal = const Value.absent(),
    Value<double?> itemProtein = const Value.absent(),
    Value<double?> itemFat = const Value.absent(),
    Value<double?> itemCarbs = const Value.absent(),
    Value<String?> notes = const Value.absent(),
  }) => PdfMealSlotItem(
    id: id ?? this.id,
    mealSlotId: mealSlotId ?? this.mealSlotId,
    itemType: itemType ?? this.itemType,
    recipeId: recipeId.present ? recipeId.value : this.recipeId,
    simpleProductId: simpleProductId.present
        ? simpleProductId.value
        : this.simpleProductId,
    displayName: displayName ?? this.displayName,
    servings: servings.present ? servings.value : this.servings,
    portionFraction: portionFraction.present
        ? portionFraction.value
        : this.portionFraction,
    amountText: amountText.present ? amountText.value : this.amountText,
    itemKcal: itemKcal.present ? itemKcal.value : this.itemKcal,
    itemProtein: itemProtein.present ? itemProtein.value : this.itemProtein,
    itemFat: itemFat.present ? itemFat.value : this.itemFat,
    itemCarbs: itemCarbs.present ? itemCarbs.value : this.itemCarbs,
    notes: notes.present ? notes.value : this.notes,
  );
  PdfMealSlotItem copyWithCompanion(PdfMealSlotItemsCompanion data) {
    return PdfMealSlotItem(
      id: data.id.present ? data.id.value : this.id,
      mealSlotId: data.mealSlotId.present
          ? data.mealSlotId.value
          : this.mealSlotId,
      itemType: data.itemType.present ? data.itemType.value : this.itemType,
      recipeId: data.recipeId.present ? data.recipeId.value : this.recipeId,
      simpleProductId: data.simpleProductId.present
          ? data.simpleProductId.value
          : this.simpleProductId,
      displayName: data.displayName.present
          ? data.displayName.value
          : this.displayName,
      servings: data.servings.present ? data.servings.value : this.servings,
      portionFraction: data.portionFraction.present
          ? data.portionFraction.value
          : this.portionFraction,
      amountText: data.amountText.present
          ? data.amountText.value
          : this.amountText,
      itemKcal: data.itemKcal.present ? data.itemKcal.value : this.itemKcal,
      itemProtein: data.itemProtein.present
          ? data.itemProtein.value
          : this.itemProtein,
      itemFat: data.itemFat.present ? data.itemFat.value : this.itemFat,
      itemCarbs: data.itemCarbs.present ? data.itemCarbs.value : this.itemCarbs,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PdfMealSlotItem(')
          ..write('id: $id, ')
          ..write('mealSlotId: $mealSlotId, ')
          ..write('itemType: $itemType, ')
          ..write('recipeId: $recipeId, ')
          ..write('simpleProductId: $simpleProductId, ')
          ..write('displayName: $displayName, ')
          ..write('servings: $servings, ')
          ..write('portionFraction: $portionFraction, ')
          ..write('amountText: $amountText, ')
          ..write('itemKcal: $itemKcal, ')
          ..write('itemProtein: $itemProtein, ')
          ..write('itemFat: $itemFat, ')
          ..write('itemCarbs: $itemCarbs, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    mealSlotId,
    itemType,
    recipeId,
    simpleProductId,
    displayName,
    servings,
    portionFraction,
    amountText,
    itemKcal,
    itemProtein,
    itemFat,
    itemCarbs,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PdfMealSlotItem &&
          other.id == this.id &&
          other.mealSlotId == this.mealSlotId &&
          other.itemType == this.itemType &&
          other.recipeId == this.recipeId &&
          other.simpleProductId == this.simpleProductId &&
          other.displayName == this.displayName &&
          other.servings == this.servings &&
          other.portionFraction == this.portionFraction &&
          other.amountText == this.amountText &&
          other.itemKcal == this.itemKcal &&
          other.itemProtein == this.itemProtein &&
          other.itemFat == this.itemFat &&
          other.itemCarbs == this.itemCarbs &&
          other.notes == this.notes);
}

class PdfMealSlotItemsCompanion extends UpdateCompanion<PdfMealSlotItem> {
  final Value<int> id;
  final Value<int> mealSlotId;
  final Value<String> itemType;
  final Value<int?> recipeId;
  final Value<int?> simpleProductId;
  final Value<String> displayName;
  final Value<double?> servings;
  final Value<double?> portionFraction;
  final Value<String?> amountText;
  final Value<double?> itemKcal;
  final Value<double?> itemProtein;
  final Value<double?> itemFat;
  final Value<double?> itemCarbs;
  final Value<String?> notes;
  const PdfMealSlotItemsCompanion({
    this.id = const Value.absent(),
    this.mealSlotId = const Value.absent(),
    this.itemType = const Value.absent(),
    this.recipeId = const Value.absent(),
    this.simpleProductId = const Value.absent(),
    this.displayName = const Value.absent(),
    this.servings = const Value.absent(),
    this.portionFraction = const Value.absent(),
    this.amountText = const Value.absent(),
    this.itemKcal = const Value.absent(),
    this.itemProtein = const Value.absent(),
    this.itemFat = const Value.absent(),
    this.itemCarbs = const Value.absent(),
    this.notes = const Value.absent(),
  });
  PdfMealSlotItemsCompanion.insert({
    this.id = const Value.absent(),
    required int mealSlotId,
    required String itemType,
    this.recipeId = const Value.absent(),
    this.simpleProductId = const Value.absent(),
    required String displayName,
    this.servings = const Value.absent(),
    this.portionFraction = const Value.absent(),
    this.amountText = const Value.absent(),
    this.itemKcal = const Value.absent(),
    this.itemProtein = const Value.absent(),
    this.itemFat = const Value.absent(),
    this.itemCarbs = const Value.absent(),
    this.notes = const Value.absent(),
  }) : mealSlotId = Value(mealSlotId),
       itemType = Value(itemType),
       displayName = Value(displayName);
  static Insertable<PdfMealSlotItem> custom({
    Expression<int>? id,
    Expression<int>? mealSlotId,
    Expression<String>? itemType,
    Expression<int>? recipeId,
    Expression<int>? simpleProductId,
    Expression<String>? displayName,
    Expression<double>? servings,
    Expression<double>? portionFraction,
    Expression<String>? amountText,
    Expression<double>? itemKcal,
    Expression<double>? itemProtein,
    Expression<double>? itemFat,
    Expression<double>? itemCarbs,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (mealSlotId != null) 'meal_slot_id': mealSlotId,
      if (itemType != null) 'item_type': itemType,
      if (recipeId != null) 'recipe_id': recipeId,
      if (simpleProductId != null) 'simple_product_id': simpleProductId,
      if (displayName != null) 'display_name': displayName,
      if (servings != null) 'servings': servings,
      if (portionFraction != null) 'portion_fraction': portionFraction,
      if (amountText != null) 'amount_text': amountText,
      if (itemKcal != null) 'item_kcal': itemKcal,
      if (itemProtein != null) 'item_protein': itemProtein,
      if (itemFat != null) 'item_fat': itemFat,
      if (itemCarbs != null) 'item_carbs': itemCarbs,
      if (notes != null) 'notes': notes,
    });
  }

  PdfMealSlotItemsCompanion copyWith({
    Value<int>? id,
    Value<int>? mealSlotId,
    Value<String>? itemType,
    Value<int?>? recipeId,
    Value<int?>? simpleProductId,
    Value<String>? displayName,
    Value<double?>? servings,
    Value<double?>? portionFraction,
    Value<String?>? amountText,
    Value<double?>? itemKcal,
    Value<double?>? itemProtein,
    Value<double?>? itemFat,
    Value<double?>? itemCarbs,
    Value<String?>? notes,
  }) {
    return PdfMealSlotItemsCompanion(
      id: id ?? this.id,
      mealSlotId: mealSlotId ?? this.mealSlotId,
      itemType: itemType ?? this.itemType,
      recipeId: recipeId ?? this.recipeId,
      simpleProductId: simpleProductId ?? this.simpleProductId,
      displayName: displayName ?? this.displayName,
      servings: servings ?? this.servings,
      portionFraction: portionFraction ?? this.portionFraction,
      amountText: amountText ?? this.amountText,
      itemKcal: itemKcal ?? this.itemKcal,
      itemProtein: itemProtein ?? this.itemProtein,
      itemFat: itemFat ?? this.itemFat,
      itemCarbs: itemCarbs ?? this.itemCarbs,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (mealSlotId.present) {
      map['meal_slot_id'] = Variable<int>(mealSlotId.value);
    }
    if (itemType.present) {
      map['item_type'] = Variable<String>(itemType.value);
    }
    if (recipeId.present) {
      map['recipe_id'] = Variable<int>(recipeId.value);
    }
    if (simpleProductId.present) {
      map['simple_product_id'] = Variable<int>(simpleProductId.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (servings.present) {
      map['servings'] = Variable<double>(servings.value);
    }
    if (portionFraction.present) {
      map['portion_fraction'] = Variable<double>(portionFraction.value);
    }
    if (amountText.present) {
      map['amount_text'] = Variable<String>(amountText.value);
    }
    if (itemKcal.present) {
      map['item_kcal'] = Variable<double>(itemKcal.value);
    }
    if (itemProtein.present) {
      map['item_protein'] = Variable<double>(itemProtein.value);
    }
    if (itemFat.present) {
      map['item_fat'] = Variable<double>(itemFat.value);
    }
    if (itemCarbs.present) {
      map['item_carbs'] = Variable<double>(itemCarbs.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PdfMealSlotItemsCompanion(')
          ..write('id: $id, ')
          ..write('mealSlotId: $mealSlotId, ')
          ..write('itemType: $itemType, ')
          ..write('recipeId: $recipeId, ')
          ..write('simpleProductId: $simpleProductId, ')
          ..write('displayName: $displayName, ')
          ..write('servings: $servings, ')
          ..write('portionFraction: $portionFraction, ')
          ..write('amountText: $amountText, ')
          ..write('itemKcal: $itemKcal, ')
          ..write('itemProtein: $itemProtein, ')
          ..write('itemFat: $itemFat, ')
          ..write('itemCarbs: $itemCarbs, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

class $UserProfilesTable extends UserProfiles
    with TableInfo<$UserProfilesTable, ProfileRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sexMeta = const VerificationMeta('sex');
  @override
  late final GeneratedColumn<String> sex = GeneratedColumn<String>(
    'sex',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ageMeta = const VerificationMeta('age');
  @override
  late final GeneratedColumn<int> age = GeneratedColumn<int>(
    'age',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _heightCmMeta = const VerificationMeta(
    'heightCm',
  );
  @override
  late final GeneratedColumn<double> heightCm = GeneratedColumn<double>(
    'height_cm',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weightKgMeta = const VerificationMeta(
    'weightKg',
  );
  @override
  late final GeneratedColumn<double> weightKg = GeneratedColumn<double>(
    'weight_kg',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _activityMeta = const VerificationMeta(
    'activity',
  );
  @override
  late final GeneratedColumn<String> activity = GeneratedColumn<String>(
    'activity',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _goalMeta = const VerificationMeta('goal');
  @override
  late final GeneratedColumn<String> goal = GeneratedColumn<String>(
    'goal',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _customKcalMeta = const VerificationMeta(
    'customKcal',
  );
  @override
  late final GeneratedColumn<double> customKcal = GeneratedColumn<double>(
    'custom_kcal',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sex,
    age,
    heightCm,
    weightKg,
    activity,
    goal,
    customKcal,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_profiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProfileRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('sex')) {
      context.handle(
        _sexMeta,
        sex.isAcceptableOrUnknown(data['sex']!, _sexMeta),
      );
    } else if (isInserting) {
      context.missing(_sexMeta);
    }
    if (data.containsKey('age')) {
      context.handle(
        _ageMeta,
        age.isAcceptableOrUnknown(data['age']!, _ageMeta),
      );
    } else if (isInserting) {
      context.missing(_ageMeta);
    }
    if (data.containsKey('height_cm')) {
      context.handle(
        _heightCmMeta,
        heightCm.isAcceptableOrUnknown(data['height_cm']!, _heightCmMeta),
      );
    } else if (isInserting) {
      context.missing(_heightCmMeta);
    }
    if (data.containsKey('weight_kg')) {
      context.handle(
        _weightKgMeta,
        weightKg.isAcceptableOrUnknown(data['weight_kg']!, _weightKgMeta),
      );
    } else if (isInserting) {
      context.missing(_weightKgMeta);
    }
    if (data.containsKey('activity')) {
      context.handle(
        _activityMeta,
        activity.isAcceptableOrUnknown(data['activity']!, _activityMeta),
      );
    } else if (isInserting) {
      context.missing(_activityMeta);
    }
    if (data.containsKey('goal')) {
      context.handle(
        _goalMeta,
        goal.isAcceptableOrUnknown(data['goal']!, _goalMeta),
      );
    } else if (isInserting) {
      context.missing(_goalMeta);
    }
    if (data.containsKey('custom_kcal')) {
      context.handle(
        _customKcalMeta,
        customKcal.isAcceptableOrUnknown(data['custom_kcal']!, _customKcalMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProfileRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProfileRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      sex: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sex'],
      )!,
      age: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}age'],
      )!,
      heightCm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}height_cm'],
      )!,
      weightKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight_kg'],
      )!,
      activity: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}activity'],
      )!,
      goal: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}goal'],
      )!,
      customKcal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}custom_kcal'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $UserProfilesTable createAlias(String alias) {
    return $UserProfilesTable(attachedDatabase, alias);
  }
}

class ProfileRow extends DataClass implements Insertable<ProfileRow> {
  final int id;

  /// female | male
  final String sex;
  final int age;
  final double heightCm;
  final double weightKg;

  /// Код [ActivityLevel].
  final String activity;

  /// Код [Goal].
  final String goal;
  final double? customKcal;
  final DateTime updatedAt;
  const ProfileRow({
    required this.id,
    required this.sex,
    required this.age,
    required this.heightCm,
    required this.weightKg,
    required this.activity,
    required this.goal,
    this.customKcal,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['sex'] = Variable<String>(sex);
    map['age'] = Variable<int>(age);
    map['height_cm'] = Variable<double>(heightCm);
    map['weight_kg'] = Variable<double>(weightKg);
    map['activity'] = Variable<String>(activity);
    map['goal'] = Variable<String>(goal);
    if (!nullToAbsent || customKcal != null) {
      map['custom_kcal'] = Variable<double>(customKcal);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  UserProfilesCompanion toCompanion(bool nullToAbsent) {
    return UserProfilesCompanion(
      id: Value(id),
      sex: Value(sex),
      age: Value(age),
      heightCm: Value(heightCm),
      weightKg: Value(weightKg),
      activity: Value(activity),
      goal: Value(goal),
      customKcal: customKcal == null && nullToAbsent
          ? const Value.absent()
          : Value(customKcal),
      updatedAt: Value(updatedAt),
    );
  }

  factory ProfileRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProfileRow(
      id: serializer.fromJson<int>(json['id']),
      sex: serializer.fromJson<String>(json['sex']),
      age: serializer.fromJson<int>(json['age']),
      heightCm: serializer.fromJson<double>(json['heightCm']),
      weightKg: serializer.fromJson<double>(json['weightKg']),
      activity: serializer.fromJson<String>(json['activity']),
      goal: serializer.fromJson<String>(json['goal']),
      customKcal: serializer.fromJson<double?>(json['customKcal']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sex': serializer.toJson<String>(sex),
      'age': serializer.toJson<int>(age),
      'heightCm': serializer.toJson<double>(heightCm),
      'weightKg': serializer.toJson<double>(weightKg),
      'activity': serializer.toJson<String>(activity),
      'goal': serializer.toJson<String>(goal),
      'customKcal': serializer.toJson<double?>(customKcal),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ProfileRow copyWith({
    int? id,
    String? sex,
    int? age,
    double? heightCm,
    double? weightKg,
    String? activity,
    String? goal,
    Value<double?> customKcal = const Value.absent(),
    DateTime? updatedAt,
  }) => ProfileRow(
    id: id ?? this.id,
    sex: sex ?? this.sex,
    age: age ?? this.age,
    heightCm: heightCm ?? this.heightCm,
    weightKg: weightKg ?? this.weightKg,
    activity: activity ?? this.activity,
    goal: goal ?? this.goal,
    customKcal: customKcal.present ? customKcal.value : this.customKcal,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ProfileRow copyWithCompanion(UserProfilesCompanion data) {
    return ProfileRow(
      id: data.id.present ? data.id.value : this.id,
      sex: data.sex.present ? data.sex.value : this.sex,
      age: data.age.present ? data.age.value : this.age,
      heightCm: data.heightCm.present ? data.heightCm.value : this.heightCm,
      weightKg: data.weightKg.present ? data.weightKg.value : this.weightKg,
      activity: data.activity.present ? data.activity.value : this.activity,
      goal: data.goal.present ? data.goal.value : this.goal,
      customKcal: data.customKcal.present
          ? data.customKcal.value
          : this.customKcal,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProfileRow(')
          ..write('id: $id, ')
          ..write('sex: $sex, ')
          ..write('age: $age, ')
          ..write('heightCm: $heightCm, ')
          ..write('weightKg: $weightKg, ')
          ..write('activity: $activity, ')
          ..write('goal: $goal, ')
          ..write('customKcal: $customKcal, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    sex,
    age,
    heightCm,
    weightKg,
    activity,
    goal,
    customKcal,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProfileRow &&
          other.id == this.id &&
          other.sex == this.sex &&
          other.age == this.age &&
          other.heightCm == this.heightCm &&
          other.weightKg == this.weightKg &&
          other.activity == this.activity &&
          other.goal == this.goal &&
          other.customKcal == this.customKcal &&
          other.updatedAt == this.updatedAt);
}

class UserProfilesCompanion extends UpdateCompanion<ProfileRow> {
  final Value<int> id;
  final Value<String> sex;
  final Value<int> age;
  final Value<double> heightCm;
  final Value<double> weightKg;
  final Value<String> activity;
  final Value<String> goal;
  final Value<double?> customKcal;
  final Value<DateTime> updatedAt;
  const UserProfilesCompanion({
    this.id = const Value.absent(),
    this.sex = const Value.absent(),
    this.age = const Value.absent(),
    this.heightCm = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.activity = const Value.absent(),
    this.goal = const Value.absent(),
    this.customKcal = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  UserProfilesCompanion.insert({
    this.id = const Value.absent(),
    required String sex,
    required int age,
    required double heightCm,
    required double weightKg,
    required String activity,
    required String goal,
    this.customKcal = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : sex = Value(sex),
       age = Value(age),
       heightCm = Value(heightCm),
       weightKg = Value(weightKg),
       activity = Value(activity),
       goal = Value(goal);
  static Insertable<ProfileRow> custom({
    Expression<int>? id,
    Expression<String>? sex,
    Expression<int>? age,
    Expression<double>? heightCm,
    Expression<double>? weightKg,
    Expression<String>? activity,
    Expression<String>? goal,
    Expression<double>? customKcal,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sex != null) 'sex': sex,
      if (age != null) 'age': age,
      if (heightCm != null) 'height_cm': heightCm,
      if (weightKg != null) 'weight_kg': weightKg,
      if (activity != null) 'activity': activity,
      if (goal != null) 'goal': goal,
      if (customKcal != null) 'custom_kcal': customKcal,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  UserProfilesCompanion copyWith({
    Value<int>? id,
    Value<String>? sex,
    Value<int>? age,
    Value<double>? heightCm,
    Value<double>? weightKg,
    Value<String>? activity,
    Value<String>? goal,
    Value<double?>? customKcal,
    Value<DateTime>? updatedAt,
  }) {
    return UserProfilesCompanion(
      id: id ?? this.id,
      sex: sex ?? this.sex,
      age: age ?? this.age,
      heightCm: heightCm ?? this.heightCm,
      weightKg: weightKg ?? this.weightKg,
      activity: activity ?? this.activity,
      goal: goal ?? this.goal,
      customKcal: customKcal ?? this.customKcal,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sex.present) {
      map['sex'] = Variable<String>(sex.value);
    }
    if (age.present) {
      map['age'] = Variable<int>(age.value);
    }
    if (heightCm.present) {
      map['height_cm'] = Variable<double>(heightCm.value);
    }
    if (weightKg.present) {
      map['weight_kg'] = Variable<double>(weightKg.value);
    }
    if (activity.present) {
      map['activity'] = Variable<String>(activity.value);
    }
    if (goal.present) {
      map['goal'] = Variable<String>(goal.value);
    }
    if (customKcal.present) {
      map['custom_kcal'] = Variable<double>(customKcal.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserProfilesCompanion(')
          ..write('id: $id, ')
          ..write('sex: $sex, ')
          ..write('age: $age, ')
          ..write('heightCm: $heightCm, ')
          ..write('weightKg: $weightKg, ')
          ..write('activity: $activity, ')
          ..write('goal: $goal, ')
          ..write('customKcal: $customKcal, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $LoggedMealsTable extends LoggedMeals
    with TableInfo<$LoggedMealsTable, LoggedMealRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LoggedMealsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _dayKeyMeta = const VerificationMeta('dayKey');
  @override
  late final GeneratedColumn<String> dayKey = GeneratedColumn<String>(
    'day_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mealTypeMeta = const VerificationMeta(
    'mealType',
  );
  @override
  late final GeneratedColumn<String> mealType = GeneratedColumn<String>(
    'meal_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _recipeKeyMeta = const VerificationMeta(
    'recipeKey',
  );
  @override
  late final GeneratedColumn<String> recipeKey = GeneratedColumn<String>(
    'recipe_key',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _portionLabelMeta = const VerificationMeta(
    'portionLabel',
  );
  @override
  late final GeneratedColumn<String> portionLabel = GeneratedColumn<String>(
    'portion_label',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _kcalMeta = const VerificationMeta('kcal');
  @override
  late final GeneratedColumn<double> kcal = GeneratedColumn<double>(
    'kcal',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _proteinMeta = const VerificationMeta(
    'protein',
  );
  @override
  late final GeneratedColumn<double> protein = GeneratedColumn<double>(
    'protein',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fatMeta = const VerificationMeta('fat');
  @override
  late final GeneratedColumn<double> fat = GeneratedColumn<double>(
    'fat',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _carbsMeta = const VerificationMeta('carbs');
  @override
  late final GeneratedColumn<double> carbs = GeneratedColumn<double>(
    'carbs',
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    dayKey,
    mealType,
    recipeKey,
    title,
    portionLabel,
    kcal,
    protein,
    fat,
    carbs,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'logged_meals';
  @override
  VerificationContext validateIntegrity(
    Insertable<LoggedMealRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('day_key')) {
      context.handle(
        _dayKeyMeta,
        dayKey.isAcceptableOrUnknown(data['day_key']!, _dayKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_dayKeyMeta);
    }
    if (data.containsKey('meal_type')) {
      context.handle(
        _mealTypeMeta,
        mealType.isAcceptableOrUnknown(data['meal_type']!, _mealTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_mealTypeMeta);
    }
    if (data.containsKey('recipe_key')) {
      context.handle(
        _recipeKeyMeta,
        recipeKey.isAcceptableOrUnknown(data['recipe_key']!, _recipeKeyMeta),
      );
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('portion_label')) {
      context.handle(
        _portionLabelMeta,
        portionLabel.isAcceptableOrUnknown(
          data['portion_label']!,
          _portionLabelMeta,
        ),
      );
    }
    if (data.containsKey('kcal')) {
      context.handle(
        _kcalMeta,
        kcal.isAcceptableOrUnknown(data['kcal']!, _kcalMeta),
      );
    } else if (isInserting) {
      context.missing(_kcalMeta);
    }
    if (data.containsKey('protein')) {
      context.handle(
        _proteinMeta,
        protein.isAcceptableOrUnknown(data['protein']!, _proteinMeta),
      );
    } else if (isInserting) {
      context.missing(_proteinMeta);
    }
    if (data.containsKey('fat')) {
      context.handle(
        _fatMeta,
        fat.isAcceptableOrUnknown(data['fat']!, _fatMeta),
      );
    } else if (isInserting) {
      context.missing(_fatMeta);
    }
    if (data.containsKey('carbs')) {
      context.handle(
        _carbsMeta,
        carbs.isAcceptableOrUnknown(data['carbs']!, _carbsMeta),
      );
    } else if (isInserting) {
      context.missing(_carbsMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LoggedMealRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LoggedMealRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      dayKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}day_key'],
      )!,
      mealType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}meal_type'],
      )!,
      recipeKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}recipe_key'],
      ),
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      portionLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}portion_label'],
      ),
      kcal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}kcal'],
      )!,
      protein: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}protein'],
      )!,
      fat: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fat'],
      )!,
      carbs: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}carbs'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $LoggedMealsTable createAlias(String alias) {
    return $LoggedMealsTable(attachedDatabase, alias);
  }
}

class LoggedMealRow extends DataClass implements Insertable<LoggedMealRow> {
  final int id;

  /// Локальная дата в формате yyyy-MM-dd.
  final String dayKey;

  /// breakfast | lunch | snack | dinner
  final String mealType;

  /// Ключ рецепта из assets/recipes/recipes.json; null для ручной записи.
  final String? recipeKey;
  final String title;
  final String? portionLabel;
  final double kcal;
  final double protein;
  final double fat;
  final double carbs;
  final DateTime createdAt;
  const LoggedMealRow({
    required this.id,
    required this.dayKey,
    required this.mealType,
    this.recipeKey,
    required this.title,
    this.portionLabel,
    required this.kcal,
    required this.protein,
    required this.fat,
    required this.carbs,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['day_key'] = Variable<String>(dayKey);
    map['meal_type'] = Variable<String>(mealType);
    if (!nullToAbsent || recipeKey != null) {
      map['recipe_key'] = Variable<String>(recipeKey);
    }
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || portionLabel != null) {
      map['portion_label'] = Variable<String>(portionLabel);
    }
    map['kcal'] = Variable<double>(kcal);
    map['protein'] = Variable<double>(protein);
    map['fat'] = Variable<double>(fat);
    map['carbs'] = Variable<double>(carbs);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  LoggedMealsCompanion toCompanion(bool nullToAbsent) {
    return LoggedMealsCompanion(
      id: Value(id),
      dayKey: Value(dayKey),
      mealType: Value(mealType),
      recipeKey: recipeKey == null && nullToAbsent
          ? const Value.absent()
          : Value(recipeKey),
      title: Value(title),
      portionLabel: portionLabel == null && nullToAbsent
          ? const Value.absent()
          : Value(portionLabel),
      kcal: Value(kcal),
      protein: Value(protein),
      fat: Value(fat),
      carbs: Value(carbs),
      createdAt: Value(createdAt),
    );
  }

  factory LoggedMealRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LoggedMealRow(
      id: serializer.fromJson<int>(json['id']),
      dayKey: serializer.fromJson<String>(json['dayKey']),
      mealType: serializer.fromJson<String>(json['mealType']),
      recipeKey: serializer.fromJson<String?>(json['recipeKey']),
      title: serializer.fromJson<String>(json['title']),
      portionLabel: serializer.fromJson<String?>(json['portionLabel']),
      kcal: serializer.fromJson<double>(json['kcal']),
      protein: serializer.fromJson<double>(json['protein']),
      fat: serializer.fromJson<double>(json['fat']),
      carbs: serializer.fromJson<double>(json['carbs']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'dayKey': serializer.toJson<String>(dayKey),
      'mealType': serializer.toJson<String>(mealType),
      'recipeKey': serializer.toJson<String?>(recipeKey),
      'title': serializer.toJson<String>(title),
      'portionLabel': serializer.toJson<String?>(portionLabel),
      'kcal': serializer.toJson<double>(kcal),
      'protein': serializer.toJson<double>(protein),
      'fat': serializer.toJson<double>(fat),
      'carbs': serializer.toJson<double>(carbs),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  LoggedMealRow copyWith({
    int? id,
    String? dayKey,
    String? mealType,
    Value<String?> recipeKey = const Value.absent(),
    String? title,
    Value<String?> portionLabel = const Value.absent(),
    double? kcal,
    double? protein,
    double? fat,
    double? carbs,
    DateTime? createdAt,
  }) => LoggedMealRow(
    id: id ?? this.id,
    dayKey: dayKey ?? this.dayKey,
    mealType: mealType ?? this.mealType,
    recipeKey: recipeKey.present ? recipeKey.value : this.recipeKey,
    title: title ?? this.title,
    portionLabel: portionLabel.present ? portionLabel.value : this.portionLabel,
    kcal: kcal ?? this.kcal,
    protein: protein ?? this.protein,
    fat: fat ?? this.fat,
    carbs: carbs ?? this.carbs,
    createdAt: createdAt ?? this.createdAt,
  );
  LoggedMealRow copyWithCompanion(LoggedMealsCompanion data) {
    return LoggedMealRow(
      id: data.id.present ? data.id.value : this.id,
      dayKey: data.dayKey.present ? data.dayKey.value : this.dayKey,
      mealType: data.mealType.present ? data.mealType.value : this.mealType,
      recipeKey: data.recipeKey.present ? data.recipeKey.value : this.recipeKey,
      title: data.title.present ? data.title.value : this.title,
      portionLabel: data.portionLabel.present
          ? data.portionLabel.value
          : this.portionLabel,
      kcal: data.kcal.present ? data.kcal.value : this.kcal,
      protein: data.protein.present ? data.protein.value : this.protein,
      fat: data.fat.present ? data.fat.value : this.fat,
      carbs: data.carbs.present ? data.carbs.value : this.carbs,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LoggedMealRow(')
          ..write('id: $id, ')
          ..write('dayKey: $dayKey, ')
          ..write('mealType: $mealType, ')
          ..write('recipeKey: $recipeKey, ')
          ..write('title: $title, ')
          ..write('portionLabel: $portionLabel, ')
          ..write('kcal: $kcal, ')
          ..write('protein: $protein, ')
          ..write('fat: $fat, ')
          ..write('carbs: $carbs, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    dayKey,
    mealType,
    recipeKey,
    title,
    portionLabel,
    kcal,
    protein,
    fat,
    carbs,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LoggedMealRow &&
          other.id == this.id &&
          other.dayKey == this.dayKey &&
          other.mealType == this.mealType &&
          other.recipeKey == this.recipeKey &&
          other.title == this.title &&
          other.portionLabel == this.portionLabel &&
          other.kcal == this.kcal &&
          other.protein == this.protein &&
          other.fat == this.fat &&
          other.carbs == this.carbs &&
          other.createdAt == this.createdAt);
}

class LoggedMealsCompanion extends UpdateCompanion<LoggedMealRow> {
  final Value<int> id;
  final Value<String> dayKey;
  final Value<String> mealType;
  final Value<String?> recipeKey;
  final Value<String> title;
  final Value<String?> portionLabel;
  final Value<double> kcal;
  final Value<double> protein;
  final Value<double> fat;
  final Value<double> carbs;
  final Value<DateTime> createdAt;
  const LoggedMealsCompanion({
    this.id = const Value.absent(),
    this.dayKey = const Value.absent(),
    this.mealType = const Value.absent(),
    this.recipeKey = const Value.absent(),
    this.title = const Value.absent(),
    this.portionLabel = const Value.absent(),
    this.kcal = const Value.absent(),
    this.protein = const Value.absent(),
    this.fat = const Value.absent(),
    this.carbs = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  LoggedMealsCompanion.insert({
    this.id = const Value.absent(),
    required String dayKey,
    required String mealType,
    this.recipeKey = const Value.absent(),
    required String title,
    this.portionLabel = const Value.absent(),
    required double kcal,
    required double protein,
    required double fat,
    required double carbs,
    this.createdAt = const Value.absent(),
  }) : dayKey = Value(dayKey),
       mealType = Value(mealType),
       title = Value(title),
       kcal = Value(kcal),
       protein = Value(protein),
       fat = Value(fat),
       carbs = Value(carbs);
  static Insertable<LoggedMealRow> custom({
    Expression<int>? id,
    Expression<String>? dayKey,
    Expression<String>? mealType,
    Expression<String>? recipeKey,
    Expression<String>? title,
    Expression<String>? portionLabel,
    Expression<double>? kcal,
    Expression<double>? protein,
    Expression<double>? fat,
    Expression<double>? carbs,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (dayKey != null) 'day_key': dayKey,
      if (mealType != null) 'meal_type': mealType,
      if (recipeKey != null) 'recipe_key': recipeKey,
      if (title != null) 'title': title,
      if (portionLabel != null) 'portion_label': portionLabel,
      if (kcal != null) 'kcal': kcal,
      if (protein != null) 'protein': protein,
      if (fat != null) 'fat': fat,
      if (carbs != null) 'carbs': carbs,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  LoggedMealsCompanion copyWith({
    Value<int>? id,
    Value<String>? dayKey,
    Value<String>? mealType,
    Value<String?>? recipeKey,
    Value<String>? title,
    Value<String?>? portionLabel,
    Value<double>? kcal,
    Value<double>? protein,
    Value<double>? fat,
    Value<double>? carbs,
    Value<DateTime>? createdAt,
  }) {
    return LoggedMealsCompanion(
      id: id ?? this.id,
      dayKey: dayKey ?? this.dayKey,
      mealType: mealType ?? this.mealType,
      recipeKey: recipeKey ?? this.recipeKey,
      title: title ?? this.title,
      portionLabel: portionLabel ?? this.portionLabel,
      kcal: kcal ?? this.kcal,
      protein: protein ?? this.protein,
      fat: fat ?? this.fat,
      carbs: carbs ?? this.carbs,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (dayKey.present) {
      map['day_key'] = Variable<String>(dayKey.value);
    }
    if (mealType.present) {
      map['meal_type'] = Variable<String>(mealType.value);
    }
    if (recipeKey.present) {
      map['recipe_key'] = Variable<String>(recipeKey.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (portionLabel.present) {
      map['portion_label'] = Variable<String>(portionLabel.value);
    }
    if (kcal.present) {
      map['kcal'] = Variable<double>(kcal.value);
    }
    if (protein.present) {
      map['protein'] = Variable<double>(protein.value);
    }
    if (fat.present) {
      map['fat'] = Variable<double>(fat.value);
    }
    if (carbs.present) {
      map['carbs'] = Variable<double>(carbs.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LoggedMealsCompanion(')
          ..write('id: $id, ')
          ..write('dayKey: $dayKey, ')
          ..write('mealType: $mealType, ')
          ..write('recipeKey: $recipeKey, ')
          ..write('title: $title, ')
          ..write('portionLabel: $portionLabel, ')
          ..write('kcal: $kcal, ')
          ..write('protein: $protein, ')
          ..write('fat: $fat, ')
          ..write('carbs: $carbs, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $FoodItemsTable foodItems = $FoodItemsTable(this);
  late final $NutrientsTable nutrients = $NutrientsTable(this);
  late final $ProductsTable products = $ProductsTable(this);
  late final $ProductNutrientValuesTable productNutrientValues =
      $ProductNutrientValuesTable(this);
  late final $FormulaDefinitionsTable formulaDefinitions =
      $FormulaDefinitionsTable(this);
  late final $ActivityLevelsTable activityLevels = $ActivityLevelsTable(this);
  late final $MacroNormTemplatesTable macroNormTemplates =
      $MacroNormTemplatesTable(this);
  late final $CalorieDeficitPoliciesTable calorieDeficitPolicies =
      $CalorieDeficitPoliciesTable(this);
  late final $CookingYieldFactorsTable cookingYieldFactors =
      $CookingYieldFactorsTable(this);
  late final $AdvisoryRulesTable advisoryRules = $AdvisoryRulesTable(this);
  late final $MealPlanTemplatesTable mealPlanTemplates =
      $MealPlanTemplatesTable(this);
  late final $MealPlanMealsTable mealPlanMeals = $MealPlanMealsTable(this);
  late final $MealPlanLinesTable mealPlanLines = $MealPlanLinesTable(this);
  late final $PdfMealPlansTable pdfMealPlans = $PdfMealPlansTable(this);
  late final $PdfMealPlanDaysTable pdfMealPlanDays = $PdfMealPlanDaysTable(
    this,
  );
  late final $PdfRecipesTable pdfRecipes = $PdfRecipesTable(this);
  late final $PdfSimpleProductsTable pdfSimpleProducts =
      $PdfSimpleProductsTable(this);
  late final $PdfMediaAssetsTable pdfMediaAssets = $PdfMediaAssetsTable(this);
  late final $PdfMealSlotsTable pdfMealSlots = $PdfMealSlotsTable(this);
  late final $PdfRecipeIngredientsTable pdfRecipeIngredients =
      $PdfRecipeIngredientsTable(this);
  late final $PdfRecipeStepsTable pdfRecipeSteps = $PdfRecipeStepsTable(this);
  late final $PdfRecipeNutritionTable pdfRecipeNutrition =
      $PdfRecipeNutritionTable(this);
  late final $PdfRecipeMediaTable pdfRecipeMedia = $PdfRecipeMediaTable(this);
  late final $PdfSimpleProductNutritionTable pdfSimpleProductNutrition =
      $PdfSimpleProductNutritionTable(this);
  late final $PdfMealSlotItemsTable pdfMealSlotItems = $PdfMealSlotItemsTable(
    this,
  );
  late final $UserProfilesTable userProfiles = $UserProfilesTable(this);
  late final $LoggedMealsTable loggedMeals = $LoggedMealsTable(this);
  late final Index productNutrientBasisUnique = Index(
    'product_nutrient_basis_unique',
    'CREATE UNIQUE INDEX product_nutrient_basis_unique ON product_nutrient_values (product_id, nutrient_id, basis_type)',
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    foodItems,
    nutrients,
    products,
    productNutrientValues,
    formulaDefinitions,
    activityLevels,
    macroNormTemplates,
    calorieDeficitPolicies,
    cookingYieldFactors,
    advisoryRules,
    mealPlanTemplates,
    mealPlanMeals,
    mealPlanLines,
    pdfMealPlans,
    pdfMealPlanDays,
    pdfRecipes,
    pdfSimpleProducts,
    pdfMediaAssets,
    pdfMealSlots,
    pdfRecipeIngredients,
    pdfRecipeSteps,
    pdfRecipeNutrition,
    pdfRecipeMedia,
    pdfSimpleProductNutrition,
    pdfMealSlotItems,
    userProfiles,
    loggedMeals,
    productNutrientBasisUnique,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'products',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('product_nutrient_values', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'nutrients',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('product_nutrient_values', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'meal_plan_templates',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('meal_plan_meals', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'meal_plan_meals',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('meal_plan_lines', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'meal_plans',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('meal_plan_days', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'meal_plan_days',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('meal_slots', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'recipes',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('recipe_ingredients', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'recipes',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('recipe_steps', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'recipes',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('recipe_nutrition', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'recipes',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('recipe_media', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'media_assets',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('recipe_media', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'simple_products',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [
        TableUpdate('simple_product_nutrition', kind: UpdateKind.delete),
      ],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'meal_slots',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('meal_slot_items', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'recipes',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('meal_slot_items', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'simple_products',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('meal_slot_items', kind: UpdateKind.update)],
    ),
  ]);
}

typedef $$FoodItemsTableCreateCompanionBuilder =
    FoodItemsCompanion Function({
      Value<int> id,
      required String title,
      Value<int> calories,
      Value<DateTime> recordedAt,
    });
typedef $$FoodItemsTableUpdateCompanionBuilder =
    FoodItemsCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<int> calories,
      Value<DateTime> recordedAt,
    });

class $$FoodItemsTableFilterComposer
    extends Composer<_$AppDatabase, $FoodItemsTable> {
  $$FoodItemsTableFilterComposer({
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

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get calories => $composableBuilder(
    column: $table.calories,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FoodItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $FoodItemsTable> {
  $$FoodItemsTableOrderingComposer({
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

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get calories => $composableBuilder(
    column: $table.calories,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FoodItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FoodItemsTable> {
  $$FoodItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<int> get calories =>
      $composableBuilder(column: $table.calories, builder: (column) => column);

  GeneratedColumn<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
    builder: (column) => column,
  );
}

class $$FoodItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FoodItemsTable,
          FoodItem,
          $$FoodItemsTableFilterComposer,
          $$FoodItemsTableOrderingComposer,
          $$FoodItemsTableAnnotationComposer,
          $$FoodItemsTableCreateCompanionBuilder,
          $$FoodItemsTableUpdateCompanionBuilder,
          (FoodItem, BaseReferences<_$AppDatabase, $FoodItemsTable, FoodItem>),
          FoodItem,
          PrefetchHooks Function()
        > {
  $$FoodItemsTableTableManager(_$AppDatabase db, $FoodItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FoodItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FoodItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FoodItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<int> calories = const Value.absent(),
                Value<DateTime> recordedAt = const Value.absent(),
              }) => FoodItemsCompanion(
                id: id,
                title: title,
                calories: calories,
                recordedAt: recordedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                Value<int> calories = const Value.absent(),
                Value<DateTime> recordedAt = const Value.absent(),
              }) => FoodItemsCompanion.insert(
                id: id,
                title: title,
                calories: calories,
                recordedAt: recordedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FoodItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FoodItemsTable,
      FoodItem,
      $$FoodItemsTableFilterComposer,
      $$FoodItemsTableOrderingComposer,
      $$FoodItemsTableAnnotationComposer,
      $$FoodItemsTableCreateCompanionBuilder,
      $$FoodItemsTableUpdateCompanionBuilder,
      (FoodItem, BaseReferences<_$AppDatabase, $FoodItemsTable, FoodItem>),
      FoodItem,
      PrefetchHooks Function()
    >;
typedef $$NutrientsTableCreateCompanionBuilder =
    NutrientsCompanion Function({
      Value<int> id,
      required String code,
      required String name,
      required String unit,
      required String nutrientType,
      Value<String?> description,
    });
typedef $$NutrientsTableUpdateCompanionBuilder =
    NutrientsCompanion Function({
      Value<int> id,
      Value<String> code,
      Value<String> name,
      Value<String> unit,
      Value<String> nutrientType,
      Value<String?> description,
    });

final class $$NutrientsTableReferences
    extends BaseReferences<_$AppDatabase, $NutrientsTable, Nutrient> {
  $$NutrientsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<
    $ProductNutrientValuesTable,
    List<ProductNutrientValue>
  >
  _productNutrientValuesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.productNutrientValues,
        aliasName: $_aliasNameGenerator(
          db.nutrients.id,
          db.productNutrientValues.nutrientId,
        ),
      );

  $$ProductNutrientValuesTableProcessedTableManager
  get productNutrientValuesRefs {
    final manager = $$ProductNutrientValuesTableTableManager(
      $_db,
      $_db.productNutrientValues,
    ).filter((f) => f.nutrientId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _productNutrientValuesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$NutrientsTableFilterComposer
    extends Composer<_$AppDatabase, $NutrientsTable> {
  $$NutrientsTableFilterComposer({
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

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nutrientType => $composableBuilder(
    column: $table.nutrientType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> productNutrientValuesRefs(
    Expression<bool> Function($$ProductNutrientValuesTableFilterComposer f) f,
  ) {
    final $$ProductNutrientValuesTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.productNutrientValues,
          getReferencedColumn: (t) => t.nutrientId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ProductNutrientValuesTableFilterComposer(
                $db: $db,
                $table: $db.productNutrientValues,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$NutrientsTableOrderingComposer
    extends Composer<_$AppDatabase, $NutrientsTable> {
  $$NutrientsTableOrderingComposer({
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

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nutrientType => $composableBuilder(
    column: $table.nutrientType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$NutrientsTableAnnotationComposer
    extends Composer<_$AppDatabase, $NutrientsTable> {
  $$NutrientsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<String> get nutrientType => $composableBuilder(
    column: $table.nutrientType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  Expression<T> productNutrientValuesRefs<T extends Object>(
    Expression<T> Function($$ProductNutrientValuesTableAnnotationComposer a) f,
  ) {
    final $$ProductNutrientValuesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.productNutrientValues,
          getReferencedColumn: (t) => t.nutrientId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ProductNutrientValuesTableAnnotationComposer(
                $db: $db,
                $table: $db.productNutrientValues,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$NutrientsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NutrientsTable,
          Nutrient,
          $$NutrientsTableFilterComposer,
          $$NutrientsTableOrderingComposer,
          $$NutrientsTableAnnotationComposer,
          $$NutrientsTableCreateCompanionBuilder,
          $$NutrientsTableUpdateCompanionBuilder,
          (Nutrient, $$NutrientsTableReferences),
          Nutrient,
          PrefetchHooks Function({bool productNutrientValuesRefs})
        > {
  $$NutrientsTableTableManager(_$AppDatabase db, $NutrientsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NutrientsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NutrientsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NutrientsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> unit = const Value.absent(),
                Value<String> nutrientType = const Value.absent(),
                Value<String?> description = const Value.absent(),
              }) => NutrientsCompanion(
                id: id,
                code: code,
                name: name,
                unit: unit,
                nutrientType: nutrientType,
                description: description,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String code,
                required String name,
                required String unit,
                required String nutrientType,
                Value<String?> description = const Value.absent(),
              }) => NutrientsCompanion.insert(
                id: id,
                code: code,
                name: name,
                unit: unit,
                nutrientType: nutrientType,
                description: description,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$NutrientsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({productNutrientValuesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (productNutrientValuesRefs) db.productNutrientValues,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (productNutrientValuesRefs)
                    await $_getPrefetchedData<
                      Nutrient,
                      $NutrientsTable,
                      ProductNutrientValue
                    >(
                      currentTable: table,
                      referencedTable: $$NutrientsTableReferences
                          ._productNutrientValuesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$NutrientsTableReferences(
                            db,
                            table,
                            p0,
                          ).productNutrientValuesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.nutrientId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$NutrientsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NutrientsTable,
      Nutrient,
      $$NutrientsTableFilterComposer,
      $$NutrientsTableOrderingComposer,
      $$NutrientsTableAnnotationComposer,
      $$NutrientsTableCreateCompanionBuilder,
      $$NutrientsTableUpdateCompanionBuilder,
      (Nutrient, $$NutrientsTableReferences),
      Nutrient,
      PrefetchHooks Function({bool productNutrientValuesRefs})
    >;
typedef $$ProductsTableCreateCompanionBuilder =
    ProductsCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> normalizedName,
      Value<String?> category,
      Value<String?> subcategory,
      Value<String?> description,
      Value<double?> defaultPortionGrams,
      Value<double?> ediblePartPercent,
      required String source,
      Value<String?> sourceRef,
      Value<String?> notes,
    });
typedef $$ProductsTableUpdateCompanionBuilder =
    ProductsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> normalizedName,
      Value<String?> category,
      Value<String?> subcategory,
      Value<String?> description,
      Value<double?> defaultPortionGrams,
      Value<double?> ediblePartPercent,
      Value<String> source,
      Value<String?> sourceRef,
      Value<String?> notes,
    });

final class $$ProductsTableReferences
    extends BaseReferences<_$AppDatabase, $ProductsTable, Product> {
  $$ProductsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<
    $ProductNutrientValuesTable,
    List<ProductNutrientValue>
  >
  _productNutrientValuesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.productNutrientValues,
        aliasName: $_aliasNameGenerator(
          db.products.id,
          db.productNutrientValues.productId,
        ),
      );

  $$ProductNutrientValuesTableProcessedTableManager
  get productNutrientValuesRefs {
    final manager = $$ProductNutrientValuesTableTableManager(
      $_db,
      $_db.productNutrientValues,
    ).filter((f) => f.productId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _productNutrientValuesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ProductsTableFilterComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get normalizedName => $composableBuilder(
    column: $table.normalizedName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get subcategory => $composableBuilder(
    column: $table.subcategory,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get defaultPortionGrams => $composableBuilder(
    column: $table.defaultPortionGrams,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get ediblePartPercent => $composableBuilder(
    column: $table.ediblePartPercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceRef => $composableBuilder(
    column: $table.sourceRef,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> productNutrientValuesRefs(
    Expression<bool> Function($$ProductNutrientValuesTableFilterComposer f) f,
  ) {
    final $$ProductNutrientValuesTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.productNutrientValues,
          getReferencedColumn: (t) => t.productId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ProductNutrientValuesTableFilterComposer(
                $db: $db,
                $table: $db.productNutrientValues,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$ProductsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get normalizedName => $composableBuilder(
    column: $table.normalizedName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get subcategory => $composableBuilder(
    column: $table.subcategory,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get defaultPortionGrams => $composableBuilder(
    column: $table.defaultPortionGrams,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get ediblePartPercent => $composableBuilder(
    column: $table.ediblePartPercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceRef => $composableBuilder(
    column: $table.sourceRef,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProductsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get normalizedName => $composableBuilder(
    column: $table.normalizedName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get subcategory => $composableBuilder(
    column: $table.subcategory,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<double> get defaultPortionGrams => $composableBuilder(
    column: $table.defaultPortionGrams,
    builder: (column) => column,
  );

  GeneratedColumn<double> get ediblePartPercent => $composableBuilder(
    column: $table.ediblePartPercent,
    builder: (column) => column,
  );

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get sourceRef =>
      $composableBuilder(column: $table.sourceRef, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  Expression<T> productNutrientValuesRefs<T extends Object>(
    Expression<T> Function($$ProductNutrientValuesTableAnnotationComposer a) f,
  ) {
    final $$ProductNutrientValuesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.productNutrientValues,
          getReferencedColumn: (t) => t.productId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ProductNutrientValuesTableAnnotationComposer(
                $db: $db,
                $table: $db.productNutrientValues,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$ProductsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductsTable,
          Product,
          $$ProductsTableFilterComposer,
          $$ProductsTableOrderingComposer,
          $$ProductsTableAnnotationComposer,
          $$ProductsTableCreateCompanionBuilder,
          $$ProductsTableUpdateCompanionBuilder,
          (Product, $$ProductsTableReferences),
          Product,
          PrefetchHooks Function({bool productNutrientValuesRefs})
        > {
  $$ProductsTableTableManager(_$AppDatabase db, $ProductsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> normalizedName = const Value.absent(),
                Value<String?> category = const Value.absent(),
                Value<String?> subcategory = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<double?> defaultPortionGrams = const Value.absent(),
                Value<double?> ediblePartPercent = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<String?> sourceRef = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => ProductsCompanion(
                id: id,
                name: name,
                normalizedName: normalizedName,
                category: category,
                subcategory: subcategory,
                description: description,
                defaultPortionGrams: defaultPortionGrams,
                ediblePartPercent: ediblePartPercent,
                source: source,
                sourceRef: sourceRef,
                notes: notes,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> normalizedName = const Value.absent(),
                Value<String?> category = const Value.absent(),
                Value<String?> subcategory = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<double?> defaultPortionGrams = const Value.absent(),
                Value<double?> ediblePartPercent = const Value.absent(),
                required String source,
                Value<String?> sourceRef = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => ProductsCompanion.insert(
                id: id,
                name: name,
                normalizedName: normalizedName,
                category: category,
                subcategory: subcategory,
                description: description,
                defaultPortionGrams: defaultPortionGrams,
                ediblePartPercent: ediblePartPercent,
                source: source,
                sourceRef: sourceRef,
                notes: notes,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ProductsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({productNutrientValuesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (productNutrientValuesRefs) db.productNutrientValues,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (productNutrientValuesRefs)
                    await $_getPrefetchedData<
                      Product,
                      $ProductsTable,
                      ProductNutrientValue
                    >(
                      currentTable: table,
                      referencedTable: $$ProductsTableReferences
                          ._productNutrientValuesRefsTable(db),
                      managerFromTypedResult: (p0) => $$ProductsTableReferences(
                        db,
                        table,
                        p0,
                      ).productNutrientValuesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.productId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ProductsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductsTable,
      Product,
      $$ProductsTableFilterComposer,
      $$ProductsTableOrderingComposer,
      $$ProductsTableAnnotationComposer,
      $$ProductsTableCreateCompanionBuilder,
      $$ProductsTableUpdateCompanionBuilder,
      (Product, $$ProductsTableReferences),
      Product,
      PrefetchHooks Function({bool productNutrientValuesRefs})
    >;
typedef $$ProductNutrientValuesTableCreateCompanionBuilder =
    ProductNutrientValuesCompanion Function({
      Value<int> id,
      required int productId,
      required int nutrientId,
      required double value,
      required String basisType,
      Value<double?> basisGrams,
      Value<String?> unitOverride,
    });
typedef $$ProductNutrientValuesTableUpdateCompanionBuilder =
    ProductNutrientValuesCompanion Function({
      Value<int> id,
      Value<int> productId,
      Value<int> nutrientId,
      Value<double> value,
      Value<String> basisType,
      Value<double?> basisGrams,
      Value<String?> unitOverride,
    });

final class $$ProductNutrientValuesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ProductNutrientValuesTable,
          ProductNutrientValue
        > {
  $$ProductNutrientValuesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ProductsTable _productIdTable(_$AppDatabase db) =>
      db.products.createAlias(
        $_aliasNameGenerator(
          db.productNutrientValues.productId,
          db.products.id,
        ),
      );

  $$ProductsTableProcessedTableManager get productId {
    final $_column = $_itemColumn<int>('product_id')!;

    final manager = $$ProductsTableTableManager(
      $_db,
      $_db.products,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $NutrientsTable _nutrientIdTable(_$AppDatabase db) =>
      db.nutrients.createAlias(
        $_aliasNameGenerator(
          db.productNutrientValues.nutrientId,
          db.nutrients.id,
        ),
      );

  $$NutrientsTableProcessedTableManager get nutrientId {
    final $_column = $_itemColumn<int>('nutrient_id')!;

    final manager = $$NutrientsTableTableManager(
      $_db,
      $_db.nutrients,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_nutrientIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ProductNutrientValuesTableFilterComposer
    extends Composer<_$AppDatabase, $ProductNutrientValuesTable> {
  $$ProductNutrientValuesTableFilterComposer({
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

  ColumnFilters<double> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get basisType => $composableBuilder(
    column: $table.basisType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get basisGrams => $composableBuilder(
    column: $table.basisGrams,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unitOverride => $composableBuilder(
    column: $table.unitOverride,
    builder: (column) => ColumnFilters(column),
  );

  $$ProductsTableFilterComposer get productId {
    final $$ProductsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableFilterComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$NutrientsTableFilterComposer get nutrientId {
    final $$NutrientsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.nutrientId,
      referencedTable: $db.nutrients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NutrientsTableFilterComposer(
            $db: $db,
            $table: $db.nutrients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProductNutrientValuesTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductNutrientValuesTable> {
  $$ProductNutrientValuesTableOrderingComposer({
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

  ColumnOrderings<double> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get basisType => $composableBuilder(
    column: $table.basisType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get basisGrams => $composableBuilder(
    column: $table.basisGrams,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unitOverride => $composableBuilder(
    column: $table.unitOverride,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProductsTableOrderingComposer get productId {
    final $$ProductsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableOrderingComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$NutrientsTableOrderingComposer get nutrientId {
    final $$NutrientsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.nutrientId,
      referencedTable: $db.nutrients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NutrientsTableOrderingComposer(
            $db: $db,
            $table: $db.nutrients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProductNutrientValuesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductNutrientValuesTable> {
  $$ProductNutrientValuesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<String> get basisType =>
      $composableBuilder(column: $table.basisType, builder: (column) => column);

  GeneratedColumn<double> get basisGrams => $composableBuilder(
    column: $table.basisGrams,
    builder: (column) => column,
  );

  GeneratedColumn<String> get unitOverride => $composableBuilder(
    column: $table.unitOverride,
    builder: (column) => column,
  );

  $$ProductsTableAnnotationComposer get productId {
    final $$ProductsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableAnnotationComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$NutrientsTableAnnotationComposer get nutrientId {
    final $$NutrientsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.nutrientId,
      referencedTable: $db.nutrients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NutrientsTableAnnotationComposer(
            $db: $db,
            $table: $db.nutrients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProductNutrientValuesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductNutrientValuesTable,
          ProductNutrientValue,
          $$ProductNutrientValuesTableFilterComposer,
          $$ProductNutrientValuesTableOrderingComposer,
          $$ProductNutrientValuesTableAnnotationComposer,
          $$ProductNutrientValuesTableCreateCompanionBuilder,
          $$ProductNutrientValuesTableUpdateCompanionBuilder,
          (ProductNutrientValue, $$ProductNutrientValuesTableReferences),
          ProductNutrientValue,
          PrefetchHooks Function({bool productId, bool nutrientId})
        > {
  $$ProductNutrientValuesTableTableManager(
    _$AppDatabase db,
    $ProductNutrientValuesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductNutrientValuesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$ProductNutrientValuesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ProductNutrientValuesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> productId = const Value.absent(),
                Value<int> nutrientId = const Value.absent(),
                Value<double> value = const Value.absent(),
                Value<String> basisType = const Value.absent(),
                Value<double?> basisGrams = const Value.absent(),
                Value<String?> unitOverride = const Value.absent(),
              }) => ProductNutrientValuesCompanion(
                id: id,
                productId: productId,
                nutrientId: nutrientId,
                value: value,
                basisType: basisType,
                basisGrams: basisGrams,
                unitOverride: unitOverride,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int productId,
                required int nutrientId,
                required double value,
                required String basisType,
                Value<double?> basisGrams = const Value.absent(),
                Value<String?> unitOverride = const Value.absent(),
              }) => ProductNutrientValuesCompanion.insert(
                id: id,
                productId: productId,
                nutrientId: nutrientId,
                value: value,
                basisType: basisType,
                basisGrams: basisGrams,
                unitOverride: unitOverride,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ProductNutrientValuesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({productId = false, nutrientId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (productId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.productId,
                                referencedTable:
                                    $$ProductNutrientValuesTableReferences
                                        ._productIdTable(db),
                                referencedColumn:
                                    $$ProductNutrientValuesTableReferences
                                        ._productIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (nutrientId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.nutrientId,
                                referencedTable:
                                    $$ProductNutrientValuesTableReferences
                                        ._nutrientIdTable(db),
                                referencedColumn:
                                    $$ProductNutrientValuesTableReferences
                                        ._nutrientIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ProductNutrientValuesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductNutrientValuesTable,
      ProductNutrientValue,
      $$ProductNutrientValuesTableFilterComposer,
      $$ProductNutrientValuesTableOrderingComposer,
      $$ProductNutrientValuesTableAnnotationComposer,
      $$ProductNutrientValuesTableCreateCompanionBuilder,
      $$ProductNutrientValuesTableUpdateCompanionBuilder,
      (ProductNutrientValue, $$ProductNutrientValuesTableReferences),
      ProductNutrientValue,
      PrefetchHooks Function({bool productId, bool nutrientId})
    >;
typedef $$FormulaDefinitionsTableCreateCompanionBuilder =
    FormulaDefinitionsCompanion Function({
      Value<int> id,
      required String code,
      required String name,
      required String expressionTemplate,
      Value<String?> variableDescription,
      Value<String?> applicationNotes,
    });
typedef $$FormulaDefinitionsTableUpdateCompanionBuilder =
    FormulaDefinitionsCompanion Function({
      Value<int> id,
      Value<String> code,
      Value<String> name,
      Value<String> expressionTemplate,
      Value<String?> variableDescription,
      Value<String?> applicationNotes,
    });

class $$FormulaDefinitionsTableFilterComposer
    extends Composer<_$AppDatabase, $FormulaDefinitionsTable> {
  $$FormulaDefinitionsTableFilterComposer({
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

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get expressionTemplate => $composableBuilder(
    column: $table.expressionTemplate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get variableDescription => $composableBuilder(
    column: $table.variableDescription,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get applicationNotes => $composableBuilder(
    column: $table.applicationNotes,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FormulaDefinitionsTableOrderingComposer
    extends Composer<_$AppDatabase, $FormulaDefinitionsTable> {
  $$FormulaDefinitionsTableOrderingComposer({
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

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get expressionTemplate => $composableBuilder(
    column: $table.expressionTemplate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get variableDescription => $composableBuilder(
    column: $table.variableDescription,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get applicationNotes => $composableBuilder(
    column: $table.applicationNotes,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FormulaDefinitionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FormulaDefinitionsTable> {
  $$FormulaDefinitionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get expressionTemplate => $composableBuilder(
    column: $table.expressionTemplate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get variableDescription => $composableBuilder(
    column: $table.variableDescription,
    builder: (column) => column,
  );

  GeneratedColumn<String> get applicationNotes => $composableBuilder(
    column: $table.applicationNotes,
    builder: (column) => column,
  );
}

class $$FormulaDefinitionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FormulaDefinitionsTable,
          FormulaDefinition,
          $$FormulaDefinitionsTableFilterComposer,
          $$FormulaDefinitionsTableOrderingComposer,
          $$FormulaDefinitionsTableAnnotationComposer,
          $$FormulaDefinitionsTableCreateCompanionBuilder,
          $$FormulaDefinitionsTableUpdateCompanionBuilder,
          (
            FormulaDefinition,
            BaseReferences<
              _$AppDatabase,
              $FormulaDefinitionsTable,
              FormulaDefinition
            >,
          ),
          FormulaDefinition,
          PrefetchHooks Function()
        > {
  $$FormulaDefinitionsTableTableManager(
    _$AppDatabase db,
    $FormulaDefinitionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FormulaDefinitionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FormulaDefinitionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FormulaDefinitionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> expressionTemplate = const Value.absent(),
                Value<String?> variableDescription = const Value.absent(),
                Value<String?> applicationNotes = const Value.absent(),
              }) => FormulaDefinitionsCompanion(
                id: id,
                code: code,
                name: name,
                expressionTemplate: expressionTemplate,
                variableDescription: variableDescription,
                applicationNotes: applicationNotes,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String code,
                required String name,
                required String expressionTemplate,
                Value<String?> variableDescription = const Value.absent(),
                Value<String?> applicationNotes = const Value.absent(),
              }) => FormulaDefinitionsCompanion.insert(
                id: id,
                code: code,
                name: name,
                expressionTemplate: expressionTemplate,
                variableDescription: variableDescription,
                applicationNotes: applicationNotes,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FormulaDefinitionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FormulaDefinitionsTable,
      FormulaDefinition,
      $$FormulaDefinitionsTableFilterComposer,
      $$FormulaDefinitionsTableOrderingComposer,
      $$FormulaDefinitionsTableAnnotationComposer,
      $$FormulaDefinitionsTableCreateCompanionBuilder,
      $$FormulaDefinitionsTableUpdateCompanionBuilder,
      (
        FormulaDefinition,
        BaseReferences<
          _$AppDatabase,
          $FormulaDefinitionsTable,
          FormulaDefinition
        >,
      ),
      FormulaDefinition,
      PrefetchHooks Function()
    >;
typedef $$ActivityLevelsTableCreateCompanionBuilder =
    ActivityLevelsCompanion Function({
      Value<int> id,
      required String code,
      required double multiplierMin,
      required double multiplierMax,
      required String description,
      Value<int> sortOrder,
    });
typedef $$ActivityLevelsTableUpdateCompanionBuilder =
    ActivityLevelsCompanion Function({
      Value<int> id,
      Value<String> code,
      Value<double> multiplierMin,
      Value<double> multiplierMax,
      Value<String> description,
      Value<int> sortOrder,
    });

class $$ActivityLevelsTableFilterComposer
    extends Composer<_$AppDatabase, $ActivityLevelsTable> {
  $$ActivityLevelsTableFilterComposer({
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

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get multiplierMin => $composableBuilder(
    column: $table.multiplierMin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get multiplierMax => $composableBuilder(
    column: $table.multiplierMax,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ActivityLevelsTableOrderingComposer
    extends Composer<_$AppDatabase, $ActivityLevelsTable> {
  $$ActivityLevelsTableOrderingComposer({
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

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get multiplierMin => $composableBuilder(
    column: $table.multiplierMin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get multiplierMax => $composableBuilder(
    column: $table.multiplierMax,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ActivityLevelsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ActivityLevelsTable> {
  $$ActivityLevelsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<double> get multiplierMin => $composableBuilder(
    column: $table.multiplierMin,
    builder: (column) => column,
  );

  GeneratedColumn<double> get multiplierMax => $composableBuilder(
    column: $table.multiplierMax,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);
}

class $$ActivityLevelsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ActivityLevelsTable,
          ActivityLevel,
          $$ActivityLevelsTableFilterComposer,
          $$ActivityLevelsTableOrderingComposer,
          $$ActivityLevelsTableAnnotationComposer,
          $$ActivityLevelsTableCreateCompanionBuilder,
          $$ActivityLevelsTableUpdateCompanionBuilder,
          (
            ActivityLevel,
            BaseReferences<_$AppDatabase, $ActivityLevelsTable, ActivityLevel>,
          ),
          ActivityLevel,
          PrefetchHooks Function()
        > {
  $$ActivityLevelsTableTableManager(
    _$AppDatabase db,
    $ActivityLevelsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ActivityLevelsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ActivityLevelsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ActivityLevelsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<double> multiplierMin = const Value.absent(),
                Value<double> multiplierMax = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
              }) => ActivityLevelsCompanion(
                id: id,
                code: code,
                multiplierMin: multiplierMin,
                multiplierMax: multiplierMax,
                description: description,
                sortOrder: sortOrder,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String code,
                required double multiplierMin,
                required double multiplierMax,
                required String description,
                Value<int> sortOrder = const Value.absent(),
              }) => ActivityLevelsCompanion.insert(
                id: id,
                code: code,
                multiplierMin: multiplierMin,
                multiplierMax: multiplierMax,
                description: description,
                sortOrder: sortOrder,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ActivityLevelsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ActivityLevelsTable,
      ActivityLevel,
      $$ActivityLevelsTableFilterComposer,
      $$ActivityLevelsTableOrderingComposer,
      $$ActivityLevelsTableAnnotationComposer,
      $$ActivityLevelsTableCreateCompanionBuilder,
      $$ActivityLevelsTableUpdateCompanionBuilder,
      (
        ActivityLevel,
        BaseReferences<_$AppDatabase, $ActivityLevelsTable, ActivityLevel>,
      ),
      ActivityLevel,
      PrefetchHooks Function()
    >;
typedef $$MacroNormTemplatesTableCreateCompanionBuilder =
    MacroNormTemplatesCompanion Function({
      Value<int> id,
      required String code,
      required String normType,
      Value<String?> sex,
      Value<double?> carbMinPct,
      Value<double?> carbMaxPct,
      Value<double?> fatMinPct,
      Value<double?> fatMaxPct,
      Value<double?> proteinMinPct,
      Value<double?> proteinMaxPct,
      Value<double?> proteinGPerKgMin,
      Value<double?> proteinGPerKgMax,
      Value<double?> fatGPerKgMin,
      Value<double?> fatGPerKgMax,
      Value<double?> kcalPerGramProtein,
      Value<double?> kcalPerGramCarb,
      Value<double?> kcalPerGramFat,
      Value<String?> notes,
    });
typedef $$MacroNormTemplatesTableUpdateCompanionBuilder =
    MacroNormTemplatesCompanion Function({
      Value<int> id,
      Value<String> code,
      Value<String> normType,
      Value<String?> sex,
      Value<double?> carbMinPct,
      Value<double?> carbMaxPct,
      Value<double?> fatMinPct,
      Value<double?> fatMaxPct,
      Value<double?> proteinMinPct,
      Value<double?> proteinMaxPct,
      Value<double?> proteinGPerKgMin,
      Value<double?> proteinGPerKgMax,
      Value<double?> fatGPerKgMin,
      Value<double?> fatGPerKgMax,
      Value<double?> kcalPerGramProtein,
      Value<double?> kcalPerGramCarb,
      Value<double?> kcalPerGramFat,
      Value<String?> notes,
    });

class $$MacroNormTemplatesTableFilterComposer
    extends Composer<_$AppDatabase, $MacroNormTemplatesTable> {
  $$MacroNormTemplatesTableFilterComposer({
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

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get normType => $composableBuilder(
    column: $table.normType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sex => $composableBuilder(
    column: $table.sex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get carbMinPct => $composableBuilder(
    column: $table.carbMinPct,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get carbMaxPct => $composableBuilder(
    column: $table.carbMaxPct,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fatMinPct => $composableBuilder(
    column: $table.fatMinPct,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fatMaxPct => $composableBuilder(
    column: $table.fatMaxPct,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get proteinMinPct => $composableBuilder(
    column: $table.proteinMinPct,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get proteinMaxPct => $composableBuilder(
    column: $table.proteinMaxPct,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get proteinGPerKgMin => $composableBuilder(
    column: $table.proteinGPerKgMin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get proteinGPerKgMax => $composableBuilder(
    column: $table.proteinGPerKgMax,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fatGPerKgMin => $composableBuilder(
    column: $table.fatGPerKgMin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fatGPerKgMax => $composableBuilder(
    column: $table.fatGPerKgMax,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get kcalPerGramProtein => $composableBuilder(
    column: $table.kcalPerGramProtein,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get kcalPerGramCarb => $composableBuilder(
    column: $table.kcalPerGramCarb,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get kcalPerGramFat => $composableBuilder(
    column: $table.kcalPerGramFat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MacroNormTemplatesTableOrderingComposer
    extends Composer<_$AppDatabase, $MacroNormTemplatesTable> {
  $$MacroNormTemplatesTableOrderingComposer({
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

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get normType => $composableBuilder(
    column: $table.normType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sex => $composableBuilder(
    column: $table.sex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get carbMinPct => $composableBuilder(
    column: $table.carbMinPct,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get carbMaxPct => $composableBuilder(
    column: $table.carbMaxPct,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fatMinPct => $composableBuilder(
    column: $table.fatMinPct,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fatMaxPct => $composableBuilder(
    column: $table.fatMaxPct,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get proteinMinPct => $composableBuilder(
    column: $table.proteinMinPct,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get proteinMaxPct => $composableBuilder(
    column: $table.proteinMaxPct,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get proteinGPerKgMin => $composableBuilder(
    column: $table.proteinGPerKgMin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get proteinGPerKgMax => $composableBuilder(
    column: $table.proteinGPerKgMax,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fatGPerKgMin => $composableBuilder(
    column: $table.fatGPerKgMin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fatGPerKgMax => $composableBuilder(
    column: $table.fatGPerKgMax,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get kcalPerGramProtein => $composableBuilder(
    column: $table.kcalPerGramProtein,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get kcalPerGramCarb => $composableBuilder(
    column: $table.kcalPerGramCarb,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get kcalPerGramFat => $composableBuilder(
    column: $table.kcalPerGramFat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MacroNormTemplatesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MacroNormTemplatesTable> {
  $$MacroNormTemplatesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get normType =>
      $composableBuilder(column: $table.normType, builder: (column) => column);

  GeneratedColumn<String> get sex =>
      $composableBuilder(column: $table.sex, builder: (column) => column);

  GeneratedColumn<double> get carbMinPct => $composableBuilder(
    column: $table.carbMinPct,
    builder: (column) => column,
  );

  GeneratedColumn<double> get carbMaxPct => $composableBuilder(
    column: $table.carbMaxPct,
    builder: (column) => column,
  );

  GeneratedColumn<double> get fatMinPct =>
      $composableBuilder(column: $table.fatMinPct, builder: (column) => column);

  GeneratedColumn<double> get fatMaxPct =>
      $composableBuilder(column: $table.fatMaxPct, builder: (column) => column);

  GeneratedColumn<double> get proteinMinPct => $composableBuilder(
    column: $table.proteinMinPct,
    builder: (column) => column,
  );

  GeneratedColumn<double> get proteinMaxPct => $composableBuilder(
    column: $table.proteinMaxPct,
    builder: (column) => column,
  );

  GeneratedColumn<double> get proteinGPerKgMin => $composableBuilder(
    column: $table.proteinGPerKgMin,
    builder: (column) => column,
  );

  GeneratedColumn<double> get proteinGPerKgMax => $composableBuilder(
    column: $table.proteinGPerKgMax,
    builder: (column) => column,
  );

  GeneratedColumn<double> get fatGPerKgMin => $composableBuilder(
    column: $table.fatGPerKgMin,
    builder: (column) => column,
  );

  GeneratedColumn<double> get fatGPerKgMax => $composableBuilder(
    column: $table.fatGPerKgMax,
    builder: (column) => column,
  );

  GeneratedColumn<double> get kcalPerGramProtein => $composableBuilder(
    column: $table.kcalPerGramProtein,
    builder: (column) => column,
  );

  GeneratedColumn<double> get kcalPerGramCarb => $composableBuilder(
    column: $table.kcalPerGramCarb,
    builder: (column) => column,
  );

  GeneratedColumn<double> get kcalPerGramFat => $composableBuilder(
    column: $table.kcalPerGramFat,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);
}

class $$MacroNormTemplatesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MacroNormTemplatesTable,
          MacroNormTemplate,
          $$MacroNormTemplatesTableFilterComposer,
          $$MacroNormTemplatesTableOrderingComposer,
          $$MacroNormTemplatesTableAnnotationComposer,
          $$MacroNormTemplatesTableCreateCompanionBuilder,
          $$MacroNormTemplatesTableUpdateCompanionBuilder,
          (
            MacroNormTemplate,
            BaseReferences<
              _$AppDatabase,
              $MacroNormTemplatesTable,
              MacroNormTemplate
            >,
          ),
          MacroNormTemplate,
          PrefetchHooks Function()
        > {
  $$MacroNormTemplatesTableTableManager(
    _$AppDatabase db,
    $MacroNormTemplatesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MacroNormTemplatesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MacroNormTemplatesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MacroNormTemplatesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<String> normType = const Value.absent(),
                Value<String?> sex = const Value.absent(),
                Value<double?> carbMinPct = const Value.absent(),
                Value<double?> carbMaxPct = const Value.absent(),
                Value<double?> fatMinPct = const Value.absent(),
                Value<double?> fatMaxPct = const Value.absent(),
                Value<double?> proteinMinPct = const Value.absent(),
                Value<double?> proteinMaxPct = const Value.absent(),
                Value<double?> proteinGPerKgMin = const Value.absent(),
                Value<double?> proteinGPerKgMax = const Value.absent(),
                Value<double?> fatGPerKgMin = const Value.absent(),
                Value<double?> fatGPerKgMax = const Value.absent(),
                Value<double?> kcalPerGramProtein = const Value.absent(),
                Value<double?> kcalPerGramCarb = const Value.absent(),
                Value<double?> kcalPerGramFat = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => MacroNormTemplatesCompanion(
                id: id,
                code: code,
                normType: normType,
                sex: sex,
                carbMinPct: carbMinPct,
                carbMaxPct: carbMaxPct,
                fatMinPct: fatMinPct,
                fatMaxPct: fatMaxPct,
                proteinMinPct: proteinMinPct,
                proteinMaxPct: proteinMaxPct,
                proteinGPerKgMin: proteinGPerKgMin,
                proteinGPerKgMax: proteinGPerKgMax,
                fatGPerKgMin: fatGPerKgMin,
                fatGPerKgMax: fatGPerKgMax,
                kcalPerGramProtein: kcalPerGramProtein,
                kcalPerGramCarb: kcalPerGramCarb,
                kcalPerGramFat: kcalPerGramFat,
                notes: notes,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String code,
                required String normType,
                Value<String?> sex = const Value.absent(),
                Value<double?> carbMinPct = const Value.absent(),
                Value<double?> carbMaxPct = const Value.absent(),
                Value<double?> fatMinPct = const Value.absent(),
                Value<double?> fatMaxPct = const Value.absent(),
                Value<double?> proteinMinPct = const Value.absent(),
                Value<double?> proteinMaxPct = const Value.absent(),
                Value<double?> proteinGPerKgMin = const Value.absent(),
                Value<double?> proteinGPerKgMax = const Value.absent(),
                Value<double?> fatGPerKgMin = const Value.absent(),
                Value<double?> fatGPerKgMax = const Value.absent(),
                Value<double?> kcalPerGramProtein = const Value.absent(),
                Value<double?> kcalPerGramCarb = const Value.absent(),
                Value<double?> kcalPerGramFat = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => MacroNormTemplatesCompanion.insert(
                id: id,
                code: code,
                normType: normType,
                sex: sex,
                carbMinPct: carbMinPct,
                carbMaxPct: carbMaxPct,
                fatMinPct: fatMinPct,
                fatMaxPct: fatMaxPct,
                proteinMinPct: proteinMinPct,
                proteinMaxPct: proteinMaxPct,
                proteinGPerKgMin: proteinGPerKgMin,
                proteinGPerKgMax: proteinGPerKgMax,
                fatGPerKgMin: fatGPerKgMin,
                fatGPerKgMax: fatGPerKgMax,
                kcalPerGramProtein: kcalPerGramProtein,
                kcalPerGramCarb: kcalPerGramCarb,
                kcalPerGramFat: kcalPerGramFat,
                notes: notes,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MacroNormTemplatesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MacroNormTemplatesTable,
      MacroNormTemplate,
      $$MacroNormTemplatesTableFilterComposer,
      $$MacroNormTemplatesTableOrderingComposer,
      $$MacroNormTemplatesTableAnnotationComposer,
      $$MacroNormTemplatesTableCreateCompanionBuilder,
      $$MacroNormTemplatesTableUpdateCompanionBuilder,
      (
        MacroNormTemplate,
        BaseReferences<
          _$AppDatabase,
          $MacroNormTemplatesTable,
          MacroNormTemplate
        >,
      ),
      MacroNormTemplate,
      PrefetchHooks Function()
    >;
typedef $$CalorieDeficitPoliciesTableCreateCompanionBuilder =
    CalorieDeficitPoliciesCompanion Function({
      Value<int> id,
      required String code,
      Value<double?> deficitPercentMin,
      Value<double?> deficitPercentMax,
      Value<int?> rollingAverageDaysMin,
      Value<int?> rollingAverageDaysRecommended,
      Value<double?> weeklyWeightLossOkKg,
      Value<double?> weeklyWeightLossTooFastKg,
      Value<int?> adjustmentAddCaloriesWhenTooFast,
      Value<double?> adjustmentExtraDeficitPercentWhenSlow,
      Value<String?> rationaleText,
    });
typedef $$CalorieDeficitPoliciesTableUpdateCompanionBuilder =
    CalorieDeficitPoliciesCompanion Function({
      Value<int> id,
      Value<String> code,
      Value<double?> deficitPercentMin,
      Value<double?> deficitPercentMax,
      Value<int?> rollingAverageDaysMin,
      Value<int?> rollingAverageDaysRecommended,
      Value<double?> weeklyWeightLossOkKg,
      Value<double?> weeklyWeightLossTooFastKg,
      Value<int?> adjustmentAddCaloriesWhenTooFast,
      Value<double?> adjustmentExtraDeficitPercentWhenSlow,
      Value<String?> rationaleText,
    });

class $$CalorieDeficitPoliciesTableFilterComposer
    extends Composer<_$AppDatabase, $CalorieDeficitPoliciesTable> {
  $$CalorieDeficitPoliciesTableFilterComposer({
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

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get deficitPercentMin => $composableBuilder(
    column: $table.deficitPercentMin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get deficitPercentMax => $composableBuilder(
    column: $table.deficitPercentMax,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rollingAverageDaysMin => $composableBuilder(
    column: $table.rollingAverageDaysMin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rollingAverageDaysRecommended => $composableBuilder(
    column: $table.rollingAverageDaysRecommended,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weeklyWeightLossOkKg => $composableBuilder(
    column: $table.weeklyWeightLossOkKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weeklyWeightLossTooFastKg => $composableBuilder(
    column: $table.weeklyWeightLossTooFastKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get adjustmentAddCaloriesWhenTooFast => $composableBuilder(
    column: $table.adjustmentAddCaloriesWhenTooFast,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get adjustmentExtraDeficitPercentWhenSlow =>
      $composableBuilder(
        column: $table.adjustmentExtraDeficitPercentWhenSlow,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<String> get rationaleText => $composableBuilder(
    column: $table.rationaleText,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CalorieDeficitPoliciesTableOrderingComposer
    extends Composer<_$AppDatabase, $CalorieDeficitPoliciesTable> {
  $$CalorieDeficitPoliciesTableOrderingComposer({
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

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get deficitPercentMin => $composableBuilder(
    column: $table.deficitPercentMin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get deficitPercentMax => $composableBuilder(
    column: $table.deficitPercentMax,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rollingAverageDaysMin => $composableBuilder(
    column: $table.rollingAverageDaysMin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rollingAverageDaysRecommended => $composableBuilder(
    column: $table.rollingAverageDaysRecommended,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weeklyWeightLossOkKg => $composableBuilder(
    column: $table.weeklyWeightLossOkKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weeklyWeightLossTooFastKg => $composableBuilder(
    column: $table.weeklyWeightLossTooFastKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get adjustmentAddCaloriesWhenTooFast =>
      $composableBuilder(
        column: $table.adjustmentAddCaloriesWhenTooFast,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<double> get adjustmentExtraDeficitPercentWhenSlow =>
      $composableBuilder(
        column: $table.adjustmentExtraDeficitPercentWhenSlow,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<String> get rationaleText => $composableBuilder(
    column: $table.rationaleText,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CalorieDeficitPoliciesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CalorieDeficitPoliciesTable> {
  $$CalorieDeficitPoliciesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<double> get deficitPercentMin => $composableBuilder(
    column: $table.deficitPercentMin,
    builder: (column) => column,
  );

  GeneratedColumn<double> get deficitPercentMax => $composableBuilder(
    column: $table.deficitPercentMax,
    builder: (column) => column,
  );

  GeneratedColumn<int> get rollingAverageDaysMin => $composableBuilder(
    column: $table.rollingAverageDaysMin,
    builder: (column) => column,
  );

  GeneratedColumn<int> get rollingAverageDaysRecommended => $composableBuilder(
    column: $table.rollingAverageDaysRecommended,
    builder: (column) => column,
  );

  GeneratedColumn<double> get weeklyWeightLossOkKg => $composableBuilder(
    column: $table.weeklyWeightLossOkKg,
    builder: (column) => column,
  );

  GeneratedColumn<double> get weeklyWeightLossTooFastKg => $composableBuilder(
    column: $table.weeklyWeightLossTooFastKg,
    builder: (column) => column,
  );

  GeneratedColumn<int> get adjustmentAddCaloriesWhenTooFast =>
      $composableBuilder(
        column: $table.adjustmentAddCaloriesWhenTooFast,
        builder: (column) => column,
      );

  GeneratedColumn<double> get adjustmentExtraDeficitPercentWhenSlow =>
      $composableBuilder(
        column: $table.adjustmentExtraDeficitPercentWhenSlow,
        builder: (column) => column,
      );

  GeneratedColumn<String> get rationaleText => $composableBuilder(
    column: $table.rationaleText,
    builder: (column) => column,
  );
}

class $$CalorieDeficitPoliciesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CalorieDeficitPoliciesTable,
          CalorieDeficitPolicy,
          $$CalorieDeficitPoliciesTableFilterComposer,
          $$CalorieDeficitPoliciesTableOrderingComposer,
          $$CalorieDeficitPoliciesTableAnnotationComposer,
          $$CalorieDeficitPoliciesTableCreateCompanionBuilder,
          $$CalorieDeficitPoliciesTableUpdateCompanionBuilder,
          (
            CalorieDeficitPolicy,
            BaseReferences<
              _$AppDatabase,
              $CalorieDeficitPoliciesTable,
              CalorieDeficitPolicy
            >,
          ),
          CalorieDeficitPolicy,
          PrefetchHooks Function()
        > {
  $$CalorieDeficitPoliciesTableTableManager(
    _$AppDatabase db,
    $CalorieDeficitPoliciesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CalorieDeficitPoliciesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$CalorieDeficitPoliciesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$CalorieDeficitPoliciesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<double?> deficitPercentMin = const Value.absent(),
                Value<double?> deficitPercentMax = const Value.absent(),
                Value<int?> rollingAverageDaysMin = const Value.absent(),
                Value<int?> rollingAverageDaysRecommended =
                    const Value.absent(),
                Value<double?> weeklyWeightLossOkKg = const Value.absent(),
                Value<double?> weeklyWeightLossTooFastKg = const Value.absent(),
                Value<int?> adjustmentAddCaloriesWhenTooFast =
                    const Value.absent(),
                Value<double?> adjustmentExtraDeficitPercentWhenSlow =
                    const Value.absent(),
                Value<String?> rationaleText = const Value.absent(),
              }) => CalorieDeficitPoliciesCompanion(
                id: id,
                code: code,
                deficitPercentMin: deficitPercentMin,
                deficitPercentMax: deficitPercentMax,
                rollingAverageDaysMin: rollingAverageDaysMin,
                rollingAverageDaysRecommended: rollingAverageDaysRecommended,
                weeklyWeightLossOkKg: weeklyWeightLossOkKg,
                weeklyWeightLossTooFastKg: weeklyWeightLossTooFastKg,
                adjustmentAddCaloriesWhenTooFast:
                    adjustmentAddCaloriesWhenTooFast,
                adjustmentExtraDeficitPercentWhenSlow:
                    adjustmentExtraDeficitPercentWhenSlow,
                rationaleText: rationaleText,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String code,
                Value<double?> deficitPercentMin = const Value.absent(),
                Value<double?> deficitPercentMax = const Value.absent(),
                Value<int?> rollingAverageDaysMin = const Value.absent(),
                Value<int?> rollingAverageDaysRecommended =
                    const Value.absent(),
                Value<double?> weeklyWeightLossOkKg = const Value.absent(),
                Value<double?> weeklyWeightLossTooFastKg = const Value.absent(),
                Value<int?> adjustmentAddCaloriesWhenTooFast =
                    const Value.absent(),
                Value<double?> adjustmentExtraDeficitPercentWhenSlow =
                    const Value.absent(),
                Value<String?> rationaleText = const Value.absent(),
              }) => CalorieDeficitPoliciesCompanion.insert(
                id: id,
                code: code,
                deficitPercentMin: deficitPercentMin,
                deficitPercentMax: deficitPercentMax,
                rollingAverageDaysMin: rollingAverageDaysMin,
                rollingAverageDaysRecommended: rollingAverageDaysRecommended,
                weeklyWeightLossOkKg: weeklyWeightLossOkKg,
                weeklyWeightLossTooFastKg: weeklyWeightLossTooFastKg,
                adjustmentAddCaloriesWhenTooFast:
                    adjustmentAddCaloriesWhenTooFast,
                adjustmentExtraDeficitPercentWhenSlow:
                    adjustmentExtraDeficitPercentWhenSlow,
                rationaleText: rationaleText,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CalorieDeficitPoliciesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CalorieDeficitPoliciesTable,
      CalorieDeficitPolicy,
      $$CalorieDeficitPoliciesTableFilterComposer,
      $$CalorieDeficitPoliciesTableOrderingComposer,
      $$CalorieDeficitPoliciesTableAnnotationComposer,
      $$CalorieDeficitPoliciesTableCreateCompanionBuilder,
      $$CalorieDeficitPoliciesTableUpdateCompanionBuilder,
      (
        CalorieDeficitPolicy,
        BaseReferences<
          _$AppDatabase,
          $CalorieDeficitPoliciesTable,
          CalorieDeficitPolicy
        >,
      ),
      CalorieDeficitPolicy,
      PrefetchHooks Function()
    >;
typedef $$CookingYieldFactorsTableCreateCompanionBuilder =
    CookingYieldFactorsCompanion Function({
      Value<int> id,
      required String ingredientKey,
      required String category,
      Value<double?> yieldLossPercent,
      Value<double?> yieldLossPercentMin,
      Value<double?> yieldLossPercentMax,
      Value<String?> notes,
    });
typedef $$CookingYieldFactorsTableUpdateCompanionBuilder =
    CookingYieldFactorsCompanion Function({
      Value<int> id,
      Value<String> ingredientKey,
      Value<String> category,
      Value<double?> yieldLossPercent,
      Value<double?> yieldLossPercentMin,
      Value<double?> yieldLossPercentMax,
      Value<String?> notes,
    });

class $$CookingYieldFactorsTableFilterComposer
    extends Composer<_$AppDatabase, $CookingYieldFactorsTable> {
  $$CookingYieldFactorsTableFilterComposer({
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

  ColumnFilters<String> get ingredientKey => $composableBuilder(
    column: $table.ingredientKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get yieldLossPercent => $composableBuilder(
    column: $table.yieldLossPercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get yieldLossPercentMin => $composableBuilder(
    column: $table.yieldLossPercentMin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get yieldLossPercentMax => $composableBuilder(
    column: $table.yieldLossPercentMax,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CookingYieldFactorsTableOrderingComposer
    extends Composer<_$AppDatabase, $CookingYieldFactorsTable> {
  $$CookingYieldFactorsTableOrderingComposer({
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

  ColumnOrderings<String> get ingredientKey => $composableBuilder(
    column: $table.ingredientKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get yieldLossPercent => $composableBuilder(
    column: $table.yieldLossPercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get yieldLossPercentMin => $composableBuilder(
    column: $table.yieldLossPercentMin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get yieldLossPercentMax => $composableBuilder(
    column: $table.yieldLossPercentMax,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CookingYieldFactorsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CookingYieldFactorsTable> {
  $$CookingYieldFactorsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get ingredientKey => $composableBuilder(
    column: $table.ingredientKey,
    builder: (column) => column,
  );

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<double> get yieldLossPercent => $composableBuilder(
    column: $table.yieldLossPercent,
    builder: (column) => column,
  );

  GeneratedColumn<double> get yieldLossPercentMin => $composableBuilder(
    column: $table.yieldLossPercentMin,
    builder: (column) => column,
  );

  GeneratedColumn<double> get yieldLossPercentMax => $composableBuilder(
    column: $table.yieldLossPercentMax,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);
}

class $$CookingYieldFactorsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CookingYieldFactorsTable,
          CookingYieldFactor,
          $$CookingYieldFactorsTableFilterComposer,
          $$CookingYieldFactorsTableOrderingComposer,
          $$CookingYieldFactorsTableAnnotationComposer,
          $$CookingYieldFactorsTableCreateCompanionBuilder,
          $$CookingYieldFactorsTableUpdateCompanionBuilder,
          (
            CookingYieldFactor,
            BaseReferences<
              _$AppDatabase,
              $CookingYieldFactorsTable,
              CookingYieldFactor
            >,
          ),
          CookingYieldFactor,
          PrefetchHooks Function()
        > {
  $$CookingYieldFactorsTableTableManager(
    _$AppDatabase db,
    $CookingYieldFactorsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CookingYieldFactorsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CookingYieldFactorsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$CookingYieldFactorsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> ingredientKey = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<double?> yieldLossPercent = const Value.absent(),
                Value<double?> yieldLossPercentMin = const Value.absent(),
                Value<double?> yieldLossPercentMax = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => CookingYieldFactorsCompanion(
                id: id,
                ingredientKey: ingredientKey,
                category: category,
                yieldLossPercent: yieldLossPercent,
                yieldLossPercentMin: yieldLossPercentMin,
                yieldLossPercentMax: yieldLossPercentMax,
                notes: notes,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String ingredientKey,
                required String category,
                Value<double?> yieldLossPercent = const Value.absent(),
                Value<double?> yieldLossPercentMin = const Value.absent(),
                Value<double?> yieldLossPercentMax = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => CookingYieldFactorsCompanion.insert(
                id: id,
                ingredientKey: ingredientKey,
                category: category,
                yieldLossPercent: yieldLossPercent,
                yieldLossPercentMin: yieldLossPercentMin,
                yieldLossPercentMax: yieldLossPercentMax,
                notes: notes,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CookingYieldFactorsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CookingYieldFactorsTable,
      CookingYieldFactor,
      $$CookingYieldFactorsTableFilterComposer,
      $$CookingYieldFactorsTableOrderingComposer,
      $$CookingYieldFactorsTableAnnotationComposer,
      $$CookingYieldFactorsTableCreateCompanionBuilder,
      $$CookingYieldFactorsTableUpdateCompanionBuilder,
      (
        CookingYieldFactor,
        BaseReferences<
          _$AppDatabase,
          $CookingYieldFactorsTable,
          CookingYieldFactor
        >,
      ),
      CookingYieldFactor,
      PrefetchHooks Function()
    >;
typedef $$AdvisoryRulesTableCreateCompanionBuilder =
    AdvisoryRulesCompanion Function({
      Value<int> id,
      required String ruleType,
      Value<String?> contextTags,
      Value<String?> conditionText,
      Value<String?> severity,
      required String recommendation,
      Value<bool> isAutomatable,
      Value<String?> sourceRef,
    });
typedef $$AdvisoryRulesTableUpdateCompanionBuilder =
    AdvisoryRulesCompanion Function({
      Value<int> id,
      Value<String> ruleType,
      Value<String?> contextTags,
      Value<String?> conditionText,
      Value<String?> severity,
      Value<String> recommendation,
      Value<bool> isAutomatable,
      Value<String?> sourceRef,
    });

class $$AdvisoryRulesTableFilterComposer
    extends Composer<_$AppDatabase, $AdvisoryRulesTable> {
  $$AdvisoryRulesTableFilterComposer({
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

  ColumnFilters<String> get ruleType => $composableBuilder(
    column: $table.ruleType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contextTags => $composableBuilder(
    column: $table.contextTags,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get conditionText => $composableBuilder(
    column: $table.conditionText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get severity => $composableBuilder(
    column: $table.severity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get recommendation => $composableBuilder(
    column: $table.recommendation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isAutomatable => $composableBuilder(
    column: $table.isAutomatable,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceRef => $composableBuilder(
    column: $table.sourceRef,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AdvisoryRulesTableOrderingComposer
    extends Composer<_$AppDatabase, $AdvisoryRulesTable> {
  $$AdvisoryRulesTableOrderingComposer({
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

  ColumnOrderings<String> get ruleType => $composableBuilder(
    column: $table.ruleType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contextTags => $composableBuilder(
    column: $table.contextTags,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get conditionText => $composableBuilder(
    column: $table.conditionText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get severity => $composableBuilder(
    column: $table.severity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recommendation => $composableBuilder(
    column: $table.recommendation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isAutomatable => $composableBuilder(
    column: $table.isAutomatable,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceRef => $composableBuilder(
    column: $table.sourceRef,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AdvisoryRulesTableAnnotationComposer
    extends Composer<_$AppDatabase, $AdvisoryRulesTable> {
  $$AdvisoryRulesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get ruleType =>
      $composableBuilder(column: $table.ruleType, builder: (column) => column);

  GeneratedColumn<String> get contextTags => $composableBuilder(
    column: $table.contextTags,
    builder: (column) => column,
  );

  GeneratedColumn<String> get conditionText => $composableBuilder(
    column: $table.conditionText,
    builder: (column) => column,
  );

  GeneratedColumn<String> get severity =>
      $composableBuilder(column: $table.severity, builder: (column) => column);

  GeneratedColumn<String> get recommendation => $composableBuilder(
    column: $table.recommendation,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isAutomatable => $composableBuilder(
    column: $table.isAutomatable,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sourceRef =>
      $composableBuilder(column: $table.sourceRef, builder: (column) => column);
}

class $$AdvisoryRulesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AdvisoryRulesTable,
          AdvisoryRule,
          $$AdvisoryRulesTableFilterComposer,
          $$AdvisoryRulesTableOrderingComposer,
          $$AdvisoryRulesTableAnnotationComposer,
          $$AdvisoryRulesTableCreateCompanionBuilder,
          $$AdvisoryRulesTableUpdateCompanionBuilder,
          (
            AdvisoryRule,
            BaseReferences<_$AppDatabase, $AdvisoryRulesTable, AdvisoryRule>,
          ),
          AdvisoryRule,
          PrefetchHooks Function()
        > {
  $$AdvisoryRulesTableTableManager(_$AppDatabase db, $AdvisoryRulesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AdvisoryRulesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AdvisoryRulesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AdvisoryRulesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> ruleType = const Value.absent(),
                Value<String?> contextTags = const Value.absent(),
                Value<String?> conditionText = const Value.absent(),
                Value<String?> severity = const Value.absent(),
                Value<String> recommendation = const Value.absent(),
                Value<bool> isAutomatable = const Value.absent(),
                Value<String?> sourceRef = const Value.absent(),
              }) => AdvisoryRulesCompanion(
                id: id,
                ruleType: ruleType,
                contextTags: contextTags,
                conditionText: conditionText,
                severity: severity,
                recommendation: recommendation,
                isAutomatable: isAutomatable,
                sourceRef: sourceRef,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String ruleType,
                Value<String?> contextTags = const Value.absent(),
                Value<String?> conditionText = const Value.absent(),
                Value<String?> severity = const Value.absent(),
                required String recommendation,
                Value<bool> isAutomatable = const Value.absent(),
                Value<String?> sourceRef = const Value.absent(),
              }) => AdvisoryRulesCompanion.insert(
                id: id,
                ruleType: ruleType,
                contextTags: contextTags,
                conditionText: conditionText,
                severity: severity,
                recommendation: recommendation,
                isAutomatable: isAutomatable,
                sourceRef: sourceRef,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AdvisoryRulesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AdvisoryRulesTable,
      AdvisoryRule,
      $$AdvisoryRulesTableFilterComposer,
      $$AdvisoryRulesTableOrderingComposer,
      $$AdvisoryRulesTableAnnotationComposer,
      $$AdvisoryRulesTableCreateCompanionBuilder,
      $$AdvisoryRulesTableUpdateCompanionBuilder,
      (
        AdvisoryRule,
        BaseReferences<_$AppDatabase, $AdvisoryRulesTable, AdvisoryRule>,
      ),
      AdvisoryRule,
      PrefetchHooks Function()
    >;
typedef $$MealPlanTemplatesTableCreateCompanionBuilder =
    MealPlanTemplatesCompanion Function({
      Value<int> id,
      required String code,
      required String title,
      Value<String?> sourceBook,
      Value<String?> chapterRef,
      Value<int?> exampleNumber,
      Value<int?> dayNumber,
      Value<double?> targetCalories,
      Value<double?> targetProteinG,
      Value<double?> targetFatG,
      Value<double?> targetCarbG,
    });
typedef $$MealPlanTemplatesTableUpdateCompanionBuilder =
    MealPlanTemplatesCompanion Function({
      Value<int> id,
      Value<String> code,
      Value<String> title,
      Value<String?> sourceBook,
      Value<String?> chapterRef,
      Value<int?> exampleNumber,
      Value<int?> dayNumber,
      Value<double?> targetCalories,
      Value<double?> targetProteinG,
      Value<double?> targetFatG,
      Value<double?> targetCarbG,
    });

final class $$MealPlanTemplatesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $MealPlanTemplatesTable,
          MealPlanTemplate
        > {
  $$MealPlanTemplatesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$MealPlanMealsTable, List<MealPlanMeal>>
  _mealPlanMealsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.mealPlanMeals,
    aliasName: $_aliasNameGenerator(
      db.mealPlanTemplates.id,
      db.mealPlanMeals.templateId,
    ),
  );

  $$MealPlanMealsTableProcessedTableManager get mealPlanMealsRefs {
    final manager = $$MealPlanMealsTableTableManager(
      $_db,
      $_db.mealPlanMeals,
    ).filter((f) => f.templateId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_mealPlanMealsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MealPlanTemplatesTableFilterComposer
    extends Composer<_$AppDatabase, $MealPlanTemplatesTable> {
  $$MealPlanTemplatesTableFilterComposer({
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

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceBook => $composableBuilder(
    column: $table.sourceBook,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get chapterRef => $composableBuilder(
    column: $table.chapterRef,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get exampleNumber => $composableBuilder(
    column: $table.exampleNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dayNumber => $composableBuilder(
    column: $table.dayNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get targetCalories => $composableBuilder(
    column: $table.targetCalories,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get targetProteinG => $composableBuilder(
    column: $table.targetProteinG,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get targetFatG => $composableBuilder(
    column: $table.targetFatG,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get targetCarbG => $composableBuilder(
    column: $table.targetCarbG,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> mealPlanMealsRefs(
    Expression<bool> Function($$MealPlanMealsTableFilterComposer f) f,
  ) {
    final $$MealPlanMealsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mealPlanMeals,
      getReferencedColumn: (t) => t.templateId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MealPlanMealsTableFilterComposer(
            $db: $db,
            $table: $db.mealPlanMeals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MealPlanTemplatesTableOrderingComposer
    extends Composer<_$AppDatabase, $MealPlanTemplatesTable> {
  $$MealPlanTemplatesTableOrderingComposer({
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

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceBook => $composableBuilder(
    column: $table.sourceBook,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get chapterRef => $composableBuilder(
    column: $table.chapterRef,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get exampleNumber => $composableBuilder(
    column: $table.exampleNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dayNumber => $composableBuilder(
    column: $table.dayNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get targetCalories => $composableBuilder(
    column: $table.targetCalories,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get targetProteinG => $composableBuilder(
    column: $table.targetProteinG,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get targetFatG => $composableBuilder(
    column: $table.targetFatG,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get targetCarbG => $composableBuilder(
    column: $table.targetCarbG,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MealPlanTemplatesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MealPlanTemplatesTable> {
  $$MealPlanTemplatesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get sourceBook => $composableBuilder(
    column: $table.sourceBook,
    builder: (column) => column,
  );

  GeneratedColumn<String> get chapterRef => $composableBuilder(
    column: $table.chapterRef,
    builder: (column) => column,
  );

  GeneratedColumn<int> get exampleNumber => $composableBuilder(
    column: $table.exampleNumber,
    builder: (column) => column,
  );

  GeneratedColumn<int> get dayNumber =>
      $composableBuilder(column: $table.dayNumber, builder: (column) => column);

  GeneratedColumn<double> get targetCalories => $composableBuilder(
    column: $table.targetCalories,
    builder: (column) => column,
  );

  GeneratedColumn<double> get targetProteinG => $composableBuilder(
    column: $table.targetProteinG,
    builder: (column) => column,
  );

  GeneratedColumn<double> get targetFatG => $composableBuilder(
    column: $table.targetFatG,
    builder: (column) => column,
  );

  GeneratedColumn<double> get targetCarbG => $composableBuilder(
    column: $table.targetCarbG,
    builder: (column) => column,
  );

  Expression<T> mealPlanMealsRefs<T extends Object>(
    Expression<T> Function($$MealPlanMealsTableAnnotationComposer a) f,
  ) {
    final $$MealPlanMealsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mealPlanMeals,
      getReferencedColumn: (t) => t.templateId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MealPlanMealsTableAnnotationComposer(
            $db: $db,
            $table: $db.mealPlanMeals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MealPlanTemplatesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MealPlanTemplatesTable,
          MealPlanTemplate,
          $$MealPlanTemplatesTableFilterComposer,
          $$MealPlanTemplatesTableOrderingComposer,
          $$MealPlanTemplatesTableAnnotationComposer,
          $$MealPlanTemplatesTableCreateCompanionBuilder,
          $$MealPlanTemplatesTableUpdateCompanionBuilder,
          (MealPlanTemplate, $$MealPlanTemplatesTableReferences),
          MealPlanTemplate,
          PrefetchHooks Function({bool mealPlanMealsRefs})
        > {
  $$MealPlanTemplatesTableTableManager(
    _$AppDatabase db,
    $MealPlanTemplatesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MealPlanTemplatesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MealPlanTemplatesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MealPlanTemplatesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> sourceBook = const Value.absent(),
                Value<String?> chapterRef = const Value.absent(),
                Value<int?> exampleNumber = const Value.absent(),
                Value<int?> dayNumber = const Value.absent(),
                Value<double?> targetCalories = const Value.absent(),
                Value<double?> targetProteinG = const Value.absent(),
                Value<double?> targetFatG = const Value.absent(),
                Value<double?> targetCarbG = const Value.absent(),
              }) => MealPlanTemplatesCompanion(
                id: id,
                code: code,
                title: title,
                sourceBook: sourceBook,
                chapterRef: chapterRef,
                exampleNumber: exampleNumber,
                dayNumber: dayNumber,
                targetCalories: targetCalories,
                targetProteinG: targetProteinG,
                targetFatG: targetFatG,
                targetCarbG: targetCarbG,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String code,
                required String title,
                Value<String?> sourceBook = const Value.absent(),
                Value<String?> chapterRef = const Value.absent(),
                Value<int?> exampleNumber = const Value.absent(),
                Value<int?> dayNumber = const Value.absent(),
                Value<double?> targetCalories = const Value.absent(),
                Value<double?> targetProteinG = const Value.absent(),
                Value<double?> targetFatG = const Value.absent(),
                Value<double?> targetCarbG = const Value.absent(),
              }) => MealPlanTemplatesCompanion.insert(
                id: id,
                code: code,
                title: title,
                sourceBook: sourceBook,
                chapterRef: chapterRef,
                exampleNumber: exampleNumber,
                dayNumber: dayNumber,
                targetCalories: targetCalories,
                targetProteinG: targetProteinG,
                targetFatG: targetFatG,
                targetCarbG: targetCarbG,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MealPlanTemplatesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({mealPlanMealsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (mealPlanMealsRefs) db.mealPlanMeals,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (mealPlanMealsRefs)
                    await $_getPrefetchedData<
                      MealPlanTemplate,
                      $MealPlanTemplatesTable,
                      MealPlanMeal
                    >(
                      currentTable: table,
                      referencedTable: $$MealPlanTemplatesTableReferences
                          ._mealPlanMealsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$MealPlanTemplatesTableReferences(
                            db,
                            table,
                            p0,
                          ).mealPlanMealsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.templateId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$MealPlanTemplatesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MealPlanTemplatesTable,
      MealPlanTemplate,
      $$MealPlanTemplatesTableFilterComposer,
      $$MealPlanTemplatesTableOrderingComposer,
      $$MealPlanTemplatesTableAnnotationComposer,
      $$MealPlanTemplatesTableCreateCompanionBuilder,
      $$MealPlanTemplatesTableUpdateCompanionBuilder,
      (MealPlanTemplate, $$MealPlanTemplatesTableReferences),
      MealPlanTemplate,
      PrefetchHooks Function({bool mealPlanMealsRefs})
    >;
typedef $$MealPlanMealsTableCreateCompanionBuilder =
    MealPlanMealsCompanion Function({
      Value<int> id,
      required int templateId,
      required int sortOrder,
      required String mealLabel,
      Value<double?> calories,
      Value<double?> proteinG,
      Value<double?> fatG,
      Value<double?> carbG,
    });
typedef $$MealPlanMealsTableUpdateCompanionBuilder =
    MealPlanMealsCompanion Function({
      Value<int> id,
      Value<int> templateId,
      Value<int> sortOrder,
      Value<String> mealLabel,
      Value<double?> calories,
      Value<double?> proteinG,
      Value<double?> fatG,
      Value<double?> carbG,
    });

final class $$MealPlanMealsTableReferences
    extends BaseReferences<_$AppDatabase, $MealPlanMealsTable, MealPlanMeal> {
  $$MealPlanMealsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $MealPlanTemplatesTable _templateIdTable(_$AppDatabase db) =>
      db.mealPlanTemplates.createAlias(
        $_aliasNameGenerator(
          db.mealPlanMeals.templateId,
          db.mealPlanTemplates.id,
        ),
      );

  $$MealPlanTemplatesTableProcessedTableManager get templateId {
    final $_column = $_itemColumn<int>('template_id')!;

    final manager = $$MealPlanTemplatesTableTableManager(
      $_db,
      $_db.mealPlanTemplates,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_templateIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$MealPlanLinesTable, List<MealPlanLine>>
  _mealPlanLinesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.mealPlanLines,
    aliasName: $_aliasNameGenerator(
      db.mealPlanMeals.id,
      db.mealPlanLines.mealId,
    ),
  );

  $$MealPlanLinesTableProcessedTableManager get mealPlanLinesRefs {
    final manager = $$MealPlanLinesTableTableManager(
      $_db,
      $_db.mealPlanLines,
    ).filter((f) => f.mealId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_mealPlanLinesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MealPlanMealsTableFilterComposer
    extends Composer<_$AppDatabase, $MealPlanMealsTable> {
  $$MealPlanMealsTableFilterComposer({
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

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mealLabel => $composableBuilder(
    column: $table.mealLabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get calories => $composableBuilder(
    column: $table.calories,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get proteinG => $composableBuilder(
    column: $table.proteinG,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fatG => $composableBuilder(
    column: $table.fatG,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get carbG => $composableBuilder(
    column: $table.carbG,
    builder: (column) => ColumnFilters(column),
  );

  $$MealPlanTemplatesTableFilterComposer get templateId {
    final $$MealPlanTemplatesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.templateId,
      referencedTable: $db.mealPlanTemplates,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MealPlanTemplatesTableFilterComposer(
            $db: $db,
            $table: $db.mealPlanTemplates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> mealPlanLinesRefs(
    Expression<bool> Function($$MealPlanLinesTableFilterComposer f) f,
  ) {
    final $$MealPlanLinesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mealPlanLines,
      getReferencedColumn: (t) => t.mealId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MealPlanLinesTableFilterComposer(
            $db: $db,
            $table: $db.mealPlanLines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MealPlanMealsTableOrderingComposer
    extends Composer<_$AppDatabase, $MealPlanMealsTable> {
  $$MealPlanMealsTableOrderingComposer({
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

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mealLabel => $composableBuilder(
    column: $table.mealLabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get calories => $composableBuilder(
    column: $table.calories,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get proteinG => $composableBuilder(
    column: $table.proteinG,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fatG => $composableBuilder(
    column: $table.fatG,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get carbG => $composableBuilder(
    column: $table.carbG,
    builder: (column) => ColumnOrderings(column),
  );

  $$MealPlanTemplatesTableOrderingComposer get templateId {
    final $$MealPlanTemplatesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.templateId,
      referencedTable: $db.mealPlanTemplates,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MealPlanTemplatesTableOrderingComposer(
            $db: $db,
            $table: $db.mealPlanTemplates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MealPlanMealsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MealPlanMealsTable> {
  $$MealPlanMealsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<String> get mealLabel =>
      $composableBuilder(column: $table.mealLabel, builder: (column) => column);

  GeneratedColumn<double> get calories =>
      $composableBuilder(column: $table.calories, builder: (column) => column);

  GeneratedColumn<double> get proteinG =>
      $composableBuilder(column: $table.proteinG, builder: (column) => column);

  GeneratedColumn<double> get fatG =>
      $composableBuilder(column: $table.fatG, builder: (column) => column);

  GeneratedColumn<double> get carbG =>
      $composableBuilder(column: $table.carbG, builder: (column) => column);

  $$MealPlanTemplatesTableAnnotationComposer get templateId {
    final $$MealPlanTemplatesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.templateId,
          referencedTable: $db.mealPlanTemplates,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$MealPlanTemplatesTableAnnotationComposer(
                $db: $db,
                $table: $db.mealPlanTemplates,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  Expression<T> mealPlanLinesRefs<T extends Object>(
    Expression<T> Function($$MealPlanLinesTableAnnotationComposer a) f,
  ) {
    final $$MealPlanLinesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mealPlanLines,
      getReferencedColumn: (t) => t.mealId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MealPlanLinesTableAnnotationComposer(
            $db: $db,
            $table: $db.mealPlanLines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MealPlanMealsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MealPlanMealsTable,
          MealPlanMeal,
          $$MealPlanMealsTableFilterComposer,
          $$MealPlanMealsTableOrderingComposer,
          $$MealPlanMealsTableAnnotationComposer,
          $$MealPlanMealsTableCreateCompanionBuilder,
          $$MealPlanMealsTableUpdateCompanionBuilder,
          (MealPlanMeal, $$MealPlanMealsTableReferences),
          MealPlanMeal,
          PrefetchHooks Function({bool templateId, bool mealPlanLinesRefs})
        > {
  $$MealPlanMealsTableTableManager(_$AppDatabase db, $MealPlanMealsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MealPlanMealsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MealPlanMealsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MealPlanMealsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> templateId = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<String> mealLabel = const Value.absent(),
                Value<double?> calories = const Value.absent(),
                Value<double?> proteinG = const Value.absent(),
                Value<double?> fatG = const Value.absent(),
                Value<double?> carbG = const Value.absent(),
              }) => MealPlanMealsCompanion(
                id: id,
                templateId: templateId,
                sortOrder: sortOrder,
                mealLabel: mealLabel,
                calories: calories,
                proteinG: proteinG,
                fatG: fatG,
                carbG: carbG,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int templateId,
                required int sortOrder,
                required String mealLabel,
                Value<double?> calories = const Value.absent(),
                Value<double?> proteinG = const Value.absent(),
                Value<double?> fatG = const Value.absent(),
                Value<double?> carbG = const Value.absent(),
              }) => MealPlanMealsCompanion.insert(
                id: id,
                templateId: templateId,
                sortOrder: sortOrder,
                mealLabel: mealLabel,
                calories: calories,
                proteinG: proteinG,
                fatG: fatG,
                carbG: carbG,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MealPlanMealsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({templateId = false, mealPlanLinesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (mealPlanLinesRefs) db.mealPlanLines,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (templateId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.templateId,
                                    referencedTable:
                                        $$MealPlanMealsTableReferences
                                            ._templateIdTable(db),
                                    referencedColumn:
                                        $$MealPlanMealsTableReferences
                                            ._templateIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (mealPlanLinesRefs)
                        await $_getPrefetchedData<
                          MealPlanMeal,
                          $MealPlanMealsTable,
                          MealPlanLine
                        >(
                          currentTable: table,
                          referencedTable: $$MealPlanMealsTableReferences
                              ._mealPlanLinesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MealPlanMealsTableReferences(
                                db,
                                table,
                                p0,
                              ).mealPlanLinesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.mealId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$MealPlanMealsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MealPlanMealsTable,
      MealPlanMeal,
      $$MealPlanMealsTableFilterComposer,
      $$MealPlanMealsTableOrderingComposer,
      $$MealPlanMealsTableAnnotationComposer,
      $$MealPlanMealsTableCreateCompanionBuilder,
      $$MealPlanMealsTableUpdateCompanionBuilder,
      (MealPlanMeal, $$MealPlanMealsTableReferences),
      MealPlanMeal,
      PrefetchHooks Function({bool templateId, bool mealPlanLinesRefs})
    >;
typedef $$MealPlanLinesTableCreateCompanionBuilder =
    MealPlanLinesCompanion Function({
      Value<int> id,
      required int mealId,
      required int sortOrder,
      required String lineType,
      required String content,
      Value<double?> amountGrams,
      Value<String?> amountText,
    });
typedef $$MealPlanLinesTableUpdateCompanionBuilder =
    MealPlanLinesCompanion Function({
      Value<int> id,
      Value<int> mealId,
      Value<int> sortOrder,
      Value<String> lineType,
      Value<String> content,
      Value<double?> amountGrams,
      Value<String?> amountText,
    });

final class $$MealPlanLinesTableReferences
    extends BaseReferences<_$AppDatabase, $MealPlanLinesTable, MealPlanLine> {
  $$MealPlanLinesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $MealPlanMealsTable _mealIdTable(_$AppDatabase db) =>
      db.mealPlanMeals.createAlias(
        $_aliasNameGenerator(db.mealPlanLines.mealId, db.mealPlanMeals.id),
      );

  $$MealPlanMealsTableProcessedTableManager get mealId {
    final $_column = $_itemColumn<int>('meal_id')!;

    final manager = $$MealPlanMealsTableTableManager(
      $_db,
      $_db.mealPlanMeals,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_mealIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$MealPlanLinesTableFilterComposer
    extends Composer<_$AppDatabase, $MealPlanLinesTable> {
  $$MealPlanLinesTableFilterComposer({
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

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lineType => $composableBuilder(
    column: $table.lineType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amountGrams => $composableBuilder(
    column: $table.amountGrams,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get amountText => $composableBuilder(
    column: $table.amountText,
    builder: (column) => ColumnFilters(column),
  );

  $$MealPlanMealsTableFilterComposer get mealId {
    final $$MealPlanMealsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mealId,
      referencedTable: $db.mealPlanMeals,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MealPlanMealsTableFilterComposer(
            $db: $db,
            $table: $db.mealPlanMeals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MealPlanLinesTableOrderingComposer
    extends Composer<_$AppDatabase, $MealPlanLinesTable> {
  $$MealPlanLinesTableOrderingComposer({
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

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lineType => $composableBuilder(
    column: $table.lineType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amountGrams => $composableBuilder(
    column: $table.amountGrams,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get amountText => $composableBuilder(
    column: $table.amountText,
    builder: (column) => ColumnOrderings(column),
  );

  $$MealPlanMealsTableOrderingComposer get mealId {
    final $$MealPlanMealsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mealId,
      referencedTable: $db.mealPlanMeals,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MealPlanMealsTableOrderingComposer(
            $db: $db,
            $table: $db.mealPlanMeals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MealPlanLinesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MealPlanLinesTable> {
  $$MealPlanLinesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<String> get lineType =>
      $composableBuilder(column: $table.lineType, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<double> get amountGrams => $composableBuilder(
    column: $table.amountGrams,
    builder: (column) => column,
  );

  GeneratedColumn<String> get amountText => $composableBuilder(
    column: $table.amountText,
    builder: (column) => column,
  );

  $$MealPlanMealsTableAnnotationComposer get mealId {
    final $$MealPlanMealsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mealId,
      referencedTable: $db.mealPlanMeals,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MealPlanMealsTableAnnotationComposer(
            $db: $db,
            $table: $db.mealPlanMeals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MealPlanLinesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MealPlanLinesTable,
          MealPlanLine,
          $$MealPlanLinesTableFilterComposer,
          $$MealPlanLinesTableOrderingComposer,
          $$MealPlanLinesTableAnnotationComposer,
          $$MealPlanLinesTableCreateCompanionBuilder,
          $$MealPlanLinesTableUpdateCompanionBuilder,
          (MealPlanLine, $$MealPlanLinesTableReferences),
          MealPlanLine,
          PrefetchHooks Function({bool mealId})
        > {
  $$MealPlanLinesTableTableManager(_$AppDatabase db, $MealPlanLinesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MealPlanLinesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MealPlanLinesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MealPlanLinesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> mealId = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<String> lineType = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<double?> amountGrams = const Value.absent(),
                Value<String?> amountText = const Value.absent(),
              }) => MealPlanLinesCompanion(
                id: id,
                mealId: mealId,
                sortOrder: sortOrder,
                lineType: lineType,
                content: content,
                amountGrams: amountGrams,
                amountText: amountText,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int mealId,
                required int sortOrder,
                required String lineType,
                required String content,
                Value<double?> amountGrams = const Value.absent(),
                Value<String?> amountText = const Value.absent(),
              }) => MealPlanLinesCompanion.insert(
                id: id,
                mealId: mealId,
                sortOrder: sortOrder,
                lineType: lineType,
                content: content,
                amountGrams: amountGrams,
                amountText: amountText,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MealPlanLinesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({mealId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (mealId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.mealId,
                                referencedTable: $$MealPlanLinesTableReferences
                                    ._mealIdTable(db),
                                referencedColumn: $$MealPlanLinesTableReferences
                                    ._mealIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$MealPlanLinesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MealPlanLinesTable,
      MealPlanLine,
      $$MealPlanLinesTableFilterComposer,
      $$MealPlanLinesTableOrderingComposer,
      $$MealPlanLinesTableAnnotationComposer,
      $$MealPlanLinesTableCreateCompanionBuilder,
      $$MealPlanLinesTableUpdateCompanionBuilder,
      (MealPlanLine, $$MealPlanLinesTableReferences),
      MealPlanLine,
      PrefetchHooks Function({bool mealId})
    >;
typedef $$PdfMealPlansTableCreateCompanionBuilder =
    PdfMealPlansCompanion Function({
      Value<int> id,
      required String title,
      Value<String?> sourceFileName,
      Value<String> sourceType,
      Value<String?> author,
      Value<String?> description,
      Value<int?> daysCount,
      Value<String?> notes,
      Value<String?> rawSourceReference,
    });
typedef $$PdfMealPlansTableUpdateCompanionBuilder =
    PdfMealPlansCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<String?> sourceFileName,
      Value<String> sourceType,
      Value<String?> author,
      Value<String?> description,
      Value<int?> daysCount,
      Value<String?> notes,
      Value<String?> rawSourceReference,
    });

final class $$PdfMealPlansTableReferences
    extends BaseReferences<_$AppDatabase, $PdfMealPlansTable, PdfMealPlan> {
  $$PdfMealPlansTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PdfMealPlanDaysTable, List<PdfMealPlanDay>>
  _pdfMealPlanDaysRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.pdfMealPlanDays,
    aliasName: $_aliasNameGenerator(
      db.pdfMealPlans.id,
      db.pdfMealPlanDays.mealPlanId,
    ),
  );

  $$PdfMealPlanDaysTableProcessedTableManager get pdfMealPlanDaysRefs {
    final manager = $$PdfMealPlanDaysTableTableManager(
      $_db,
      $_db.pdfMealPlanDays,
    ).filter((f) => f.mealPlanId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _pdfMealPlanDaysRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PdfMealPlansTableFilterComposer
    extends Composer<_$AppDatabase, $PdfMealPlansTable> {
  $$PdfMealPlansTableFilterComposer({
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

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceFileName => $composableBuilder(
    column: $table.sourceFileName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceType => $composableBuilder(
    column: $table.sourceType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get author => $composableBuilder(
    column: $table.author,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get daysCount => $composableBuilder(
    column: $table.daysCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rawSourceReference => $composableBuilder(
    column: $table.rawSourceReference,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> pdfMealPlanDaysRefs(
    Expression<bool> Function($$PdfMealPlanDaysTableFilterComposer f) f,
  ) {
    final $$PdfMealPlanDaysTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pdfMealPlanDays,
      getReferencedColumn: (t) => t.mealPlanId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PdfMealPlanDaysTableFilterComposer(
            $db: $db,
            $table: $db.pdfMealPlanDays,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PdfMealPlansTableOrderingComposer
    extends Composer<_$AppDatabase, $PdfMealPlansTable> {
  $$PdfMealPlansTableOrderingComposer({
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

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceFileName => $composableBuilder(
    column: $table.sourceFileName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceType => $composableBuilder(
    column: $table.sourceType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get author => $composableBuilder(
    column: $table.author,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get daysCount => $composableBuilder(
    column: $table.daysCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rawSourceReference => $composableBuilder(
    column: $table.rawSourceReference,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PdfMealPlansTableAnnotationComposer
    extends Composer<_$AppDatabase, $PdfMealPlansTable> {
  $$PdfMealPlansTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get sourceFileName => $composableBuilder(
    column: $table.sourceFileName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sourceType => $composableBuilder(
    column: $table.sourceType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get author =>
      $composableBuilder(column: $table.author, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<int> get daysCount =>
      $composableBuilder(column: $table.daysCount, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get rawSourceReference => $composableBuilder(
    column: $table.rawSourceReference,
    builder: (column) => column,
  );

  Expression<T> pdfMealPlanDaysRefs<T extends Object>(
    Expression<T> Function($$PdfMealPlanDaysTableAnnotationComposer a) f,
  ) {
    final $$PdfMealPlanDaysTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pdfMealPlanDays,
      getReferencedColumn: (t) => t.mealPlanId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PdfMealPlanDaysTableAnnotationComposer(
            $db: $db,
            $table: $db.pdfMealPlanDays,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PdfMealPlansTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PdfMealPlansTable,
          PdfMealPlan,
          $$PdfMealPlansTableFilterComposer,
          $$PdfMealPlansTableOrderingComposer,
          $$PdfMealPlansTableAnnotationComposer,
          $$PdfMealPlansTableCreateCompanionBuilder,
          $$PdfMealPlansTableUpdateCompanionBuilder,
          (PdfMealPlan, $$PdfMealPlansTableReferences),
          PdfMealPlan,
          PrefetchHooks Function({bool pdfMealPlanDaysRefs})
        > {
  $$PdfMealPlansTableTableManager(_$AppDatabase db, $PdfMealPlansTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PdfMealPlansTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PdfMealPlansTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PdfMealPlansTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> sourceFileName = const Value.absent(),
                Value<String> sourceType = const Value.absent(),
                Value<String?> author = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<int?> daysCount = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> rawSourceReference = const Value.absent(),
              }) => PdfMealPlansCompanion(
                id: id,
                title: title,
                sourceFileName: sourceFileName,
                sourceType: sourceType,
                author: author,
                description: description,
                daysCount: daysCount,
                notes: notes,
                rawSourceReference: rawSourceReference,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                Value<String?> sourceFileName = const Value.absent(),
                Value<String> sourceType = const Value.absent(),
                Value<String?> author = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<int?> daysCount = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> rawSourceReference = const Value.absent(),
              }) => PdfMealPlansCompanion.insert(
                id: id,
                title: title,
                sourceFileName: sourceFileName,
                sourceType: sourceType,
                author: author,
                description: description,
                daysCount: daysCount,
                notes: notes,
                rawSourceReference: rawSourceReference,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PdfMealPlansTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({pdfMealPlanDaysRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (pdfMealPlanDaysRefs) db.pdfMealPlanDays,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (pdfMealPlanDaysRefs)
                    await $_getPrefetchedData<
                      PdfMealPlan,
                      $PdfMealPlansTable,
                      PdfMealPlanDay
                    >(
                      currentTable: table,
                      referencedTable: $$PdfMealPlansTableReferences
                          ._pdfMealPlanDaysRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$PdfMealPlansTableReferences(
                            db,
                            table,
                            p0,
                          ).pdfMealPlanDaysRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.mealPlanId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$PdfMealPlansTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PdfMealPlansTable,
      PdfMealPlan,
      $$PdfMealPlansTableFilterComposer,
      $$PdfMealPlansTableOrderingComposer,
      $$PdfMealPlansTableAnnotationComposer,
      $$PdfMealPlansTableCreateCompanionBuilder,
      $$PdfMealPlansTableUpdateCompanionBuilder,
      (PdfMealPlan, $$PdfMealPlansTableReferences),
      PdfMealPlan,
      PrefetchHooks Function({bool pdfMealPlanDaysRefs})
    >;
typedef $$PdfMealPlanDaysTableCreateCompanionBuilder =
    PdfMealPlanDaysCompanion Function({
      Value<int> id,
      required int mealPlanId,
      required int dayNumber,
      Value<String?> title,
      Value<double?> dailyKcal,
      Value<double?> dailyProtein,
      Value<double?> dailyFat,
      Value<double?> dailyCarbs,
      Value<String?> notes,
    });
typedef $$PdfMealPlanDaysTableUpdateCompanionBuilder =
    PdfMealPlanDaysCompanion Function({
      Value<int> id,
      Value<int> mealPlanId,
      Value<int> dayNumber,
      Value<String?> title,
      Value<double?> dailyKcal,
      Value<double?> dailyProtein,
      Value<double?> dailyFat,
      Value<double?> dailyCarbs,
      Value<String?> notes,
    });

final class $$PdfMealPlanDaysTableReferences
    extends
        BaseReferences<_$AppDatabase, $PdfMealPlanDaysTable, PdfMealPlanDay> {
  $$PdfMealPlanDaysTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PdfMealPlansTable _mealPlanIdTable(_$AppDatabase db) =>
      db.pdfMealPlans.createAlias(
        $_aliasNameGenerator(db.pdfMealPlanDays.mealPlanId, db.pdfMealPlans.id),
      );

  $$PdfMealPlansTableProcessedTableManager get mealPlanId {
    final $_column = $_itemColumn<int>('meal_plan_id')!;

    final manager = $$PdfMealPlansTableTableManager(
      $_db,
      $_db.pdfMealPlans,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_mealPlanIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$PdfMealSlotsTable, List<PdfMealSlot>>
  _pdfMealSlotsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.pdfMealSlots,
    aliasName: $_aliasNameGenerator(
      db.pdfMealPlanDays.id,
      db.pdfMealSlots.mealPlanDayId,
    ),
  );

  $$PdfMealSlotsTableProcessedTableManager get pdfMealSlotsRefs {
    final manager = $$PdfMealSlotsTableTableManager(
      $_db,
      $_db.pdfMealSlots,
    ).filter((f) => f.mealPlanDayId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_pdfMealSlotsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PdfMealPlanDaysTableFilterComposer
    extends Composer<_$AppDatabase, $PdfMealPlanDaysTable> {
  $$PdfMealPlanDaysTableFilterComposer({
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

  ColumnFilters<int> get dayNumber => $composableBuilder(
    column: $table.dayNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get dailyKcal => $composableBuilder(
    column: $table.dailyKcal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get dailyProtein => $composableBuilder(
    column: $table.dailyProtein,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get dailyFat => $composableBuilder(
    column: $table.dailyFat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get dailyCarbs => $composableBuilder(
    column: $table.dailyCarbs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  $$PdfMealPlansTableFilterComposer get mealPlanId {
    final $$PdfMealPlansTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mealPlanId,
      referencedTable: $db.pdfMealPlans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PdfMealPlansTableFilterComposer(
            $db: $db,
            $table: $db.pdfMealPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> pdfMealSlotsRefs(
    Expression<bool> Function($$PdfMealSlotsTableFilterComposer f) f,
  ) {
    final $$PdfMealSlotsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pdfMealSlots,
      getReferencedColumn: (t) => t.mealPlanDayId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PdfMealSlotsTableFilterComposer(
            $db: $db,
            $table: $db.pdfMealSlots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PdfMealPlanDaysTableOrderingComposer
    extends Composer<_$AppDatabase, $PdfMealPlanDaysTable> {
  $$PdfMealPlanDaysTableOrderingComposer({
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

  ColumnOrderings<int> get dayNumber => $composableBuilder(
    column: $table.dayNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get dailyKcal => $composableBuilder(
    column: $table.dailyKcal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get dailyProtein => $composableBuilder(
    column: $table.dailyProtein,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get dailyFat => $composableBuilder(
    column: $table.dailyFat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get dailyCarbs => $composableBuilder(
    column: $table.dailyCarbs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  $$PdfMealPlansTableOrderingComposer get mealPlanId {
    final $$PdfMealPlansTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mealPlanId,
      referencedTable: $db.pdfMealPlans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PdfMealPlansTableOrderingComposer(
            $db: $db,
            $table: $db.pdfMealPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PdfMealPlanDaysTableAnnotationComposer
    extends Composer<_$AppDatabase, $PdfMealPlanDaysTable> {
  $$PdfMealPlanDaysTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get dayNumber =>
      $composableBuilder(column: $table.dayNumber, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<double> get dailyKcal =>
      $composableBuilder(column: $table.dailyKcal, builder: (column) => column);

  GeneratedColumn<double> get dailyProtein => $composableBuilder(
    column: $table.dailyProtein,
    builder: (column) => column,
  );

  GeneratedColumn<double> get dailyFat =>
      $composableBuilder(column: $table.dailyFat, builder: (column) => column);

  GeneratedColumn<double> get dailyCarbs => $composableBuilder(
    column: $table.dailyCarbs,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  $$PdfMealPlansTableAnnotationComposer get mealPlanId {
    final $$PdfMealPlansTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mealPlanId,
      referencedTable: $db.pdfMealPlans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PdfMealPlansTableAnnotationComposer(
            $db: $db,
            $table: $db.pdfMealPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> pdfMealSlotsRefs<T extends Object>(
    Expression<T> Function($$PdfMealSlotsTableAnnotationComposer a) f,
  ) {
    final $$PdfMealSlotsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pdfMealSlots,
      getReferencedColumn: (t) => t.mealPlanDayId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PdfMealSlotsTableAnnotationComposer(
            $db: $db,
            $table: $db.pdfMealSlots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PdfMealPlanDaysTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PdfMealPlanDaysTable,
          PdfMealPlanDay,
          $$PdfMealPlanDaysTableFilterComposer,
          $$PdfMealPlanDaysTableOrderingComposer,
          $$PdfMealPlanDaysTableAnnotationComposer,
          $$PdfMealPlanDaysTableCreateCompanionBuilder,
          $$PdfMealPlanDaysTableUpdateCompanionBuilder,
          (PdfMealPlanDay, $$PdfMealPlanDaysTableReferences),
          PdfMealPlanDay,
          PrefetchHooks Function({bool mealPlanId, bool pdfMealSlotsRefs})
        > {
  $$PdfMealPlanDaysTableTableManager(
    _$AppDatabase db,
    $PdfMealPlanDaysTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PdfMealPlanDaysTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PdfMealPlanDaysTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PdfMealPlanDaysTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> mealPlanId = const Value.absent(),
                Value<int> dayNumber = const Value.absent(),
                Value<String?> title = const Value.absent(),
                Value<double?> dailyKcal = const Value.absent(),
                Value<double?> dailyProtein = const Value.absent(),
                Value<double?> dailyFat = const Value.absent(),
                Value<double?> dailyCarbs = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => PdfMealPlanDaysCompanion(
                id: id,
                mealPlanId: mealPlanId,
                dayNumber: dayNumber,
                title: title,
                dailyKcal: dailyKcal,
                dailyProtein: dailyProtein,
                dailyFat: dailyFat,
                dailyCarbs: dailyCarbs,
                notes: notes,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int mealPlanId,
                required int dayNumber,
                Value<String?> title = const Value.absent(),
                Value<double?> dailyKcal = const Value.absent(),
                Value<double?> dailyProtein = const Value.absent(),
                Value<double?> dailyFat = const Value.absent(),
                Value<double?> dailyCarbs = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => PdfMealPlanDaysCompanion.insert(
                id: id,
                mealPlanId: mealPlanId,
                dayNumber: dayNumber,
                title: title,
                dailyKcal: dailyKcal,
                dailyProtein: dailyProtein,
                dailyFat: dailyFat,
                dailyCarbs: dailyCarbs,
                notes: notes,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PdfMealPlanDaysTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({mealPlanId = false, pdfMealSlotsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (pdfMealSlotsRefs) db.pdfMealSlots,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (mealPlanId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.mealPlanId,
                                    referencedTable:
                                        $$PdfMealPlanDaysTableReferences
                                            ._mealPlanIdTable(db),
                                    referencedColumn:
                                        $$PdfMealPlanDaysTableReferences
                                            ._mealPlanIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (pdfMealSlotsRefs)
                        await $_getPrefetchedData<
                          PdfMealPlanDay,
                          $PdfMealPlanDaysTable,
                          PdfMealSlot
                        >(
                          currentTable: table,
                          referencedTable: $$PdfMealPlanDaysTableReferences
                              ._pdfMealSlotsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PdfMealPlanDaysTableReferences(
                                db,
                                table,
                                p0,
                              ).pdfMealSlotsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.mealPlanDayId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$PdfMealPlanDaysTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PdfMealPlanDaysTable,
      PdfMealPlanDay,
      $$PdfMealPlanDaysTableFilterComposer,
      $$PdfMealPlanDaysTableOrderingComposer,
      $$PdfMealPlanDaysTableAnnotationComposer,
      $$PdfMealPlanDaysTableCreateCompanionBuilder,
      $$PdfMealPlanDaysTableUpdateCompanionBuilder,
      (PdfMealPlanDay, $$PdfMealPlanDaysTableReferences),
      PdfMealPlanDay,
      PrefetchHooks Function({bool mealPlanId, bool pdfMealSlotsRefs})
    >;
typedef $$PdfRecipesTableCreateCompanionBuilder =
    PdfRecipesCompanion Function({
      Value<int> id,
      required String canonicalName,
      required String normalizedName,
      Value<String?> recipeType,
      Value<String?> description,
      Value<double?> defaultServings,
      Value<double?> yieldServings,
      Value<String?> yieldText,
      Value<int?> cookTimeMinutes,
      Value<int?> prepTimeMinutes,
      Value<int?> totalTimeMinutes,
      Value<String?> difficulty,
      Value<String?> sourceType,
      Value<String?> sourceTitle,
      Value<int?> sourcePageStart,
      Value<int?> sourcePageEnd,
      Value<bool> isReusable,
      Value<String?> deduplicationKey,
      Value<String?> notes,
    });
typedef $$PdfRecipesTableUpdateCompanionBuilder =
    PdfRecipesCompanion Function({
      Value<int> id,
      Value<String> canonicalName,
      Value<String> normalizedName,
      Value<String?> recipeType,
      Value<String?> description,
      Value<double?> defaultServings,
      Value<double?> yieldServings,
      Value<String?> yieldText,
      Value<int?> cookTimeMinutes,
      Value<int?> prepTimeMinutes,
      Value<int?> totalTimeMinutes,
      Value<String?> difficulty,
      Value<String?> sourceType,
      Value<String?> sourceTitle,
      Value<int?> sourcePageStart,
      Value<int?> sourcePageEnd,
      Value<bool> isReusable,
      Value<String?> deduplicationKey,
      Value<String?> notes,
    });

final class $$PdfRecipesTableReferences
    extends BaseReferences<_$AppDatabase, $PdfRecipesTable, PdfRecipe> {
  $$PdfRecipesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<
    $PdfRecipeIngredientsTable,
    List<PdfRecipeIngredient>
  >
  _pdfRecipeIngredientsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.pdfRecipeIngredients,
        aliasName: $_aliasNameGenerator(
          db.pdfRecipes.id,
          db.pdfRecipeIngredients.recipeId,
        ),
      );

  $$PdfRecipeIngredientsTableProcessedTableManager
  get pdfRecipeIngredientsRefs {
    final manager = $$PdfRecipeIngredientsTableTableManager(
      $_db,
      $_db.pdfRecipeIngredients,
    ).filter((f) => f.recipeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _pdfRecipeIngredientsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PdfRecipeStepsTable, List<PdfRecipeStep>>
  _pdfRecipeStepsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.pdfRecipeSteps,
    aliasName: $_aliasNameGenerator(
      db.pdfRecipes.id,
      db.pdfRecipeSteps.recipeId,
    ),
  );

  $$PdfRecipeStepsTableProcessedTableManager get pdfRecipeStepsRefs {
    final manager = $$PdfRecipeStepsTableTableManager(
      $_db,
      $_db.pdfRecipeSteps,
    ).filter((f) => f.recipeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_pdfRecipeStepsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $PdfRecipeNutritionTable,
    List<PdfRecipeNutritionData>
  >
  _pdfRecipeNutritionRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.pdfRecipeNutrition,
        aliasName: $_aliasNameGenerator(
          db.pdfRecipes.id,
          db.pdfRecipeNutrition.recipeId,
        ),
      );

  $$PdfRecipeNutritionTableProcessedTableManager get pdfRecipeNutritionRefs {
    final manager = $$PdfRecipeNutritionTableTableManager(
      $_db,
      $_db.pdfRecipeNutrition,
    ).filter((f) => f.recipeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _pdfRecipeNutritionRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PdfRecipeMediaTable, List<PdfRecipeMediaData>>
  _pdfRecipeMediaRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.pdfRecipeMedia,
    aliasName: $_aliasNameGenerator(
      db.pdfRecipes.id,
      db.pdfRecipeMedia.recipeId,
    ),
  );

  $$PdfRecipeMediaTableProcessedTableManager get pdfRecipeMediaRefs {
    final manager = $$PdfRecipeMediaTableTableManager(
      $_db,
      $_db.pdfRecipeMedia,
    ).filter((f) => f.recipeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_pdfRecipeMediaRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PdfMealSlotItemsTable, List<PdfMealSlotItem>>
  _pdfMealSlotItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.pdfMealSlotItems,
    aliasName: $_aliasNameGenerator(
      db.pdfRecipes.id,
      db.pdfMealSlotItems.recipeId,
    ),
  );

  $$PdfMealSlotItemsTableProcessedTableManager get pdfMealSlotItemsRefs {
    final manager = $$PdfMealSlotItemsTableTableManager(
      $_db,
      $_db.pdfMealSlotItems,
    ).filter((f) => f.recipeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _pdfMealSlotItemsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PdfRecipesTableFilterComposer
    extends Composer<_$AppDatabase, $PdfRecipesTable> {
  $$PdfRecipesTableFilterComposer({
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

  ColumnFilters<String> get canonicalName => $composableBuilder(
    column: $table.canonicalName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get normalizedName => $composableBuilder(
    column: $table.normalizedName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get recipeType => $composableBuilder(
    column: $table.recipeType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get defaultServings => $composableBuilder(
    column: $table.defaultServings,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get yieldServings => $composableBuilder(
    column: $table.yieldServings,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get yieldText => $composableBuilder(
    column: $table.yieldText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get cookTimeMinutes => $composableBuilder(
    column: $table.cookTimeMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get prepTimeMinutes => $composableBuilder(
    column: $table.prepTimeMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalTimeMinutes => $composableBuilder(
    column: $table.totalTimeMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceType => $composableBuilder(
    column: $table.sourceType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceTitle => $composableBuilder(
    column: $table.sourceTitle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sourcePageStart => $composableBuilder(
    column: $table.sourcePageStart,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sourcePageEnd => $composableBuilder(
    column: $table.sourcePageEnd,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isReusable => $composableBuilder(
    column: $table.isReusable,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deduplicationKey => $composableBuilder(
    column: $table.deduplicationKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> pdfRecipeIngredientsRefs(
    Expression<bool> Function($$PdfRecipeIngredientsTableFilterComposer f) f,
  ) {
    final $$PdfRecipeIngredientsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pdfRecipeIngredients,
      getReferencedColumn: (t) => t.recipeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PdfRecipeIngredientsTableFilterComposer(
            $db: $db,
            $table: $db.pdfRecipeIngredients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> pdfRecipeStepsRefs(
    Expression<bool> Function($$PdfRecipeStepsTableFilterComposer f) f,
  ) {
    final $$PdfRecipeStepsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pdfRecipeSteps,
      getReferencedColumn: (t) => t.recipeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PdfRecipeStepsTableFilterComposer(
            $db: $db,
            $table: $db.pdfRecipeSteps,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> pdfRecipeNutritionRefs(
    Expression<bool> Function($$PdfRecipeNutritionTableFilterComposer f) f,
  ) {
    final $$PdfRecipeNutritionTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pdfRecipeNutrition,
      getReferencedColumn: (t) => t.recipeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PdfRecipeNutritionTableFilterComposer(
            $db: $db,
            $table: $db.pdfRecipeNutrition,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> pdfRecipeMediaRefs(
    Expression<bool> Function($$PdfRecipeMediaTableFilterComposer f) f,
  ) {
    final $$PdfRecipeMediaTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pdfRecipeMedia,
      getReferencedColumn: (t) => t.recipeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PdfRecipeMediaTableFilterComposer(
            $db: $db,
            $table: $db.pdfRecipeMedia,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> pdfMealSlotItemsRefs(
    Expression<bool> Function($$PdfMealSlotItemsTableFilterComposer f) f,
  ) {
    final $$PdfMealSlotItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pdfMealSlotItems,
      getReferencedColumn: (t) => t.recipeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PdfMealSlotItemsTableFilterComposer(
            $db: $db,
            $table: $db.pdfMealSlotItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PdfRecipesTableOrderingComposer
    extends Composer<_$AppDatabase, $PdfRecipesTable> {
  $$PdfRecipesTableOrderingComposer({
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

  ColumnOrderings<String> get canonicalName => $composableBuilder(
    column: $table.canonicalName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get normalizedName => $composableBuilder(
    column: $table.normalizedName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recipeType => $composableBuilder(
    column: $table.recipeType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get defaultServings => $composableBuilder(
    column: $table.defaultServings,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get yieldServings => $composableBuilder(
    column: $table.yieldServings,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get yieldText => $composableBuilder(
    column: $table.yieldText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get cookTimeMinutes => $composableBuilder(
    column: $table.cookTimeMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get prepTimeMinutes => $composableBuilder(
    column: $table.prepTimeMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalTimeMinutes => $composableBuilder(
    column: $table.totalTimeMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceType => $composableBuilder(
    column: $table.sourceType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceTitle => $composableBuilder(
    column: $table.sourceTitle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sourcePageStart => $composableBuilder(
    column: $table.sourcePageStart,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sourcePageEnd => $composableBuilder(
    column: $table.sourcePageEnd,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isReusable => $composableBuilder(
    column: $table.isReusable,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deduplicationKey => $composableBuilder(
    column: $table.deduplicationKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PdfRecipesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PdfRecipesTable> {
  $$PdfRecipesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get canonicalName => $composableBuilder(
    column: $table.canonicalName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get normalizedName => $composableBuilder(
    column: $table.normalizedName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get recipeType => $composableBuilder(
    column: $table.recipeType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<double> get defaultServings => $composableBuilder(
    column: $table.defaultServings,
    builder: (column) => column,
  );

  GeneratedColumn<double> get yieldServings => $composableBuilder(
    column: $table.yieldServings,
    builder: (column) => column,
  );

  GeneratedColumn<String> get yieldText =>
      $composableBuilder(column: $table.yieldText, builder: (column) => column);

  GeneratedColumn<int> get cookTimeMinutes => $composableBuilder(
    column: $table.cookTimeMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get prepTimeMinutes => $composableBuilder(
    column: $table.prepTimeMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalTimeMinutes => $composableBuilder(
    column: $table.totalTimeMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sourceType => $composableBuilder(
    column: $table.sourceType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sourceTitle => $composableBuilder(
    column: $table.sourceTitle,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sourcePageStart => $composableBuilder(
    column: $table.sourcePageStart,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sourcePageEnd => $composableBuilder(
    column: $table.sourcePageEnd,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isReusable => $composableBuilder(
    column: $table.isReusable,
    builder: (column) => column,
  );

  GeneratedColumn<String> get deduplicationKey => $composableBuilder(
    column: $table.deduplicationKey,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  Expression<T> pdfRecipeIngredientsRefs<T extends Object>(
    Expression<T> Function($$PdfRecipeIngredientsTableAnnotationComposer a) f,
  ) {
    final $$PdfRecipeIngredientsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.pdfRecipeIngredients,
          getReferencedColumn: (t) => t.recipeId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PdfRecipeIngredientsTableAnnotationComposer(
                $db: $db,
                $table: $db.pdfRecipeIngredients,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> pdfRecipeStepsRefs<T extends Object>(
    Expression<T> Function($$PdfRecipeStepsTableAnnotationComposer a) f,
  ) {
    final $$PdfRecipeStepsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pdfRecipeSteps,
      getReferencedColumn: (t) => t.recipeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PdfRecipeStepsTableAnnotationComposer(
            $db: $db,
            $table: $db.pdfRecipeSteps,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> pdfRecipeNutritionRefs<T extends Object>(
    Expression<T> Function($$PdfRecipeNutritionTableAnnotationComposer a) f,
  ) {
    final $$PdfRecipeNutritionTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.pdfRecipeNutrition,
          getReferencedColumn: (t) => t.recipeId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PdfRecipeNutritionTableAnnotationComposer(
                $db: $db,
                $table: $db.pdfRecipeNutrition,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> pdfRecipeMediaRefs<T extends Object>(
    Expression<T> Function($$PdfRecipeMediaTableAnnotationComposer a) f,
  ) {
    final $$PdfRecipeMediaTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pdfRecipeMedia,
      getReferencedColumn: (t) => t.recipeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PdfRecipeMediaTableAnnotationComposer(
            $db: $db,
            $table: $db.pdfRecipeMedia,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> pdfMealSlotItemsRefs<T extends Object>(
    Expression<T> Function($$PdfMealSlotItemsTableAnnotationComposer a) f,
  ) {
    final $$PdfMealSlotItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pdfMealSlotItems,
      getReferencedColumn: (t) => t.recipeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PdfMealSlotItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.pdfMealSlotItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PdfRecipesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PdfRecipesTable,
          PdfRecipe,
          $$PdfRecipesTableFilterComposer,
          $$PdfRecipesTableOrderingComposer,
          $$PdfRecipesTableAnnotationComposer,
          $$PdfRecipesTableCreateCompanionBuilder,
          $$PdfRecipesTableUpdateCompanionBuilder,
          (PdfRecipe, $$PdfRecipesTableReferences),
          PdfRecipe,
          PrefetchHooks Function({
            bool pdfRecipeIngredientsRefs,
            bool pdfRecipeStepsRefs,
            bool pdfRecipeNutritionRefs,
            bool pdfRecipeMediaRefs,
            bool pdfMealSlotItemsRefs,
          })
        > {
  $$PdfRecipesTableTableManager(_$AppDatabase db, $PdfRecipesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PdfRecipesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PdfRecipesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PdfRecipesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> canonicalName = const Value.absent(),
                Value<String> normalizedName = const Value.absent(),
                Value<String?> recipeType = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<double?> defaultServings = const Value.absent(),
                Value<double?> yieldServings = const Value.absent(),
                Value<String?> yieldText = const Value.absent(),
                Value<int?> cookTimeMinutes = const Value.absent(),
                Value<int?> prepTimeMinutes = const Value.absent(),
                Value<int?> totalTimeMinutes = const Value.absent(),
                Value<String?> difficulty = const Value.absent(),
                Value<String?> sourceType = const Value.absent(),
                Value<String?> sourceTitle = const Value.absent(),
                Value<int?> sourcePageStart = const Value.absent(),
                Value<int?> sourcePageEnd = const Value.absent(),
                Value<bool> isReusable = const Value.absent(),
                Value<String?> deduplicationKey = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => PdfRecipesCompanion(
                id: id,
                canonicalName: canonicalName,
                normalizedName: normalizedName,
                recipeType: recipeType,
                description: description,
                defaultServings: defaultServings,
                yieldServings: yieldServings,
                yieldText: yieldText,
                cookTimeMinutes: cookTimeMinutes,
                prepTimeMinutes: prepTimeMinutes,
                totalTimeMinutes: totalTimeMinutes,
                difficulty: difficulty,
                sourceType: sourceType,
                sourceTitle: sourceTitle,
                sourcePageStart: sourcePageStart,
                sourcePageEnd: sourcePageEnd,
                isReusable: isReusable,
                deduplicationKey: deduplicationKey,
                notes: notes,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String canonicalName,
                required String normalizedName,
                Value<String?> recipeType = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<double?> defaultServings = const Value.absent(),
                Value<double?> yieldServings = const Value.absent(),
                Value<String?> yieldText = const Value.absent(),
                Value<int?> cookTimeMinutes = const Value.absent(),
                Value<int?> prepTimeMinutes = const Value.absent(),
                Value<int?> totalTimeMinutes = const Value.absent(),
                Value<String?> difficulty = const Value.absent(),
                Value<String?> sourceType = const Value.absent(),
                Value<String?> sourceTitle = const Value.absent(),
                Value<int?> sourcePageStart = const Value.absent(),
                Value<int?> sourcePageEnd = const Value.absent(),
                Value<bool> isReusable = const Value.absent(),
                Value<String?> deduplicationKey = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => PdfRecipesCompanion.insert(
                id: id,
                canonicalName: canonicalName,
                normalizedName: normalizedName,
                recipeType: recipeType,
                description: description,
                defaultServings: defaultServings,
                yieldServings: yieldServings,
                yieldText: yieldText,
                cookTimeMinutes: cookTimeMinutes,
                prepTimeMinutes: prepTimeMinutes,
                totalTimeMinutes: totalTimeMinutes,
                difficulty: difficulty,
                sourceType: sourceType,
                sourceTitle: sourceTitle,
                sourcePageStart: sourcePageStart,
                sourcePageEnd: sourcePageEnd,
                isReusable: isReusable,
                deduplicationKey: deduplicationKey,
                notes: notes,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PdfRecipesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                pdfRecipeIngredientsRefs = false,
                pdfRecipeStepsRefs = false,
                pdfRecipeNutritionRefs = false,
                pdfRecipeMediaRefs = false,
                pdfMealSlotItemsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (pdfRecipeIngredientsRefs) db.pdfRecipeIngredients,
                    if (pdfRecipeStepsRefs) db.pdfRecipeSteps,
                    if (pdfRecipeNutritionRefs) db.pdfRecipeNutrition,
                    if (pdfRecipeMediaRefs) db.pdfRecipeMedia,
                    if (pdfMealSlotItemsRefs) db.pdfMealSlotItems,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (pdfRecipeIngredientsRefs)
                        await $_getPrefetchedData<
                          PdfRecipe,
                          $PdfRecipesTable,
                          PdfRecipeIngredient
                        >(
                          currentTable: table,
                          referencedTable: $$PdfRecipesTableReferences
                              ._pdfRecipeIngredientsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PdfRecipesTableReferences(
                                db,
                                table,
                                p0,
                              ).pdfRecipeIngredientsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.recipeId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (pdfRecipeStepsRefs)
                        await $_getPrefetchedData<
                          PdfRecipe,
                          $PdfRecipesTable,
                          PdfRecipeStep
                        >(
                          currentTable: table,
                          referencedTable: $$PdfRecipesTableReferences
                              ._pdfRecipeStepsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PdfRecipesTableReferences(
                                db,
                                table,
                                p0,
                              ).pdfRecipeStepsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.recipeId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (pdfRecipeNutritionRefs)
                        await $_getPrefetchedData<
                          PdfRecipe,
                          $PdfRecipesTable,
                          PdfRecipeNutritionData
                        >(
                          currentTable: table,
                          referencedTable: $$PdfRecipesTableReferences
                              ._pdfRecipeNutritionRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PdfRecipesTableReferences(
                                db,
                                table,
                                p0,
                              ).pdfRecipeNutritionRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.recipeId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (pdfRecipeMediaRefs)
                        await $_getPrefetchedData<
                          PdfRecipe,
                          $PdfRecipesTable,
                          PdfRecipeMediaData
                        >(
                          currentTable: table,
                          referencedTable: $$PdfRecipesTableReferences
                              ._pdfRecipeMediaRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PdfRecipesTableReferences(
                                db,
                                table,
                                p0,
                              ).pdfRecipeMediaRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.recipeId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (pdfMealSlotItemsRefs)
                        await $_getPrefetchedData<
                          PdfRecipe,
                          $PdfRecipesTable,
                          PdfMealSlotItem
                        >(
                          currentTable: table,
                          referencedTable: $$PdfRecipesTableReferences
                              ._pdfMealSlotItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PdfRecipesTableReferences(
                                db,
                                table,
                                p0,
                              ).pdfMealSlotItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.recipeId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$PdfRecipesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PdfRecipesTable,
      PdfRecipe,
      $$PdfRecipesTableFilterComposer,
      $$PdfRecipesTableOrderingComposer,
      $$PdfRecipesTableAnnotationComposer,
      $$PdfRecipesTableCreateCompanionBuilder,
      $$PdfRecipesTableUpdateCompanionBuilder,
      (PdfRecipe, $$PdfRecipesTableReferences),
      PdfRecipe,
      PrefetchHooks Function({
        bool pdfRecipeIngredientsRefs,
        bool pdfRecipeStepsRefs,
        bool pdfRecipeNutritionRefs,
        bool pdfRecipeMediaRefs,
        bool pdfMealSlotItemsRefs,
      })
    >;
typedef $$PdfSimpleProductsTableCreateCompanionBuilder =
    PdfSimpleProductsCompanion Function({
      Value<int> id,
      required String name,
      required String normalizedName,
      Value<String?> category,
      Value<String?> defaultUnit,
      Value<String?> notes,
    });
typedef $$PdfSimpleProductsTableUpdateCompanionBuilder =
    PdfSimpleProductsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> normalizedName,
      Value<String?> category,
      Value<String?> defaultUnit,
      Value<String?> notes,
    });

final class $$PdfSimpleProductsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $PdfSimpleProductsTable,
          PdfSimpleProduct
        > {
  $$PdfSimpleProductsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<
    $PdfSimpleProductNutritionTable,
    List<PdfSimpleProductNutritionData>
  >
  _pdfSimpleProductNutritionRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.pdfSimpleProductNutrition,
        aliasName: $_aliasNameGenerator(
          db.pdfSimpleProducts.id,
          db.pdfSimpleProductNutrition.simpleProductId,
        ),
      );

  $$PdfSimpleProductNutritionTableProcessedTableManager
  get pdfSimpleProductNutritionRefs {
    final manager = $$PdfSimpleProductNutritionTableTableManager(
      $_db,
      $_db.pdfSimpleProductNutrition,
    ).filter((f) => f.simpleProductId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _pdfSimpleProductNutritionRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PdfMealSlotItemsTable, List<PdfMealSlotItem>>
  _pdfMealSlotItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.pdfMealSlotItems,
    aliasName: $_aliasNameGenerator(
      db.pdfSimpleProducts.id,
      db.pdfMealSlotItems.simpleProductId,
    ),
  );

  $$PdfMealSlotItemsTableProcessedTableManager get pdfMealSlotItemsRefs {
    final manager = $$PdfMealSlotItemsTableTableManager(
      $_db,
      $_db.pdfMealSlotItems,
    ).filter((f) => f.simpleProductId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _pdfMealSlotItemsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PdfSimpleProductsTableFilterComposer
    extends Composer<_$AppDatabase, $PdfSimpleProductsTable> {
  $$PdfSimpleProductsTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get normalizedName => $composableBuilder(
    column: $table.normalizedName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get defaultUnit => $composableBuilder(
    column: $table.defaultUnit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> pdfSimpleProductNutritionRefs(
    Expression<bool> Function($$PdfSimpleProductNutritionTableFilterComposer f)
    f,
  ) {
    final $$PdfSimpleProductNutritionTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.pdfSimpleProductNutrition,
          getReferencedColumn: (t) => t.simpleProductId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PdfSimpleProductNutritionTableFilterComposer(
                $db: $db,
                $table: $db.pdfSimpleProductNutrition,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> pdfMealSlotItemsRefs(
    Expression<bool> Function($$PdfMealSlotItemsTableFilterComposer f) f,
  ) {
    final $$PdfMealSlotItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pdfMealSlotItems,
      getReferencedColumn: (t) => t.simpleProductId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PdfMealSlotItemsTableFilterComposer(
            $db: $db,
            $table: $db.pdfMealSlotItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PdfSimpleProductsTableOrderingComposer
    extends Composer<_$AppDatabase, $PdfSimpleProductsTable> {
  $$PdfSimpleProductsTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get normalizedName => $composableBuilder(
    column: $table.normalizedName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get defaultUnit => $composableBuilder(
    column: $table.defaultUnit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PdfSimpleProductsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PdfSimpleProductsTable> {
  $$PdfSimpleProductsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get normalizedName => $composableBuilder(
    column: $table.normalizedName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get defaultUnit => $composableBuilder(
    column: $table.defaultUnit,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  Expression<T> pdfSimpleProductNutritionRefs<T extends Object>(
    Expression<T> Function($$PdfSimpleProductNutritionTableAnnotationComposer a)
    f,
  ) {
    final $$PdfSimpleProductNutritionTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.pdfSimpleProductNutrition,
          getReferencedColumn: (t) => t.simpleProductId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PdfSimpleProductNutritionTableAnnotationComposer(
                $db: $db,
                $table: $db.pdfSimpleProductNutrition,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> pdfMealSlotItemsRefs<T extends Object>(
    Expression<T> Function($$PdfMealSlotItemsTableAnnotationComposer a) f,
  ) {
    final $$PdfMealSlotItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pdfMealSlotItems,
      getReferencedColumn: (t) => t.simpleProductId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PdfMealSlotItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.pdfMealSlotItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PdfSimpleProductsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PdfSimpleProductsTable,
          PdfSimpleProduct,
          $$PdfSimpleProductsTableFilterComposer,
          $$PdfSimpleProductsTableOrderingComposer,
          $$PdfSimpleProductsTableAnnotationComposer,
          $$PdfSimpleProductsTableCreateCompanionBuilder,
          $$PdfSimpleProductsTableUpdateCompanionBuilder,
          (PdfSimpleProduct, $$PdfSimpleProductsTableReferences),
          PdfSimpleProduct,
          PrefetchHooks Function({
            bool pdfSimpleProductNutritionRefs,
            bool pdfMealSlotItemsRefs,
          })
        > {
  $$PdfSimpleProductsTableTableManager(
    _$AppDatabase db,
    $PdfSimpleProductsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PdfSimpleProductsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PdfSimpleProductsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PdfSimpleProductsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> normalizedName = const Value.absent(),
                Value<String?> category = const Value.absent(),
                Value<String?> defaultUnit = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => PdfSimpleProductsCompanion(
                id: id,
                name: name,
                normalizedName: normalizedName,
                category: category,
                defaultUnit: defaultUnit,
                notes: notes,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String normalizedName,
                Value<String?> category = const Value.absent(),
                Value<String?> defaultUnit = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => PdfSimpleProductsCompanion.insert(
                id: id,
                name: name,
                normalizedName: normalizedName,
                category: category,
                defaultUnit: defaultUnit,
                notes: notes,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PdfSimpleProductsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                pdfSimpleProductNutritionRefs = false,
                pdfMealSlotItemsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (pdfSimpleProductNutritionRefs)
                      db.pdfSimpleProductNutrition,
                    if (pdfMealSlotItemsRefs) db.pdfMealSlotItems,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (pdfSimpleProductNutritionRefs)
                        await $_getPrefetchedData<
                          PdfSimpleProduct,
                          $PdfSimpleProductsTable,
                          PdfSimpleProductNutritionData
                        >(
                          currentTable: table,
                          referencedTable: $$PdfSimpleProductsTableReferences
                              ._pdfSimpleProductNutritionRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PdfSimpleProductsTableReferences(
                                db,
                                table,
                                p0,
                              ).pdfSimpleProductNutritionRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.simpleProductId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (pdfMealSlotItemsRefs)
                        await $_getPrefetchedData<
                          PdfSimpleProduct,
                          $PdfSimpleProductsTable,
                          PdfMealSlotItem
                        >(
                          currentTable: table,
                          referencedTable: $$PdfSimpleProductsTableReferences
                              ._pdfMealSlotItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PdfSimpleProductsTableReferences(
                                db,
                                table,
                                p0,
                              ).pdfMealSlotItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.simpleProductId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$PdfSimpleProductsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PdfSimpleProductsTable,
      PdfSimpleProduct,
      $$PdfSimpleProductsTableFilterComposer,
      $$PdfSimpleProductsTableOrderingComposer,
      $$PdfSimpleProductsTableAnnotationComposer,
      $$PdfSimpleProductsTableCreateCompanionBuilder,
      $$PdfSimpleProductsTableUpdateCompanionBuilder,
      (PdfSimpleProduct, $$PdfSimpleProductsTableReferences),
      PdfSimpleProduct,
      PrefetchHooks Function({
        bool pdfSimpleProductNutritionRefs,
        bool pdfMealSlotItemsRefs,
      })
    >;
typedef $$PdfMediaAssetsTableCreateCompanionBuilder =
    PdfMediaAssetsCompanion Function({
      Value<int> id,
      Value<String?> sourceFileId,
      Value<int?> sourcePage,
      Value<String> mediaType,
      Value<String?> fileName,
      Value<String?> relativePath,
      Value<String?> storageUri,
      Value<String?> caption,
      Value<String?> altText,
      Value<int?> width,
      Value<int?> height,
      Value<String?> hash,
      Value<String?> notes,
    });
typedef $$PdfMediaAssetsTableUpdateCompanionBuilder =
    PdfMediaAssetsCompanion Function({
      Value<int> id,
      Value<String?> sourceFileId,
      Value<int?> sourcePage,
      Value<String> mediaType,
      Value<String?> fileName,
      Value<String?> relativePath,
      Value<String?> storageUri,
      Value<String?> caption,
      Value<String?> altText,
      Value<int?> width,
      Value<int?> height,
      Value<String?> hash,
      Value<String?> notes,
    });

final class $$PdfMediaAssetsTableReferences
    extends BaseReferences<_$AppDatabase, $PdfMediaAssetsTable, PdfMediaAsset> {
  $$PdfMediaAssetsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$PdfRecipeMediaTable, List<PdfRecipeMediaData>>
  _pdfRecipeMediaRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.pdfRecipeMedia,
    aliasName: $_aliasNameGenerator(
      db.pdfMediaAssets.id,
      db.pdfRecipeMedia.mediaAssetId,
    ),
  );

  $$PdfRecipeMediaTableProcessedTableManager get pdfRecipeMediaRefs {
    final manager = $$PdfRecipeMediaTableTableManager(
      $_db,
      $_db.pdfRecipeMedia,
    ).filter((f) => f.mediaAssetId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_pdfRecipeMediaRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PdfMediaAssetsTableFilterComposer
    extends Composer<_$AppDatabase, $PdfMediaAssetsTable> {
  $$PdfMediaAssetsTableFilterComposer({
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

  ColumnFilters<String> get sourceFileId => $composableBuilder(
    column: $table.sourceFileId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sourcePage => $composableBuilder(
    column: $table.sourcePage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mediaType => $composableBuilder(
    column: $table.mediaType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fileName => $composableBuilder(
    column: $table.fileName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get relativePath => $composableBuilder(
    column: $table.relativePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get storageUri => $composableBuilder(
    column: $table.storageUri,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get caption => $composableBuilder(
    column: $table.caption,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get altText => $composableBuilder(
    column: $table.altText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get width => $composableBuilder(
    column: $table.width,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get height => $composableBuilder(
    column: $table.height,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get hash => $composableBuilder(
    column: $table.hash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> pdfRecipeMediaRefs(
    Expression<bool> Function($$PdfRecipeMediaTableFilterComposer f) f,
  ) {
    final $$PdfRecipeMediaTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pdfRecipeMedia,
      getReferencedColumn: (t) => t.mediaAssetId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PdfRecipeMediaTableFilterComposer(
            $db: $db,
            $table: $db.pdfRecipeMedia,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PdfMediaAssetsTableOrderingComposer
    extends Composer<_$AppDatabase, $PdfMediaAssetsTable> {
  $$PdfMediaAssetsTableOrderingComposer({
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

  ColumnOrderings<String> get sourceFileId => $composableBuilder(
    column: $table.sourceFileId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sourcePage => $composableBuilder(
    column: $table.sourcePage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mediaType => $composableBuilder(
    column: $table.mediaType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fileName => $composableBuilder(
    column: $table.fileName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get relativePath => $composableBuilder(
    column: $table.relativePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get storageUri => $composableBuilder(
    column: $table.storageUri,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get caption => $composableBuilder(
    column: $table.caption,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get altText => $composableBuilder(
    column: $table.altText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get width => $composableBuilder(
    column: $table.width,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get height => $composableBuilder(
    column: $table.height,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get hash => $composableBuilder(
    column: $table.hash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PdfMediaAssetsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PdfMediaAssetsTable> {
  $$PdfMediaAssetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sourceFileId => $composableBuilder(
    column: $table.sourceFileId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sourcePage => $composableBuilder(
    column: $table.sourcePage,
    builder: (column) => column,
  );

  GeneratedColumn<String> get mediaType =>
      $composableBuilder(column: $table.mediaType, builder: (column) => column);

  GeneratedColumn<String> get fileName =>
      $composableBuilder(column: $table.fileName, builder: (column) => column);

  GeneratedColumn<String> get relativePath => $composableBuilder(
    column: $table.relativePath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get storageUri => $composableBuilder(
    column: $table.storageUri,
    builder: (column) => column,
  );

  GeneratedColumn<String> get caption =>
      $composableBuilder(column: $table.caption, builder: (column) => column);

  GeneratedColumn<String> get altText =>
      $composableBuilder(column: $table.altText, builder: (column) => column);

  GeneratedColumn<int> get width =>
      $composableBuilder(column: $table.width, builder: (column) => column);

  GeneratedColumn<int> get height =>
      $composableBuilder(column: $table.height, builder: (column) => column);

  GeneratedColumn<String> get hash =>
      $composableBuilder(column: $table.hash, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  Expression<T> pdfRecipeMediaRefs<T extends Object>(
    Expression<T> Function($$PdfRecipeMediaTableAnnotationComposer a) f,
  ) {
    final $$PdfRecipeMediaTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pdfRecipeMedia,
      getReferencedColumn: (t) => t.mediaAssetId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PdfRecipeMediaTableAnnotationComposer(
            $db: $db,
            $table: $db.pdfRecipeMedia,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PdfMediaAssetsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PdfMediaAssetsTable,
          PdfMediaAsset,
          $$PdfMediaAssetsTableFilterComposer,
          $$PdfMediaAssetsTableOrderingComposer,
          $$PdfMediaAssetsTableAnnotationComposer,
          $$PdfMediaAssetsTableCreateCompanionBuilder,
          $$PdfMediaAssetsTableUpdateCompanionBuilder,
          (PdfMediaAsset, $$PdfMediaAssetsTableReferences),
          PdfMediaAsset,
          PrefetchHooks Function({bool pdfRecipeMediaRefs})
        > {
  $$PdfMediaAssetsTableTableManager(
    _$AppDatabase db,
    $PdfMediaAssetsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PdfMediaAssetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PdfMediaAssetsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PdfMediaAssetsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> sourceFileId = const Value.absent(),
                Value<int?> sourcePage = const Value.absent(),
                Value<String> mediaType = const Value.absent(),
                Value<String?> fileName = const Value.absent(),
                Value<String?> relativePath = const Value.absent(),
                Value<String?> storageUri = const Value.absent(),
                Value<String?> caption = const Value.absent(),
                Value<String?> altText = const Value.absent(),
                Value<int?> width = const Value.absent(),
                Value<int?> height = const Value.absent(),
                Value<String?> hash = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => PdfMediaAssetsCompanion(
                id: id,
                sourceFileId: sourceFileId,
                sourcePage: sourcePage,
                mediaType: mediaType,
                fileName: fileName,
                relativePath: relativePath,
                storageUri: storageUri,
                caption: caption,
                altText: altText,
                width: width,
                height: height,
                hash: hash,
                notes: notes,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> sourceFileId = const Value.absent(),
                Value<int?> sourcePage = const Value.absent(),
                Value<String> mediaType = const Value.absent(),
                Value<String?> fileName = const Value.absent(),
                Value<String?> relativePath = const Value.absent(),
                Value<String?> storageUri = const Value.absent(),
                Value<String?> caption = const Value.absent(),
                Value<String?> altText = const Value.absent(),
                Value<int?> width = const Value.absent(),
                Value<int?> height = const Value.absent(),
                Value<String?> hash = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => PdfMediaAssetsCompanion.insert(
                id: id,
                sourceFileId: sourceFileId,
                sourcePage: sourcePage,
                mediaType: mediaType,
                fileName: fileName,
                relativePath: relativePath,
                storageUri: storageUri,
                caption: caption,
                altText: altText,
                width: width,
                height: height,
                hash: hash,
                notes: notes,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PdfMediaAssetsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({pdfRecipeMediaRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (pdfRecipeMediaRefs) db.pdfRecipeMedia,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (pdfRecipeMediaRefs)
                    await $_getPrefetchedData<
                      PdfMediaAsset,
                      $PdfMediaAssetsTable,
                      PdfRecipeMediaData
                    >(
                      currentTable: table,
                      referencedTable: $$PdfMediaAssetsTableReferences
                          ._pdfRecipeMediaRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$PdfMediaAssetsTableReferences(
                            db,
                            table,
                            p0,
                          ).pdfRecipeMediaRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.mediaAssetId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$PdfMediaAssetsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PdfMediaAssetsTable,
      PdfMediaAsset,
      $$PdfMediaAssetsTableFilterComposer,
      $$PdfMediaAssetsTableOrderingComposer,
      $$PdfMediaAssetsTableAnnotationComposer,
      $$PdfMediaAssetsTableCreateCompanionBuilder,
      $$PdfMediaAssetsTableUpdateCompanionBuilder,
      (PdfMediaAsset, $$PdfMediaAssetsTableReferences),
      PdfMediaAsset,
      PrefetchHooks Function({bool pdfRecipeMediaRefs})
    >;
typedef $$PdfMealSlotsTableCreateCompanionBuilder =
    PdfMealSlotsCompanion Function({
      Value<int> id,
      required int mealPlanDayId,
      required String mealType,
      required String displayName,
      required int orderIndex,
      Value<double?> slotKcal,
      Value<double?> slotProtein,
      Value<double?> slotFat,
      Value<double?> slotCarbs,
      Value<String?> notes,
    });
typedef $$PdfMealSlotsTableUpdateCompanionBuilder =
    PdfMealSlotsCompanion Function({
      Value<int> id,
      Value<int> mealPlanDayId,
      Value<String> mealType,
      Value<String> displayName,
      Value<int> orderIndex,
      Value<double?> slotKcal,
      Value<double?> slotProtein,
      Value<double?> slotFat,
      Value<double?> slotCarbs,
      Value<String?> notes,
    });

final class $$PdfMealSlotsTableReferences
    extends BaseReferences<_$AppDatabase, $PdfMealSlotsTable, PdfMealSlot> {
  $$PdfMealSlotsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PdfMealPlanDaysTable _mealPlanDayIdTable(_$AppDatabase db) =>
      db.pdfMealPlanDays.createAlias(
        $_aliasNameGenerator(
          db.pdfMealSlots.mealPlanDayId,
          db.pdfMealPlanDays.id,
        ),
      );

  $$PdfMealPlanDaysTableProcessedTableManager get mealPlanDayId {
    final $_column = $_itemColumn<int>('meal_plan_day_id')!;

    final manager = $$PdfMealPlanDaysTableTableManager(
      $_db,
      $_db.pdfMealPlanDays,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_mealPlanDayIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$PdfMealSlotItemsTable, List<PdfMealSlotItem>>
  _pdfMealSlotItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.pdfMealSlotItems,
    aliasName: $_aliasNameGenerator(
      db.pdfMealSlots.id,
      db.pdfMealSlotItems.mealSlotId,
    ),
  );

  $$PdfMealSlotItemsTableProcessedTableManager get pdfMealSlotItemsRefs {
    final manager = $$PdfMealSlotItemsTableTableManager(
      $_db,
      $_db.pdfMealSlotItems,
    ).filter((f) => f.mealSlotId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _pdfMealSlotItemsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PdfMealSlotsTableFilterComposer
    extends Composer<_$AppDatabase, $PdfMealSlotsTable> {
  $$PdfMealSlotsTableFilterComposer({
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

  ColumnFilters<String> get mealType => $composableBuilder(
    column: $table.mealType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get slotKcal => $composableBuilder(
    column: $table.slotKcal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get slotProtein => $composableBuilder(
    column: $table.slotProtein,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get slotFat => $composableBuilder(
    column: $table.slotFat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get slotCarbs => $composableBuilder(
    column: $table.slotCarbs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  $$PdfMealPlanDaysTableFilterComposer get mealPlanDayId {
    final $$PdfMealPlanDaysTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mealPlanDayId,
      referencedTable: $db.pdfMealPlanDays,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PdfMealPlanDaysTableFilterComposer(
            $db: $db,
            $table: $db.pdfMealPlanDays,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> pdfMealSlotItemsRefs(
    Expression<bool> Function($$PdfMealSlotItemsTableFilterComposer f) f,
  ) {
    final $$PdfMealSlotItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pdfMealSlotItems,
      getReferencedColumn: (t) => t.mealSlotId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PdfMealSlotItemsTableFilterComposer(
            $db: $db,
            $table: $db.pdfMealSlotItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PdfMealSlotsTableOrderingComposer
    extends Composer<_$AppDatabase, $PdfMealSlotsTable> {
  $$PdfMealSlotsTableOrderingComposer({
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

  ColumnOrderings<String> get mealType => $composableBuilder(
    column: $table.mealType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get slotKcal => $composableBuilder(
    column: $table.slotKcal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get slotProtein => $composableBuilder(
    column: $table.slotProtein,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get slotFat => $composableBuilder(
    column: $table.slotFat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get slotCarbs => $composableBuilder(
    column: $table.slotCarbs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  $$PdfMealPlanDaysTableOrderingComposer get mealPlanDayId {
    final $$PdfMealPlanDaysTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mealPlanDayId,
      referencedTable: $db.pdfMealPlanDays,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PdfMealPlanDaysTableOrderingComposer(
            $db: $db,
            $table: $db.pdfMealPlanDays,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PdfMealSlotsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PdfMealSlotsTable> {
  $$PdfMealSlotsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get mealType =>
      $composableBuilder(column: $table.mealType, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

  GeneratedColumn<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => column,
  );

  GeneratedColumn<double> get slotKcal =>
      $composableBuilder(column: $table.slotKcal, builder: (column) => column);

  GeneratedColumn<double> get slotProtein => $composableBuilder(
    column: $table.slotProtein,
    builder: (column) => column,
  );

  GeneratedColumn<double> get slotFat =>
      $composableBuilder(column: $table.slotFat, builder: (column) => column);

  GeneratedColumn<double> get slotCarbs =>
      $composableBuilder(column: $table.slotCarbs, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  $$PdfMealPlanDaysTableAnnotationComposer get mealPlanDayId {
    final $$PdfMealPlanDaysTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mealPlanDayId,
      referencedTable: $db.pdfMealPlanDays,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PdfMealPlanDaysTableAnnotationComposer(
            $db: $db,
            $table: $db.pdfMealPlanDays,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> pdfMealSlotItemsRefs<T extends Object>(
    Expression<T> Function($$PdfMealSlotItemsTableAnnotationComposer a) f,
  ) {
    final $$PdfMealSlotItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pdfMealSlotItems,
      getReferencedColumn: (t) => t.mealSlotId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PdfMealSlotItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.pdfMealSlotItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PdfMealSlotsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PdfMealSlotsTable,
          PdfMealSlot,
          $$PdfMealSlotsTableFilterComposer,
          $$PdfMealSlotsTableOrderingComposer,
          $$PdfMealSlotsTableAnnotationComposer,
          $$PdfMealSlotsTableCreateCompanionBuilder,
          $$PdfMealSlotsTableUpdateCompanionBuilder,
          (PdfMealSlot, $$PdfMealSlotsTableReferences),
          PdfMealSlot,
          PrefetchHooks Function({
            bool mealPlanDayId,
            bool pdfMealSlotItemsRefs,
          })
        > {
  $$PdfMealSlotsTableTableManager(_$AppDatabase db, $PdfMealSlotsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PdfMealSlotsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PdfMealSlotsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PdfMealSlotsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> mealPlanDayId = const Value.absent(),
                Value<String> mealType = const Value.absent(),
                Value<String> displayName = const Value.absent(),
                Value<int> orderIndex = const Value.absent(),
                Value<double?> slotKcal = const Value.absent(),
                Value<double?> slotProtein = const Value.absent(),
                Value<double?> slotFat = const Value.absent(),
                Value<double?> slotCarbs = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => PdfMealSlotsCompanion(
                id: id,
                mealPlanDayId: mealPlanDayId,
                mealType: mealType,
                displayName: displayName,
                orderIndex: orderIndex,
                slotKcal: slotKcal,
                slotProtein: slotProtein,
                slotFat: slotFat,
                slotCarbs: slotCarbs,
                notes: notes,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int mealPlanDayId,
                required String mealType,
                required String displayName,
                required int orderIndex,
                Value<double?> slotKcal = const Value.absent(),
                Value<double?> slotProtein = const Value.absent(),
                Value<double?> slotFat = const Value.absent(),
                Value<double?> slotCarbs = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => PdfMealSlotsCompanion.insert(
                id: id,
                mealPlanDayId: mealPlanDayId,
                mealType: mealType,
                displayName: displayName,
                orderIndex: orderIndex,
                slotKcal: slotKcal,
                slotProtein: slotProtein,
                slotFat: slotFat,
                slotCarbs: slotCarbs,
                notes: notes,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PdfMealSlotsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({mealPlanDayId = false, pdfMealSlotItemsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (pdfMealSlotItemsRefs) db.pdfMealSlotItems,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (mealPlanDayId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.mealPlanDayId,
                                    referencedTable:
                                        $$PdfMealSlotsTableReferences
                                            ._mealPlanDayIdTable(db),
                                    referencedColumn:
                                        $$PdfMealSlotsTableReferences
                                            ._mealPlanDayIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (pdfMealSlotItemsRefs)
                        await $_getPrefetchedData<
                          PdfMealSlot,
                          $PdfMealSlotsTable,
                          PdfMealSlotItem
                        >(
                          currentTable: table,
                          referencedTable: $$PdfMealSlotsTableReferences
                              ._pdfMealSlotItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PdfMealSlotsTableReferences(
                                db,
                                table,
                                p0,
                              ).pdfMealSlotItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.mealSlotId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$PdfMealSlotsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PdfMealSlotsTable,
      PdfMealSlot,
      $$PdfMealSlotsTableFilterComposer,
      $$PdfMealSlotsTableOrderingComposer,
      $$PdfMealSlotsTableAnnotationComposer,
      $$PdfMealSlotsTableCreateCompanionBuilder,
      $$PdfMealSlotsTableUpdateCompanionBuilder,
      (PdfMealSlot, $$PdfMealSlotsTableReferences),
      PdfMealSlot,
      PrefetchHooks Function({bool mealPlanDayId, bool pdfMealSlotItemsRefs})
    >;
typedef $$PdfRecipeIngredientsTableCreateCompanionBuilder =
    PdfRecipeIngredientsCompanion Function({
      Value<int> id,
      required int recipeId,
      required String ingredientNameRaw,
      Value<String?> ingredientNameNormalized,
      Value<double?> amount,
      Value<String?> unit,
      Value<String?> amountText,
      Value<String?> preparationState,
      Value<bool> optionalFlag,
      required int sortOrder,
      Value<String?> notes,
    });
typedef $$PdfRecipeIngredientsTableUpdateCompanionBuilder =
    PdfRecipeIngredientsCompanion Function({
      Value<int> id,
      Value<int> recipeId,
      Value<String> ingredientNameRaw,
      Value<String?> ingredientNameNormalized,
      Value<double?> amount,
      Value<String?> unit,
      Value<String?> amountText,
      Value<String?> preparationState,
      Value<bool> optionalFlag,
      Value<int> sortOrder,
      Value<String?> notes,
    });

final class $$PdfRecipeIngredientsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $PdfRecipeIngredientsTable,
          PdfRecipeIngredient
        > {
  $$PdfRecipeIngredientsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PdfRecipesTable _recipeIdTable(_$AppDatabase db) =>
      db.pdfRecipes.createAlias(
        $_aliasNameGenerator(
          db.pdfRecipeIngredients.recipeId,
          db.pdfRecipes.id,
        ),
      );

  $$PdfRecipesTableProcessedTableManager get recipeId {
    final $_column = $_itemColumn<int>('recipe_id')!;

    final manager = $$PdfRecipesTableTableManager(
      $_db,
      $_db.pdfRecipes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_recipeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PdfRecipeIngredientsTableFilterComposer
    extends Composer<_$AppDatabase, $PdfRecipeIngredientsTable> {
  $$PdfRecipeIngredientsTableFilterComposer({
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

  ColumnFilters<String> get ingredientNameRaw => $composableBuilder(
    column: $table.ingredientNameRaw,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ingredientNameNormalized => $composableBuilder(
    column: $table.ingredientNameNormalized,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get amountText => $composableBuilder(
    column: $table.amountText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get preparationState => $composableBuilder(
    column: $table.preparationState,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get optionalFlag => $composableBuilder(
    column: $table.optionalFlag,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  $$PdfRecipesTableFilterComposer get recipeId {
    final $$PdfRecipesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.pdfRecipes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PdfRecipesTableFilterComposer(
            $db: $db,
            $table: $db.pdfRecipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PdfRecipeIngredientsTableOrderingComposer
    extends Composer<_$AppDatabase, $PdfRecipeIngredientsTable> {
  $$PdfRecipeIngredientsTableOrderingComposer({
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

  ColumnOrderings<String> get ingredientNameRaw => $composableBuilder(
    column: $table.ingredientNameRaw,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ingredientNameNormalized => $composableBuilder(
    column: $table.ingredientNameNormalized,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get amountText => $composableBuilder(
    column: $table.amountText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get preparationState => $composableBuilder(
    column: $table.preparationState,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get optionalFlag => $composableBuilder(
    column: $table.optionalFlag,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  $$PdfRecipesTableOrderingComposer get recipeId {
    final $$PdfRecipesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.pdfRecipes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PdfRecipesTableOrderingComposer(
            $db: $db,
            $table: $db.pdfRecipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PdfRecipeIngredientsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PdfRecipeIngredientsTable> {
  $$PdfRecipeIngredientsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get ingredientNameRaw => $composableBuilder(
    column: $table.ingredientNameRaw,
    builder: (column) => column,
  );

  GeneratedColumn<String> get ingredientNameNormalized => $composableBuilder(
    column: $table.ingredientNameNormalized,
    builder: (column) => column,
  );

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<String> get amountText => $composableBuilder(
    column: $table.amountText,
    builder: (column) => column,
  );

  GeneratedColumn<String> get preparationState => $composableBuilder(
    column: $table.preparationState,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get optionalFlag => $composableBuilder(
    column: $table.optionalFlag,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  $$PdfRecipesTableAnnotationComposer get recipeId {
    final $$PdfRecipesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.pdfRecipes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PdfRecipesTableAnnotationComposer(
            $db: $db,
            $table: $db.pdfRecipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PdfRecipeIngredientsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PdfRecipeIngredientsTable,
          PdfRecipeIngredient,
          $$PdfRecipeIngredientsTableFilterComposer,
          $$PdfRecipeIngredientsTableOrderingComposer,
          $$PdfRecipeIngredientsTableAnnotationComposer,
          $$PdfRecipeIngredientsTableCreateCompanionBuilder,
          $$PdfRecipeIngredientsTableUpdateCompanionBuilder,
          (PdfRecipeIngredient, $$PdfRecipeIngredientsTableReferences),
          PdfRecipeIngredient,
          PrefetchHooks Function({bool recipeId})
        > {
  $$PdfRecipeIngredientsTableTableManager(
    _$AppDatabase db,
    $PdfRecipeIngredientsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PdfRecipeIngredientsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PdfRecipeIngredientsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$PdfRecipeIngredientsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> recipeId = const Value.absent(),
                Value<String> ingredientNameRaw = const Value.absent(),
                Value<String?> ingredientNameNormalized = const Value.absent(),
                Value<double?> amount = const Value.absent(),
                Value<String?> unit = const Value.absent(),
                Value<String?> amountText = const Value.absent(),
                Value<String?> preparationState = const Value.absent(),
                Value<bool> optionalFlag = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => PdfRecipeIngredientsCompanion(
                id: id,
                recipeId: recipeId,
                ingredientNameRaw: ingredientNameRaw,
                ingredientNameNormalized: ingredientNameNormalized,
                amount: amount,
                unit: unit,
                amountText: amountText,
                preparationState: preparationState,
                optionalFlag: optionalFlag,
                sortOrder: sortOrder,
                notes: notes,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int recipeId,
                required String ingredientNameRaw,
                Value<String?> ingredientNameNormalized = const Value.absent(),
                Value<double?> amount = const Value.absent(),
                Value<String?> unit = const Value.absent(),
                Value<String?> amountText = const Value.absent(),
                Value<String?> preparationState = const Value.absent(),
                Value<bool> optionalFlag = const Value.absent(),
                required int sortOrder,
                Value<String?> notes = const Value.absent(),
              }) => PdfRecipeIngredientsCompanion.insert(
                id: id,
                recipeId: recipeId,
                ingredientNameRaw: ingredientNameRaw,
                ingredientNameNormalized: ingredientNameNormalized,
                amount: amount,
                unit: unit,
                amountText: amountText,
                preparationState: preparationState,
                optionalFlag: optionalFlag,
                sortOrder: sortOrder,
                notes: notes,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PdfRecipeIngredientsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({recipeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (recipeId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.recipeId,
                                referencedTable:
                                    $$PdfRecipeIngredientsTableReferences
                                        ._recipeIdTable(db),
                                referencedColumn:
                                    $$PdfRecipeIngredientsTableReferences
                                        ._recipeIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PdfRecipeIngredientsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PdfRecipeIngredientsTable,
      PdfRecipeIngredient,
      $$PdfRecipeIngredientsTableFilterComposer,
      $$PdfRecipeIngredientsTableOrderingComposer,
      $$PdfRecipeIngredientsTableAnnotationComposer,
      $$PdfRecipeIngredientsTableCreateCompanionBuilder,
      $$PdfRecipeIngredientsTableUpdateCompanionBuilder,
      (PdfRecipeIngredient, $$PdfRecipeIngredientsTableReferences),
      PdfRecipeIngredient,
      PrefetchHooks Function({bool recipeId})
    >;
typedef $$PdfRecipeStepsTableCreateCompanionBuilder =
    PdfRecipeStepsCompanion Function({
      Value<int> id,
      required int recipeId,
      required int stepNumber,
      required String instructionText,
      Value<int?> timeMinutes,
      Value<int?> temperatureC,
      Value<String?> notes,
    });
typedef $$PdfRecipeStepsTableUpdateCompanionBuilder =
    PdfRecipeStepsCompanion Function({
      Value<int> id,
      Value<int> recipeId,
      Value<int> stepNumber,
      Value<String> instructionText,
      Value<int?> timeMinutes,
      Value<int?> temperatureC,
      Value<String?> notes,
    });

final class $$PdfRecipeStepsTableReferences
    extends BaseReferences<_$AppDatabase, $PdfRecipeStepsTable, PdfRecipeStep> {
  $$PdfRecipeStepsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PdfRecipesTable _recipeIdTable(_$AppDatabase db) =>
      db.pdfRecipes.createAlias(
        $_aliasNameGenerator(db.pdfRecipeSteps.recipeId, db.pdfRecipes.id),
      );

  $$PdfRecipesTableProcessedTableManager get recipeId {
    final $_column = $_itemColumn<int>('recipe_id')!;

    final manager = $$PdfRecipesTableTableManager(
      $_db,
      $_db.pdfRecipes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_recipeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PdfRecipeStepsTableFilterComposer
    extends Composer<_$AppDatabase, $PdfRecipeStepsTable> {
  $$PdfRecipeStepsTableFilterComposer({
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

  ColumnFilters<int> get stepNumber => $composableBuilder(
    column: $table.stepNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get instructionText => $composableBuilder(
    column: $table.instructionText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get timeMinutes => $composableBuilder(
    column: $table.timeMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get temperatureC => $composableBuilder(
    column: $table.temperatureC,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  $$PdfRecipesTableFilterComposer get recipeId {
    final $$PdfRecipesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.pdfRecipes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PdfRecipesTableFilterComposer(
            $db: $db,
            $table: $db.pdfRecipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PdfRecipeStepsTableOrderingComposer
    extends Composer<_$AppDatabase, $PdfRecipeStepsTable> {
  $$PdfRecipeStepsTableOrderingComposer({
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

  ColumnOrderings<int> get stepNumber => $composableBuilder(
    column: $table.stepNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get instructionText => $composableBuilder(
    column: $table.instructionText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get timeMinutes => $composableBuilder(
    column: $table.timeMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get temperatureC => $composableBuilder(
    column: $table.temperatureC,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  $$PdfRecipesTableOrderingComposer get recipeId {
    final $$PdfRecipesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.pdfRecipes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PdfRecipesTableOrderingComposer(
            $db: $db,
            $table: $db.pdfRecipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PdfRecipeStepsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PdfRecipeStepsTable> {
  $$PdfRecipeStepsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get stepNumber => $composableBuilder(
    column: $table.stepNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get instructionText => $composableBuilder(
    column: $table.instructionText,
    builder: (column) => column,
  );

  GeneratedColumn<int> get timeMinutes => $composableBuilder(
    column: $table.timeMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get temperatureC => $composableBuilder(
    column: $table.temperatureC,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  $$PdfRecipesTableAnnotationComposer get recipeId {
    final $$PdfRecipesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.pdfRecipes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PdfRecipesTableAnnotationComposer(
            $db: $db,
            $table: $db.pdfRecipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PdfRecipeStepsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PdfRecipeStepsTable,
          PdfRecipeStep,
          $$PdfRecipeStepsTableFilterComposer,
          $$PdfRecipeStepsTableOrderingComposer,
          $$PdfRecipeStepsTableAnnotationComposer,
          $$PdfRecipeStepsTableCreateCompanionBuilder,
          $$PdfRecipeStepsTableUpdateCompanionBuilder,
          (PdfRecipeStep, $$PdfRecipeStepsTableReferences),
          PdfRecipeStep,
          PrefetchHooks Function({bool recipeId})
        > {
  $$PdfRecipeStepsTableTableManager(
    _$AppDatabase db,
    $PdfRecipeStepsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PdfRecipeStepsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PdfRecipeStepsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PdfRecipeStepsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> recipeId = const Value.absent(),
                Value<int> stepNumber = const Value.absent(),
                Value<String> instructionText = const Value.absent(),
                Value<int?> timeMinutes = const Value.absent(),
                Value<int?> temperatureC = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => PdfRecipeStepsCompanion(
                id: id,
                recipeId: recipeId,
                stepNumber: stepNumber,
                instructionText: instructionText,
                timeMinutes: timeMinutes,
                temperatureC: temperatureC,
                notes: notes,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int recipeId,
                required int stepNumber,
                required String instructionText,
                Value<int?> timeMinutes = const Value.absent(),
                Value<int?> temperatureC = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => PdfRecipeStepsCompanion.insert(
                id: id,
                recipeId: recipeId,
                stepNumber: stepNumber,
                instructionText: instructionText,
                timeMinutes: timeMinutes,
                temperatureC: temperatureC,
                notes: notes,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PdfRecipeStepsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({recipeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (recipeId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.recipeId,
                                referencedTable: $$PdfRecipeStepsTableReferences
                                    ._recipeIdTable(db),
                                referencedColumn:
                                    $$PdfRecipeStepsTableReferences
                                        ._recipeIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PdfRecipeStepsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PdfRecipeStepsTable,
      PdfRecipeStep,
      $$PdfRecipeStepsTableFilterComposer,
      $$PdfRecipeStepsTableOrderingComposer,
      $$PdfRecipeStepsTableAnnotationComposer,
      $$PdfRecipeStepsTableCreateCompanionBuilder,
      $$PdfRecipeStepsTableUpdateCompanionBuilder,
      (PdfRecipeStep, $$PdfRecipeStepsTableReferences),
      PdfRecipeStep,
      PrefetchHooks Function({bool recipeId})
    >;
typedef $$PdfRecipeNutritionTableCreateCompanionBuilder =
    PdfRecipeNutritionCompanion Function({
      Value<int> id,
      required int recipeId,
      required String basisType,
      Value<double?> basisValue,
      Value<double?> kcal,
      Value<double?> protein,
      Value<double?> fat,
      Value<double?> carbs,
      Value<double?> fiber,
      Value<String> provenance,
      Value<String?> notes,
    });
typedef $$PdfRecipeNutritionTableUpdateCompanionBuilder =
    PdfRecipeNutritionCompanion Function({
      Value<int> id,
      Value<int> recipeId,
      Value<String> basisType,
      Value<double?> basisValue,
      Value<double?> kcal,
      Value<double?> protein,
      Value<double?> fat,
      Value<double?> carbs,
      Value<double?> fiber,
      Value<String> provenance,
      Value<String?> notes,
    });

final class $$PdfRecipeNutritionTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $PdfRecipeNutritionTable,
          PdfRecipeNutritionData
        > {
  $$PdfRecipeNutritionTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PdfRecipesTable _recipeIdTable(_$AppDatabase db) =>
      db.pdfRecipes.createAlias(
        $_aliasNameGenerator(db.pdfRecipeNutrition.recipeId, db.pdfRecipes.id),
      );

  $$PdfRecipesTableProcessedTableManager get recipeId {
    final $_column = $_itemColumn<int>('recipe_id')!;

    final manager = $$PdfRecipesTableTableManager(
      $_db,
      $_db.pdfRecipes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_recipeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PdfRecipeNutritionTableFilterComposer
    extends Composer<_$AppDatabase, $PdfRecipeNutritionTable> {
  $$PdfRecipeNutritionTableFilterComposer({
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

  ColumnFilters<String> get basisType => $composableBuilder(
    column: $table.basisType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get basisValue => $composableBuilder(
    column: $table.basisValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get kcal => $composableBuilder(
    column: $table.kcal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get protein => $composableBuilder(
    column: $table.protein,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fat => $composableBuilder(
    column: $table.fat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get carbs => $composableBuilder(
    column: $table.carbs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fiber => $composableBuilder(
    column: $table.fiber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get provenance => $composableBuilder(
    column: $table.provenance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  $$PdfRecipesTableFilterComposer get recipeId {
    final $$PdfRecipesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.pdfRecipes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PdfRecipesTableFilterComposer(
            $db: $db,
            $table: $db.pdfRecipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PdfRecipeNutritionTableOrderingComposer
    extends Composer<_$AppDatabase, $PdfRecipeNutritionTable> {
  $$PdfRecipeNutritionTableOrderingComposer({
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

  ColumnOrderings<String> get basisType => $composableBuilder(
    column: $table.basisType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get basisValue => $composableBuilder(
    column: $table.basisValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get kcal => $composableBuilder(
    column: $table.kcal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get protein => $composableBuilder(
    column: $table.protein,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fat => $composableBuilder(
    column: $table.fat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get carbs => $composableBuilder(
    column: $table.carbs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fiber => $composableBuilder(
    column: $table.fiber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get provenance => $composableBuilder(
    column: $table.provenance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  $$PdfRecipesTableOrderingComposer get recipeId {
    final $$PdfRecipesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.pdfRecipes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PdfRecipesTableOrderingComposer(
            $db: $db,
            $table: $db.pdfRecipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PdfRecipeNutritionTableAnnotationComposer
    extends Composer<_$AppDatabase, $PdfRecipeNutritionTable> {
  $$PdfRecipeNutritionTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get basisType =>
      $composableBuilder(column: $table.basisType, builder: (column) => column);

  GeneratedColumn<double> get basisValue => $composableBuilder(
    column: $table.basisValue,
    builder: (column) => column,
  );

  GeneratedColumn<double> get kcal =>
      $composableBuilder(column: $table.kcal, builder: (column) => column);

  GeneratedColumn<double> get protein =>
      $composableBuilder(column: $table.protein, builder: (column) => column);

  GeneratedColumn<double> get fat =>
      $composableBuilder(column: $table.fat, builder: (column) => column);

  GeneratedColumn<double> get carbs =>
      $composableBuilder(column: $table.carbs, builder: (column) => column);

  GeneratedColumn<double> get fiber =>
      $composableBuilder(column: $table.fiber, builder: (column) => column);

  GeneratedColumn<String> get provenance => $composableBuilder(
    column: $table.provenance,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  $$PdfRecipesTableAnnotationComposer get recipeId {
    final $$PdfRecipesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.pdfRecipes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PdfRecipesTableAnnotationComposer(
            $db: $db,
            $table: $db.pdfRecipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PdfRecipeNutritionTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PdfRecipeNutritionTable,
          PdfRecipeNutritionData,
          $$PdfRecipeNutritionTableFilterComposer,
          $$PdfRecipeNutritionTableOrderingComposer,
          $$PdfRecipeNutritionTableAnnotationComposer,
          $$PdfRecipeNutritionTableCreateCompanionBuilder,
          $$PdfRecipeNutritionTableUpdateCompanionBuilder,
          (PdfRecipeNutritionData, $$PdfRecipeNutritionTableReferences),
          PdfRecipeNutritionData,
          PrefetchHooks Function({bool recipeId})
        > {
  $$PdfRecipeNutritionTableTableManager(
    _$AppDatabase db,
    $PdfRecipeNutritionTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PdfRecipeNutritionTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PdfRecipeNutritionTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PdfRecipeNutritionTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> recipeId = const Value.absent(),
                Value<String> basisType = const Value.absent(),
                Value<double?> basisValue = const Value.absent(),
                Value<double?> kcal = const Value.absent(),
                Value<double?> protein = const Value.absent(),
                Value<double?> fat = const Value.absent(),
                Value<double?> carbs = const Value.absent(),
                Value<double?> fiber = const Value.absent(),
                Value<String> provenance = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => PdfRecipeNutritionCompanion(
                id: id,
                recipeId: recipeId,
                basisType: basisType,
                basisValue: basisValue,
                kcal: kcal,
                protein: protein,
                fat: fat,
                carbs: carbs,
                fiber: fiber,
                provenance: provenance,
                notes: notes,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int recipeId,
                required String basisType,
                Value<double?> basisValue = const Value.absent(),
                Value<double?> kcal = const Value.absent(),
                Value<double?> protein = const Value.absent(),
                Value<double?> fat = const Value.absent(),
                Value<double?> carbs = const Value.absent(),
                Value<double?> fiber = const Value.absent(),
                Value<String> provenance = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => PdfRecipeNutritionCompanion.insert(
                id: id,
                recipeId: recipeId,
                basisType: basisType,
                basisValue: basisValue,
                kcal: kcal,
                protein: protein,
                fat: fat,
                carbs: carbs,
                fiber: fiber,
                provenance: provenance,
                notes: notes,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PdfRecipeNutritionTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({recipeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (recipeId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.recipeId,
                                referencedTable:
                                    $$PdfRecipeNutritionTableReferences
                                        ._recipeIdTable(db),
                                referencedColumn:
                                    $$PdfRecipeNutritionTableReferences
                                        ._recipeIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PdfRecipeNutritionTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PdfRecipeNutritionTable,
      PdfRecipeNutritionData,
      $$PdfRecipeNutritionTableFilterComposer,
      $$PdfRecipeNutritionTableOrderingComposer,
      $$PdfRecipeNutritionTableAnnotationComposer,
      $$PdfRecipeNutritionTableCreateCompanionBuilder,
      $$PdfRecipeNutritionTableUpdateCompanionBuilder,
      (PdfRecipeNutritionData, $$PdfRecipeNutritionTableReferences),
      PdfRecipeNutritionData,
      PrefetchHooks Function({bool recipeId})
    >;
typedef $$PdfRecipeMediaTableCreateCompanionBuilder =
    PdfRecipeMediaCompanion Function({
      required int recipeId,
      required int mediaAssetId,
      Value<bool> isPrimary,
      Value<int> sortOrder,
      Value<int> rowid,
    });
typedef $$PdfRecipeMediaTableUpdateCompanionBuilder =
    PdfRecipeMediaCompanion Function({
      Value<int> recipeId,
      Value<int> mediaAssetId,
      Value<bool> isPrimary,
      Value<int> sortOrder,
      Value<int> rowid,
    });

final class $$PdfRecipeMediaTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $PdfRecipeMediaTable,
          PdfRecipeMediaData
        > {
  $$PdfRecipeMediaTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PdfRecipesTable _recipeIdTable(_$AppDatabase db) =>
      db.pdfRecipes.createAlias(
        $_aliasNameGenerator(db.pdfRecipeMedia.recipeId, db.pdfRecipes.id),
      );

  $$PdfRecipesTableProcessedTableManager get recipeId {
    final $_column = $_itemColumn<int>('recipe_id')!;

    final manager = $$PdfRecipesTableTableManager(
      $_db,
      $_db.pdfRecipes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_recipeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PdfMediaAssetsTable _mediaAssetIdTable(_$AppDatabase db) =>
      db.pdfMediaAssets.createAlias(
        $_aliasNameGenerator(
          db.pdfRecipeMedia.mediaAssetId,
          db.pdfMediaAssets.id,
        ),
      );

  $$PdfMediaAssetsTableProcessedTableManager get mediaAssetId {
    final $_column = $_itemColumn<int>('media_asset_id')!;

    final manager = $$PdfMediaAssetsTableTableManager(
      $_db,
      $_db.pdfMediaAssets,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_mediaAssetIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PdfRecipeMediaTableFilterComposer
    extends Composer<_$AppDatabase, $PdfRecipeMediaTable> {
  $$PdfRecipeMediaTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<bool> get isPrimary => $composableBuilder(
    column: $table.isPrimary,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  $$PdfRecipesTableFilterComposer get recipeId {
    final $$PdfRecipesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.pdfRecipes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PdfRecipesTableFilterComposer(
            $db: $db,
            $table: $db.pdfRecipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PdfMediaAssetsTableFilterComposer get mediaAssetId {
    final $$PdfMediaAssetsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mediaAssetId,
      referencedTable: $db.pdfMediaAssets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PdfMediaAssetsTableFilterComposer(
            $db: $db,
            $table: $db.pdfMediaAssets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PdfRecipeMediaTableOrderingComposer
    extends Composer<_$AppDatabase, $PdfRecipeMediaTable> {
  $$PdfRecipeMediaTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<bool> get isPrimary => $composableBuilder(
    column: $table.isPrimary,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  $$PdfRecipesTableOrderingComposer get recipeId {
    final $$PdfRecipesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.pdfRecipes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PdfRecipesTableOrderingComposer(
            $db: $db,
            $table: $db.pdfRecipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PdfMediaAssetsTableOrderingComposer get mediaAssetId {
    final $$PdfMediaAssetsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mediaAssetId,
      referencedTable: $db.pdfMediaAssets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PdfMediaAssetsTableOrderingComposer(
            $db: $db,
            $table: $db.pdfMediaAssets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PdfRecipeMediaTableAnnotationComposer
    extends Composer<_$AppDatabase, $PdfRecipeMediaTable> {
  $$PdfRecipeMediaTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<bool> get isPrimary =>
      $composableBuilder(column: $table.isPrimary, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  $$PdfRecipesTableAnnotationComposer get recipeId {
    final $$PdfRecipesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.pdfRecipes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PdfRecipesTableAnnotationComposer(
            $db: $db,
            $table: $db.pdfRecipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PdfMediaAssetsTableAnnotationComposer get mediaAssetId {
    final $$PdfMediaAssetsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mediaAssetId,
      referencedTable: $db.pdfMediaAssets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PdfMediaAssetsTableAnnotationComposer(
            $db: $db,
            $table: $db.pdfMediaAssets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PdfRecipeMediaTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PdfRecipeMediaTable,
          PdfRecipeMediaData,
          $$PdfRecipeMediaTableFilterComposer,
          $$PdfRecipeMediaTableOrderingComposer,
          $$PdfRecipeMediaTableAnnotationComposer,
          $$PdfRecipeMediaTableCreateCompanionBuilder,
          $$PdfRecipeMediaTableUpdateCompanionBuilder,
          (PdfRecipeMediaData, $$PdfRecipeMediaTableReferences),
          PdfRecipeMediaData,
          PrefetchHooks Function({bool recipeId, bool mediaAssetId})
        > {
  $$PdfRecipeMediaTableTableManager(
    _$AppDatabase db,
    $PdfRecipeMediaTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PdfRecipeMediaTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PdfRecipeMediaTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PdfRecipeMediaTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> recipeId = const Value.absent(),
                Value<int> mediaAssetId = const Value.absent(),
                Value<bool> isPrimary = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PdfRecipeMediaCompanion(
                recipeId: recipeId,
                mediaAssetId: mediaAssetId,
                isPrimary: isPrimary,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int recipeId,
                required int mediaAssetId,
                Value<bool> isPrimary = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PdfRecipeMediaCompanion.insert(
                recipeId: recipeId,
                mediaAssetId: mediaAssetId,
                isPrimary: isPrimary,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PdfRecipeMediaTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({recipeId = false, mediaAssetId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (recipeId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.recipeId,
                                referencedTable: $$PdfRecipeMediaTableReferences
                                    ._recipeIdTable(db),
                                referencedColumn:
                                    $$PdfRecipeMediaTableReferences
                                        ._recipeIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (mediaAssetId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.mediaAssetId,
                                referencedTable: $$PdfRecipeMediaTableReferences
                                    ._mediaAssetIdTable(db),
                                referencedColumn:
                                    $$PdfRecipeMediaTableReferences
                                        ._mediaAssetIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PdfRecipeMediaTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PdfRecipeMediaTable,
      PdfRecipeMediaData,
      $$PdfRecipeMediaTableFilterComposer,
      $$PdfRecipeMediaTableOrderingComposer,
      $$PdfRecipeMediaTableAnnotationComposer,
      $$PdfRecipeMediaTableCreateCompanionBuilder,
      $$PdfRecipeMediaTableUpdateCompanionBuilder,
      (PdfRecipeMediaData, $$PdfRecipeMediaTableReferences),
      PdfRecipeMediaData,
      PrefetchHooks Function({bool recipeId, bool mediaAssetId})
    >;
typedef $$PdfSimpleProductNutritionTableCreateCompanionBuilder =
    PdfSimpleProductNutritionCompanion Function({
      Value<int> id,
      required int simpleProductId,
      required String basisType,
      Value<double?> basisValue,
      Value<double?> kcal,
      Value<double?> protein,
      Value<double?> fat,
      Value<double?> carbs,
      Value<String> provenance,
      Value<String?> notes,
    });
typedef $$PdfSimpleProductNutritionTableUpdateCompanionBuilder =
    PdfSimpleProductNutritionCompanion Function({
      Value<int> id,
      Value<int> simpleProductId,
      Value<String> basisType,
      Value<double?> basisValue,
      Value<double?> kcal,
      Value<double?> protein,
      Value<double?> fat,
      Value<double?> carbs,
      Value<String> provenance,
      Value<String?> notes,
    });

final class $$PdfSimpleProductNutritionTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $PdfSimpleProductNutritionTable,
          PdfSimpleProductNutritionData
        > {
  $$PdfSimpleProductNutritionTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PdfSimpleProductsTable _simpleProductIdTable(_$AppDatabase db) =>
      db.pdfSimpleProducts.createAlias(
        $_aliasNameGenerator(
          db.pdfSimpleProductNutrition.simpleProductId,
          db.pdfSimpleProducts.id,
        ),
      );

  $$PdfSimpleProductsTableProcessedTableManager get simpleProductId {
    final $_column = $_itemColumn<int>('simple_product_id')!;

    final manager = $$PdfSimpleProductsTableTableManager(
      $_db,
      $_db.pdfSimpleProducts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_simpleProductIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PdfSimpleProductNutritionTableFilterComposer
    extends Composer<_$AppDatabase, $PdfSimpleProductNutritionTable> {
  $$PdfSimpleProductNutritionTableFilterComposer({
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

  ColumnFilters<String> get basisType => $composableBuilder(
    column: $table.basisType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get basisValue => $composableBuilder(
    column: $table.basisValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get kcal => $composableBuilder(
    column: $table.kcal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get protein => $composableBuilder(
    column: $table.protein,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fat => $composableBuilder(
    column: $table.fat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get carbs => $composableBuilder(
    column: $table.carbs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get provenance => $composableBuilder(
    column: $table.provenance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  $$PdfSimpleProductsTableFilterComposer get simpleProductId {
    final $$PdfSimpleProductsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.simpleProductId,
      referencedTable: $db.pdfSimpleProducts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PdfSimpleProductsTableFilterComposer(
            $db: $db,
            $table: $db.pdfSimpleProducts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PdfSimpleProductNutritionTableOrderingComposer
    extends Composer<_$AppDatabase, $PdfSimpleProductNutritionTable> {
  $$PdfSimpleProductNutritionTableOrderingComposer({
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

  ColumnOrderings<String> get basisType => $composableBuilder(
    column: $table.basisType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get basisValue => $composableBuilder(
    column: $table.basisValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get kcal => $composableBuilder(
    column: $table.kcal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get protein => $composableBuilder(
    column: $table.protein,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fat => $composableBuilder(
    column: $table.fat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get carbs => $composableBuilder(
    column: $table.carbs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get provenance => $composableBuilder(
    column: $table.provenance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  $$PdfSimpleProductsTableOrderingComposer get simpleProductId {
    final $$PdfSimpleProductsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.simpleProductId,
      referencedTable: $db.pdfSimpleProducts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PdfSimpleProductsTableOrderingComposer(
            $db: $db,
            $table: $db.pdfSimpleProducts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PdfSimpleProductNutritionTableAnnotationComposer
    extends Composer<_$AppDatabase, $PdfSimpleProductNutritionTable> {
  $$PdfSimpleProductNutritionTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get basisType =>
      $composableBuilder(column: $table.basisType, builder: (column) => column);

  GeneratedColumn<double> get basisValue => $composableBuilder(
    column: $table.basisValue,
    builder: (column) => column,
  );

  GeneratedColumn<double> get kcal =>
      $composableBuilder(column: $table.kcal, builder: (column) => column);

  GeneratedColumn<double> get protein =>
      $composableBuilder(column: $table.protein, builder: (column) => column);

  GeneratedColumn<double> get fat =>
      $composableBuilder(column: $table.fat, builder: (column) => column);

  GeneratedColumn<double> get carbs =>
      $composableBuilder(column: $table.carbs, builder: (column) => column);

  GeneratedColumn<String> get provenance => $composableBuilder(
    column: $table.provenance,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  $$PdfSimpleProductsTableAnnotationComposer get simpleProductId {
    final $$PdfSimpleProductsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.simpleProductId,
          referencedTable: $db.pdfSimpleProducts,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PdfSimpleProductsTableAnnotationComposer(
                $db: $db,
                $table: $db.pdfSimpleProducts,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$PdfSimpleProductNutritionTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PdfSimpleProductNutritionTable,
          PdfSimpleProductNutritionData,
          $$PdfSimpleProductNutritionTableFilterComposer,
          $$PdfSimpleProductNutritionTableOrderingComposer,
          $$PdfSimpleProductNutritionTableAnnotationComposer,
          $$PdfSimpleProductNutritionTableCreateCompanionBuilder,
          $$PdfSimpleProductNutritionTableUpdateCompanionBuilder,
          (
            PdfSimpleProductNutritionData,
            $$PdfSimpleProductNutritionTableReferences,
          ),
          PdfSimpleProductNutritionData,
          PrefetchHooks Function({bool simpleProductId})
        > {
  $$PdfSimpleProductNutritionTableTableManager(
    _$AppDatabase db,
    $PdfSimpleProductNutritionTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PdfSimpleProductNutritionTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$PdfSimpleProductNutritionTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$PdfSimpleProductNutritionTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> simpleProductId = const Value.absent(),
                Value<String> basisType = const Value.absent(),
                Value<double?> basisValue = const Value.absent(),
                Value<double?> kcal = const Value.absent(),
                Value<double?> protein = const Value.absent(),
                Value<double?> fat = const Value.absent(),
                Value<double?> carbs = const Value.absent(),
                Value<String> provenance = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => PdfSimpleProductNutritionCompanion(
                id: id,
                simpleProductId: simpleProductId,
                basisType: basisType,
                basisValue: basisValue,
                kcal: kcal,
                protein: protein,
                fat: fat,
                carbs: carbs,
                provenance: provenance,
                notes: notes,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int simpleProductId,
                required String basisType,
                Value<double?> basisValue = const Value.absent(),
                Value<double?> kcal = const Value.absent(),
                Value<double?> protein = const Value.absent(),
                Value<double?> fat = const Value.absent(),
                Value<double?> carbs = const Value.absent(),
                Value<String> provenance = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => PdfSimpleProductNutritionCompanion.insert(
                id: id,
                simpleProductId: simpleProductId,
                basisType: basisType,
                basisValue: basisValue,
                kcal: kcal,
                protein: protein,
                fat: fat,
                carbs: carbs,
                provenance: provenance,
                notes: notes,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PdfSimpleProductNutritionTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({simpleProductId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (simpleProductId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.simpleProductId,
                                referencedTable:
                                    $$PdfSimpleProductNutritionTableReferences
                                        ._simpleProductIdTable(db),
                                referencedColumn:
                                    $$PdfSimpleProductNutritionTableReferences
                                        ._simpleProductIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PdfSimpleProductNutritionTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PdfSimpleProductNutritionTable,
      PdfSimpleProductNutritionData,
      $$PdfSimpleProductNutritionTableFilterComposer,
      $$PdfSimpleProductNutritionTableOrderingComposer,
      $$PdfSimpleProductNutritionTableAnnotationComposer,
      $$PdfSimpleProductNutritionTableCreateCompanionBuilder,
      $$PdfSimpleProductNutritionTableUpdateCompanionBuilder,
      (
        PdfSimpleProductNutritionData,
        $$PdfSimpleProductNutritionTableReferences,
      ),
      PdfSimpleProductNutritionData,
      PrefetchHooks Function({bool simpleProductId})
    >;
typedef $$PdfMealSlotItemsTableCreateCompanionBuilder =
    PdfMealSlotItemsCompanion Function({
      Value<int> id,
      required int mealSlotId,
      required String itemType,
      Value<int?> recipeId,
      Value<int?> simpleProductId,
      required String displayName,
      Value<double?> servings,
      Value<double?> portionFraction,
      Value<String?> amountText,
      Value<double?> itemKcal,
      Value<double?> itemProtein,
      Value<double?> itemFat,
      Value<double?> itemCarbs,
      Value<String?> notes,
    });
typedef $$PdfMealSlotItemsTableUpdateCompanionBuilder =
    PdfMealSlotItemsCompanion Function({
      Value<int> id,
      Value<int> mealSlotId,
      Value<String> itemType,
      Value<int?> recipeId,
      Value<int?> simpleProductId,
      Value<String> displayName,
      Value<double?> servings,
      Value<double?> portionFraction,
      Value<String?> amountText,
      Value<double?> itemKcal,
      Value<double?> itemProtein,
      Value<double?> itemFat,
      Value<double?> itemCarbs,
      Value<String?> notes,
    });

final class $$PdfMealSlotItemsTableReferences
    extends
        BaseReferences<_$AppDatabase, $PdfMealSlotItemsTable, PdfMealSlotItem> {
  $$PdfMealSlotItemsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PdfMealSlotsTable _mealSlotIdTable(_$AppDatabase db) =>
      db.pdfMealSlots.createAlias(
        $_aliasNameGenerator(
          db.pdfMealSlotItems.mealSlotId,
          db.pdfMealSlots.id,
        ),
      );

  $$PdfMealSlotsTableProcessedTableManager get mealSlotId {
    final $_column = $_itemColumn<int>('meal_slot_id')!;

    final manager = $$PdfMealSlotsTableTableManager(
      $_db,
      $_db.pdfMealSlots,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_mealSlotIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PdfRecipesTable _recipeIdTable(_$AppDatabase db) =>
      db.pdfRecipes.createAlias(
        $_aliasNameGenerator(db.pdfMealSlotItems.recipeId, db.pdfRecipes.id),
      );

  $$PdfRecipesTableProcessedTableManager? get recipeId {
    final $_column = $_itemColumn<int>('recipe_id');
    if ($_column == null) return null;
    final manager = $$PdfRecipesTableTableManager(
      $_db,
      $_db.pdfRecipes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_recipeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PdfSimpleProductsTable _simpleProductIdTable(_$AppDatabase db) =>
      db.pdfSimpleProducts.createAlias(
        $_aliasNameGenerator(
          db.pdfMealSlotItems.simpleProductId,
          db.pdfSimpleProducts.id,
        ),
      );

  $$PdfSimpleProductsTableProcessedTableManager? get simpleProductId {
    final $_column = $_itemColumn<int>('simple_product_id');
    if ($_column == null) return null;
    final manager = $$PdfSimpleProductsTableTableManager(
      $_db,
      $_db.pdfSimpleProducts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_simpleProductIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PdfMealSlotItemsTableFilterComposer
    extends Composer<_$AppDatabase, $PdfMealSlotItemsTable> {
  $$PdfMealSlotItemsTableFilterComposer({
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

  ColumnFilters<String> get itemType => $composableBuilder(
    column: $table.itemType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get servings => $composableBuilder(
    column: $table.servings,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get portionFraction => $composableBuilder(
    column: $table.portionFraction,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get amountText => $composableBuilder(
    column: $table.amountText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get itemKcal => $composableBuilder(
    column: $table.itemKcal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get itemProtein => $composableBuilder(
    column: $table.itemProtein,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get itemFat => $composableBuilder(
    column: $table.itemFat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get itemCarbs => $composableBuilder(
    column: $table.itemCarbs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  $$PdfMealSlotsTableFilterComposer get mealSlotId {
    final $$PdfMealSlotsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mealSlotId,
      referencedTable: $db.pdfMealSlots,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PdfMealSlotsTableFilterComposer(
            $db: $db,
            $table: $db.pdfMealSlots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PdfRecipesTableFilterComposer get recipeId {
    final $$PdfRecipesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.pdfRecipes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PdfRecipesTableFilterComposer(
            $db: $db,
            $table: $db.pdfRecipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PdfSimpleProductsTableFilterComposer get simpleProductId {
    final $$PdfSimpleProductsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.simpleProductId,
      referencedTable: $db.pdfSimpleProducts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PdfSimpleProductsTableFilterComposer(
            $db: $db,
            $table: $db.pdfSimpleProducts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PdfMealSlotItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $PdfMealSlotItemsTable> {
  $$PdfMealSlotItemsTableOrderingComposer({
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

  ColumnOrderings<String> get itemType => $composableBuilder(
    column: $table.itemType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get servings => $composableBuilder(
    column: $table.servings,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get portionFraction => $composableBuilder(
    column: $table.portionFraction,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get amountText => $composableBuilder(
    column: $table.amountText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get itemKcal => $composableBuilder(
    column: $table.itemKcal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get itemProtein => $composableBuilder(
    column: $table.itemProtein,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get itemFat => $composableBuilder(
    column: $table.itemFat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get itemCarbs => $composableBuilder(
    column: $table.itemCarbs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  $$PdfMealSlotsTableOrderingComposer get mealSlotId {
    final $$PdfMealSlotsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mealSlotId,
      referencedTable: $db.pdfMealSlots,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PdfMealSlotsTableOrderingComposer(
            $db: $db,
            $table: $db.pdfMealSlots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PdfRecipesTableOrderingComposer get recipeId {
    final $$PdfRecipesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.pdfRecipes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PdfRecipesTableOrderingComposer(
            $db: $db,
            $table: $db.pdfRecipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PdfSimpleProductsTableOrderingComposer get simpleProductId {
    final $$PdfSimpleProductsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.simpleProductId,
      referencedTable: $db.pdfSimpleProducts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PdfSimpleProductsTableOrderingComposer(
            $db: $db,
            $table: $db.pdfSimpleProducts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PdfMealSlotItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PdfMealSlotItemsTable> {
  $$PdfMealSlotItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get itemType =>
      $composableBuilder(column: $table.itemType, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

  GeneratedColumn<double> get servings =>
      $composableBuilder(column: $table.servings, builder: (column) => column);

  GeneratedColumn<double> get portionFraction => $composableBuilder(
    column: $table.portionFraction,
    builder: (column) => column,
  );

  GeneratedColumn<String> get amountText => $composableBuilder(
    column: $table.amountText,
    builder: (column) => column,
  );

  GeneratedColumn<double> get itemKcal =>
      $composableBuilder(column: $table.itemKcal, builder: (column) => column);

  GeneratedColumn<double> get itemProtein => $composableBuilder(
    column: $table.itemProtein,
    builder: (column) => column,
  );

  GeneratedColumn<double> get itemFat =>
      $composableBuilder(column: $table.itemFat, builder: (column) => column);

  GeneratedColumn<double> get itemCarbs =>
      $composableBuilder(column: $table.itemCarbs, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  $$PdfMealSlotsTableAnnotationComposer get mealSlotId {
    final $$PdfMealSlotsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mealSlotId,
      referencedTable: $db.pdfMealSlots,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PdfMealSlotsTableAnnotationComposer(
            $db: $db,
            $table: $db.pdfMealSlots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PdfRecipesTableAnnotationComposer get recipeId {
    final $$PdfRecipesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.pdfRecipes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PdfRecipesTableAnnotationComposer(
            $db: $db,
            $table: $db.pdfRecipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PdfSimpleProductsTableAnnotationComposer get simpleProductId {
    final $$PdfSimpleProductsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.simpleProductId,
          referencedTable: $db.pdfSimpleProducts,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PdfSimpleProductsTableAnnotationComposer(
                $db: $db,
                $table: $db.pdfSimpleProducts,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$PdfMealSlotItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PdfMealSlotItemsTable,
          PdfMealSlotItem,
          $$PdfMealSlotItemsTableFilterComposer,
          $$PdfMealSlotItemsTableOrderingComposer,
          $$PdfMealSlotItemsTableAnnotationComposer,
          $$PdfMealSlotItemsTableCreateCompanionBuilder,
          $$PdfMealSlotItemsTableUpdateCompanionBuilder,
          (PdfMealSlotItem, $$PdfMealSlotItemsTableReferences),
          PdfMealSlotItem,
          PrefetchHooks Function({
            bool mealSlotId,
            bool recipeId,
            bool simpleProductId,
          })
        > {
  $$PdfMealSlotItemsTableTableManager(
    _$AppDatabase db,
    $PdfMealSlotItemsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PdfMealSlotItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PdfMealSlotItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PdfMealSlotItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> mealSlotId = const Value.absent(),
                Value<String> itemType = const Value.absent(),
                Value<int?> recipeId = const Value.absent(),
                Value<int?> simpleProductId = const Value.absent(),
                Value<String> displayName = const Value.absent(),
                Value<double?> servings = const Value.absent(),
                Value<double?> portionFraction = const Value.absent(),
                Value<String?> amountText = const Value.absent(),
                Value<double?> itemKcal = const Value.absent(),
                Value<double?> itemProtein = const Value.absent(),
                Value<double?> itemFat = const Value.absent(),
                Value<double?> itemCarbs = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => PdfMealSlotItemsCompanion(
                id: id,
                mealSlotId: mealSlotId,
                itemType: itemType,
                recipeId: recipeId,
                simpleProductId: simpleProductId,
                displayName: displayName,
                servings: servings,
                portionFraction: portionFraction,
                amountText: amountText,
                itemKcal: itemKcal,
                itemProtein: itemProtein,
                itemFat: itemFat,
                itemCarbs: itemCarbs,
                notes: notes,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int mealSlotId,
                required String itemType,
                Value<int?> recipeId = const Value.absent(),
                Value<int?> simpleProductId = const Value.absent(),
                required String displayName,
                Value<double?> servings = const Value.absent(),
                Value<double?> portionFraction = const Value.absent(),
                Value<String?> amountText = const Value.absent(),
                Value<double?> itemKcal = const Value.absent(),
                Value<double?> itemProtein = const Value.absent(),
                Value<double?> itemFat = const Value.absent(),
                Value<double?> itemCarbs = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => PdfMealSlotItemsCompanion.insert(
                id: id,
                mealSlotId: mealSlotId,
                itemType: itemType,
                recipeId: recipeId,
                simpleProductId: simpleProductId,
                displayName: displayName,
                servings: servings,
                portionFraction: portionFraction,
                amountText: amountText,
                itemKcal: itemKcal,
                itemProtein: itemProtein,
                itemFat: itemFat,
                itemCarbs: itemCarbs,
                notes: notes,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PdfMealSlotItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                mealSlotId = false,
                recipeId = false,
                simpleProductId = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (mealSlotId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.mealSlotId,
                                    referencedTable:
                                        $$PdfMealSlotItemsTableReferences
                                            ._mealSlotIdTable(db),
                                    referencedColumn:
                                        $$PdfMealSlotItemsTableReferences
                                            ._mealSlotIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (recipeId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.recipeId,
                                    referencedTable:
                                        $$PdfMealSlotItemsTableReferences
                                            ._recipeIdTable(db),
                                    referencedColumn:
                                        $$PdfMealSlotItemsTableReferences
                                            ._recipeIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (simpleProductId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.simpleProductId,
                                    referencedTable:
                                        $$PdfMealSlotItemsTableReferences
                                            ._simpleProductIdTable(db),
                                    referencedColumn:
                                        $$PdfMealSlotItemsTableReferences
                                            ._simpleProductIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$PdfMealSlotItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PdfMealSlotItemsTable,
      PdfMealSlotItem,
      $$PdfMealSlotItemsTableFilterComposer,
      $$PdfMealSlotItemsTableOrderingComposer,
      $$PdfMealSlotItemsTableAnnotationComposer,
      $$PdfMealSlotItemsTableCreateCompanionBuilder,
      $$PdfMealSlotItemsTableUpdateCompanionBuilder,
      (PdfMealSlotItem, $$PdfMealSlotItemsTableReferences),
      PdfMealSlotItem,
      PrefetchHooks Function({
        bool mealSlotId,
        bool recipeId,
        bool simpleProductId,
      })
    >;
typedef $$UserProfilesTableCreateCompanionBuilder =
    UserProfilesCompanion Function({
      Value<int> id,
      required String sex,
      required int age,
      required double heightCm,
      required double weightKg,
      required String activity,
      required String goal,
      Value<double?> customKcal,
      Value<DateTime> updatedAt,
    });
typedef $$UserProfilesTableUpdateCompanionBuilder =
    UserProfilesCompanion Function({
      Value<int> id,
      Value<String> sex,
      Value<int> age,
      Value<double> heightCm,
      Value<double> weightKg,
      Value<String> activity,
      Value<String> goal,
      Value<double?> customKcal,
      Value<DateTime> updatedAt,
    });

class $$UserProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableFilterComposer({
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

  ColumnFilters<String> get sex => $composableBuilder(
    column: $table.sex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get age => $composableBuilder(
    column: $table.age,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get heightCm => $composableBuilder(
    column: $table.heightCm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get activity => $composableBuilder(
    column: $table.activity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get goal => $composableBuilder(
    column: $table.goal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get customKcal => $composableBuilder(
    column: $table.customKcal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UserProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableOrderingComposer({
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

  ColumnOrderings<String> get sex => $composableBuilder(
    column: $table.sex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get age => $composableBuilder(
    column: $table.age,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get heightCm => $composableBuilder(
    column: $table.heightCm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get activity => $composableBuilder(
    column: $table.activity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get goal => $composableBuilder(
    column: $table.goal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get customKcal => $composableBuilder(
    column: $table.customKcal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sex =>
      $composableBuilder(column: $table.sex, builder: (column) => column);

  GeneratedColumn<int> get age =>
      $composableBuilder(column: $table.age, builder: (column) => column);

  GeneratedColumn<double> get heightCm =>
      $composableBuilder(column: $table.heightCm, builder: (column) => column);

  GeneratedColumn<double> get weightKg =>
      $composableBuilder(column: $table.weightKg, builder: (column) => column);

  GeneratedColumn<String> get activity =>
      $composableBuilder(column: $table.activity, builder: (column) => column);

  GeneratedColumn<String> get goal =>
      $composableBuilder(column: $table.goal, builder: (column) => column);

  GeneratedColumn<double> get customKcal => $composableBuilder(
    column: $table.customKcal,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$UserProfilesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserProfilesTable,
          ProfileRow,
          $$UserProfilesTableFilterComposer,
          $$UserProfilesTableOrderingComposer,
          $$UserProfilesTableAnnotationComposer,
          $$UserProfilesTableCreateCompanionBuilder,
          $$UserProfilesTableUpdateCompanionBuilder,
          (
            ProfileRow,
            BaseReferences<_$AppDatabase, $UserProfilesTable, ProfileRow>,
          ),
          ProfileRow,
          PrefetchHooks Function()
        > {
  $$UserProfilesTableTableManager(_$AppDatabase db, $UserProfilesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> sex = const Value.absent(),
                Value<int> age = const Value.absent(),
                Value<double> heightCm = const Value.absent(),
                Value<double> weightKg = const Value.absent(),
                Value<String> activity = const Value.absent(),
                Value<String> goal = const Value.absent(),
                Value<double?> customKcal = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => UserProfilesCompanion(
                id: id,
                sex: sex,
                age: age,
                heightCm: heightCm,
                weightKg: weightKg,
                activity: activity,
                goal: goal,
                customKcal: customKcal,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String sex,
                required int age,
                required double heightCm,
                required double weightKg,
                required String activity,
                required String goal,
                Value<double?> customKcal = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => UserProfilesCompanion.insert(
                id: id,
                sex: sex,
                age: age,
                heightCm: heightCm,
                weightKg: weightKg,
                activity: activity,
                goal: goal,
                customKcal: customKcal,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UserProfilesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserProfilesTable,
      ProfileRow,
      $$UserProfilesTableFilterComposer,
      $$UserProfilesTableOrderingComposer,
      $$UserProfilesTableAnnotationComposer,
      $$UserProfilesTableCreateCompanionBuilder,
      $$UserProfilesTableUpdateCompanionBuilder,
      (
        ProfileRow,
        BaseReferences<_$AppDatabase, $UserProfilesTable, ProfileRow>,
      ),
      ProfileRow,
      PrefetchHooks Function()
    >;
typedef $$LoggedMealsTableCreateCompanionBuilder =
    LoggedMealsCompanion Function({
      Value<int> id,
      required String dayKey,
      required String mealType,
      Value<String?> recipeKey,
      required String title,
      Value<String?> portionLabel,
      required double kcal,
      required double protein,
      required double fat,
      required double carbs,
      Value<DateTime> createdAt,
    });
typedef $$LoggedMealsTableUpdateCompanionBuilder =
    LoggedMealsCompanion Function({
      Value<int> id,
      Value<String> dayKey,
      Value<String> mealType,
      Value<String?> recipeKey,
      Value<String> title,
      Value<String?> portionLabel,
      Value<double> kcal,
      Value<double> protein,
      Value<double> fat,
      Value<double> carbs,
      Value<DateTime> createdAt,
    });

class $$LoggedMealsTableFilterComposer
    extends Composer<_$AppDatabase, $LoggedMealsTable> {
  $$LoggedMealsTableFilterComposer({
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

  ColumnFilters<String> get dayKey => $composableBuilder(
    column: $table.dayKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mealType => $composableBuilder(
    column: $table.mealType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get recipeKey => $composableBuilder(
    column: $table.recipeKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get portionLabel => $composableBuilder(
    column: $table.portionLabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get kcal => $composableBuilder(
    column: $table.kcal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get protein => $composableBuilder(
    column: $table.protein,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fat => $composableBuilder(
    column: $table.fat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get carbs => $composableBuilder(
    column: $table.carbs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LoggedMealsTableOrderingComposer
    extends Composer<_$AppDatabase, $LoggedMealsTable> {
  $$LoggedMealsTableOrderingComposer({
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

  ColumnOrderings<String> get dayKey => $composableBuilder(
    column: $table.dayKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mealType => $composableBuilder(
    column: $table.mealType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recipeKey => $composableBuilder(
    column: $table.recipeKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get portionLabel => $composableBuilder(
    column: $table.portionLabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get kcal => $composableBuilder(
    column: $table.kcal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get protein => $composableBuilder(
    column: $table.protein,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fat => $composableBuilder(
    column: $table.fat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get carbs => $composableBuilder(
    column: $table.carbs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LoggedMealsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LoggedMealsTable> {
  $$LoggedMealsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get dayKey =>
      $composableBuilder(column: $table.dayKey, builder: (column) => column);

  GeneratedColumn<String> get mealType =>
      $composableBuilder(column: $table.mealType, builder: (column) => column);

  GeneratedColumn<String> get recipeKey =>
      $composableBuilder(column: $table.recipeKey, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get portionLabel => $composableBuilder(
    column: $table.portionLabel,
    builder: (column) => column,
  );

  GeneratedColumn<double> get kcal =>
      $composableBuilder(column: $table.kcal, builder: (column) => column);

  GeneratedColumn<double> get protein =>
      $composableBuilder(column: $table.protein, builder: (column) => column);

  GeneratedColumn<double> get fat =>
      $composableBuilder(column: $table.fat, builder: (column) => column);

  GeneratedColumn<double> get carbs =>
      $composableBuilder(column: $table.carbs, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$LoggedMealsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LoggedMealsTable,
          LoggedMealRow,
          $$LoggedMealsTableFilterComposer,
          $$LoggedMealsTableOrderingComposer,
          $$LoggedMealsTableAnnotationComposer,
          $$LoggedMealsTableCreateCompanionBuilder,
          $$LoggedMealsTableUpdateCompanionBuilder,
          (
            LoggedMealRow,
            BaseReferences<_$AppDatabase, $LoggedMealsTable, LoggedMealRow>,
          ),
          LoggedMealRow,
          PrefetchHooks Function()
        > {
  $$LoggedMealsTableTableManager(_$AppDatabase db, $LoggedMealsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LoggedMealsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LoggedMealsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LoggedMealsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> dayKey = const Value.absent(),
                Value<String> mealType = const Value.absent(),
                Value<String?> recipeKey = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> portionLabel = const Value.absent(),
                Value<double> kcal = const Value.absent(),
                Value<double> protein = const Value.absent(),
                Value<double> fat = const Value.absent(),
                Value<double> carbs = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => LoggedMealsCompanion(
                id: id,
                dayKey: dayKey,
                mealType: mealType,
                recipeKey: recipeKey,
                title: title,
                portionLabel: portionLabel,
                kcal: kcal,
                protein: protein,
                fat: fat,
                carbs: carbs,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String dayKey,
                required String mealType,
                Value<String?> recipeKey = const Value.absent(),
                required String title,
                Value<String?> portionLabel = const Value.absent(),
                required double kcal,
                required double protein,
                required double fat,
                required double carbs,
                Value<DateTime> createdAt = const Value.absent(),
              }) => LoggedMealsCompanion.insert(
                id: id,
                dayKey: dayKey,
                mealType: mealType,
                recipeKey: recipeKey,
                title: title,
                portionLabel: portionLabel,
                kcal: kcal,
                protein: protein,
                fat: fat,
                carbs: carbs,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LoggedMealsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LoggedMealsTable,
      LoggedMealRow,
      $$LoggedMealsTableFilterComposer,
      $$LoggedMealsTableOrderingComposer,
      $$LoggedMealsTableAnnotationComposer,
      $$LoggedMealsTableCreateCompanionBuilder,
      $$LoggedMealsTableUpdateCompanionBuilder,
      (
        LoggedMealRow,
        BaseReferences<_$AppDatabase, $LoggedMealsTable, LoggedMealRow>,
      ),
      LoggedMealRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$FoodItemsTableTableManager get foodItems =>
      $$FoodItemsTableTableManager(_db, _db.foodItems);
  $$NutrientsTableTableManager get nutrients =>
      $$NutrientsTableTableManager(_db, _db.nutrients);
  $$ProductsTableTableManager get products =>
      $$ProductsTableTableManager(_db, _db.products);
  $$ProductNutrientValuesTableTableManager get productNutrientValues =>
      $$ProductNutrientValuesTableTableManager(_db, _db.productNutrientValues);
  $$FormulaDefinitionsTableTableManager get formulaDefinitions =>
      $$FormulaDefinitionsTableTableManager(_db, _db.formulaDefinitions);
  $$ActivityLevelsTableTableManager get activityLevels =>
      $$ActivityLevelsTableTableManager(_db, _db.activityLevels);
  $$MacroNormTemplatesTableTableManager get macroNormTemplates =>
      $$MacroNormTemplatesTableTableManager(_db, _db.macroNormTemplates);
  $$CalorieDeficitPoliciesTableTableManager get calorieDeficitPolicies =>
      $$CalorieDeficitPoliciesTableTableManager(
        _db,
        _db.calorieDeficitPolicies,
      );
  $$CookingYieldFactorsTableTableManager get cookingYieldFactors =>
      $$CookingYieldFactorsTableTableManager(_db, _db.cookingYieldFactors);
  $$AdvisoryRulesTableTableManager get advisoryRules =>
      $$AdvisoryRulesTableTableManager(_db, _db.advisoryRules);
  $$MealPlanTemplatesTableTableManager get mealPlanTemplates =>
      $$MealPlanTemplatesTableTableManager(_db, _db.mealPlanTemplates);
  $$MealPlanMealsTableTableManager get mealPlanMeals =>
      $$MealPlanMealsTableTableManager(_db, _db.mealPlanMeals);
  $$MealPlanLinesTableTableManager get mealPlanLines =>
      $$MealPlanLinesTableTableManager(_db, _db.mealPlanLines);
  $$PdfMealPlansTableTableManager get pdfMealPlans =>
      $$PdfMealPlansTableTableManager(_db, _db.pdfMealPlans);
  $$PdfMealPlanDaysTableTableManager get pdfMealPlanDays =>
      $$PdfMealPlanDaysTableTableManager(_db, _db.pdfMealPlanDays);
  $$PdfRecipesTableTableManager get pdfRecipes =>
      $$PdfRecipesTableTableManager(_db, _db.pdfRecipes);
  $$PdfSimpleProductsTableTableManager get pdfSimpleProducts =>
      $$PdfSimpleProductsTableTableManager(_db, _db.pdfSimpleProducts);
  $$PdfMediaAssetsTableTableManager get pdfMediaAssets =>
      $$PdfMediaAssetsTableTableManager(_db, _db.pdfMediaAssets);
  $$PdfMealSlotsTableTableManager get pdfMealSlots =>
      $$PdfMealSlotsTableTableManager(_db, _db.pdfMealSlots);
  $$PdfRecipeIngredientsTableTableManager get pdfRecipeIngredients =>
      $$PdfRecipeIngredientsTableTableManager(_db, _db.pdfRecipeIngredients);
  $$PdfRecipeStepsTableTableManager get pdfRecipeSteps =>
      $$PdfRecipeStepsTableTableManager(_db, _db.pdfRecipeSteps);
  $$PdfRecipeNutritionTableTableManager get pdfRecipeNutrition =>
      $$PdfRecipeNutritionTableTableManager(_db, _db.pdfRecipeNutrition);
  $$PdfRecipeMediaTableTableManager get pdfRecipeMedia =>
      $$PdfRecipeMediaTableTableManager(_db, _db.pdfRecipeMedia);
  $$PdfSimpleProductNutritionTableTableManager get pdfSimpleProductNutrition =>
      $$PdfSimpleProductNutritionTableTableManager(
        _db,
        _db.pdfSimpleProductNutrition,
      );
  $$PdfMealSlotItemsTableTableManager get pdfMealSlotItems =>
      $$PdfMealSlotItemsTableTableManager(_db, _db.pdfMealSlotItems);
  $$UserProfilesTableTableManager get userProfiles =>
      $$UserProfilesTableTableManager(_db, _db.userProfiles);
  $$LoggedMealsTableTableManager get loggedMeals =>
      $$LoggedMealsTableTableManager(_db, _db.loggedMeals);
}
