// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_database.dart';

// ignore_for_file: type=lint
class $HabitsTable extends Habits with TableInfo<$HabitsTable, Habit> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HabitsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _lastTimeCompletedMeta =
      const VerificationMeta('lastTimeCompleted');
  @override
  late final GeneratedColumn<DateTime> lastTimeCompleted =
      GeneratedColumn<DateTime>('last_time_completed', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  static const VerificationMeta _categoryIdMeta =
      const VerificationMeta('categoryId');
  @override
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
      'category_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _isPendingSyncMeta =
      const VerificationMeta('isPendingSync');
  @override
  late final GeneratedColumn<bool> isPendingSync = GeneratedColumn<bool>(
      'is_pending_sync', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_pending_sync" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _stepsMeta = const VerificationMeta('steps');
  @override
  late final GeneratedColumn<int> steps = GeneratedColumn<int>(
      'steps', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _syncStatusMeta =
      const VerificationMeta('syncStatus');
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
      'sync_status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('add'));
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
      'icon', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        description,
        lastTimeCompleted,
        createdAt,
        updatedAt,
        categoryId,
        isPendingSync,
        steps,
        isActive,
        syncStatus,
        icon
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'habits';
  @override
  VerificationContext validateIntegrity(Insertable<Habit> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('last_time_completed')) {
      context.handle(
          _lastTimeCompletedMeta,
          lastTimeCompleted.isAcceptableOrUnknown(
              data['last_time_completed']!, _lastTimeCompletedMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('category_id')) {
      context.handle(
          _categoryIdMeta,
          categoryId.isAcceptableOrUnknown(
              data['category_id']!, _categoryIdMeta));
    }
    if (data.containsKey('is_pending_sync')) {
      context.handle(
          _isPendingSyncMeta,
          isPendingSync.isAcceptableOrUnknown(
              data['is_pending_sync']!, _isPendingSyncMeta));
    }
    if (data.containsKey('steps')) {
      context.handle(
          _stepsMeta, steps.isAcceptableOrUnknown(data['steps']!, _stepsMeta));
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    if (data.containsKey('sync_status')) {
      context.handle(
          _syncStatusMeta,
          syncStatus.isAcceptableOrUnknown(
              data['sync_status']!, _syncStatusMeta));
    }
    if (data.containsKey('icon')) {
      context.handle(
          _iconMeta, icon.isAcceptableOrUnknown(data['icon']!, _iconMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Habit map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Habit(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      lastTimeCompleted: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_time_completed']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      categoryId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}category_id'])!,
      isPendingSync: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_pending_sync'])!,
      steps: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}steps'])!,
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
      syncStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_status'])!,
      icon: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}icon'])!,
    );
  }

  @override
  $HabitsTable createAlias(String alias) {
    return $HabitsTable(attachedDatabase, alias);
  }
}

class Habit extends DataClass implements Insertable<Habit> {
  final String id;
  final String title;
  final String? description;
  final DateTime? lastTimeCompleted;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int categoryId;
  final bool isPendingSync;
  final int steps;
  final bool isActive;
  final String syncStatus;
  final String icon;
  const Habit(
      {required this.id,
      required this.title,
      this.description,
      this.lastTimeCompleted,
      required this.createdAt,
      required this.updatedAt,
      required this.categoryId,
      required this.isPendingSync,
      required this.steps,
      required this.isActive,
      required this.syncStatus,
      required this.icon});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || lastTimeCompleted != null) {
      map['last_time_completed'] = Variable<DateTime>(lastTimeCompleted);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['category_id'] = Variable<int>(categoryId);
    map['is_pending_sync'] = Variable<bool>(isPendingSync);
    map['steps'] = Variable<int>(steps);
    map['is_active'] = Variable<bool>(isActive);
    map['sync_status'] = Variable<String>(syncStatus);
    map['icon'] = Variable<String>(icon);
    return map;
  }

  HabitsCompanion toCompanion(bool nullToAbsent) {
    return HabitsCompanion(
      id: Value(id),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      lastTimeCompleted: lastTimeCompleted == null && nullToAbsent
          ? const Value.absent()
          : Value(lastTimeCompleted),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      categoryId: Value(categoryId),
      isPendingSync: Value(isPendingSync),
      steps: Value(steps),
      isActive: Value(isActive),
      syncStatus: Value(syncStatus),
      icon: Value(icon),
    );
  }

  factory Habit.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Habit(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      lastTimeCompleted:
          serializer.fromJson<DateTime?>(json['lastTimeCompleted']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      categoryId: serializer.fromJson<int>(json['categoryId']),
      isPendingSync: serializer.fromJson<bool>(json['isPendingSync']),
      steps: serializer.fromJson<int>(json['steps']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      icon: serializer.fromJson<String>(json['icon']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'lastTimeCompleted': serializer.toJson<DateTime?>(lastTimeCompleted),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'categoryId': serializer.toJson<int>(categoryId),
      'isPendingSync': serializer.toJson<bool>(isPendingSync),
      'steps': serializer.toJson<int>(steps),
      'isActive': serializer.toJson<bool>(isActive),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'icon': serializer.toJson<String>(icon),
    };
  }

  Habit copyWith(
          {String? id,
          String? title,
          Value<String?> description = const Value.absent(),
          Value<DateTime?> lastTimeCompleted = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt,
          int? categoryId,
          bool? isPendingSync,
          int? steps,
          bool? isActive,
          String? syncStatus,
          String? icon}) =>
      Habit(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description.present ? description.value : this.description,
        lastTimeCompleted: lastTimeCompleted.present
            ? lastTimeCompleted.value
            : this.lastTimeCompleted,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        categoryId: categoryId ?? this.categoryId,
        isPendingSync: isPendingSync ?? this.isPendingSync,
        steps: steps ?? this.steps,
        isActive: isActive ?? this.isActive,
        syncStatus: syncStatus ?? this.syncStatus,
        icon: icon ?? this.icon,
      );
  Habit copyWithCompanion(HabitsCompanion data) {
    return Habit(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description:
          data.description.present ? data.description.value : this.description,
      lastTimeCompleted: data.lastTimeCompleted.present
          ? data.lastTimeCompleted.value
          : this.lastTimeCompleted,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      categoryId:
          data.categoryId.present ? data.categoryId.value : this.categoryId,
      isPendingSync: data.isPendingSync.present
          ? data.isPendingSync.value
          : this.isPendingSync,
      steps: data.steps.present ? data.steps.value : this.steps,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      syncStatus:
          data.syncStatus.present ? data.syncStatus.value : this.syncStatus,
      icon: data.icon.present ? data.icon.value : this.icon,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Habit(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('lastTimeCompleted: $lastTimeCompleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('categoryId: $categoryId, ')
          ..write('isPendingSync: $isPendingSync, ')
          ..write('steps: $steps, ')
          ..write('isActive: $isActive, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('icon: $icon')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      title,
      description,
      lastTimeCompleted,
      createdAt,
      updatedAt,
      categoryId,
      isPendingSync,
      steps,
      isActive,
      syncStatus,
      icon);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Habit &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.lastTimeCompleted == this.lastTimeCompleted &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.categoryId == this.categoryId &&
          other.isPendingSync == this.isPendingSync &&
          other.steps == this.steps &&
          other.isActive == this.isActive &&
          other.syncStatus == this.syncStatus &&
          other.icon == this.icon);
}

class HabitsCompanion extends UpdateCompanion<Habit> {
  final Value<String> id;
  final Value<String> title;
  final Value<String?> description;
  final Value<DateTime?> lastTimeCompleted;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> categoryId;
  final Value<bool> isPendingSync;
  final Value<int> steps;
  final Value<bool> isActive;
  final Value<String> syncStatus;
  final Value<String> icon;
  final Value<int> rowid;
  const HabitsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.lastTimeCompleted = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.isPendingSync = const Value.absent(),
    this.steps = const Value.absent(),
    this.isActive = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.icon = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HabitsCompanion.insert({
    required String id,
    required String title,
    this.description = const Value.absent(),
    this.lastTimeCompleted = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.isPendingSync = const Value.absent(),
    this.steps = const Value.absent(),
    this.isActive = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.icon = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        title = Value(title);
  static Insertable<Habit> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<DateTime>? lastTimeCompleted,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? categoryId,
    Expression<bool>? isPendingSync,
    Expression<int>? steps,
    Expression<bool>? isActive,
    Expression<String>? syncStatus,
    Expression<String>? icon,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (lastTimeCompleted != null) 'last_time_completed': lastTimeCompleted,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (categoryId != null) 'category_id': categoryId,
      if (isPendingSync != null) 'is_pending_sync': isPendingSync,
      if (steps != null) 'steps': steps,
      if (isActive != null) 'is_active': isActive,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (icon != null) 'icon': icon,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HabitsCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<String?>? description,
      Value<DateTime?>? lastTimeCompleted,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? categoryId,
      Value<bool>? isPendingSync,
      Value<int>? steps,
      Value<bool>? isActive,
      Value<String>? syncStatus,
      Value<String>? icon,
      Value<int>? rowid}) {
    return HabitsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      lastTimeCompleted: lastTimeCompleted ?? this.lastTimeCompleted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      categoryId: categoryId ?? this.categoryId,
      isPendingSync: isPendingSync ?? this.isPendingSync,
      steps: steps ?? this.steps,
      isActive: isActive ?? this.isActive,
      syncStatus: syncStatus ?? this.syncStatus,
      icon: icon ?? this.icon,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (lastTimeCompleted.present) {
      map['last_time_completed'] = Variable<DateTime>(lastTimeCompleted.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (isPendingSync.present) {
      map['is_pending_sync'] = Variable<bool>(isPendingSync.value);
    }
    if (steps.present) {
      map['steps'] = Variable<int>(steps.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HabitsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('lastTimeCompleted: $lastTimeCompleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('categoryId: $categoryId, ')
          ..write('isPendingSync: $isPendingSync, ')
          ..write('steps: $steps, ')
          ..write('isActive: $isActive, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('icon: $icon, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $HabitsTable habits = $HabitsTable(this);
  late final HabitsDao habitsDao = HabitsDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [habits];
}

typedef $$HabitsTableCreateCompanionBuilder = HabitsCompanion Function({
  required String id,
  required String title,
  Value<String?> description,
  Value<DateTime?> lastTimeCompleted,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> categoryId,
  Value<bool> isPendingSync,
  Value<int> steps,
  Value<bool> isActive,
  Value<String> syncStatus,
  Value<String> icon,
  Value<int> rowid,
});
typedef $$HabitsTableUpdateCompanionBuilder = HabitsCompanion Function({
  Value<String> id,
  Value<String> title,
  Value<String?> description,
  Value<DateTime?> lastTimeCompleted,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> categoryId,
  Value<bool> isPendingSync,
  Value<int> steps,
  Value<bool> isActive,
  Value<String> syncStatus,
  Value<String> icon,
  Value<int> rowid,
});

class $$HabitsTableFilterComposer
    extends Composer<_$AppDatabase, $HabitsTable> {
  $$HabitsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastTimeCompleted => $composableBuilder(
      column: $table.lastTimeCompleted,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get categoryId => $composableBuilder(
      column: $table.categoryId, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isPendingSync => $composableBuilder(
      column: $table.isPendingSync, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get steps => $composableBuilder(
      column: $table.steps, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get icon => $composableBuilder(
      column: $table.icon, builder: (column) => ColumnFilters(column));
}

class $$HabitsTableOrderingComposer
    extends Composer<_$AppDatabase, $HabitsTable> {
  $$HabitsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastTimeCompleted => $composableBuilder(
      column: $table.lastTimeCompleted,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get categoryId => $composableBuilder(
      column: $table.categoryId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isPendingSync => $composableBuilder(
      column: $table.isPendingSync,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get steps => $composableBuilder(
      column: $table.steps, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get icon => $composableBuilder(
      column: $table.icon, builder: (column) => ColumnOrderings(column));
}

class $$HabitsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HabitsTable> {
  $$HabitsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<DateTime> get lastTimeCompleted => $composableBuilder(
      column: $table.lastTimeCompleted, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get categoryId => $composableBuilder(
      column: $table.categoryId, builder: (column) => column);

  GeneratedColumn<bool> get isPendingSync => $composableBuilder(
      column: $table.isPendingSync, builder: (column) => column);

  GeneratedColumn<int> get steps =>
      $composableBuilder(column: $table.steps, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => column);

  GeneratedColumn<String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);
}

class $$HabitsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $HabitsTable,
    Habit,
    $$HabitsTableFilterComposer,
    $$HabitsTableOrderingComposer,
    $$HabitsTableAnnotationComposer,
    $$HabitsTableCreateCompanionBuilder,
    $$HabitsTableUpdateCompanionBuilder,
    (Habit, BaseReferences<_$AppDatabase, $HabitsTable, Habit>),
    Habit,
    PrefetchHooks Function()> {
  $$HabitsTableTableManager(_$AppDatabase db, $HabitsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HabitsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HabitsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HabitsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<DateTime?> lastTimeCompleted = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> categoryId = const Value.absent(),
            Value<bool> isPendingSync = const Value.absent(),
            Value<int> steps = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<String> syncStatus = const Value.absent(),
            Value<String> icon = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              HabitsCompanion(
            id: id,
            title: title,
            description: description,
            lastTimeCompleted: lastTimeCompleted,
            createdAt: createdAt,
            updatedAt: updatedAt,
            categoryId: categoryId,
            isPendingSync: isPendingSync,
            steps: steps,
            isActive: isActive,
            syncStatus: syncStatus,
            icon: icon,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String title,
            Value<String?> description = const Value.absent(),
            Value<DateTime?> lastTimeCompleted = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> categoryId = const Value.absent(),
            Value<bool> isPendingSync = const Value.absent(),
            Value<int> steps = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<String> syncStatus = const Value.absent(),
            Value<String> icon = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              HabitsCompanion.insert(
            id: id,
            title: title,
            description: description,
            lastTimeCompleted: lastTimeCompleted,
            createdAt: createdAt,
            updatedAt: updatedAt,
            categoryId: categoryId,
            isPendingSync: isPendingSync,
            steps: steps,
            isActive: isActive,
            syncStatus: syncStatus,
            icon: icon,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$HabitsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $HabitsTable,
    Habit,
    $$HabitsTableFilterComposer,
    $$HabitsTableOrderingComposer,
    $$HabitsTableAnnotationComposer,
    $$HabitsTableCreateCompanionBuilder,
    $$HabitsTableUpdateCompanionBuilder,
    (Habit, BaseReferences<_$AppDatabase, $HabitsTable, Habit>),
    Habit,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$HabitsTableTableManager get habits =>
      $$HabitsTableTableManager(_db, _db.habits);
}
