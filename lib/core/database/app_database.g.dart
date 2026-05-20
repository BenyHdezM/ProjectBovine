// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $RazasTable extends Razas with TableInfo<$RazasTable, Raza> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RazasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
      'nombre', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  @override
  List<GeneratedColumn> get $columns => [id, nombre];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'razas';
  @override
  VerificationContext validateIntegrity(Insertable<Raza> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nombre')) {
      context.handle(_nombreMeta,
          nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta));
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Raza map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Raza(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      nombre: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nombre'])!,
    );
  }

  @override
  $RazasTable createAlias(String alias) {
    return $RazasTable(attachedDatabase, alias);
  }
}

class Raza extends DataClass implements Insertable<Raza> {
  final int id;
  final String nombre;
  const Raza({required this.id, required this.nombre});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nombre'] = Variable<String>(nombre);
    return map;
  }

  RazasCompanion toCompanion(bool nullToAbsent) {
    return RazasCompanion(
      id: Value(id),
      nombre: Value(nombre),
    );
  }

  factory Raza.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Raza(
      id: serializer.fromJson<int>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nombre': serializer.toJson<String>(nombre),
    };
  }

  Raza copyWith({int? id, String? nombre}) => Raza(
        id: id ?? this.id,
        nombre: nombre ?? this.nombre,
      );
  Raza copyWithCompanion(RazasCompanion data) {
    return Raza(
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Raza(')
          ..write('id: $id, ')
          ..write('nombre: $nombre')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nombre);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Raza && other.id == this.id && other.nombre == this.nombre);
}

class RazasCompanion extends UpdateCompanion<Raza> {
  final Value<int> id;
  final Value<String> nombre;
  const RazasCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
  });
  RazasCompanion.insert({
    this.id = const Value.absent(),
    required String nombre,
  }) : nombre = Value(nombre);
  static Insertable<Raza> custom({
    Expression<int>? id,
    Expression<String>? nombre,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
    });
  }

  RazasCompanion copyWith({Value<int>? id, Value<String>? nombre}) {
    return RazasCompanion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RazasCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre')
          ..write(')'))
        .toString();
  }
}

class $LotesTable extends Lotes with TableInfo<$LotesTable, Lote> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LotesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _claveMeta = const VerificationMeta('clave');
  @override
  late final GeneratedColumn<String> clave = GeneratedColumn<String>(
      'clave', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL UNIQUE');
  static const VerificationMeta _descripcionMeta =
      const VerificationMeta('descripcion');
  @override
  late final GeneratedColumn<String> descripcion = GeneratedColumn<String>(
      'descripcion', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, clave, descripcion];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'lotes';
  @override
  VerificationContext validateIntegrity(Insertable<Lote> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('clave')) {
      context.handle(
          _claveMeta, clave.isAcceptableOrUnknown(data['clave']!, _claveMeta));
    } else if (isInserting) {
      context.missing(_claveMeta);
    }
    if (data.containsKey('descripcion')) {
      context.handle(
          _descripcionMeta,
          descripcion.isAcceptableOrUnknown(
              data['descripcion']!, _descripcionMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Lote map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Lote(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      clave: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}clave'])!,
      descripcion: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}descripcion']),
    );
  }

  @override
  $LotesTable createAlias(String alias) {
    return $LotesTable(attachedDatabase, alias);
  }
}

class Lote extends DataClass implements Insertable<Lote> {
  final int id;
  final String clave;
  final String? descripcion;
  const Lote({required this.id, required this.clave, this.descripcion});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['clave'] = Variable<String>(clave);
    if (!nullToAbsent || descripcion != null) {
      map['descripcion'] = Variable<String>(descripcion);
    }
    return map;
  }

  LotesCompanion toCompanion(bool nullToAbsent) {
    return LotesCompanion(
      id: Value(id),
      clave: Value(clave),
      descripcion: descripcion == null && nullToAbsent
          ? const Value.absent()
          : Value(descripcion),
    );
  }

  factory Lote.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Lote(
      id: serializer.fromJson<int>(json['id']),
      clave: serializer.fromJson<String>(json['clave']),
      descripcion: serializer.fromJson<String?>(json['descripcion']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'clave': serializer.toJson<String>(clave),
      'descripcion': serializer.toJson<String?>(descripcion),
    };
  }

  Lote copyWith(
          {int? id,
          String? clave,
          Value<String?> descripcion = const Value.absent()}) =>
      Lote(
        id: id ?? this.id,
        clave: clave ?? this.clave,
        descripcion: descripcion.present ? descripcion.value : this.descripcion,
      );
  Lote copyWithCompanion(LotesCompanion data) {
    return Lote(
      id: data.id.present ? data.id.value : this.id,
      clave: data.clave.present ? data.clave.value : this.clave,
      descripcion:
          data.descripcion.present ? data.descripcion.value : this.descripcion,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Lote(')
          ..write('id: $id, ')
          ..write('clave: $clave, ')
          ..write('descripcion: $descripcion')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, clave, descripcion);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Lote &&
          other.id == this.id &&
          other.clave == this.clave &&
          other.descripcion == this.descripcion);
}

class LotesCompanion extends UpdateCompanion<Lote> {
  final Value<int> id;
  final Value<String> clave;
  final Value<String?> descripcion;
  const LotesCompanion({
    this.id = const Value.absent(),
    this.clave = const Value.absent(),
    this.descripcion = const Value.absent(),
  });
  LotesCompanion.insert({
    this.id = const Value.absent(),
    required String clave,
    this.descripcion = const Value.absent(),
  }) : clave = Value(clave);
  static Insertable<Lote> custom({
    Expression<int>? id,
    Expression<String>? clave,
    Expression<String>? descripcion,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (clave != null) 'clave': clave,
      if (descripcion != null) 'descripcion': descripcion,
    });
  }

  LotesCompanion copyWith(
      {Value<int>? id, Value<String>? clave, Value<String?>? descripcion}) {
    return LotesCompanion(
      id: id ?? this.id,
      clave: clave ?? this.clave,
      descripcion: descripcion ?? this.descripcion,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (clave.present) {
      map['clave'] = Variable<String>(clave.value);
    }
    if (descripcion.present) {
      map['descripcion'] = Variable<String>(descripcion.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LotesCompanion(')
          ..write('id: $id, ')
          ..write('clave: $clave, ')
          ..write('descripcion: $descripcion')
          ..write(')'))
        .toString();
  }
}

class $DuenosTable extends Duenos with TableInfo<$DuenosTable, Dueno> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DuenosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
      'nombre', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 200),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _telefonoMeta =
      const VerificationMeta('telefono');
  @override
  late final GeneratedColumn<String> telefono = GeneratedColumn<String>(
      'telefono', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [id, nombre, telefono, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'duenos';
  @override
  VerificationContext validateIntegrity(Insertable<Dueno> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nombre')) {
      context.handle(_nombreMeta,
          nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta));
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('telefono')) {
      context.handle(_telefonoMeta,
          telefono.isAcceptableOrUnknown(data['telefono']!, _telefonoMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Dueno map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Dueno(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      nombre: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nombre'])!,
      telefono: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}telefono']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $DuenosTable createAlias(String alias) {
    return $DuenosTable(attachedDatabase, alias);
  }
}

class Dueno extends DataClass implements Insertable<Dueno> {
  final int id;
  final String nombre;
  final String? telefono;
  final DateTime createdAt;
  const Dueno(
      {required this.id,
      required this.nombre,
      this.telefono,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nombre'] = Variable<String>(nombre);
    if (!nullToAbsent || telefono != null) {
      map['telefono'] = Variable<String>(telefono);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  DuenosCompanion toCompanion(bool nullToAbsent) {
    return DuenosCompanion(
      id: Value(id),
      nombre: Value(nombre),
      telefono: telefono == null && nullToAbsent
          ? const Value.absent()
          : Value(telefono),
      createdAt: Value(createdAt),
    );
  }

  factory Dueno.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Dueno(
      id: serializer.fromJson<int>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
      telefono: serializer.fromJson<String?>(json['telefono']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nombre': serializer.toJson<String>(nombre),
      'telefono': serializer.toJson<String?>(telefono),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Dueno copyWith(
          {int? id,
          String? nombre,
          Value<String?> telefono = const Value.absent(),
          DateTime? createdAt}) =>
      Dueno(
        id: id ?? this.id,
        nombre: nombre ?? this.nombre,
        telefono: telefono.present ? telefono.value : this.telefono,
        createdAt: createdAt ?? this.createdAt,
      );
  Dueno copyWithCompanion(DuenosCompanion data) {
    return Dueno(
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      telefono: data.telefono.present ? data.telefono.value : this.telefono,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Dueno(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('telefono: $telefono, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nombre, telefono, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Dueno &&
          other.id == this.id &&
          other.nombre == this.nombre &&
          other.telefono == this.telefono &&
          other.createdAt == this.createdAt);
}

class DuenosCompanion extends UpdateCompanion<Dueno> {
  final Value<int> id;
  final Value<String> nombre;
  final Value<String?> telefono;
  final Value<DateTime> createdAt;
  const DuenosCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.telefono = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  DuenosCompanion.insert({
    this.id = const Value.absent(),
    required String nombre,
    this.telefono = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : nombre = Value(nombre);
  static Insertable<Dueno> custom({
    Expression<int>? id,
    Expression<String>? nombre,
    Expression<String>? telefono,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
      if (telefono != null) 'telefono': telefono,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  DuenosCompanion copyWith(
      {Value<int>? id,
      Value<String>? nombre,
      Value<String?>? telefono,
      Value<DateTime>? createdAt}) {
    return DuenosCompanion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      telefono: telefono ?? this.telefono,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (telefono.present) {
      map['telefono'] = Variable<String>(telefono.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DuenosCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('telefono: $telefono, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $BovinosTable extends Bovinos with TableInfo<$BovinosTable, Bovino> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BovinosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _areteIdMeta =
      const VerificationMeta('areteId');
  @override
  late final GeneratedColumn<String> areteId = GeneratedColumn<String>(
      'arete_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _numRegistroMeta =
      const VerificationMeta('numRegistro');
  @override
  late final GeneratedColumn<String> numRegistro = GeneratedColumn<String>(
      'num_registro', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
      'nombre', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _sexoMeta = const VerificationMeta('sexo');
  @override
  late final GeneratedColumn<String> sexo = GeneratedColumn<String>(
      'sexo', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL CHECK(sexo IN (\'M\',\'H\'))');
  static const VerificationMeta _fechaNacimientoMeta =
      const VerificationMeta('fechaNacimiento');
  @override
  late final GeneratedColumn<DateTime> fechaNacimiento =
      GeneratedColumn<DateTime>('fecha_nacimiento', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _fechaMuerteMeta =
      const VerificationMeta('fechaMuerte');
  @override
  late final GeneratedColumn<DateTime> fechaMuerte = GeneratedColumn<DateTime>(
      'fecha_muerte', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _loteIdMeta = const VerificationMeta('loteId');
  @override
  late final GeneratedColumn<int> loteId = GeneratedColumn<int>(
      'lote_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES lotes (id)'));
  static const VerificationMeta _uppMeta = const VerificationMeta('upp');
  @override
  late final GeneratedColumn<String> upp = GeneratedColumn<String>(
      'upp', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _razaIdMeta = const VerificationMeta('razaId');
  @override
  late final GeneratedColumn<int> razaId = GeneratedColumn<int>(
      'raza_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES razas (id)'));
  static const VerificationMeta _estadoMeta = const VerificationMeta('estado');
  @override
  late final GeneratedColumn<String> estado = GeneratedColumn<String>(
      'estado', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints:
          'NOT NULL DEFAULT \'activo\' CHECK(estado IN (\'activo\',\'vendido\',\'muerto\'))',
      defaultValue: const CustomExpression('\'activo\''));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        areteId,
        numRegistro,
        nombre,
        sexo,
        fechaNacimiento,
        fechaMuerte,
        loteId,
        upp,
        razaId,
        estado,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bovinos';
  @override
  VerificationContext validateIntegrity(Insertable<Bovino> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('arete_id')) {
      context.handle(_areteIdMeta,
          areteId.isAcceptableOrUnknown(data['arete_id']!, _areteIdMeta));
    } else if (isInserting) {
      context.missing(_areteIdMeta);
    }
    if (data.containsKey('num_registro')) {
      context.handle(
          _numRegistroMeta,
          numRegistro.isAcceptableOrUnknown(
              data['num_registro']!, _numRegistroMeta));
    }
    if (data.containsKey('nombre')) {
      context.handle(_nombreMeta,
          nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta));
    }
    if (data.containsKey('sexo')) {
      context.handle(
          _sexoMeta, sexo.isAcceptableOrUnknown(data['sexo']!, _sexoMeta));
    } else if (isInserting) {
      context.missing(_sexoMeta);
    }
    if (data.containsKey('fecha_nacimiento')) {
      context.handle(
          _fechaNacimientoMeta,
          fechaNacimiento.isAcceptableOrUnknown(
              data['fecha_nacimiento']!, _fechaNacimientoMeta));
    }
    if (data.containsKey('fecha_muerte')) {
      context.handle(
          _fechaMuerteMeta,
          fechaMuerte.isAcceptableOrUnknown(
              data['fecha_muerte']!, _fechaMuerteMeta));
    }
    if (data.containsKey('lote_id')) {
      context.handle(_loteIdMeta,
          loteId.isAcceptableOrUnknown(data['lote_id']!, _loteIdMeta));
    }
    if (data.containsKey('upp')) {
      context.handle(
          _uppMeta, upp.isAcceptableOrUnknown(data['upp']!, _uppMeta));
    }
    if (data.containsKey('raza_id')) {
      context.handle(_razaIdMeta,
          razaId.isAcceptableOrUnknown(data['raza_id']!, _razaIdMeta));
    }
    if (data.containsKey('estado')) {
      context.handle(_estadoMeta,
          estado.isAcceptableOrUnknown(data['estado']!, _estadoMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {nombre},
      ];
  @override
  Bovino map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Bovino(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      areteId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}arete_id'])!,
      numRegistro: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}num_registro']),
      nombre: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nombre']),
      sexo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sexo'])!,
      fechaNacimiento: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}fecha_nacimiento']),
      fechaMuerte: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}fecha_muerte']),
      loteId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}lote_id']),
      upp: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}upp']),
      razaId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}raza_id']),
      estado: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}estado'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $BovinosTable createAlias(String alias) {
    return $BovinosTable(attachedDatabase, alias);
  }
}

class Bovino extends DataClass implements Insertable<Bovino> {
  final int id;
  final String areteId;
  final String? numRegistro;
  final String? nombre;
  final String sexo;
  final DateTime? fechaNacimiento;
  final DateTime? fechaMuerte;
  final int? loteId;
  final String? upp;
  final int? razaId;
  final String estado;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Bovino(
      {required this.id,
      required this.areteId,
      this.numRegistro,
      this.nombre,
      required this.sexo,
      this.fechaNacimiento,
      this.fechaMuerte,
      this.loteId,
      this.upp,
      this.razaId,
      required this.estado,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['arete_id'] = Variable<String>(areteId);
    if (!nullToAbsent || numRegistro != null) {
      map['num_registro'] = Variable<String>(numRegistro);
    }
    if (!nullToAbsent || nombre != null) {
      map['nombre'] = Variable<String>(nombre);
    }
    map['sexo'] = Variable<String>(sexo);
    if (!nullToAbsent || fechaNacimiento != null) {
      map['fecha_nacimiento'] = Variable<DateTime>(fechaNacimiento);
    }
    if (!nullToAbsent || fechaMuerte != null) {
      map['fecha_muerte'] = Variable<DateTime>(fechaMuerte);
    }
    if (!nullToAbsent || loteId != null) {
      map['lote_id'] = Variable<int>(loteId);
    }
    if (!nullToAbsent || upp != null) {
      map['upp'] = Variable<String>(upp);
    }
    if (!nullToAbsent || razaId != null) {
      map['raza_id'] = Variable<int>(razaId);
    }
    map['estado'] = Variable<String>(estado);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  BovinosCompanion toCompanion(bool nullToAbsent) {
    return BovinosCompanion(
      id: Value(id),
      areteId: Value(areteId),
      numRegistro: numRegistro == null && nullToAbsent
          ? const Value.absent()
          : Value(numRegistro),
      nombre:
          nombre == null && nullToAbsent ? const Value.absent() : Value(nombre),
      sexo: Value(sexo),
      fechaNacimiento: fechaNacimiento == null && nullToAbsent
          ? const Value.absent()
          : Value(fechaNacimiento),
      fechaMuerte: fechaMuerte == null && nullToAbsent
          ? const Value.absent()
          : Value(fechaMuerte),
      loteId:
          loteId == null && nullToAbsent ? const Value.absent() : Value(loteId),
      upp: upp == null && nullToAbsent ? const Value.absent() : Value(upp),
      razaId:
          razaId == null && nullToAbsent ? const Value.absent() : Value(razaId),
      estado: Value(estado),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Bovino.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Bovino(
      id: serializer.fromJson<int>(json['id']),
      areteId: serializer.fromJson<String>(json['areteId']),
      numRegistro: serializer.fromJson<String?>(json['numRegistro']),
      nombre: serializer.fromJson<String?>(json['nombre']),
      sexo: serializer.fromJson<String>(json['sexo']),
      fechaNacimiento: serializer.fromJson<DateTime?>(json['fechaNacimiento']),
      fechaMuerte: serializer.fromJson<DateTime?>(json['fechaMuerte']),
      loteId: serializer.fromJson<int?>(json['loteId']),
      upp: serializer.fromJson<String?>(json['upp']),
      razaId: serializer.fromJson<int?>(json['razaId']),
      estado: serializer.fromJson<String>(json['estado']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'areteId': serializer.toJson<String>(areteId),
      'numRegistro': serializer.toJson<String?>(numRegistro),
      'nombre': serializer.toJson<String?>(nombre),
      'sexo': serializer.toJson<String>(sexo),
      'fechaNacimiento': serializer.toJson<DateTime?>(fechaNacimiento),
      'fechaMuerte': serializer.toJson<DateTime?>(fechaMuerte),
      'loteId': serializer.toJson<int?>(loteId),
      'upp': serializer.toJson<String?>(upp),
      'razaId': serializer.toJson<int?>(razaId),
      'estado': serializer.toJson<String>(estado),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Bovino copyWith(
          {int? id,
          String? areteId,
          Value<String?> numRegistro = const Value.absent(),
          Value<String?> nombre = const Value.absent(),
          String? sexo,
          Value<DateTime?> fechaNacimiento = const Value.absent(),
          Value<DateTime?> fechaMuerte = const Value.absent(),
          Value<int?> loteId = const Value.absent(),
          Value<String?> upp = const Value.absent(),
          Value<int?> razaId = const Value.absent(),
          String? estado,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      Bovino(
        id: id ?? this.id,
        areteId: areteId ?? this.areteId,
        numRegistro: numRegistro.present ? numRegistro.value : this.numRegistro,
        nombre: nombre.present ? nombre.value : this.nombre,
        sexo: sexo ?? this.sexo,
        fechaNacimiento: fechaNacimiento.present
            ? fechaNacimiento.value
            : this.fechaNacimiento,
        fechaMuerte: fechaMuerte.present ? fechaMuerte.value : this.fechaMuerte,
        loteId: loteId.present ? loteId.value : this.loteId,
        upp: upp.present ? upp.value : this.upp,
        razaId: razaId.present ? razaId.value : this.razaId,
        estado: estado ?? this.estado,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Bovino copyWithCompanion(BovinosCompanion data) {
    return Bovino(
      id: data.id.present ? data.id.value : this.id,
      areteId: data.areteId.present ? data.areteId.value : this.areteId,
      numRegistro:
          data.numRegistro.present ? data.numRegistro.value : this.numRegistro,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      sexo: data.sexo.present ? data.sexo.value : this.sexo,
      fechaNacimiento: data.fechaNacimiento.present
          ? data.fechaNacimiento.value
          : this.fechaNacimiento,
      fechaMuerte:
          data.fechaMuerte.present ? data.fechaMuerte.value : this.fechaMuerte,
      loteId: data.loteId.present ? data.loteId.value : this.loteId,
      upp: data.upp.present ? data.upp.value : this.upp,
      razaId: data.razaId.present ? data.razaId.value : this.razaId,
      estado: data.estado.present ? data.estado.value : this.estado,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Bovino(')
          ..write('id: $id, ')
          ..write('areteId: $areteId, ')
          ..write('numRegistro: $numRegistro, ')
          ..write('nombre: $nombre, ')
          ..write('sexo: $sexo, ')
          ..write('fechaNacimiento: $fechaNacimiento, ')
          ..write('fechaMuerte: $fechaMuerte, ')
          ..write('loteId: $loteId, ')
          ..write('upp: $upp, ')
          ..write('razaId: $razaId, ')
          ..write('estado: $estado, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      areteId,
      numRegistro,
      nombre,
      sexo,
      fechaNacimiento,
      fechaMuerte,
      loteId,
      upp,
      razaId,
      estado,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Bovino &&
          other.id == this.id &&
          other.areteId == this.areteId &&
          other.numRegistro == this.numRegistro &&
          other.nombre == this.nombre &&
          other.sexo == this.sexo &&
          other.fechaNacimiento == this.fechaNacimiento &&
          other.fechaMuerte == this.fechaMuerte &&
          other.loteId == this.loteId &&
          other.upp == this.upp &&
          other.razaId == this.razaId &&
          other.estado == this.estado &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class BovinosCompanion extends UpdateCompanion<Bovino> {
  final Value<int> id;
  final Value<String> areteId;
  final Value<String?> numRegistro;
  final Value<String?> nombre;
  final Value<String> sexo;
  final Value<DateTime?> fechaNacimiento;
  final Value<DateTime?> fechaMuerte;
  final Value<int?> loteId;
  final Value<String?> upp;
  final Value<int?> razaId;
  final Value<String> estado;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const BovinosCompanion({
    this.id = const Value.absent(),
    this.areteId = const Value.absent(),
    this.numRegistro = const Value.absent(),
    this.nombre = const Value.absent(),
    this.sexo = const Value.absent(),
    this.fechaNacimiento = const Value.absent(),
    this.fechaMuerte = const Value.absent(),
    this.loteId = const Value.absent(),
    this.upp = const Value.absent(),
    this.razaId = const Value.absent(),
    this.estado = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  BovinosCompanion.insert({
    this.id = const Value.absent(),
    required String areteId,
    this.numRegistro = const Value.absent(),
    this.nombre = const Value.absent(),
    required String sexo,
    this.fechaNacimiento = const Value.absent(),
    this.fechaMuerte = const Value.absent(),
    this.loteId = const Value.absent(),
    this.upp = const Value.absent(),
    this.razaId = const Value.absent(),
    this.estado = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : areteId = Value(areteId),
        sexo = Value(sexo);
  static Insertable<Bovino> custom({
    Expression<int>? id,
    Expression<String>? areteId,
    Expression<String>? numRegistro,
    Expression<String>? nombre,
    Expression<String>? sexo,
    Expression<DateTime>? fechaNacimiento,
    Expression<DateTime>? fechaMuerte,
    Expression<int>? loteId,
    Expression<String>? upp,
    Expression<int>? razaId,
    Expression<String>? estado,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (areteId != null) 'arete_id': areteId,
      if (numRegistro != null) 'num_registro': numRegistro,
      if (nombre != null) 'nombre': nombre,
      if (sexo != null) 'sexo': sexo,
      if (fechaNacimiento != null) 'fecha_nacimiento': fechaNacimiento,
      if (fechaMuerte != null) 'fecha_muerte': fechaMuerte,
      if (loteId != null) 'lote_id': loteId,
      if (upp != null) 'upp': upp,
      if (razaId != null) 'raza_id': razaId,
      if (estado != null) 'estado': estado,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  BovinosCompanion copyWith(
      {Value<int>? id,
      Value<String>? areteId,
      Value<String?>? numRegistro,
      Value<String?>? nombre,
      Value<String>? sexo,
      Value<DateTime?>? fechaNacimiento,
      Value<DateTime?>? fechaMuerte,
      Value<int?>? loteId,
      Value<String?>? upp,
      Value<int?>? razaId,
      Value<String>? estado,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return BovinosCompanion(
      id: id ?? this.id,
      areteId: areteId ?? this.areteId,
      numRegistro: numRegistro ?? this.numRegistro,
      nombre: nombre ?? this.nombre,
      sexo: sexo ?? this.sexo,
      fechaNacimiento: fechaNacimiento ?? this.fechaNacimiento,
      fechaMuerte: fechaMuerte ?? this.fechaMuerte,
      loteId: loteId ?? this.loteId,
      upp: upp ?? this.upp,
      razaId: razaId ?? this.razaId,
      estado: estado ?? this.estado,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (areteId.present) {
      map['arete_id'] = Variable<String>(areteId.value);
    }
    if (numRegistro.present) {
      map['num_registro'] = Variable<String>(numRegistro.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (sexo.present) {
      map['sexo'] = Variable<String>(sexo.value);
    }
    if (fechaNacimiento.present) {
      map['fecha_nacimiento'] = Variable<DateTime>(fechaNacimiento.value);
    }
    if (fechaMuerte.present) {
      map['fecha_muerte'] = Variable<DateTime>(fechaMuerte.value);
    }
    if (loteId.present) {
      map['lote_id'] = Variable<int>(loteId.value);
    }
    if (upp.present) {
      map['upp'] = Variable<String>(upp.value);
    }
    if (razaId.present) {
      map['raza_id'] = Variable<int>(razaId.value);
    }
    if (estado.present) {
      map['estado'] = Variable<String>(estado.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BovinosCompanion(')
          ..write('id: $id, ')
          ..write('areteId: $areteId, ')
          ..write('numRegistro: $numRegistro, ')
          ..write('nombre: $nombre, ')
          ..write('sexo: $sexo, ')
          ..write('fechaNacimiento: $fechaNacimiento, ')
          ..write('fechaMuerte: $fechaMuerte, ')
          ..write('loteId: $loteId, ')
          ..write('upp: $upp, ')
          ..write('razaId: $razaId, ')
          ..write('estado: $estado, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $PertenenciaTable extends Pertenencia
    with TableInfo<$PertenenciaTable, PertenenciaData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PertenenciaTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _bovinoIdMeta =
      const VerificationMeta('bovinoId');
  @override
  late final GeneratedColumn<int> bovinoId = GeneratedColumn<int>(
      'bovino_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES bovinos (id)'));
  static const VerificationMeta _duenoIdMeta =
      const VerificationMeta('duenoId');
  @override
  late final GeneratedColumn<int> duenoId = GeneratedColumn<int>(
      'dueno_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES duenos (id)'));
  static const VerificationMeta _fechaInicioMeta =
      const VerificationMeta('fechaInicio');
  @override
  late final GeneratedColumn<DateTime> fechaInicio = GeneratedColumn<DateTime>(
      'fecha_inicio', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _fechaFinMeta =
      const VerificationMeta('fechaFin');
  @override
  late final GeneratedColumn<DateTime> fechaFin = GeneratedColumn<DateTime>(
      'fecha_fin', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, bovinoId, duenoId, fechaInicio, fechaFin];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pertenencia';
  @override
  VerificationContext validateIntegrity(Insertable<PertenenciaData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('bovino_id')) {
      context.handle(_bovinoIdMeta,
          bovinoId.isAcceptableOrUnknown(data['bovino_id']!, _bovinoIdMeta));
    } else if (isInserting) {
      context.missing(_bovinoIdMeta);
    }
    if (data.containsKey('dueno_id')) {
      context.handle(_duenoIdMeta,
          duenoId.isAcceptableOrUnknown(data['dueno_id']!, _duenoIdMeta));
    } else if (isInserting) {
      context.missing(_duenoIdMeta);
    }
    if (data.containsKey('fecha_inicio')) {
      context.handle(
          _fechaInicioMeta,
          fechaInicio.isAcceptableOrUnknown(
              data['fecha_inicio']!, _fechaInicioMeta));
    } else if (isInserting) {
      context.missing(_fechaInicioMeta);
    }
    if (data.containsKey('fecha_fin')) {
      context.handle(_fechaFinMeta,
          fechaFin.isAcceptableOrUnknown(data['fecha_fin']!, _fechaFinMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PertenenciaData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PertenenciaData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      bovinoId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}bovino_id'])!,
      duenoId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}dueno_id'])!,
      fechaInicio: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}fecha_inicio'])!,
      fechaFin: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}fecha_fin']),
    );
  }

  @override
  $PertenenciaTable createAlias(String alias) {
    return $PertenenciaTable(attachedDatabase, alias);
  }
}

class PertenenciaData extends DataClass implements Insertable<PertenenciaData> {
  final int id;
  final int bovinoId;
  final int duenoId;
  final DateTime fechaInicio;
  final DateTime? fechaFin;
  const PertenenciaData(
      {required this.id,
      required this.bovinoId,
      required this.duenoId,
      required this.fechaInicio,
      this.fechaFin});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['bovino_id'] = Variable<int>(bovinoId);
    map['dueno_id'] = Variable<int>(duenoId);
    map['fecha_inicio'] = Variable<DateTime>(fechaInicio);
    if (!nullToAbsent || fechaFin != null) {
      map['fecha_fin'] = Variable<DateTime>(fechaFin);
    }
    return map;
  }

  PertenenciaCompanion toCompanion(bool nullToAbsent) {
    return PertenenciaCompanion(
      id: Value(id),
      bovinoId: Value(bovinoId),
      duenoId: Value(duenoId),
      fechaInicio: Value(fechaInicio),
      fechaFin: fechaFin == null && nullToAbsent
          ? const Value.absent()
          : Value(fechaFin),
    );
  }

  factory PertenenciaData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PertenenciaData(
      id: serializer.fromJson<int>(json['id']),
      bovinoId: serializer.fromJson<int>(json['bovinoId']),
      duenoId: serializer.fromJson<int>(json['duenoId']),
      fechaInicio: serializer.fromJson<DateTime>(json['fechaInicio']),
      fechaFin: serializer.fromJson<DateTime?>(json['fechaFin']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'bovinoId': serializer.toJson<int>(bovinoId),
      'duenoId': serializer.toJson<int>(duenoId),
      'fechaInicio': serializer.toJson<DateTime>(fechaInicio),
      'fechaFin': serializer.toJson<DateTime?>(fechaFin),
    };
  }

  PertenenciaData copyWith(
          {int? id,
          int? bovinoId,
          int? duenoId,
          DateTime? fechaInicio,
          Value<DateTime?> fechaFin = const Value.absent()}) =>
      PertenenciaData(
        id: id ?? this.id,
        bovinoId: bovinoId ?? this.bovinoId,
        duenoId: duenoId ?? this.duenoId,
        fechaInicio: fechaInicio ?? this.fechaInicio,
        fechaFin: fechaFin.present ? fechaFin.value : this.fechaFin,
      );
  PertenenciaData copyWithCompanion(PertenenciaCompanion data) {
    return PertenenciaData(
      id: data.id.present ? data.id.value : this.id,
      bovinoId: data.bovinoId.present ? data.bovinoId.value : this.bovinoId,
      duenoId: data.duenoId.present ? data.duenoId.value : this.duenoId,
      fechaInicio:
          data.fechaInicio.present ? data.fechaInicio.value : this.fechaInicio,
      fechaFin: data.fechaFin.present ? data.fechaFin.value : this.fechaFin,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PertenenciaData(')
          ..write('id: $id, ')
          ..write('bovinoId: $bovinoId, ')
          ..write('duenoId: $duenoId, ')
          ..write('fechaInicio: $fechaInicio, ')
          ..write('fechaFin: $fechaFin')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, bovinoId, duenoId, fechaInicio, fechaFin);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PertenenciaData &&
          other.id == this.id &&
          other.bovinoId == this.bovinoId &&
          other.duenoId == this.duenoId &&
          other.fechaInicio == this.fechaInicio &&
          other.fechaFin == this.fechaFin);
}

class PertenenciaCompanion extends UpdateCompanion<PertenenciaData> {
  final Value<int> id;
  final Value<int> bovinoId;
  final Value<int> duenoId;
  final Value<DateTime> fechaInicio;
  final Value<DateTime?> fechaFin;
  const PertenenciaCompanion({
    this.id = const Value.absent(),
    this.bovinoId = const Value.absent(),
    this.duenoId = const Value.absent(),
    this.fechaInicio = const Value.absent(),
    this.fechaFin = const Value.absent(),
  });
  PertenenciaCompanion.insert({
    this.id = const Value.absent(),
    required int bovinoId,
    required int duenoId,
    required DateTime fechaInicio,
    this.fechaFin = const Value.absent(),
  })  : bovinoId = Value(bovinoId),
        duenoId = Value(duenoId),
        fechaInicio = Value(fechaInicio);
  static Insertable<PertenenciaData> custom({
    Expression<int>? id,
    Expression<int>? bovinoId,
    Expression<int>? duenoId,
    Expression<DateTime>? fechaInicio,
    Expression<DateTime>? fechaFin,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (bovinoId != null) 'bovino_id': bovinoId,
      if (duenoId != null) 'dueno_id': duenoId,
      if (fechaInicio != null) 'fecha_inicio': fechaInicio,
      if (fechaFin != null) 'fecha_fin': fechaFin,
    });
  }

  PertenenciaCompanion copyWith(
      {Value<int>? id,
      Value<int>? bovinoId,
      Value<int>? duenoId,
      Value<DateTime>? fechaInicio,
      Value<DateTime?>? fechaFin}) {
    return PertenenciaCompanion(
      id: id ?? this.id,
      bovinoId: bovinoId ?? this.bovinoId,
      duenoId: duenoId ?? this.duenoId,
      fechaInicio: fechaInicio ?? this.fechaInicio,
      fechaFin: fechaFin ?? this.fechaFin,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (bovinoId.present) {
      map['bovino_id'] = Variable<int>(bovinoId.value);
    }
    if (duenoId.present) {
      map['dueno_id'] = Variable<int>(duenoId.value);
    }
    if (fechaInicio.present) {
      map['fecha_inicio'] = Variable<DateTime>(fechaInicio.value);
    }
    if (fechaFin.present) {
      map['fecha_fin'] = Variable<DateTime>(fechaFin.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PertenenciaCompanion(')
          ..write('id: $id, ')
          ..write('bovinoId: $bovinoId, ')
          ..write('duenoId: $duenoId, ')
          ..write('fechaInicio: $fechaInicio, ')
          ..write('fechaFin: $fechaFin')
          ..write(')'))
        .toString();
  }
}

class $ProgenieTable extends Progenie
    with TableInfo<$ProgenieTable, ProgenieData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProgenieTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _bovinoIdMeta =
      const VerificationMeta('bovinoId');
  @override
  late final GeneratedColumn<int> bovinoId = GeneratedColumn<int>(
      'bovino_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('UNIQUE REFERENCES bovinos (id)'));
  static const VerificationMeta _bovinoPadreIdMeta =
      const VerificationMeta('bovinoPadreId');
  @override
  late final GeneratedColumn<int> bovinoPadreId = GeneratedColumn<int>(
      'bovino_padre_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES bovinos (id)'));
  static const VerificationMeta _bovinaMadreIdMeta =
      const VerificationMeta('bovinaMadreId');
  @override
  late final GeneratedColumn<int> bovinaMadreId = GeneratedColumn<int>(
      'bovina_madre_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES bovinos (id)'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, bovinoId, bovinoPadreId, bovinaMadreId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'progenie';
  @override
  VerificationContext validateIntegrity(Insertable<ProgenieData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('bovino_id')) {
      context.handle(_bovinoIdMeta,
          bovinoId.isAcceptableOrUnknown(data['bovino_id']!, _bovinoIdMeta));
    } else if (isInserting) {
      context.missing(_bovinoIdMeta);
    }
    if (data.containsKey('bovino_padre_id')) {
      context.handle(
          _bovinoPadreIdMeta,
          bovinoPadreId.isAcceptableOrUnknown(
              data['bovino_padre_id']!, _bovinoPadreIdMeta));
    }
    if (data.containsKey('bovina_madre_id')) {
      context.handle(
          _bovinaMadreIdMeta,
          bovinaMadreId.isAcceptableOrUnknown(
              data['bovina_madre_id']!, _bovinaMadreIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProgenieData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProgenieData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      bovinoId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}bovino_id'])!,
      bovinoPadreId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}bovino_padre_id']),
      bovinaMadreId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}bovina_madre_id']),
    );
  }

  @override
  $ProgenieTable createAlias(String alias) {
    return $ProgenieTable(attachedDatabase, alias);
  }
}

class ProgenieData extends DataClass implements Insertable<ProgenieData> {
  final int id;
  final int bovinoId;
  final int? bovinoPadreId;
  final int? bovinaMadreId;
  const ProgenieData(
      {required this.id,
      required this.bovinoId,
      this.bovinoPadreId,
      this.bovinaMadreId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['bovino_id'] = Variable<int>(bovinoId);
    if (!nullToAbsent || bovinoPadreId != null) {
      map['bovino_padre_id'] = Variable<int>(bovinoPadreId);
    }
    if (!nullToAbsent || bovinaMadreId != null) {
      map['bovina_madre_id'] = Variable<int>(bovinaMadreId);
    }
    return map;
  }

  ProgenieCompanion toCompanion(bool nullToAbsent) {
    return ProgenieCompanion(
      id: Value(id),
      bovinoId: Value(bovinoId),
      bovinoPadreId: bovinoPadreId == null && nullToAbsent
          ? const Value.absent()
          : Value(bovinoPadreId),
      bovinaMadreId: bovinaMadreId == null && nullToAbsent
          ? const Value.absent()
          : Value(bovinaMadreId),
    );
  }

  factory ProgenieData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProgenieData(
      id: serializer.fromJson<int>(json['id']),
      bovinoId: serializer.fromJson<int>(json['bovinoId']),
      bovinoPadreId: serializer.fromJson<int?>(json['bovinoPadreId']),
      bovinaMadreId: serializer.fromJson<int?>(json['bovinaMadreId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'bovinoId': serializer.toJson<int>(bovinoId),
      'bovinoPadreId': serializer.toJson<int?>(bovinoPadreId),
      'bovinaMadreId': serializer.toJson<int?>(bovinaMadreId),
    };
  }

  ProgenieData copyWith(
          {int? id,
          int? bovinoId,
          Value<int?> bovinoPadreId = const Value.absent(),
          Value<int?> bovinaMadreId = const Value.absent()}) =>
      ProgenieData(
        id: id ?? this.id,
        bovinoId: bovinoId ?? this.bovinoId,
        bovinoPadreId:
            bovinoPadreId.present ? bovinoPadreId.value : this.bovinoPadreId,
        bovinaMadreId:
            bovinaMadreId.present ? bovinaMadreId.value : this.bovinaMadreId,
      );
  ProgenieData copyWithCompanion(ProgenieCompanion data) {
    return ProgenieData(
      id: data.id.present ? data.id.value : this.id,
      bovinoId: data.bovinoId.present ? data.bovinoId.value : this.bovinoId,
      bovinoPadreId: data.bovinoPadreId.present
          ? data.bovinoPadreId.value
          : this.bovinoPadreId,
      bovinaMadreId: data.bovinaMadreId.present
          ? data.bovinaMadreId.value
          : this.bovinaMadreId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProgenieData(')
          ..write('id: $id, ')
          ..write('bovinoId: $bovinoId, ')
          ..write('bovinoPadreId: $bovinoPadreId, ')
          ..write('bovinaMadreId: $bovinaMadreId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, bovinoId, bovinoPadreId, bovinaMadreId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProgenieData &&
          other.id == this.id &&
          other.bovinoId == this.bovinoId &&
          other.bovinoPadreId == this.bovinoPadreId &&
          other.bovinaMadreId == this.bovinaMadreId);
}

class ProgenieCompanion extends UpdateCompanion<ProgenieData> {
  final Value<int> id;
  final Value<int> bovinoId;
  final Value<int?> bovinoPadreId;
  final Value<int?> bovinaMadreId;
  const ProgenieCompanion({
    this.id = const Value.absent(),
    this.bovinoId = const Value.absent(),
    this.bovinoPadreId = const Value.absent(),
    this.bovinaMadreId = const Value.absent(),
  });
  ProgenieCompanion.insert({
    this.id = const Value.absent(),
    required int bovinoId,
    this.bovinoPadreId = const Value.absent(),
    this.bovinaMadreId = const Value.absent(),
  }) : bovinoId = Value(bovinoId);
  static Insertable<ProgenieData> custom({
    Expression<int>? id,
    Expression<int>? bovinoId,
    Expression<int>? bovinoPadreId,
    Expression<int>? bovinaMadreId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (bovinoId != null) 'bovino_id': bovinoId,
      if (bovinoPadreId != null) 'bovino_padre_id': bovinoPadreId,
      if (bovinaMadreId != null) 'bovina_madre_id': bovinaMadreId,
    });
  }

  ProgenieCompanion copyWith(
      {Value<int>? id,
      Value<int>? bovinoId,
      Value<int?>? bovinoPadreId,
      Value<int?>? bovinaMadreId}) {
    return ProgenieCompanion(
      id: id ?? this.id,
      bovinoId: bovinoId ?? this.bovinoId,
      bovinoPadreId: bovinoPadreId ?? this.bovinoPadreId,
      bovinaMadreId: bovinaMadreId ?? this.bovinaMadreId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (bovinoId.present) {
      map['bovino_id'] = Variable<int>(bovinoId.value);
    }
    if (bovinoPadreId.present) {
      map['bovino_padre_id'] = Variable<int>(bovinoPadreId.value);
    }
    if (bovinaMadreId.present) {
      map['bovina_madre_id'] = Variable<int>(bovinaMadreId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProgenieCompanion(')
          ..write('id: $id, ')
          ..write('bovinoId: $bovinoId, ')
          ..write('bovinoPadreId: $bovinoPadreId, ')
          ..write('bovinaMadreId: $bovinaMadreId')
          ..write(')'))
        .toString();
  }
}

class $PartosTable extends Partos with TableInfo<$PartosTable, Parto> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PartosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _bovinoIdMeta =
      const VerificationMeta('bovinoId');
  @override
  late final GeneratedColumn<int> bovinoId = GeneratedColumn<int>(
      'bovino_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES bovinos (id)'));
  static const VerificationMeta _fechaPartoMeta =
      const VerificationMeta('fechaParto');
  @override
  late final GeneratedColumn<DateTime> fechaParto = GeneratedColumn<DateTime>(
      'fecha_parto', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _notasMeta = const VerificationMeta('notas');
  @override
  late final GeneratedColumn<String> notas = GeneratedColumn<String>(
      'notas', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, bovinoId, fechaParto, notas];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'partos';
  @override
  VerificationContext validateIntegrity(Insertable<Parto> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('bovino_id')) {
      context.handle(_bovinoIdMeta,
          bovinoId.isAcceptableOrUnknown(data['bovino_id']!, _bovinoIdMeta));
    } else if (isInserting) {
      context.missing(_bovinoIdMeta);
    }
    if (data.containsKey('fecha_parto')) {
      context.handle(
          _fechaPartoMeta,
          fechaParto.isAcceptableOrUnknown(
              data['fecha_parto']!, _fechaPartoMeta));
    } else if (isInserting) {
      context.missing(_fechaPartoMeta);
    }
    if (data.containsKey('notas')) {
      context.handle(
          _notasMeta, notas.isAcceptableOrUnknown(data['notas']!, _notasMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Parto map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Parto(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      bovinoId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}bovino_id'])!,
      fechaParto: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}fecha_parto'])!,
      notas: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notas']),
    );
  }

  @override
  $PartosTable createAlias(String alias) {
    return $PartosTable(attachedDatabase, alias);
  }
}

class Parto extends DataClass implements Insertable<Parto> {
  final int id;
  final int bovinoId;
  final DateTime fechaParto;
  final String? notas;
  const Parto(
      {required this.id,
      required this.bovinoId,
      required this.fechaParto,
      this.notas});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['bovino_id'] = Variable<int>(bovinoId);
    map['fecha_parto'] = Variable<DateTime>(fechaParto);
    if (!nullToAbsent || notas != null) {
      map['notas'] = Variable<String>(notas);
    }
    return map;
  }

  PartosCompanion toCompanion(bool nullToAbsent) {
    return PartosCompanion(
      id: Value(id),
      bovinoId: Value(bovinoId),
      fechaParto: Value(fechaParto),
      notas:
          notas == null && nullToAbsent ? const Value.absent() : Value(notas),
    );
  }

  factory Parto.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Parto(
      id: serializer.fromJson<int>(json['id']),
      bovinoId: serializer.fromJson<int>(json['bovinoId']),
      fechaParto: serializer.fromJson<DateTime>(json['fechaParto']),
      notas: serializer.fromJson<String?>(json['notas']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'bovinoId': serializer.toJson<int>(bovinoId),
      'fechaParto': serializer.toJson<DateTime>(fechaParto),
      'notas': serializer.toJson<String?>(notas),
    };
  }

  Parto copyWith(
          {int? id,
          int? bovinoId,
          DateTime? fechaParto,
          Value<String?> notas = const Value.absent()}) =>
      Parto(
        id: id ?? this.id,
        bovinoId: bovinoId ?? this.bovinoId,
        fechaParto: fechaParto ?? this.fechaParto,
        notas: notas.present ? notas.value : this.notas,
      );
  Parto copyWithCompanion(PartosCompanion data) {
    return Parto(
      id: data.id.present ? data.id.value : this.id,
      bovinoId: data.bovinoId.present ? data.bovinoId.value : this.bovinoId,
      fechaParto:
          data.fechaParto.present ? data.fechaParto.value : this.fechaParto,
      notas: data.notas.present ? data.notas.value : this.notas,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Parto(')
          ..write('id: $id, ')
          ..write('bovinoId: $bovinoId, ')
          ..write('fechaParto: $fechaParto, ')
          ..write('notas: $notas')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, bovinoId, fechaParto, notas);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Parto &&
          other.id == this.id &&
          other.bovinoId == this.bovinoId &&
          other.fechaParto == this.fechaParto &&
          other.notas == this.notas);
}

class PartosCompanion extends UpdateCompanion<Parto> {
  final Value<int> id;
  final Value<int> bovinoId;
  final Value<DateTime> fechaParto;
  final Value<String?> notas;
  const PartosCompanion({
    this.id = const Value.absent(),
    this.bovinoId = const Value.absent(),
    this.fechaParto = const Value.absent(),
    this.notas = const Value.absent(),
  });
  PartosCompanion.insert({
    this.id = const Value.absent(),
    required int bovinoId,
    required DateTime fechaParto,
    this.notas = const Value.absent(),
  })  : bovinoId = Value(bovinoId),
        fechaParto = Value(fechaParto);
  static Insertable<Parto> custom({
    Expression<int>? id,
    Expression<int>? bovinoId,
    Expression<DateTime>? fechaParto,
    Expression<String>? notas,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (bovinoId != null) 'bovino_id': bovinoId,
      if (fechaParto != null) 'fecha_parto': fechaParto,
      if (notas != null) 'notas': notas,
    });
  }

  PartosCompanion copyWith(
      {Value<int>? id,
      Value<int>? bovinoId,
      Value<DateTime>? fechaParto,
      Value<String?>? notas}) {
    return PartosCompanion(
      id: id ?? this.id,
      bovinoId: bovinoId ?? this.bovinoId,
      fechaParto: fechaParto ?? this.fechaParto,
      notas: notas ?? this.notas,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (bovinoId.present) {
      map['bovino_id'] = Variable<int>(bovinoId.value);
    }
    if (fechaParto.present) {
      map['fecha_parto'] = Variable<DateTime>(fechaParto.value);
    }
    if (notas.present) {
      map['notas'] = Variable<String>(notas.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PartosCompanion(')
          ..write('id: $id, ')
          ..write('bovinoId: $bovinoId, ')
          ..write('fechaParto: $fechaParto, ')
          ..write('notas: $notas')
          ..write(')'))
        .toString();
  }
}

class $VentasTable extends Ventas with TableInfo<$VentasTable, Venta> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VentasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _bovinoIdMeta =
      const VerificationMeta('bovinoId');
  @override
  late final GeneratedColumn<int> bovinoId = GeneratedColumn<int>(
      'bovino_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES bovinos (id)'));
  static const VerificationMeta _fechaVentaMeta =
      const VerificationMeta('fechaVenta');
  @override
  late final GeneratedColumn<DateTime> fechaVenta = GeneratedColumn<DateTime>(
      'fecha_venta', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _precioMeta = const VerificationMeta('precio');
  @override
  late final GeneratedColumn<double> precio = GeneratedColumn<double>(
      'precio', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _compradorMeta =
      const VerificationMeta('comprador');
  @override
  late final GeneratedColumn<String> comprador = GeneratedColumn<String>(
      'comprador', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, bovinoId, fechaVenta, precio, comprador];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ventas';
  @override
  VerificationContext validateIntegrity(Insertable<Venta> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('bovino_id')) {
      context.handle(_bovinoIdMeta,
          bovinoId.isAcceptableOrUnknown(data['bovino_id']!, _bovinoIdMeta));
    } else if (isInserting) {
      context.missing(_bovinoIdMeta);
    }
    if (data.containsKey('fecha_venta')) {
      context.handle(
          _fechaVentaMeta,
          fechaVenta.isAcceptableOrUnknown(
              data['fecha_venta']!, _fechaVentaMeta));
    } else if (isInserting) {
      context.missing(_fechaVentaMeta);
    }
    if (data.containsKey('precio')) {
      context.handle(_precioMeta,
          precio.isAcceptableOrUnknown(data['precio']!, _precioMeta));
    }
    if (data.containsKey('comprador')) {
      context.handle(_compradorMeta,
          comprador.isAcceptableOrUnknown(data['comprador']!, _compradorMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Venta map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Venta(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      bovinoId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}bovino_id'])!,
      fechaVenta: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}fecha_venta'])!,
      precio: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}precio']),
      comprador: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}comprador']),
    );
  }

  @override
  $VentasTable createAlias(String alias) {
    return $VentasTable(attachedDatabase, alias);
  }
}

class Venta extends DataClass implements Insertable<Venta> {
  final int id;
  final int bovinoId;
  final DateTime fechaVenta;
  final double? precio;
  final String? comprador;
  const Venta(
      {required this.id,
      required this.bovinoId,
      required this.fechaVenta,
      this.precio,
      this.comprador});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['bovino_id'] = Variable<int>(bovinoId);
    map['fecha_venta'] = Variable<DateTime>(fechaVenta);
    if (!nullToAbsent || precio != null) {
      map['precio'] = Variable<double>(precio);
    }
    if (!nullToAbsent || comprador != null) {
      map['comprador'] = Variable<String>(comprador);
    }
    return map;
  }

  VentasCompanion toCompanion(bool nullToAbsent) {
    return VentasCompanion(
      id: Value(id),
      bovinoId: Value(bovinoId),
      fechaVenta: Value(fechaVenta),
      precio:
          precio == null && nullToAbsent ? const Value.absent() : Value(precio),
      comprador: comprador == null && nullToAbsent
          ? const Value.absent()
          : Value(comprador),
    );
  }

  factory Venta.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Venta(
      id: serializer.fromJson<int>(json['id']),
      bovinoId: serializer.fromJson<int>(json['bovinoId']),
      fechaVenta: serializer.fromJson<DateTime>(json['fechaVenta']),
      precio: serializer.fromJson<double?>(json['precio']),
      comprador: serializer.fromJson<String?>(json['comprador']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'bovinoId': serializer.toJson<int>(bovinoId),
      'fechaVenta': serializer.toJson<DateTime>(fechaVenta),
      'precio': serializer.toJson<double?>(precio),
      'comprador': serializer.toJson<String?>(comprador),
    };
  }

  Venta copyWith(
          {int? id,
          int? bovinoId,
          DateTime? fechaVenta,
          Value<double?> precio = const Value.absent(),
          Value<String?> comprador = const Value.absent()}) =>
      Venta(
        id: id ?? this.id,
        bovinoId: bovinoId ?? this.bovinoId,
        fechaVenta: fechaVenta ?? this.fechaVenta,
        precio: precio.present ? precio.value : this.precio,
        comprador: comprador.present ? comprador.value : this.comprador,
      );
  Venta copyWithCompanion(VentasCompanion data) {
    return Venta(
      id: data.id.present ? data.id.value : this.id,
      bovinoId: data.bovinoId.present ? data.bovinoId.value : this.bovinoId,
      fechaVenta:
          data.fechaVenta.present ? data.fechaVenta.value : this.fechaVenta,
      precio: data.precio.present ? data.precio.value : this.precio,
      comprador: data.comprador.present ? data.comprador.value : this.comprador,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Venta(')
          ..write('id: $id, ')
          ..write('bovinoId: $bovinoId, ')
          ..write('fechaVenta: $fechaVenta, ')
          ..write('precio: $precio, ')
          ..write('comprador: $comprador')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, bovinoId, fechaVenta, precio, comprador);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Venta &&
          other.id == this.id &&
          other.bovinoId == this.bovinoId &&
          other.fechaVenta == this.fechaVenta &&
          other.precio == this.precio &&
          other.comprador == this.comprador);
}

class VentasCompanion extends UpdateCompanion<Venta> {
  final Value<int> id;
  final Value<int> bovinoId;
  final Value<DateTime> fechaVenta;
  final Value<double?> precio;
  final Value<String?> comprador;
  const VentasCompanion({
    this.id = const Value.absent(),
    this.bovinoId = const Value.absent(),
    this.fechaVenta = const Value.absent(),
    this.precio = const Value.absent(),
    this.comprador = const Value.absent(),
  });
  VentasCompanion.insert({
    this.id = const Value.absent(),
    required int bovinoId,
    required DateTime fechaVenta,
    this.precio = const Value.absent(),
    this.comprador = const Value.absent(),
  })  : bovinoId = Value(bovinoId),
        fechaVenta = Value(fechaVenta);
  static Insertable<Venta> custom({
    Expression<int>? id,
    Expression<int>? bovinoId,
    Expression<DateTime>? fechaVenta,
    Expression<double>? precio,
    Expression<String>? comprador,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (bovinoId != null) 'bovino_id': bovinoId,
      if (fechaVenta != null) 'fecha_venta': fechaVenta,
      if (precio != null) 'precio': precio,
      if (comprador != null) 'comprador': comprador,
    });
  }

  VentasCompanion copyWith(
      {Value<int>? id,
      Value<int>? bovinoId,
      Value<DateTime>? fechaVenta,
      Value<double?>? precio,
      Value<String?>? comprador}) {
    return VentasCompanion(
      id: id ?? this.id,
      bovinoId: bovinoId ?? this.bovinoId,
      fechaVenta: fechaVenta ?? this.fechaVenta,
      precio: precio ?? this.precio,
      comprador: comprador ?? this.comprador,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (bovinoId.present) {
      map['bovino_id'] = Variable<int>(bovinoId.value);
    }
    if (fechaVenta.present) {
      map['fecha_venta'] = Variable<DateTime>(fechaVenta.value);
    }
    if (precio.present) {
      map['precio'] = Variable<double>(precio.value);
    }
    if (comprador.present) {
      map['comprador'] = Variable<String>(comprador.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VentasCompanion(')
          ..write('id: $id, ')
          ..write('bovinoId: $bovinoId, ')
          ..write('fechaVenta: $fechaVenta, ')
          ..write('precio: $precio, ')
          ..write('comprador: $comprador')
          ..write(')'))
        .toString();
  }
}

class $TorosTable extends Toros with TableInfo<$TorosTable, Toro> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TorosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _bovinoIdMeta =
      const VerificationMeta('bovinoId');
  @override
  late final GeneratedColumn<int> bovinoId = GeneratedColumn<int>(
      'bovino_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('UNIQUE REFERENCES bovinos (id)'));
  @override
  List<GeneratedColumn> get $columns => [id, bovinoId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'toros';
  @override
  VerificationContext validateIntegrity(Insertable<Toro> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('bovino_id')) {
      context.handle(_bovinoIdMeta,
          bovinoId.isAcceptableOrUnknown(data['bovino_id']!, _bovinoIdMeta));
    } else if (isInserting) {
      context.missing(_bovinoIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Toro map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Toro(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      bovinoId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}bovino_id'])!,
    );
  }

  @override
  $TorosTable createAlias(String alias) {
    return $TorosTable(attachedDatabase, alias);
  }
}

class Toro extends DataClass implements Insertable<Toro> {
  final int id;
  final int bovinoId;
  const Toro({required this.id, required this.bovinoId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['bovino_id'] = Variable<int>(bovinoId);
    return map;
  }

  TorosCompanion toCompanion(bool nullToAbsent) {
    return TorosCompanion(
      id: Value(id),
      bovinoId: Value(bovinoId),
    );
  }

  factory Toro.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Toro(
      id: serializer.fromJson<int>(json['id']),
      bovinoId: serializer.fromJson<int>(json['bovinoId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'bovinoId': serializer.toJson<int>(bovinoId),
    };
  }

  Toro copyWith({int? id, int? bovinoId}) => Toro(
        id: id ?? this.id,
        bovinoId: bovinoId ?? this.bovinoId,
      );
  Toro copyWithCompanion(TorosCompanion data) {
    return Toro(
      id: data.id.present ? data.id.value : this.id,
      bovinoId: data.bovinoId.present ? data.bovinoId.value : this.bovinoId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Toro(')
          ..write('id: $id, ')
          ..write('bovinoId: $bovinoId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, bovinoId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Toro && other.id == this.id && other.bovinoId == this.bovinoId);
}

class TorosCompanion extends UpdateCompanion<Toro> {
  final Value<int> id;
  final Value<int> bovinoId;
  const TorosCompanion({
    this.id = const Value.absent(),
    this.bovinoId = const Value.absent(),
  });
  TorosCompanion.insert({
    this.id = const Value.absent(),
    required int bovinoId,
  }) : bovinoId = Value(bovinoId);
  static Insertable<Toro> custom({
    Expression<int>? id,
    Expression<int>? bovinoId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (bovinoId != null) 'bovino_id': bovinoId,
    });
  }

  TorosCompanion copyWith({Value<int>? id, Value<int>? bovinoId}) {
    return TorosCompanion(
      id: id ?? this.id,
      bovinoId: bovinoId ?? this.bovinoId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (bovinoId.present) {
      map['bovino_id'] = Variable<int>(bovinoId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TorosCompanion(')
          ..write('id: $id, ')
          ..write('bovinoId: $bovinoId')
          ..write(')'))
        .toString();
  }
}

class $VacunasTable extends Vacunas with TableInfo<$VacunasTable, Vacuna> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VacunasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _bovinoIdMeta =
      const VerificationMeta('bovinoId');
  @override
  late final GeneratedColumn<int> bovinoId = GeneratedColumn<int>(
      'bovino_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES bovinos (id)'));
  static const VerificationMeta _nombreVacunaMeta =
      const VerificationMeta('nombreVacuna');
  @override
  late final GeneratedColumn<String> nombreVacuna = GeneratedColumn<String>(
      'nombre_vacuna', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _fechaAplicacionMeta =
      const VerificationMeta('fechaAplicacion');
  @override
  late final GeneratedColumn<DateTime> fechaAplicacion =
      GeneratedColumn<DateTime>('fecha_aplicacion', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _descripcionMeta =
      const VerificationMeta('descripcion');
  @override
  late final GeneratedColumn<String> descripcion = GeneratedColumn<String>(
      'descripcion', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _proximaDosisMeta =
      const VerificationMeta('proximaDosis');
  @override
  late final GeneratedColumn<DateTime> proximaDosis = GeneratedColumn<DateTime>(
      'proxima_dosis', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, bovinoId, nombreVacuna, fechaAplicacion, descripcion, proximaDosis];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vacunas';
  @override
  VerificationContext validateIntegrity(Insertable<Vacuna> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('bovino_id')) {
      context.handle(_bovinoIdMeta,
          bovinoId.isAcceptableOrUnknown(data['bovino_id']!, _bovinoIdMeta));
    } else if (isInserting) {
      context.missing(_bovinoIdMeta);
    }
    if (data.containsKey('nombre_vacuna')) {
      context.handle(
          _nombreVacunaMeta,
          nombreVacuna.isAcceptableOrUnknown(
              data['nombre_vacuna']!, _nombreVacunaMeta));
    } else if (isInserting) {
      context.missing(_nombreVacunaMeta);
    }
    if (data.containsKey('fecha_aplicacion')) {
      context.handle(
          _fechaAplicacionMeta,
          fechaAplicacion.isAcceptableOrUnknown(
              data['fecha_aplicacion']!, _fechaAplicacionMeta));
    } else if (isInserting) {
      context.missing(_fechaAplicacionMeta);
    }
    if (data.containsKey('descripcion')) {
      context.handle(
          _descripcionMeta,
          descripcion.isAcceptableOrUnknown(
              data['descripcion']!, _descripcionMeta));
    }
    if (data.containsKey('proxima_dosis')) {
      context.handle(
          _proximaDosisMeta,
          proximaDosis.isAcceptableOrUnknown(
              data['proxima_dosis']!, _proximaDosisMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Vacuna map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Vacuna(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      bovinoId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}bovino_id'])!,
      nombreVacuna: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nombre_vacuna'])!,
      fechaAplicacion: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}fecha_aplicacion'])!,
      descripcion: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}descripcion']),
      proximaDosis: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}proxima_dosis']),
    );
  }

  @override
  $VacunasTable createAlias(String alias) {
    return $VacunasTable(attachedDatabase, alias);
  }
}

class Vacuna extends DataClass implements Insertable<Vacuna> {
  final int id;
  final int bovinoId;
  final String nombreVacuna;
  final DateTime fechaAplicacion;
  final String? descripcion;
  final DateTime? proximaDosis;
  const Vacuna(
      {required this.id,
      required this.bovinoId,
      required this.nombreVacuna,
      required this.fechaAplicacion,
      this.descripcion,
      this.proximaDosis});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['bovino_id'] = Variable<int>(bovinoId);
    map['nombre_vacuna'] = Variable<String>(nombreVacuna);
    map['fecha_aplicacion'] = Variable<DateTime>(fechaAplicacion);
    if (!nullToAbsent || descripcion != null) {
      map['descripcion'] = Variable<String>(descripcion);
    }
    if (!nullToAbsent || proximaDosis != null) {
      map['proxima_dosis'] = Variable<DateTime>(proximaDosis);
    }
    return map;
  }

  VacunasCompanion toCompanion(bool nullToAbsent) {
    return VacunasCompanion(
      id: Value(id),
      bovinoId: Value(bovinoId),
      nombreVacuna: Value(nombreVacuna),
      fechaAplicacion: Value(fechaAplicacion),
      descripcion: descripcion == null && nullToAbsent
          ? const Value.absent()
          : Value(descripcion),
      proximaDosis: proximaDosis == null && nullToAbsent
          ? const Value.absent()
          : Value(proximaDosis),
    );
  }

  factory Vacuna.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Vacuna(
      id: serializer.fromJson<int>(json['id']),
      bovinoId: serializer.fromJson<int>(json['bovinoId']),
      nombreVacuna: serializer.fromJson<String>(json['nombreVacuna']),
      fechaAplicacion: serializer.fromJson<DateTime>(json['fechaAplicacion']),
      descripcion: serializer.fromJson<String?>(json['descripcion']),
      proximaDosis: serializer.fromJson<DateTime?>(json['proximaDosis']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'bovinoId': serializer.toJson<int>(bovinoId),
      'nombreVacuna': serializer.toJson<String>(nombreVacuna),
      'fechaAplicacion': serializer.toJson<DateTime>(fechaAplicacion),
      'descripcion': serializer.toJson<String?>(descripcion),
      'proximaDosis': serializer.toJson<DateTime?>(proximaDosis),
    };
  }

  Vacuna copyWith(
          {int? id,
          int? bovinoId,
          String? nombreVacuna,
          DateTime? fechaAplicacion,
          Value<String?> descripcion = const Value.absent(),
          Value<DateTime?> proximaDosis = const Value.absent()}) =>
      Vacuna(
        id: id ?? this.id,
        bovinoId: bovinoId ?? this.bovinoId,
        nombreVacuna: nombreVacuna ?? this.nombreVacuna,
        fechaAplicacion: fechaAplicacion ?? this.fechaAplicacion,
        descripcion: descripcion.present ? descripcion.value : this.descripcion,
        proximaDosis:
            proximaDosis.present ? proximaDosis.value : this.proximaDosis,
      );
  Vacuna copyWithCompanion(VacunasCompanion data) {
    return Vacuna(
      id: data.id.present ? data.id.value : this.id,
      bovinoId: data.bovinoId.present ? data.bovinoId.value : this.bovinoId,
      nombreVacuna: data.nombreVacuna.present
          ? data.nombreVacuna.value
          : this.nombreVacuna,
      fechaAplicacion: data.fechaAplicacion.present
          ? data.fechaAplicacion.value
          : this.fechaAplicacion,
      descripcion:
          data.descripcion.present ? data.descripcion.value : this.descripcion,
      proximaDosis: data.proximaDosis.present
          ? data.proximaDosis.value
          : this.proximaDosis,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Vacuna(')
          ..write('id: $id, ')
          ..write('bovinoId: $bovinoId, ')
          ..write('nombreVacuna: $nombreVacuna, ')
          ..write('fechaAplicacion: $fechaAplicacion, ')
          ..write('descripcion: $descripcion, ')
          ..write('proximaDosis: $proximaDosis')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, bovinoId, nombreVacuna, fechaAplicacion, descripcion, proximaDosis);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Vacuna &&
          other.id == this.id &&
          other.bovinoId == this.bovinoId &&
          other.nombreVacuna == this.nombreVacuna &&
          other.fechaAplicacion == this.fechaAplicacion &&
          other.descripcion == this.descripcion &&
          other.proximaDosis == this.proximaDosis);
}

class VacunasCompanion extends UpdateCompanion<Vacuna> {
  final Value<int> id;
  final Value<int> bovinoId;
  final Value<String> nombreVacuna;
  final Value<DateTime> fechaAplicacion;
  final Value<String?> descripcion;
  final Value<DateTime?> proximaDosis;
  const VacunasCompanion({
    this.id = const Value.absent(),
    this.bovinoId = const Value.absent(),
    this.nombreVacuna = const Value.absent(),
    this.fechaAplicacion = const Value.absent(),
    this.descripcion = const Value.absent(),
    this.proximaDosis = const Value.absent(),
  });
  VacunasCompanion.insert({
    this.id = const Value.absent(),
    required int bovinoId,
    required String nombreVacuna,
    required DateTime fechaAplicacion,
    this.descripcion = const Value.absent(),
    this.proximaDosis = const Value.absent(),
  })  : bovinoId = Value(bovinoId),
        nombreVacuna = Value(nombreVacuna),
        fechaAplicacion = Value(fechaAplicacion);
  static Insertable<Vacuna> custom({
    Expression<int>? id,
    Expression<int>? bovinoId,
    Expression<String>? nombreVacuna,
    Expression<DateTime>? fechaAplicacion,
    Expression<String>? descripcion,
    Expression<DateTime>? proximaDosis,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (bovinoId != null) 'bovino_id': bovinoId,
      if (nombreVacuna != null) 'nombre_vacuna': nombreVacuna,
      if (fechaAplicacion != null) 'fecha_aplicacion': fechaAplicacion,
      if (descripcion != null) 'descripcion': descripcion,
      if (proximaDosis != null) 'proxima_dosis': proximaDosis,
    });
  }

  VacunasCompanion copyWith(
      {Value<int>? id,
      Value<int>? bovinoId,
      Value<String>? nombreVacuna,
      Value<DateTime>? fechaAplicacion,
      Value<String?>? descripcion,
      Value<DateTime?>? proximaDosis}) {
    return VacunasCompanion(
      id: id ?? this.id,
      bovinoId: bovinoId ?? this.bovinoId,
      nombreVacuna: nombreVacuna ?? this.nombreVacuna,
      fechaAplicacion: fechaAplicacion ?? this.fechaAplicacion,
      descripcion: descripcion ?? this.descripcion,
      proximaDosis: proximaDosis ?? this.proximaDosis,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (bovinoId.present) {
      map['bovino_id'] = Variable<int>(bovinoId.value);
    }
    if (nombreVacuna.present) {
      map['nombre_vacuna'] = Variable<String>(nombreVacuna.value);
    }
    if (fechaAplicacion.present) {
      map['fecha_aplicacion'] = Variable<DateTime>(fechaAplicacion.value);
    }
    if (descripcion.present) {
      map['descripcion'] = Variable<String>(descripcion.value);
    }
    if (proximaDosis.present) {
      map['proxima_dosis'] = Variable<DateTime>(proximaDosis.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VacunasCompanion(')
          ..write('id: $id, ')
          ..write('bovinoId: $bovinoId, ')
          ..write('nombreVacuna: $nombreVacuna, ')
          ..write('fechaAplicacion: $fechaAplicacion, ')
          ..write('descripcion: $descripcion, ')
          ..write('proximaDosis: $proximaDosis')
          ..write(')'))
        .toString();
  }
}

class $TratamientosTable extends Tratamientos
    with TableInfo<$TratamientosTable, Tratamiento> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TratamientosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _bovinoIdMeta =
      const VerificationMeta('bovinoId');
  @override
  late final GeneratedColumn<int> bovinoId = GeneratedColumn<int>(
      'bovino_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES bovinos (id)'));
  static const VerificationMeta _descripcionMeta =
      const VerificationMeta('descripcion');
  @override
  late final GeneratedColumn<String> descripcion = GeneratedColumn<String>(
      'descripcion', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _fechaMeta = const VerificationMeta('fecha');
  @override
  late final GeneratedColumn<DateTime> fecha = GeneratedColumn<DateTime>(
      'fecha', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _veterinarioMeta =
      const VerificationMeta('veterinario');
  @override
  late final GeneratedColumn<String> veterinario = GeneratedColumn<String>(
      'veterinario', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, bovinoId, descripcion, fecha, veterinario];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tratamientos';
  @override
  VerificationContext validateIntegrity(Insertable<Tratamiento> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('bovino_id')) {
      context.handle(_bovinoIdMeta,
          bovinoId.isAcceptableOrUnknown(data['bovino_id']!, _bovinoIdMeta));
    } else if (isInserting) {
      context.missing(_bovinoIdMeta);
    }
    if (data.containsKey('descripcion')) {
      context.handle(
          _descripcionMeta,
          descripcion.isAcceptableOrUnknown(
              data['descripcion']!, _descripcionMeta));
    } else if (isInserting) {
      context.missing(_descripcionMeta);
    }
    if (data.containsKey('fecha')) {
      context.handle(
          _fechaMeta, fecha.isAcceptableOrUnknown(data['fecha']!, _fechaMeta));
    } else if (isInserting) {
      context.missing(_fechaMeta);
    }
    if (data.containsKey('veterinario')) {
      context.handle(
          _veterinarioMeta,
          veterinario.isAcceptableOrUnknown(
              data['veterinario']!, _veterinarioMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Tratamiento map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Tratamiento(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      bovinoId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}bovino_id'])!,
      descripcion: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}descripcion'])!,
      fecha: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}fecha'])!,
      veterinario: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}veterinario']),
    );
  }

  @override
  $TratamientosTable createAlias(String alias) {
    return $TratamientosTable(attachedDatabase, alias);
  }
}

class Tratamiento extends DataClass implements Insertable<Tratamiento> {
  final int id;
  final int bovinoId;
  final String descripcion;
  final DateTime fecha;
  final String? veterinario;
  const Tratamiento(
      {required this.id,
      required this.bovinoId,
      required this.descripcion,
      required this.fecha,
      this.veterinario});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['bovino_id'] = Variable<int>(bovinoId);
    map['descripcion'] = Variable<String>(descripcion);
    map['fecha'] = Variable<DateTime>(fecha);
    if (!nullToAbsent || veterinario != null) {
      map['veterinario'] = Variable<String>(veterinario);
    }
    return map;
  }

  TratamientosCompanion toCompanion(bool nullToAbsent) {
    return TratamientosCompanion(
      id: Value(id),
      bovinoId: Value(bovinoId),
      descripcion: Value(descripcion),
      fecha: Value(fecha),
      veterinario: veterinario == null && nullToAbsent
          ? const Value.absent()
          : Value(veterinario),
    );
  }

  factory Tratamiento.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Tratamiento(
      id: serializer.fromJson<int>(json['id']),
      bovinoId: serializer.fromJson<int>(json['bovinoId']),
      descripcion: serializer.fromJson<String>(json['descripcion']),
      fecha: serializer.fromJson<DateTime>(json['fecha']),
      veterinario: serializer.fromJson<String?>(json['veterinario']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'bovinoId': serializer.toJson<int>(bovinoId),
      'descripcion': serializer.toJson<String>(descripcion),
      'fecha': serializer.toJson<DateTime>(fecha),
      'veterinario': serializer.toJson<String?>(veterinario),
    };
  }

  Tratamiento copyWith(
          {int? id,
          int? bovinoId,
          String? descripcion,
          DateTime? fecha,
          Value<String?> veterinario = const Value.absent()}) =>
      Tratamiento(
        id: id ?? this.id,
        bovinoId: bovinoId ?? this.bovinoId,
        descripcion: descripcion ?? this.descripcion,
        fecha: fecha ?? this.fecha,
        veterinario: veterinario.present ? veterinario.value : this.veterinario,
      );
  Tratamiento copyWithCompanion(TratamientosCompanion data) {
    return Tratamiento(
      id: data.id.present ? data.id.value : this.id,
      bovinoId: data.bovinoId.present ? data.bovinoId.value : this.bovinoId,
      descripcion:
          data.descripcion.present ? data.descripcion.value : this.descripcion,
      fecha: data.fecha.present ? data.fecha.value : this.fecha,
      veterinario:
          data.veterinario.present ? data.veterinario.value : this.veterinario,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Tratamiento(')
          ..write('id: $id, ')
          ..write('bovinoId: $bovinoId, ')
          ..write('descripcion: $descripcion, ')
          ..write('fecha: $fecha, ')
          ..write('veterinario: $veterinario')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, bovinoId, descripcion, fecha, veterinario);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Tratamiento &&
          other.id == this.id &&
          other.bovinoId == this.bovinoId &&
          other.descripcion == this.descripcion &&
          other.fecha == this.fecha &&
          other.veterinario == this.veterinario);
}

class TratamientosCompanion extends UpdateCompanion<Tratamiento> {
  final Value<int> id;
  final Value<int> bovinoId;
  final Value<String> descripcion;
  final Value<DateTime> fecha;
  final Value<String?> veterinario;
  const TratamientosCompanion({
    this.id = const Value.absent(),
    this.bovinoId = const Value.absent(),
    this.descripcion = const Value.absent(),
    this.fecha = const Value.absent(),
    this.veterinario = const Value.absent(),
  });
  TratamientosCompanion.insert({
    this.id = const Value.absent(),
    required int bovinoId,
    required String descripcion,
    required DateTime fecha,
    this.veterinario = const Value.absent(),
  })  : bovinoId = Value(bovinoId),
        descripcion = Value(descripcion),
        fecha = Value(fecha);
  static Insertable<Tratamiento> custom({
    Expression<int>? id,
    Expression<int>? bovinoId,
    Expression<String>? descripcion,
    Expression<DateTime>? fecha,
    Expression<String>? veterinario,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (bovinoId != null) 'bovino_id': bovinoId,
      if (descripcion != null) 'descripcion': descripcion,
      if (fecha != null) 'fecha': fecha,
      if (veterinario != null) 'veterinario': veterinario,
    });
  }

  TratamientosCompanion copyWith(
      {Value<int>? id,
      Value<int>? bovinoId,
      Value<String>? descripcion,
      Value<DateTime>? fecha,
      Value<String?>? veterinario}) {
    return TratamientosCompanion(
      id: id ?? this.id,
      bovinoId: bovinoId ?? this.bovinoId,
      descripcion: descripcion ?? this.descripcion,
      fecha: fecha ?? this.fecha,
      veterinario: veterinario ?? this.veterinario,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (bovinoId.present) {
      map['bovino_id'] = Variable<int>(bovinoId.value);
    }
    if (descripcion.present) {
      map['descripcion'] = Variable<String>(descripcion.value);
    }
    if (fecha.present) {
      map['fecha'] = Variable<DateTime>(fecha.value);
    }
    if (veterinario.present) {
      map['veterinario'] = Variable<String>(veterinario.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TratamientosCompanion(')
          ..write('id: $id, ')
          ..write('bovinoId: $bovinoId, ')
          ..write('descripcion: $descripcion, ')
          ..write('fecha: $fecha, ')
          ..write('veterinario: $veterinario')
          ..write(')'))
        .toString();
  }
}

class $RegistroReproductivoTable extends RegistroReproductivo
    with TableInfo<$RegistroReproductivoTable, RegistroReproductivoData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RegistroReproductivoTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _bovinoIdMeta =
      const VerificationMeta('bovinoId');
  @override
  late final GeneratedColumn<int> bovinoId = GeneratedColumn<int>(
      'bovino_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES bovinos (id)'));
  static const VerificationMeta _tipoMeta = const VerificationMeta('tipo');
  @override
  late final GeneratedColumn<String> tipo = GeneratedColumn<String>(
      'tipo', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _diagnosticoMeta =
      const VerificationMeta('diagnostico');
  @override
  late final GeneratedColumn<String> diagnostico = GeneratedColumn<String>(
      'diagnostico', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _fechaMeta = const VerificationMeta('fecha');
  @override
  late final GeneratedColumn<DateTime> fecha = GeneratedColumn<DateTime>(
      'fecha', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _fechaProbablePartoMeta =
      const VerificationMeta('fechaProbableParto');
  @override
  late final GeneratedColumn<DateTime> fechaProbableParto =
      GeneratedColumn<DateTime>('fecha_probable_parto', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _toroIdMeta = const VerificationMeta('toroId');
  @override
  late final GeneratedColumn<int> toroId = GeneratedColumn<int>(
      'toro_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES toros (id)'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, bovinoId, tipo, diagnostico, fecha, fechaProbableParto, toroId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'registro_reproductivo';
  @override
  VerificationContext validateIntegrity(
      Insertable<RegistroReproductivoData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('bovino_id')) {
      context.handle(_bovinoIdMeta,
          bovinoId.isAcceptableOrUnknown(data['bovino_id']!, _bovinoIdMeta));
    } else if (isInserting) {
      context.missing(_bovinoIdMeta);
    }
    if (data.containsKey('tipo')) {
      context.handle(
          _tipoMeta, tipo.isAcceptableOrUnknown(data['tipo']!, _tipoMeta));
    } else if (isInserting) {
      context.missing(_tipoMeta);
    }
    if (data.containsKey('diagnostico')) {
      context.handle(
          _diagnosticoMeta,
          diagnostico.isAcceptableOrUnknown(
              data['diagnostico']!, _diagnosticoMeta));
    }
    if (data.containsKey('fecha')) {
      context.handle(
          _fechaMeta, fecha.isAcceptableOrUnknown(data['fecha']!, _fechaMeta));
    } else if (isInserting) {
      context.missing(_fechaMeta);
    }
    if (data.containsKey('fecha_probable_parto')) {
      context.handle(
          _fechaProbablePartoMeta,
          fechaProbableParto.isAcceptableOrUnknown(
              data['fecha_probable_parto']!, _fechaProbablePartoMeta));
    }
    if (data.containsKey('toro_id')) {
      context.handle(_toroIdMeta,
          toroId.isAcceptableOrUnknown(data['toro_id']!, _toroIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RegistroReproductivoData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RegistroReproductivoData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      bovinoId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}bovino_id'])!,
      tipo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tipo'])!,
      diagnostico: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}diagnostico']),
      fecha: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}fecha'])!,
      fechaProbableParto: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime,
          data['${effectivePrefix}fecha_probable_parto']),
      toroId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}toro_id']),
    );
  }

  @override
  $RegistroReproductivoTable createAlias(String alias) {
    return $RegistroReproductivoTable(attachedDatabase, alias);
  }
}

class RegistroReproductivoData extends DataClass
    implements Insertable<RegistroReproductivoData> {
  final int id;
  final int bovinoId;
  final String tipo;
  final String? diagnostico;
  final DateTime fecha;
  final DateTime? fechaProbableParto;
  final int? toroId;
  const RegistroReproductivoData(
      {required this.id,
      required this.bovinoId,
      required this.tipo,
      this.diagnostico,
      required this.fecha,
      this.fechaProbableParto,
      this.toroId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['bovino_id'] = Variable<int>(bovinoId);
    map['tipo'] = Variable<String>(tipo);
    if (!nullToAbsent || diagnostico != null) {
      map['diagnostico'] = Variable<String>(diagnostico);
    }
    map['fecha'] = Variable<DateTime>(fecha);
    if (!nullToAbsent || fechaProbableParto != null) {
      map['fecha_probable_parto'] = Variable<DateTime>(fechaProbableParto);
    }
    if (!nullToAbsent || toroId != null) {
      map['toro_id'] = Variable<int>(toroId);
    }
    return map;
  }

  RegistroReproductivoCompanion toCompanion(bool nullToAbsent) {
    return RegistroReproductivoCompanion(
      id: Value(id),
      bovinoId: Value(bovinoId),
      tipo: Value(tipo),
      diagnostico: diagnostico == null && nullToAbsent
          ? const Value.absent()
          : Value(diagnostico),
      fecha: Value(fecha),
      fechaProbableParto: fechaProbableParto == null && nullToAbsent
          ? const Value.absent()
          : Value(fechaProbableParto),
      toroId:
          toroId == null && nullToAbsent ? const Value.absent() : Value(toroId),
    );
  }

  factory RegistroReproductivoData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RegistroReproductivoData(
      id: serializer.fromJson<int>(json['id']),
      bovinoId: serializer.fromJson<int>(json['bovinoId']),
      tipo: serializer.fromJson<String>(json['tipo']),
      diagnostico: serializer.fromJson<String?>(json['diagnostico']),
      fecha: serializer.fromJson<DateTime>(json['fecha']),
      fechaProbableParto:
          serializer.fromJson<DateTime?>(json['fechaProbableParto']),
      toroId: serializer.fromJson<int?>(json['toroId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'bovinoId': serializer.toJson<int>(bovinoId),
      'tipo': serializer.toJson<String>(tipo),
      'diagnostico': serializer.toJson<String?>(diagnostico),
      'fecha': serializer.toJson<DateTime>(fecha),
      'fechaProbableParto': serializer.toJson<DateTime?>(fechaProbableParto),
      'toroId': serializer.toJson<int?>(toroId),
    };
  }

  RegistroReproductivoData copyWith(
          {int? id,
          int? bovinoId,
          String? tipo,
          Value<String?> diagnostico = const Value.absent(),
          DateTime? fecha,
          Value<DateTime?> fechaProbableParto = const Value.absent(),
          Value<int?> toroId = const Value.absent()}) =>
      RegistroReproductivoData(
        id: id ?? this.id,
        bovinoId: bovinoId ?? this.bovinoId,
        tipo: tipo ?? this.tipo,
        diagnostico: diagnostico.present ? diagnostico.value : this.diagnostico,
        fecha: fecha ?? this.fecha,
        fechaProbableParto: fechaProbableParto.present
            ? fechaProbableParto.value
            : this.fechaProbableParto,
        toroId: toroId.present ? toroId.value : this.toroId,
      );
  RegistroReproductivoData copyWithCompanion(
      RegistroReproductivoCompanion data) {
    return RegistroReproductivoData(
      id: data.id.present ? data.id.value : this.id,
      bovinoId: data.bovinoId.present ? data.bovinoId.value : this.bovinoId,
      tipo: data.tipo.present ? data.tipo.value : this.tipo,
      diagnostico:
          data.diagnostico.present ? data.diagnostico.value : this.diagnostico,
      fecha: data.fecha.present ? data.fecha.value : this.fecha,
      fechaProbableParto: data.fechaProbableParto.present
          ? data.fechaProbableParto.value
          : this.fechaProbableParto,
      toroId: data.toroId.present ? data.toroId.value : this.toroId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RegistroReproductivoData(')
          ..write('id: $id, ')
          ..write('bovinoId: $bovinoId, ')
          ..write('tipo: $tipo, ')
          ..write('diagnostico: $diagnostico, ')
          ..write('fecha: $fecha, ')
          ..write('fechaProbableParto: $fechaProbableParto, ')
          ..write('toroId: $toroId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, bovinoId, tipo, diagnostico, fecha, fechaProbableParto, toroId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RegistroReproductivoData &&
          other.id == this.id &&
          other.bovinoId == this.bovinoId &&
          other.tipo == this.tipo &&
          other.diagnostico == this.diagnostico &&
          other.fecha == this.fecha &&
          other.fechaProbableParto == this.fechaProbableParto &&
          other.toroId == this.toroId);
}

class RegistroReproductivoCompanion
    extends UpdateCompanion<RegistroReproductivoData> {
  final Value<int> id;
  final Value<int> bovinoId;
  final Value<String> tipo;
  final Value<String?> diagnostico;
  final Value<DateTime> fecha;
  final Value<DateTime?> fechaProbableParto;
  final Value<int?> toroId;
  const RegistroReproductivoCompanion({
    this.id = const Value.absent(),
    this.bovinoId = const Value.absent(),
    this.tipo = const Value.absent(),
    this.diagnostico = const Value.absent(),
    this.fecha = const Value.absent(),
    this.fechaProbableParto = const Value.absent(),
    this.toroId = const Value.absent(),
  });
  RegistroReproductivoCompanion.insert({
    this.id = const Value.absent(),
    required int bovinoId,
    required String tipo,
    this.diagnostico = const Value.absent(),
    required DateTime fecha,
    this.fechaProbableParto = const Value.absent(),
    this.toroId = const Value.absent(),
  })  : bovinoId = Value(bovinoId),
        tipo = Value(tipo),
        fecha = Value(fecha);
  static Insertable<RegistroReproductivoData> custom({
    Expression<int>? id,
    Expression<int>? bovinoId,
    Expression<String>? tipo,
    Expression<String>? diagnostico,
    Expression<DateTime>? fecha,
    Expression<DateTime>? fechaProbableParto,
    Expression<int>? toroId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (bovinoId != null) 'bovino_id': bovinoId,
      if (tipo != null) 'tipo': tipo,
      if (diagnostico != null) 'diagnostico': diagnostico,
      if (fecha != null) 'fecha': fecha,
      if (fechaProbableParto != null)
        'fecha_probable_parto': fechaProbableParto,
      if (toroId != null) 'toro_id': toroId,
    });
  }

  RegistroReproductivoCompanion copyWith(
      {Value<int>? id,
      Value<int>? bovinoId,
      Value<String>? tipo,
      Value<String?>? diagnostico,
      Value<DateTime>? fecha,
      Value<DateTime?>? fechaProbableParto,
      Value<int?>? toroId}) {
    return RegistroReproductivoCompanion(
      id: id ?? this.id,
      bovinoId: bovinoId ?? this.bovinoId,
      tipo: tipo ?? this.tipo,
      diagnostico: diagnostico ?? this.diagnostico,
      fecha: fecha ?? this.fecha,
      fechaProbableParto: fechaProbableParto ?? this.fechaProbableParto,
      toroId: toroId ?? this.toroId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (bovinoId.present) {
      map['bovino_id'] = Variable<int>(bovinoId.value);
    }
    if (tipo.present) {
      map['tipo'] = Variable<String>(tipo.value);
    }
    if (diagnostico.present) {
      map['diagnostico'] = Variable<String>(diagnostico.value);
    }
    if (fecha.present) {
      map['fecha'] = Variable<DateTime>(fecha.value);
    }
    if (fechaProbableParto.present) {
      map['fecha_probable_parto'] =
          Variable<DateTime>(fechaProbableParto.value);
    }
    if (toroId.present) {
      map['toro_id'] = Variable<int>(toroId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RegistroReproductivoCompanion(')
          ..write('id: $id, ')
          ..write('bovinoId: $bovinoId, ')
          ..write('tipo: $tipo, ')
          ..write('diagnostico: $diagnostico, ')
          ..write('fecha: $fecha, ')
          ..write('fechaProbableParto: $fechaProbableParto, ')
          ..write('toroId: $toroId')
          ..write(')'))
        .toString();
  }
}

class $FotosTable extends Fotos with TableInfo<$FotosTable, Foto> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FotosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _bovinoIdMeta =
      const VerificationMeta('bovinoId');
  @override
  late final GeneratedColumn<int> bovinoId = GeneratedColumn<int>(
      'bovino_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES bovinos (id)'));
  static const VerificationMeta _rutaFotoMeta =
      const VerificationMeta('rutaFoto');
  @override
  late final GeneratedColumn<String> rutaFoto = GeneratedColumn<String>(
      'ruta_foto', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _fechaCapturaMeta =
      const VerificationMeta('fechaCaptura');
  @override
  late final GeneratedColumn<DateTime> fechaCaptura = GeneratedColumn<DateTime>(
      'fecha_captura', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _descripcionMeta =
      const VerificationMeta('descripcion');
  @override
  late final GeneratedColumn<String> descripcion = GeneratedColumn<String>(
      'descripcion', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, bovinoId, rutaFoto, fechaCaptura, descripcion];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'fotos';
  @override
  VerificationContext validateIntegrity(Insertable<Foto> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('bovino_id')) {
      context.handle(_bovinoIdMeta,
          bovinoId.isAcceptableOrUnknown(data['bovino_id']!, _bovinoIdMeta));
    } else if (isInserting) {
      context.missing(_bovinoIdMeta);
    }
    if (data.containsKey('ruta_foto')) {
      context.handle(_rutaFotoMeta,
          rutaFoto.isAcceptableOrUnknown(data['ruta_foto']!, _rutaFotoMeta));
    } else if (isInserting) {
      context.missing(_rutaFotoMeta);
    }
    if (data.containsKey('fecha_captura')) {
      context.handle(
          _fechaCapturaMeta,
          fechaCaptura.isAcceptableOrUnknown(
              data['fecha_captura']!, _fechaCapturaMeta));
    }
    if (data.containsKey('descripcion')) {
      context.handle(
          _descripcionMeta,
          descripcion.isAcceptableOrUnknown(
              data['descripcion']!, _descripcionMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Foto map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Foto(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      bovinoId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}bovino_id'])!,
      rutaFoto: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}ruta_foto'])!,
      fechaCaptura: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}fecha_captura'])!,
      descripcion: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}descripcion']),
    );
  }

  @override
  $FotosTable createAlias(String alias) {
    return $FotosTable(attachedDatabase, alias);
  }
}

class Foto extends DataClass implements Insertable<Foto> {
  final int id;
  final int bovinoId;
  final String rutaFoto;
  final DateTime fechaCaptura;
  final String? descripcion;
  const Foto(
      {required this.id,
      required this.bovinoId,
      required this.rutaFoto,
      required this.fechaCaptura,
      this.descripcion});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['bovino_id'] = Variable<int>(bovinoId);
    map['ruta_foto'] = Variable<String>(rutaFoto);
    map['fecha_captura'] = Variable<DateTime>(fechaCaptura);
    if (!nullToAbsent || descripcion != null) {
      map['descripcion'] = Variable<String>(descripcion);
    }
    return map;
  }

  FotosCompanion toCompanion(bool nullToAbsent) {
    return FotosCompanion(
      id: Value(id),
      bovinoId: Value(bovinoId),
      rutaFoto: Value(rutaFoto),
      fechaCaptura: Value(fechaCaptura),
      descripcion: descripcion == null && nullToAbsent
          ? const Value.absent()
          : Value(descripcion),
    );
  }

  factory Foto.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Foto(
      id: serializer.fromJson<int>(json['id']),
      bovinoId: serializer.fromJson<int>(json['bovinoId']),
      rutaFoto: serializer.fromJson<String>(json['rutaFoto']),
      fechaCaptura: serializer.fromJson<DateTime>(json['fechaCaptura']),
      descripcion: serializer.fromJson<String?>(json['descripcion']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'bovinoId': serializer.toJson<int>(bovinoId),
      'rutaFoto': serializer.toJson<String>(rutaFoto),
      'fechaCaptura': serializer.toJson<DateTime>(fechaCaptura),
      'descripcion': serializer.toJson<String?>(descripcion),
    };
  }

  Foto copyWith(
          {int? id,
          int? bovinoId,
          String? rutaFoto,
          DateTime? fechaCaptura,
          Value<String?> descripcion = const Value.absent()}) =>
      Foto(
        id: id ?? this.id,
        bovinoId: bovinoId ?? this.bovinoId,
        rutaFoto: rutaFoto ?? this.rutaFoto,
        fechaCaptura: fechaCaptura ?? this.fechaCaptura,
        descripcion: descripcion.present ? descripcion.value : this.descripcion,
      );
  Foto copyWithCompanion(FotosCompanion data) {
    return Foto(
      id: data.id.present ? data.id.value : this.id,
      bovinoId: data.bovinoId.present ? data.bovinoId.value : this.bovinoId,
      rutaFoto: data.rutaFoto.present ? data.rutaFoto.value : this.rutaFoto,
      fechaCaptura: data.fechaCaptura.present
          ? data.fechaCaptura.value
          : this.fechaCaptura,
      descripcion:
          data.descripcion.present ? data.descripcion.value : this.descripcion,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Foto(')
          ..write('id: $id, ')
          ..write('bovinoId: $bovinoId, ')
          ..write('rutaFoto: $rutaFoto, ')
          ..write('fechaCaptura: $fechaCaptura, ')
          ..write('descripcion: $descripcion')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, bovinoId, rutaFoto, fechaCaptura, descripcion);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Foto &&
          other.id == this.id &&
          other.bovinoId == this.bovinoId &&
          other.rutaFoto == this.rutaFoto &&
          other.fechaCaptura == this.fechaCaptura &&
          other.descripcion == this.descripcion);
}

class FotosCompanion extends UpdateCompanion<Foto> {
  final Value<int> id;
  final Value<int> bovinoId;
  final Value<String> rutaFoto;
  final Value<DateTime> fechaCaptura;
  final Value<String?> descripcion;
  const FotosCompanion({
    this.id = const Value.absent(),
    this.bovinoId = const Value.absent(),
    this.rutaFoto = const Value.absent(),
    this.fechaCaptura = const Value.absent(),
    this.descripcion = const Value.absent(),
  });
  FotosCompanion.insert({
    this.id = const Value.absent(),
    required int bovinoId,
    required String rutaFoto,
    this.fechaCaptura = const Value.absent(),
    this.descripcion = const Value.absent(),
  })  : bovinoId = Value(bovinoId),
        rutaFoto = Value(rutaFoto);
  static Insertable<Foto> custom({
    Expression<int>? id,
    Expression<int>? bovinoId,
    Expression<String>? rutaFoto,
    Expression<DateTime>? fechaCaptura,
    Expression<String>? descripcion,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (bovinoId != null) 'bovino_id': bovinoId,
      if (rutaFoto != null) 'ruta_foto': rutaFoto,
      if (fechaCaptura != null) 'fecha_captura': fechaCaptura,
      if (descripcion != null) 'descripcion': descripcion,
    });
  }

  FotosCompanion copyWith(
      {Value<int>? id,
      Value<int>? bovinoId,
      Value<String>? rutaFoto,
      Value<DateTime>? fechaCaptura,
      Value<String?>? descripcion}) {
    return FotosCompanion(
      id: id ?? this.id,
      bovinoId: bovinoId ?? this.bovinoId,
      rutaFoto: rutaFoto ?? this.rutaFoto,
      fechaCaptura: fechaCaptura ?? this.fechaCaptura,
      descripcion: descripcion ?? this.descripcion,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (bovinoId.present) {
      map['bovino_id'] = Variable<int>(bovinoId.value);
    }
    if (rutaFoto.present) {
      map['ruta_foto'] = Variable<String>(rutaFoto.value);
    }
    if (fechaCaptura.present) {
      map['fecha_captura'] = Variable<DateTime>(fechaCaptura.value);
    }
    if (descripcion.present) {
      map['descripcion'] = Variable<String>(descripcion.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FotosCompanion(')
          ..write('id: $id, ')
          ..write('bovinoId: $bovinoId, ')
          ..write('rutaFoto: $rutaFoto, ')
          ..write('fechaCaptura: $fechaCaptura, ')
          ..write('descripcion: $descripcion')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $RazasTable razas = $RazasTable(this);
  late final $LotesTable lotes = $LotesTable(this);
  late final $DuenosTable duenos = $DuenosTable(this);
  late final $BovinosTable bovinos = $BovinosTable(this);
  late final $PertenenciaTable pertenencia = $PertenenciaTable(this);
  late final $ProgenieTable progenie = $ProgenieTable(this);
  late final $PartosTable partos = $PartosTable(this);
  late final $VentasTable ventas = $VentasTable(this);
  late final $TorosTable toros = $TorosTable(this);
  late final $VacunasTable vacunas = $VacunasTable(this);
  late final $TratamientosTable tratamientos = $TratamientosTable(this);
  late final $RegistroReproductivoTable registroReproductivo =
      $RegistroReproductivoTable(this);
  late final $FotosTable fotos = $FotosTable(this);
  late final BovinosDao bovinosDao = BovinosDao(this as AppDatabase);
  late final DuenosDao duenosDao = DuenosDao(this as AppDatabase);
  late final FotosDao fotosDao = FotosDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        razas,
        lotes,
        duenos,
        bovinos,
        pertenencia,
        progenie,
        partos,
        ventas,
        toros,
        vacunas,
        tratamientos,
        registroReproductivo,
        fotos
      ];
}

typedef $$RazasTableCreateCompanionBuilder = RazasCompanion Function({
  Value<int> id,
  required String nombre,
});
typedef $$RazasTableUpdateCompanionBuilder = RazasCompanion Function({
  Value<int> id,
  Value<String> nombre,
});

final class $$RazasTableReferences
    extends BaseReferences<_$AppDatabase, $RazasTable, Raza> {
  $$RazasTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$BovinosTable, List<Bovino>> _bovinosRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.bovinos,
          aliasName: $_aliasNameGenerator(db.razas.id, db.bovinos.razaId));

  $$BovinosTableProcessedTableManager get bovinosRefs {
    final manager = $$BovinosTableTableManager($_db, $_db.bovinos)
        .filter((f) => f.razaId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_bovinosRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$RazasTableFilterComposer extends Composer<_$AppDatabase, $RazasTable> {
  $$RazasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nombre => $composableBuilder(
      column: $table.nombre, builder: (column) => ColumnFilters(column));

  Expression<bool> bovinosRefs(
      Expression<bool> Function($$BovinosTableFilterComposer f) f) {
    final $$BovinosTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.bovinos,
        getReferencedColumn: (t) => t.razaId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinosTableFilterComposer(
              $db: $db,
              $table: $db.bovinos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$RazasTableOrderingComposer
    extends Composer<_$AppDatabase, $RazasTable> {
  $$RazasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nombre => $composableBuilder(
      column: $table.nombre, builder: (column) => ColumnOrderings(column));
}

class $$RazasTableAnnotationComposer
    extends Composer<_$AppDatabase, $RazasTable> {
  $$RazasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  Expression<T> bovinosRefs<T extends Object>(
      Expression<T> Function($$BovinosTableAnnotationComposer a) f) {
    final $$BovinosTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.bovinos,
        getReferencedColumn: (t) => t.razaId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinosTableAnnotationComposer(
              $db: $db,
              $table: $db.bovinos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$RazasTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RazasTable,
    Raza,
    $$RazasTableFilterComposer,
    $$RazasTableOrderingComposer,
    $$RazasTableAnnotationComposer,
    $$RazasTableCreateCompanionBuilder,
    $$RazasTableUpdateCompanionBuilder,
    (Raza, $$RazasTableReferences),
    Raza,
    PrefetchHooks Function({bool bovinosRefs})> {
  $$RazasTableTableManager(_$AppDatabase db, $RazasTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RazasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RazasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RazasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> nombre = const Value.absent(),
          }) =>
              RazasCompanion(
            id: id,
            nombre: nombre,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String nombre,
          }) =>
              RazasCompanion.insert(
            id: id,
            nombre: nombre,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$RazasTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({bovinosRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (bovinosRefs) db.bovinos],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (bovinosRefs)
                    await $_getPrefetchedData<Raza, $RazasTable, Bovino>(
                        currentTable: table,
                        referencedTable:
                            $$RazasTableReferences._bovinosRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$RazasTableReferences(db, table, p0).bovinosRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.razaId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$RazasTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $RazasTable,
    Raza,
    $$RazasTableFilterComposer,
    $$RazasTableOrderingComposer,
    $$RazasTableAnnotationComposer,
    $$RazasTableCreateCompanionBuilder,
    $$RazasTableUpdateCompanionBuilder,
    (Raza, $$RazasTableReferences),
    Raza,
    PrefetchHooks Function({bool bovinosRefs})>;
typedef $$LotesTableCreateCompanionBuilder = LotesCompanion Function({
  Value<int> id,
  required String clave,
  Value<String?> descripcion,
});
typedef $$LotesTableUpdateCompanionBuilder = LotesCompanion Function({
  Value<int> id,
  Value<String> clave,
  Value<String?> descripcion,
});

final class $$LotesTableReferences
    extends BaseReferences<_$AppDatabase, $LotesTable, Lote> {
  $$LotesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$BovinosTable, List<Bovino>> _bovinosRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.bovinos,
          aliasName: $_aliasNameGenerator(db.lotes.id, db.bovinos.loteId));

  $$BovinosTableProcessedTableManager get bovinosRefs {
    final manager = $$BovinosTableTableManager($_db, $_db.bovinos)
        .filter((f) => f.loteId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_bovinosRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$LotesTableFilterComposer extends Composer<_$AppDatabase, $LotesTable> {
  $$LotesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get clave => $composableBuilder(
      column: $table.clave, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get descripcion => $composableBuilder(
      column: $table.descripcion, builder: (column) => ColumnFilters(column));

  Expression<bool> bovinosRefs(
      Expression<bool> Function($$BovinosTableFilterComposer f) f) {
    final $$BovinosTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.bovinos,
        getReferencedColumn: (t) => t.loteId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinosTableFilterComposer(
              $db: $db,
              $table: $db.bovinos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$LotesTableOrderingComposer
    extends Composer<_$AppDatabase, $LotesTable> {
  $$LotesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get clave => $composableBuilder(
      column: $table.clave, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get descripcion => $composableBuilder(
      column: $table.descripcion, builder: (column) => ColumnOrderings(column));
}

class $$LotesTableAnnotationComposer
    extends Composer<_$AppDatabase, $LotesTable> {
  $$LotesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get clave =>
      $composableBuilder(column: $table.clave, builder: (column) => column);

  GeneratedColumn<String> get descripcion => $composableBuilder(
      column: $table.descripcion, builder: (column) => column);

  Expression<T> bovinosRefs<T extends Object>(
      Expression<T> Function($$BovinosTableAnnotationComposer a) f) {
    final $$BovinosTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.bovinos,
        getReferencedColumn: (t) => t.loteId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinosTableAnnotationComposer(
              $db: $db,
              $table: $db.bovinos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$LotesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LotesTable,
    Lote,
    $$LotesTableFilterComposer,
    $$LotesTableOrderingComposer,
    $$LotesTableAnnotationComposer,
    $$LotesTableCreateCompanionBuilder,
    $$LotesTableUpdateCompanionBuilder,
    (Lote, $$LotesTableReferences),
    Lote,
    PrefetchHooks Function({bool bovinosRefs})> {
  $$LotesTableTableManager(_$AppDatabase db, $LotesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LotesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LotesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LotesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> clave = const Value.absent(),
            Value<String?> descripcion = const Value.absent(),
          }) =>
              LotesCompanion(
            id: id,
            clave: clave,
            descripcion: descripcion,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String clave,
            Value<String?> descripcion = const Value.absent(),
          }) =>
              LotesCompanion.insert(
            id: id,
            clave: clave,
            descripcion: descripcion,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$LotesTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({bovinosRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (bovinosRefs) db.bovinos],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (bovinosRefs)
                    await $_getPrefetchedData<Lote, $LotesTable, Bovino>(
                        currentTable: table,
                        referencedTable:
                            $$LotesTableReferences._bovinosRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$LotesTableReferences(db, table, p0).bovinosRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.loteId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$LotesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $LotesTable,
    Lote,
    $$LotesTableFilterComposer,
    $$LotesTableOrderingComposer,
    $$LotesTableAnnotationComposer,
    $$LotesTableCreateCompanionBuilder,
    $$LotesTableUpdateCompanionBuilder,
    (Lote, $$LotesTableReferences),
    Lote,
    PrefetchHooks Function({bool bovinosRefs})>;
typedef $$DuenosTableCreateCompanionBuilder = DuenosCompanion Function({
  Value<int> id,
  required String nombre,
  Value<String?> telefono,
  Value<DateTime> createdAt,
});
typedef $$DuenosTableUpdateCompanionBuilder = DuenosCompanion Function({
  Value<int> id,
  Value<String> nombre,
  Value<String?> telefono,
  Value<DateTime> createdAt,
});

final class $$DuenosTableReferences
    extends BaseReferences<_$AppDatabase, $DuenosTable, Dueno> {
  $$DuenosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PertenenciaTable, List<PertenenciaData>>
      _pertenenciaRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.pertenencia,
              aliasName:
                  $_aliasNameGenerator(db.duenos.id, db.pertenencia.duenoId));

  $$PertenenciaTableProcessedTableManager get pertenenciaRefs {
    final manager = $$PertenenciaTableTableManager($_db, $_db.pertenencia)
        .filter((f) => f.duenoId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_pertenenciaRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$DuenosTableFilterComposer
    extends Composer<_$AppDatabase, $DuenosTable> {
  $$DuenosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nombre => $composableBuilder(
      column: $table.nombre, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get telefono => $composableBuilder(
      column: $table.telefono, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  Expression<bool> pertenenciaRefs(
      Expression<bool> Function($$PertenenciaTableFilterComposer f) f) {
    final $$PertenenciaTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.pertenencia,
        getReferencedColumn: (t) => t.duenoId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PertenenciaTableFilterComposer(
              $db: $db,
              $table: $db.pertenencia,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$DuenosTableOrderingComposer
    extends Composer<_$AppDatabase, $DuenosTable> {
  $$DuenosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nombre => $composableBuilder(
      column: $table.nombre, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get telefono => $composableBuilder(
      column: $table.telefono, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$DuenosTableAnnotationComposer
    extends Composer<_$AppDatabase, $DuenosTable> {
  $$DuenosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<String> get telefono =>
      $composableBuilder(column: $table.telefono, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> pertenenciaRefs<T extends Object>(
      Expression<T> Function($$PertenenciaTableAnnotationComposer a) f) {
    final $$PertenenciaTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.pertenencia,
        getReferencedColumn: (t) => t.duenoId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PertenenciaTableAnnotationComposer(
              $db: $db,
              $table: $db.pertenencia,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$DuenosTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DuenosTable,
    Dueno,
    $$DuenosTableFilterComposer,
    $$DuenosTableOrderingComposer,
    $$DuenosTableAnnotationComposer,
    $$DuenosTableCreateCompanionBuilder,
    $$DuenosTableUpdateCompanionBuilder,
    (Dueno, $$DuenosTableReferences),
    Dueno,
    PrefetchHooks Function({bool pertenenciaRefs})> {
  $$DuenosTableTableManager(_$AppDatabase db, $DuenosTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DuenosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DuenosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DuenosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> nombre = const Value.absent(),
            Value<String?> telefono = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              DuenosCompanion(
            id: id,
            nombre: nombre,
            telefono: telefono,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String nombre,
            Value<String?> telefono = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              DuenosCompanion.insert(
            id: id,
            nombre: nombre,
            telefono: telefono,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$DuenosTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({pertenenciaRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (pertenenciaRefs) db.pertenencia],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (pertenenciaRefs)
                    await $_getPrefetchedData<Dueno, $DuenosTable,
                            PertenenciaData>(
                        currentTable: table,
                        referencedTable:
                            $$DuenosTableReferences._pertenenciaRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$DuenosTableReferences(db, table, p0)
                                .pertenenciaRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.duenoId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$DuenosTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $DuenosTable,
    Dueno,
    $$DuenosTableFilterComposer,
    $$DuenosTableOrderingComposer,
    $$DuenosTableAnnotationComposer,
    $$DuenosTableCreateCompanionBuilder,
    $$DuenosTableUpdateCompanionBuilder,
    (Dueno, $$DuenosTableReferences),
    Dueno,
    PrefetchHooks Function({bool pertenenciaRefs})>;
typedef $$BovinosTableCreateCompanionBuilder = BovinosCompanion Function({
  Value<int> id,
  required String areteId,
  Value<String?> numRegistro,
  Value<String?> nombre,
  required String sexo,
  Value<DateTime?> fechaNacimiento,
  Value<DateTime?> fechaMuerte,
  Value<int?> loteId,
  Value<String?> upp,
  Value<int?> razaId,
  Value<String> estado,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$BovinosTableUpdateCompanionBuilder = BovinosCompanion Function({
  Value<int> id,
  Value<String> areteId,
  Value<String?> numRegistro,
  Value<String?> nombre,
  Value<String> sexo,
  Value<DateTime?> fechaNacimiento,
  Value<DateTime?> fechaMuerte,
  Value<int?> loteId,
  Value<String?> upp,
  Value<int?> razaId,
  Value<String> estado,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $$BovinosTableReferences
    extends BaseReferences<_$AppDatabase, $BovinosTable, Bovino> {
  $$BovinosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $LotesTable _loteIdTable(_$AppDatabase db) => db.lotes
      .createAlias($_aliasNameGenerator(db.bovinos.loteId, db.lotes.id));

  $$LotesTableProcessedTableManager? get loteId {
    final $_column = $_itemColumn<int>('lote_id');
    if ($_column == null) return null;
    final manager = $$LotesTableTableManager($_db, $_db.lotes)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_loteIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $RazasTable _razaIdTable(_$AppDatabase db) => db.razas
      .createAlias($_aliasNameGenerator(db.bovinos.razaId, db.razas.id));

  $$RazasTableProcessedTableManager? get razaId {
    final $_column = $_itemColumn<int>('raza_id');
    if ($_column == null) return null;
    final manager = $$RazasTableTableManager($_db, $_db.razas)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_razaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$PertenenciaTable, List<PertenenciaData>>
      _pertenenciaRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.pertenencia,
              aliasName:
                  $_aliasNameGenerator(db.bovinos.id, db.pertenencia.bovinoId));

  $$PertenenciaTableProcessedTableManager get pertenenciaRefs {
    final manager = $$PertenenciaTableTableManager($_db, $_db.pertenencia)
        .filter((f) => f.bovinoId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_pertenenciaRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$ProgenieTable, List<ProgenieData>>
      _progenieHijoRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.progenie,
          aliasName: $_aliasNameGenerator(db.bovinos.id, db.progenie.bovinoId));

  $$ProgenieTableProcessedTableManager get progenieHijoRefs {
    final manager = $$ProgenieTableTableManager($_db, $_db.progenie)
        .filter((f) => f.bovinoId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_progenieHijoRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$ProgenieTable, List<ProgenieData>>
      _progeniePadreRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.progenie,
              aliasName: $_aliasNameGenerator(
                  db.bovinos.id, db.progenie.bovinoPadreId));

  $$ProgenieTableProcessedTableManager get progeniePadreRefs {
    final manager = $$ProgenieTableTableManager($_db, $_db.progenie)
        .filter((f) => f.bovinoPadreId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_progeniePadreRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$ProgenieTable, List<ProgenieData>>
      _progenieMadreRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.progenie,
              aliasName: $_aliasNameGenerator(
                  db.bovinos.id, db.progenie.bovinaMadreId));

  $$ProgenieTableProcessedTableManager get progenieMadreRefs {
    final manager = $$ProgenieTableTableManager($_db, $_db.progenie)
        .filter((f) => f.bovinaMadreId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_progenieMadreRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$PartosTable, List<Parto>> _partosRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.partos,
          aliasName: $_aliasNameGenerator(db.bovinos.id, db.partos.bovinoId));

  $$PartosTableProcessedTableManager get partosRefs {
    final manager = $$PartosTableTableManager($_db, $_db.partos)
        .filter((f) => f.bovinoId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_partosRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$VentasTable, List<Venta>> _ventasRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.ventas,
          aliasName: $_aliasNameGenerator(db.bovinos.id, db.ventas.bovinoId));

  $$VentasTableProcessedTableManager get ventasRefs {
    final manager = $$VentasTableTableManager($_db, $_db.ventas)
        .filter((f) => f.bovinoId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_ventasRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$TorosTable, List<Toro>> _torosRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.toros,
          aliasName: $_aliasNameGenerator(db.bovinos.id, db.toros.bovinoId));

  $$TorosTableProcessedTableManager get torosRefs {
    final manager = $$TorosTableTableManager($_db, $_db.toros)
        .filter((f) => f.bovinoId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_torosRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$VacunasTable, List<Vacuna>> _vacunasRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.vacunas,
          aliasName: $_aliasNameGenerator(db.bovinos.id, db.vacunas.bovinoId));

  $$VacunasTableProcessedTableManager get vacunasRefs {
    final manager = $$VacunasTableTableManager($_db, $_db.vacunas)
        .filter((f) => f.bovinoId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_vacunasRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$TratamientosTable, List<Tratamiento>>
      _tratamientosRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.tratamientos,
          aliasName:
              $_aliasNameGenerator(db.bovinos.id, db.tratamientos.bovinoId));

  $$TratamientosTableProcessedTableManager get tratamientosRefs {
    final manager = $$TratamientosTableTableManager($_db, $_db.tratamientos)
        .filter((f) => f.bovinoId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_tratamientosRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$RegistroReproductivoTable,
      List<RegistroReproductivoData>> _registroReproductivoRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.registroReproductivo,
          aliasName: $_aliasNameGenerator(
              db.bovinos.id, db.registroReproductivo.bovinoId));

  $$RegistroReproductivoTableProcessedTableManager
      get registroReproductivoRefs {
    final manager =
        $$RegistroReproductivoTableTableManager($_db, $_db.registroReproductivo)
            .filter((f) => f.bovinoId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_registroReproductivoRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$FotosTable, List<Foto>> _fotosRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.fotos,
          aliasName: $_aliasNameGenerator(db.bovinos.id, db.fotos.bovinoId));

  $$FotosTableProcessedTableManager get fotosRefs {
    final manager = $$FotosTableTableManager($_db, $_db.fotos)
        .filter((f) => f.bovinoId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_fotosRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$BovinosTableFilterComposer
    extends Composer<_$AppDatabase, $BovinosTable> {
  $$BovinosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get areteId => $composableBuilder(
      column: $table.areteId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get numRegistro => $composableBuilder(
      column: $table.numRegistro, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nombre => $composableBuilder(
      column: $table.nombre, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sexo => $composableBuilder(
      column: $table.sexo, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get fechaNacimiento => $composableBuilder(
      column: $table.fechaNacimiento,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get fechaMuerte => $composableBuilder(
      column: $table.fechaMuerte, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get upp => $composableBuilder(
      column: $table.upp, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get estado => $composableBuilder(
      column: $table.estado, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$LotesTableFilterComposer get loteId {
    final $$LotesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.loteId,
        referencedTable: $db.lotes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LotesTableFilterComposer(
              $db: $db,
              $table: $db.lotes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$RazasTableFilterComposer get razaId {
    final $$RazasTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.razaId,
        referencedTable: $db.razas,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RazasTableFilterComposer(
              $db: $db,
              $table: $db.razas,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> pertenenciaRefs(
      Expression<bool> Function($$PertenenciaTableFilterComposer f) f) {
    final $$PertenenciaTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.pertenencia,
        getReferencedColumn: (t) => t.bovinoId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PertenenciaTableFilterComposer(
              $db: $db,
              $table: $db.pertenencia,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> progenieHijoRefs(
      Expression<bool> Function($$ProgenieTableFilterComposer f) f) {
    final $$ProgenieTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.progenie,
        getReferencedColumn: (t) => t.bovinoId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProgenieTableFilterComposer(
              $db: $db,
              $table: $db.progenie,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> progeniePadreRefs(
      Expression<bool> Function($$ProgenieTableFilterComposer f) f) {
    final $$ProgenieTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.progenie,
        getReferencedColumn: (t) => t.bovinoPadreId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProgenieTableFilterComposer(
              $db: $db,
              $table: $db.progenie,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> progenieMadreRefs(
      Expression<bool> Function($$ProgenieTableFilterComposer f) f) {
    final $$ProgenieTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.progenie,
        getReferencedColumn: (t) => t.bovinaMadreId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProgenieTableFilterComposer(
              $db: $db,
              $table: $db.progenie,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> partosRefs(
      Expression<bool> Function($$PartosTableFilterComposer f) f) {
    final $$PartosTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.partos,
        getReferencedColumn: (t) => t.bovinoId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PartosTableFilterComposer(
              $db: $db,
              $table: $db.partos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> ventasRefs(
      Expression<bool> Function($$VentasTableFilterComposer f) f) {
    final $$VentasTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.ventas,
        getReferencedColumn: (t) => t.bovinoId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$VentasTableFilterComposer(
              $db: $db,
              $table: $db.ventas,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> torosRefs(
      Expression<bool> Function($$TorosTableFilterComposer f) f) {
    final $$TorosTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.toros,
        getReferencedColumn: (t) => t.bovinoId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TorosTableFilterComposer(
              $db: $db,
              $table: $db.toros,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> vacunasRefs(
      Expression<bool> Function($$VacunasTableFilterComposer f) f) {
    final $$VacunasTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.vacunas,
        getReferencedColumn: (t) => t.bovinoId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$VacunasTableFilterComposer(
              $db: $db,
              $table: $db.vacunas,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> tratamientosRefs(
      Expression<bool> Function($$TratamientosTableFilterComposer f) f) {
    final $$TratamientosTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.tratamientos,
        getReferencedColumn: (t) => t.bovinoId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TratamientosTableFilterComposer(
              $db: $db,
              $table: $db.tratamientos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> registroReproductivoRefs(
      Expression<bool> Function($$RegistroReproductivoTableFilterComposer f)
          f) {
    final $$RegistroReproductivoTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.registroReproductivo,
        getReferencedColumn: (t) => t.bovinoId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RegistroReproductivoTableFilterComposer(
              $db: $db,
              $table: $db.registroReproductivo,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> fotosRefs(
      Expression<bool> Function($$FotosTableFilterComposer f) f) {
    final $$FotosTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.fotos,
        getReferencedColumn: (t) => t.bovinoId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FotosTableFilterComposer(
              $db: $db,
              $table: $db.fotos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$BovinosTableOrderingComposer
    extends Composer<_$AppDatabase, $BovinosTable> {
  $$BovinosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get areteId => $composableBuilder(
      column: $table.areteId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get numRegistro => $composableBuilder(
      column: $table.numRegistro, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nombre => $composableBuilder(
      column: $table.nombre, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sexo => $composableBuilder(
      column: $table.sexo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get fechaNacimiento => $composableBuilder(
      column: $table.fechaNacimiento,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get fechaMuerte => $composableBuilder(
      column: $table.fechaMuerte, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get upp => $composableBuilder(
      column: $table.upp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get estado => $composableBuilder(
      column: $table.estado, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$LotesTableOrderingComposer get loteId {
    final $$LotesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.loteId,
        referencedTable: $db.lotes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LotesTableOrderingComposer(
              $db: $db,
              $table: $db.lotes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$RazasTableOrderingComposer get razaId {
    final $$RazasTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.razaId,
        referencedTable: $db.razas,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RazasTableOrderingComposer(
              $db: $db,
              $table: $db.razas,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$BovinosTableAnnotationComposer
    extends Composer<_$AppDatabase, $BovinosTable> {
  $$BovinosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get areteId =>
      $composableBuilder(column: $table.areteId, builder: (column) => column);

  GeneratedColumn<String> get numRegistro => $composableBuilder(
      column: $table.numRegistro, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<String> get sexo =>
      $composableBuilder(column: $table.sexo, builder: (column) => column);

  GeneratedColumn<DateTime> get fechaNacimiento => $composableBuilder(
      column: $table.fechaNacimiento, builder: (column) => column);

  GeneratedColumn<DateTime> get fechaMuerte => $composableBuilder(
      column: $table.fechaMuerte, builder: (column) => column);

  GeneratedColumn<String> get upp =>
      $composableBuilder(column: $table.upp, builder: (column) => column);

  GeneratedColumn<String> get estado =>
      $composableBuilder(column: $table.estado, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$LotesTableAnnotationComposer get loteId {
    final $$LotesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.loteId,
        referencedTable: $db.lotes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LotesTableAnnotationComposer(
              $db: $db,
              $table: $db.lotes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$RazasTableAnnotationComposer get razaId {
    final $$RazasTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.razaId,
        referencedTable: $db.razas,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RazasTableAnnotationComposer(
              $db: $db,
              $table: $db.razas,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> pertenenciaRefs<T extends Object>(
      Expression<T> Function($$PertenenciaTableAnnotationComposer a) f) {
    final $$PertenenciaTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.pertenencia,
        getReferencedColumn: (t) => t.bovinoId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PertenenciaTableAnnotationComposer(
              $db: $db,
              $table: $db.pertenencia,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> progenieHijoRefs<T extends Object>(
      Expression<T> Function($$ProgenieTableAnnotationComposer a) f) {
    final $$ProgenieTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.progenie,
        getReferencedColumn: (t) => t.bovinoId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProgenieTableAnnotationComposer(
              $db: $db,
              $table: $db.progenie,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> progeniePadreRefs<T extends Object>(
      Expression<T> Function($$ProgenieTableAnnotationComposer a) f) {
    final $$ProgenieTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.progenie,
        getReferencedColumn: (t) => t.bovinoPadreId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProgenieTableAnnotationComposer(
              $db: $db,
              $table: $db.progenie,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> progenieMadreRefs<T extends Object>(
      Expression<T> Function($$ProgenieTableAnnotationComposer a) f) {
    final $$ProgenieTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.progenie,
        getReferencedColumn: (t) => t.bovinaMadreId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProgenieTableAnnotationComposer(
              $db: $db,
              $table: $db.progenie,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> partosRefs<T extends Object>(
      Expression<T> Function($$PartosTableAnnotationComposer a) f) {
    final $$PartosTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.partos,
        getReferencedColumn: (t) => t.bovinoId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PartosTableAnnotationComposer(
              $db: $db,
              $table: $db.partos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> ventasRefs<T extends Object>(
      Expression<T> Function($$VentasTableAnnotationComposer a) f) {
    final $$VentasTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.ventas,
        getReferencedColumn: (t) => t.bovinoId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$VentasTableAnnotationComposer(
              $db: $db,
              $table: $db.ventas,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> torosRefs<T extends Object>(
      Expression<T> Function($$TorosTableAnnotationComposer a) f) {
    final $$TorosTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.toros,
        getReferencedColumn: (t) => t.bovinoId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TorosTableAnnotationComposer(
              $db: $db,
              $table: $db.toros,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> vacunasRefs<T extends Object>(
      Expression<T> Function($$VacunasTableAnnotationComposer a) f) {
    final $$VacunasTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.vacunas,
        getReferencedColumn: (t) => t.bovinoId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$VacunasTableAnnotationComposer(
              $db: $db,
              $table: $db.vacunas,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> tratamientosRefs<T extends Object>(
      Expression<T> Function($$TratamientosTableAnnotationComposer a) f) {
    final $$TratamientosTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.tratamientos,
        getReferencedColumn: (t) => t.bovinoId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TratamientosTableAnnotationComposer(
              $db: $db,
              $table: $db.tratamientos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> registroReproductivoRefs<T extends Object>(
      Expression<T> Function($$RegistroReproductivoTableAnnotationComposer a)
          f) {
    final $$RegistroReproductivoTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.registroReproductivo,
            getReferencedColumn: (t) => t.bovinoId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$RegistroReproductivoTableAnnotationComposer(
                  $db: $db,
                  $table: $db.registroReproductivo,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> fotosRefs<T extends Object>(
      Expression<T> Function($$FotosTableAnnotationComposer a) f) {
    final $$FotosTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.fotos,
        getReferencedColumn: (t) => t.bovinoId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FotosTableAnnotationComposer(
              $db: $db,
              $table: $db.fotos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$BovinosTableTableManager extends RootTableManager<
    _$AppDatabase,
    $BovinosTable,
    Bovino,
    $$BovinosTableFilterComposer,
    $$BovinosTableOrderingComposer,
    $$BovinosTableAnnotationComposer,
    $$BovinosTableCreateCompanionBuilder,
    $$BovinosTableUpdateCompanionBuilder,
    (Bovino, $$BovinosTableReferences),
    Bovino,
    PrefetchHooks Function(
        {bool loteId,
        bool razaId,
        bool pertenenciaRefs,
        bool progenieHijoRefs,
        bool progeniePadreRefs,
        bool progenieMadreRefs,
        bool partosRefs,
        bool ventasRefs,
        bool torosRefs,
        bool vacunasRefs,
        bool tratamientosRefs,
        bool registroReproductivoRefs,
        bool fotosRefs})> {
  $$BovinosTableTableManager(_$AppDatabase db, $BovinosTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BovinosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BovinosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BovinosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> areteId = const Value.absent(),
            Value<String?> numRegistro = const Value.absent(),
            Value<String?> nombre = const Value.absent(),
            Value<String> sexo = const Value.absent(),
            Value<DateTime?> fechaNacimiento = const Value.absent(),
            Value<DateTime?> fechaMuerte = const Value.absent(),
            Value<int?> loteId = const Value.absent(),
            Value<String?> upp = const Value.absent(),
            Value<int?> razaId = const Value.absent(),
            Value<String> estado = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              BovinosCompanion(
            id: id,
            areteId: areteId,
            numRegistro: numRegistro,
            nombre: nombre,
            sexo: sexo,
            fechaNacimiento: fechaNacimiento,
            fechaMuerte: fechaMuerte,
            loteId: loteId,
            upp: upp,
            razaId: razaId,
            estado: estado,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String areteId,
            Value<String?> numRegistro = const Value.absent(),
            Value<String?> nombre = const Value.absent(),
            required String sexo,
            Value<DateTime?> fechaNacimiento = const Value.absent(),
            Value<DateTime?> fechaMuerte = const Value.absent(),
            Value<int?> loteId = const Value.absent(),
            Value<String?> upp = const Value.absent(),
            Value<int?> razaId = const Value.absent(),
            Value<String> estado = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              BovinosCompanion.insert(
            id: id,
            areteId: areteId,
            numRegistro: numRegistro,
            nombre: nombre,
            sexo: sexo,
            fechaNacimiento: fechaNacimiento,
            fechaMuerte: fechaMuerte,
            loteId: loteId,
            upp: upp,
            razaId: razaId,
            estado: estado,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$BovinosTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {loteId = false,
              razaId = false,
              pertenenciaRefs = false,
              progenieHijoRefs = false,
              progeniePadreRefs = false,
              progenieMadreRefs = false,
              partosRefs = false,
              ventasRefs = false,
              torosRefs = false,
              vacunasRefs = false,
              tratamientosRefs = false,
              registroReproductivoRefs = false,
              fotosRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (pertenenciaRefs) db.pertenencia,
                if (progenieHijoRefs) db.progenie,
                if (progeniePadreRefs) db.progenie,
                if (progenieMadreRefs) db.progenie,
                if (partosRefs) db.partos,
                if (ventasRefs) db.ventas,
                if (torosRefs) db.toros,
                if (vacunasRefs) db.vacunas,
                if (tratamientosRefs) db.tratamientos,
                if (registroReproductivoRefs) db.registroReproductivo,
                if (fotosRefs) db.fotos
              ],
              addJoins: <
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
                      dynamic>>(state) {
                if (loteId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.loteId,
                    referencedTable: $$BovinosTableReferences._loteIdTable(db),
                    referencedColumn:
                        $$BovinosTableReferences._loteIdTable(db).id,
                  ) as T;
                }
                if (razaId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.razaId,
                    referencedTable: $$BovinosTableReferences._razaIdTable(db),
                    referencedColumn:
                        $$BovinosTableReferences._razaIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (pertenenciaRefs)
                    await $_getPrefetchedData<Bovino, $BovinosTable,
                            PertenenciaData>(
                        currentTable: table,
                        referencedTable:
                            $$BovinosTableReferences._pertenenciaRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$BovinosTableReferences(db, table, p0)
                                .pertenenciaRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.bovinoId == item.id),
                        typedResults: items),
                  if (progenieHijoRefs)
                    await $_getPrefetchedData<Bovino, $BovinosTable,
                            ProgenieData>(
                        currentTable: table,
                        referencedTable:
                            $$BovinosTableReferences._progenieHijoRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$BovinosTableReferences(db, table, p0)
                                .progenieHijoRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.bovinoId == item.id),
                        typedResults: items),
                  if (progeniePadreRefs)
                    await $_getPrefetchedData<Bovino, $BovinosTable,
                            ProgenieData>(
                        currentTable: table,
                        referencedTable: $$BovinosTableReferences
                            ._progeniePadreRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$BovinosTableReferences(db, table, p0)
                                .progeniePadreRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.bovinoPadreId == item.id),
                        typedResults: items),
                  if (progenieMadreRefs)
                    await $_getPrefetchedData<Bovino, $BovinosTable,
                            ProgenieData>(
                        currentTable: table,
                        referencedTable: $$BovinosTableReferences
                            ._progenieMadreRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$BovinosTableReferences(db, table, p0)
                                .progenieMadreRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.bovinaMadreId == item.id),
                        typedResults: items),
                  if (partosRefs)
                    await $_getPrefetchedData<Bovino, $BovinosTable, Parto>(
                        currentTable: table,
                        referencedTable:
                            $$BovinosTableReferences._partosRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$BovinosTableReferences(db, table, p0).partosRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.bovinoId == item.id),
                        typedResults: items),
                  if (ventasRefs)
                    await $_getPrefetchedData<Bovino, $BovinosTable, Venta>(
                        currentTable: table,
                        referencedTable:
                            $$BovinosTableReferences._ventasRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$BovinosTableReferences(db, table, p0).ventasRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.bovinoId == item.id),
                        typedResults: items),
                  if (torosRefs)
                    await $_getPrefetchedData<Bovino, $BovinosTable, Toro>(
                        currentTable: table,
                        referencedTable:
                            $$BovinosTableReferences._torosRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$BovinosTableReferences(db, table, p0).torosRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.bovinoId == item.id),
                        typedResults: items),
                  if (vacunasRefs)
                    await $_getPrefetchedData<Bovino, $BovinosTable, Vacuna>(
                        currentTable: table,
                        referencedTable:
                            $$BovinosTableReferences._vacunasRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$BovinosTableReferences(db, table, p0).vacunasRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.bovinoId == item.id),
                        typedResults: items),
                  if (tratamientosRefs)
                    await $_getPrefetchedData<Bovino, $BovinosTable,
                            Tratamiento>(
                        currentTable: table,
                        referencedTable:
                            $$BovinosTableReferences._tratamientosRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$BovinosTableReferences(db, table, p0)
                                .tratamientosRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.bovinoId == item.id),
                        typedResults: items),
                  if (registroReproductivoRefs)
                    await $_getPrefetchedData<Bovino, $BovinosTable,
                            RegistroReproductivoData>(
                        currentTable: table,
                        referencedTable: $$BovinosTableReferences
                            ._registroReproductivoRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$BovinosTableReferences(db, table, p0)
                                .registroReproductivoRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.bovinoId == item.id),
                        typedResults: items),
                  if (fotosRefs)
                    await $_getPrefetchedData<Bovino, $BovinosTable, Foto>(
                        currentTable: table,
                        referencedTable:
                            $$BovinosTableReferences._fotosRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$BovinosTableReferences(db, table, p0).fotosRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.bovinoId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$BovinosTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $BovinosTable,
    Bovino,
    $$BovinosTableFilterComposer,
    $$BovinosTableOrderingComposer,
    $$BovinosTableAnnotationComposer,
    $$BovinosTableCreateCompanionBuilder,
    $$BovinosTableUpdateCompanionBuilder,
    (Bovino, $$BovinosTableReferences),
    Bovino,
    PrefetchHooks Function(
        {bool loteId,
        bool razaId,
        bool pertenenciaRefs,
        bool progenieHijoRefs,
        bool progeniePadreRefs,
        bool progenieMadreRefs,
        bool partosRefs,
        bool ventasRefs,
        bool torosRefs,
        bool vacunasRefs,
        bool tratamientosRefs,
        bool registroReproductivoRefs,
        bool fotosRefs})>;
typedef $$PertenenciaTableCreateCompanionBuilder = PertenenciaCompanion
    Function({
  Value<int> id,
  required int bovinoId,
  required int duenoId,
  required DateTime fechaInicio,
  Value<DateTime?> fechaFin,
});
typedef $$PertenenciaTableUpdateCompanionBuilder = PertenenciaCompanion
    Function({
  Value<int> id,
  Value<int> bovinoId,
  Value<int> duenoId,
  Value<DateTime> fechaInicio,
  Value<DateTime?> fechaFin,
});

final class $$PertenenciaTableReferences
    extends BaseReferences<_$AppDatabase, $PertenenciaTable, PertenenciaData> {
  $$PertenenciaTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BovinosTable _bovinoIdTable(_$AppDatabase db) =>
      db.bovinos.createAlias(
          $_aliasNameGenerator(db.pertenencia.bovinoId, db.bovinos.id));

  $$BovinosTableProcessedTableManager get bovinoId {
    final $_column = $_itemColumn<int>('bovino_id')!;

    final manager = $$BovinosTableTableManager($_db, $_db.bovinos)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_bovinoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $DuenosTable _duenoIdTable(_$AppDatabase db) => db.duenos
      .createAlias($_aliasNameGenerator(db.pertenencia.duenoId, db.duenos.id));

  $$DuenosTableProcessedTableManager get duenoId {
    final $_column = $_itemColumn<int>('dueno_id')!;

    final manager = $$DuenosTableTableManager($_db, $_db.duenos)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_duenoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$PertenenciaTableFilterComposer
    extends Composer<_$AppDatabase, $PertenenciaTable> {
  $$PertenenciaTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get fechaInicio => $composableBuilder(
      column: $table.fechaInicio, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get fechaFin => $composableBuilder(
      column: $table.fechaFin, builder: (column) => ColumnFilters(column));

  $$BovinosTableFilterComposer get bovinoId {
    final $$BovinosTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bovinoId,
        referencedTable: $db.bovinos,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinosTableFilterComposer(
              $db: $db,
              $table: $db.bovinos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$DuenosTableFilterComposer get duenoId {
    final $$DuenosTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.duenoId,
        referencedTable: $db.duenos,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DuenosTableFilterComposer(
              $db: $db,
              $table: $db.duenos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PertenenciaTableOrderingComposer
    extends Composer<_$AppDatabase, $PertenenciaTable> {
  $$PertenenciaTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get fechaInicio => $composableBuilder(
      column: $table.fechaInicio, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get fechaFin => $composableBuilder(
      column: $table.fechaFin, builder: (column) => ColumnOrderings(column));

  $$BovinosTableOrderingComposer get bovinoId {
    final $$BovinosTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bovinoId,
        referencedTable: $db.bovinos,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinosTableOrderingComposer(
              $db: $db,
              $table: $db.bovinos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$DuenosTableOrderingComposer get duenoId {
    final $$DuenosTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.duenoId,
        referencedTable: $db.duenos,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DuenosTableOrderingComposer(
              $db: $db,
              $table: $db.duenos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PertenenciaTableAnnotationComposer
    extends Composer<_$AppDatabase, $PertenenciaTable> {
  $$PertenenciaTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get fechaInicio => $composableBuilder(
      column: $table.fechaInicio, builder: (column) => column);

  GeneratedColumn<DateTime> get fechaFin =>
      $composableBuilder(column: $table.fechaFin, builder: (column) => column);

  $$BovinosTableAnnotationComposer get bovinoId {
    final $$BovinosTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bovinoId,
        referencedTable: $db.bovinos,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinosTableAnnotationComposer(
              $db: $db,
              $table: $db.bovinos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$DuenosTableAnnotationComposer get duenoId {
    final $$DuenosTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.duenoId,
        referencedTable: $db.duenos,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DuenosTableAnnotationComposer(
              $db: $db,
              $table: $db.duenos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PertenenciaTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PertenenciaTable,
    PertenenciaData,
    $$PertenenciaTableFilterComposer,
    $$PertenenciaTableOrderingComposer,
    $$PertenenciaTableAnnotationComposer,
    $$PertenenciaTableCreateCompanionBuilder,
    $$PertenenciaTableUpdateCompanionBuilder,
    (PertenenciaData, $$PertenenciaTableReferences),
    PertenenciaData,
    PrefetchHooks Function({bool bovinoId, bool duenoId})> {
  $$PertenenciaTableTableManager(_$AppDatabase db, $PertenenciaTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PertenenciaTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PertenenciaTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PertenenciaTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> bovinoId = const Value.absent(),
            Value<int> duenoId = const Value.absent(),
            Value<DateTime> fechaInicio = const Value.absent(),
            Value<DateTime?> fechaFin = const Value.absent(),
          }) =>
              PertenenciaCompanion(
            id: id,
            bovinoId: bovinoId,
            duenoId: duenoId,
            fechaInicio: fechaInicio,
            fechaFin: fechaFin,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int bovinoId,
            required int duenoId,
            required DateTime fechaInicio,
            Value<DateTime?> fechaFin = const Value.absent(),
          }) =>
              PertenenciaCompanion.insert(
            id: id,
            bovinoId: bovinoId,
            duenoId: duenoId,
            fechaInicio: fechaInicio,
            fechaFin: fechaFin,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$PertenenciaTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({bovinoId = false, duenoId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                      dynamic>>(state) {
                if (bovinoId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.bovinoId,
                    referencedTable:
                        $$PertenenciaTableReferences._bovinoIdTable(db),
                    referencedColumn:
                        $$PertenenciaTableReferences._bovinoIdTable(db).id,
                  ) as T;
                }
                if (duenoId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.duenoId,
                    referencedTable:
                        $$PertenenciaTableReferences._duenoIdTable(db),
                    referencedColumn:
                        $$PertenenciaTableReferences._duenoIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$PertenenciaTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PertenenciaTable,
    PertenenciaData,
    $$PertenenciaTableFilterComposer,
    $$PertenenciaTableOrderingComposer,
    $$PertenenciaTableAnnotationComposer,
    $$PertenenciaTableCreateCompanionBuilder,
    $$PertenenciaTableUpdateCompanionBuilder,
    (PertenenciaData, $$PertenenciaTableReferences),
    PertenenciaData,
    PrefetchHooks Function({bool bovinoId, bool duenoId})>;
typedef $$ProgenieTableCreateCompanionBuilder = ProgenieCompanion Function({
  Value<int> id,
  required int bovinoId,
  Value<int?> bovinoPadreId,
  Value<int?> bovinaMadreId,
});
typedef $$ProgenieTableUpdateCompanionBuilder = ProgenieCompanion Function({
  Value<int> id,
  Value<int> bovinoId,
  Value<int?> bovinoPadreId,
  Value<int?> bovinaMadreId,
});

final class $$ProgenieTableReferences
    extends BaseReferences<_$AppDatabase, $ProgenieTable, ProgenieData> {
  $$ProgenieTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BovinosTable _bovinoIdTable(_$AppDatabase db) => db.bovinos
      .createAlias($_aliasNameGenerator(db.progenie.bovinoId, db.bovinos.id));

  $$BovinosTableProcessedTableManager get bovinoId {
    final $_column = $_itemColumn<int>('bovino_id')!;

    final manager = $$BovinosTableTableManager($_db, $_db.bovinos)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_bovinoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $BovinosTable _bovinoPadreIdTable(_$AppDatabase db) =>
      db.bovinos.createAlias(
          $_aliasNameGenerator(db.progenie.bovinoPadreId, db.bovinos.id));

  $$BovinosTableProcessedTableManager? get bovinoPadreId {
    final $_column = $_itemColumn<int>('bovino_padre_id');
    if ($_column == null) return null;
    final manager = $$BovinosTableTableManager($_db, $_db.bovinos)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_bovinoPadreIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $BovinosTable _bovinaMadreIdTable(_$AppDatabase db) =>
      db.bovinos.createAlias(
          $_aliasNameGenerator(db.progenie.bovinaMadreId, db.bovinos.id));

  $$BovinosTableProcessedTableManager? get bovinaMadreId {
    final $_column = $_itemColumn<int>('bovina_madre_id');
    if ($_column == null) return null;
    final manager = $$BovinosTableTableManager($_db, $_db.bovinos)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_bovinaMadreIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$ProgenieTableFilterComposer
    extends Composer<_$AppDatabase, $ProgenieTable> {
  $$ProgenieTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  $$BovinosTableFilterComposer get bovinoId {
    final $$BovinosTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bovinoId,
        referencedTable: $db.bovinos,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinosTableFilterComposer(
              $db: $db,
              $table: $db.bovinos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$BovinosTableFilterComposer get bovinoPadreId {
    final $$BovinosTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bovinoPadreId,
        referencedTable: $db.bovinos,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinosTableFilterComposer(
              $db: $db,
              $table: $db.bovinos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$BovinosTableFilterComposer get bovinaMadreId {
    final $$BovinosTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bovinaMadreId,
        referencedTable: $db.bovinos,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinosTableFilterComposer(
              $db: $db,
              $table: $db.bovinos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ProgenieTableOrderingComposer
    extends Composer<_$AppDatabase, $ProgenieTable> {
  $$ProgenieTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  $$BovinosTableOrderingComposer get bovinoId {
    final $$BovinosTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bovinoId,
        referencedTable: $db.bovinos,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinosTableOrderingComposer(
              $db: $db,
              $table: $db.bovinos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$BovinosTableOrderingComposer get bovinoPadreId {
    final $$BovinosTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bovinoPadreId,
        referencedTable: $db.bovinos,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinosTableOrderingComposer(
              $db: $db,
              $table: $db.bovinos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$BovinosTableOrderingComposer get bovinaMadreId {
    final $$BovinosTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bovinaMadreId,
        referencedTable: $db.bovinos,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinosTableOrderingComposer(
              $db: $db,
              $table: $db.bovinos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ProgenieTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProgenieTable> {
  $$ProgenieTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  $$BovinosTableAnnotationComposer get bovinoId {
    final $$BovinosTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bovinoId,
        referencedTable: $db.bovinos,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinosTableAnnotationComposer(
              $db: $db,
              $table: $db.bovinos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$BovinosTableAnnotationComposer get bovinoPadreId {
    final $$BovinosTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bovinoPadreId,
        referencedTable: $db.bovinos,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinosTableAnnotationComposer(
              $db: $db,
              $table: $db.bovinos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$BovinosTableAnnotationComposer get bovinaMadreId {
    final $$BovinosTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bovinaMadreId,
        referencedTable: $db.bovinos,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinosTableAnnotationComposer(
              $db: $db,
              $table: $db.bovinos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ProgenieTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ProgenieTable,
    ProgenieData,
    $$ProgenieTableFilterComposer,
    $$ProgenieTableOrderingComposer,
    $$ProgenieTableAnnotationComposer,
    $$ProgenieTableCreateCompanionBuilder,
    $$ProgenieTableUpdateCompanionBuilder,
    (ProgenieData, $$ProgenieTableReferences),
    ProgenieData,
    PrefetchHooks Function(
        {bool bovinoId, bool bovinoPadreId, bool bovinaMadreId})> {
  $$ProgenieTableTableManager(_$AppDatabase db, $ProgenieTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProgenieTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProgenieTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProgenieTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> bovinoId = const Value.absent(),
            Value<int?> bovinoPadreId = const Value.absent(),
            Value<int?> bovinaMadreId = const Value.absent(),
          }) =>
              ProgenieCompanion(
            id: id,
            bovinoId: bovinoId,
            bovinoPadreId: bovinoPadreId,
            bovinaMadreId: bovinaMadreId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int bovinoId,
            Value<int?> bovinoPadreId = const Value.absent(),
            Value<int?> bovinaMadreId = const Value.absent(),
          }) =>
              ProgenieCompanion.insert(
            id: id,
            bovinoId: bovinoId,
            bovinoPadreId: bovinoPadreId,
            bovinaMadreId: bovinaMadreId,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$ProgenieTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {bovinoId = false,
              bovinoPadreId = false,
              bovinaMadreId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                      dynamic>>(state) {
                if (bovinoId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.bovinoId,
                    referencedTable:
                        $$ProgenieTableReferences._bovinoIdTable(db),
                    referencedColumn:
                        $$ProgenieTableReferences._bovinoIdTable(db).id,
                  ) as T;
                }
                if (bovinoPadreId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.bovinoPadreId,
                    referencedTable:
                        $$ProgenieTableReferences._bovinoPadreIdTable(db),
                    referencedColumn:
                        $$ProgenieTableReferences._bovinoPadreIdTable(db).id,
                  ) as T;
                }
                if (bovinaMadreId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.bovinaMadreId,
                    referencedTable:
                        $$ProgenieTableReferences._bovinaMadreIdTable(db),
                    referencedColumn:
                        $$ProgenieTableReferences._bovinaMadreIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$ProgenieTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ProgenieTable,
    ProgenieData,
    $$ProgenieTableFilterComposer,
    $$ProgenieTableOrderingComposer,
    $$ProgenieTableAnnotationComposer,
    $$ProgenieTableCreateCompanionBuilder,
    $$ProgenieTableUpdateCompanionBuilder,
    (ProgenieData, $$ProgenieTableReferences),
    ProgenieData,
    PrefetchHooks Function(
        {bool bovinoId, bool bovinoPadreId, bool bovinaMadreId})>;
typedef $$PartosTableCreateCompanionBuilder = PartosCompanion Function({
  Value<int> id,
  required int bovinoId,
  required DateTime fechaParto,
  Value<String?> notas,
});
typedef $$PartosTableUpdateCompanionBuilder = PartosCompanion Function({
  Value<int> id,
  Value<int> bovinoId,
  Value<DateTime> fechaParto,
  Value<String?> notas,
});

final class $$PartosTableReferences
    extends BaseReferences<_$AppDatabase, $PartosTable, Parto> {
  $$PartosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BovinosTable _bovinoIdTable(_$AppDatabase db) => db.bovinos
      .createAlias($_aliasNameGenerator(db.partos.bovinoId, db.bovinos.id));

  $$BovinosTableProcessedTableManager get bovinoId {
    final $_column = $_itemColumn<int>('bovino_id')!;

    final manager = $$BovinosTableTableManager($_db, $_db.bovinos)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_bovinoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$PartosTableFilterComposer
    extends Composer<_$AppDatabase, $PartosTable> {
  $$PartosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get fechaParto => $composableBuilder(
      column: $table.fechaParto, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notas => $composableBuilder(
      column: $table.notas, builder: (column) => ColumnFilters(column));

  $$BovinosTableFilterComposer get bovinoId {
    final $$BovinosTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bovinoId,
        referencedTable: $db.bovinos,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinosTableFilterComposer(
              $db: $db,
              $table: $db.bovinos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PartosTableOrderingComposer
    extends Composer<_$AppDatabase, $PartosTable> {
  $$PartosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get fechaParto => $composableBuilder(
      column: $table.fechaParto, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notas => $composableBuilder(
      column: $table.notas, builder: (column) => ColumnOrderings(column));

  $$BovinosTableOrderingComposer get bovinoId {
    final $$BovinosTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bovinoId,
        referencedTable: $db.bovinos,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinosTableOrderingComposer(
              $db: $db,
              $table: $db.bovinos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PartosTableAnnotationComposer
    extends Composer<_$AppDatabase, $PartosTable> {
  $$PartosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get fechaParto => $composableBuilder(
      column: $table.fechaParto, builder: (column) => column);

  GeneratedColumn<String> get notas =>
      $composableBuilder(column: $table.notas, builder: (column) => column);

  $$BovinosTableAnnotationComposer get bovinoId {
    final $$BovinosTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bovinoId,
        referencedTable: $db.bovinos,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinosTableAnnotationComposer(
              $db: $db,
              $table: $db.bovinos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PartosTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PartosTable,
    Parto,
    $$PartosTableFilterComposer,
    $$PartosTableOrderingComposer,
    $$PartosTableAnnotationComposer,
    $$PartosTableCreateCompanionBuilder,
    $$PartosTableUpdateCompanionBuilder,
    (Parto, $$PartosTableReferences),
    Parto,
    PrefetchHooks Function({bool bovinoId})> {
  $$PartosTableTableManager(_$AppDatabase db, $PartosTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PartosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PartosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PartosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> bovinoId = const Value.absent(),
            Value<DateTime> fechaParto = const Value.absent(),
            Value<String?> notas = const Value.absent(),
          }) =>
              PartosCompanion(
            id: id,
            bovinoId: bovinoId,
            fechaParto: fechaParto,
            notas: notas,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int bovinoId,
            required DateTime fechaParto,
            Value<String?> notas = const Value.absent(),
          }) =>
              PartosCompanion.insert(
            id: id,
            bovinoId: bovinoId,
            fechaParto: fechaParto,
            notas: notas,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$PartosTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({bovinoId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                      dynamic>>(state) {
                if (bovinoId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.bovinoId,
                    referencedTable: $$PartosTableReferences._bovinoIdTable(db),
                    referencedColumn:
                        $$PartosTableReferences._bovinoIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$PartosTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PartosTable,
    Parto,
    $$PartosTableFilterComposer,
    $$PartosTableOrderingComposer,
    $$PartosTableAnnotationComposer,
    $$PartosTableCreateCompanionBuilder,
    $$PartosTableUpdateCompanionBuilder,
    (Parto, $$PartosTableReferences),
    Parto,
    PrefetchHooks Function({bool bovinoId})>;
typedef $$VentasTableCreateCompanionBuilder = VentasCompanion Function({
  Value<int> id,
  required int bovinoId,
  required DateTime fechaVenta,
  Value<double?> precio,
  Value<String?> comprador,
});
typedef $$VentasTableUpdateCompanionBuilder = VentasCompanion Function({
  Value<int> id,
  Value<int> bovinoId,
  Value<DateTime> fechaVenta,
  Value<double?> precio,
  Value<String?> comprador,
});

final class $$VentasTableReferences
    extends BaseReferences<_$AppDatabase, $VentasTable, Venta> {
  $$VentasTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BovinosTable _bovinoIdTable(_$AppDatabase db) => db.bovinos
      .createAlias($_aliasNameGenerator(db.ventas.bovinoId, db.bovinos.id));

  $$BovinosTableProcessedTableManager get bovinoId {
    final $_column = $_itemColumn<int>('bovino_id')!;

    final manager = $$BovinosTableTableManager($_db, $_db.bovinos)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_bovinoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$VentasTableFilterComposer
    extends Composer<_$AppDatabase, $VentasTable> {
  $$VentasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get fechaVenta => $composableBuilder(
      column: $table.fechaVenta, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get precio => $composableBuilder(
      column: $table.precio, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get comprador => $composableBuilder(
      column: $table.comprador, builder: (column) => ColumnFilters(column));

  $$BovinosTableFilterComposer get bovinoId {
    final $$BovinosTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bovinoId,
        referencedTable: $db.bovinos,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinosTableFilterComposer(
              $db: $db,
              $table: $db.bovinos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$VentasTableOrderingComposer
    extends Composer<_$AppDatabase, $VentasTable> {
  $$VentasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get fechaVenta => $composableBuilder(
      column: $table.fechaVenta, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get precio => $composableBuilder(
      column: $table.precio, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get comprador => $composableBuilder(
      column: $table.comprador, builder: (column) => ColumnOrderings(column));

  $$BovinosTableOrderingComposer get bovinoId {
    final $$BovinosTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bovinoId,
        referencedTable: $db.bovinos,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinosTableOrderingComposer(
              $db: $db,
              $table: $db.bovinos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$VentasTableAnnotationComposer
    extends Composer<_$AppDatabase, $VentasTable> {
  $$VentasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get fechaVenta => $composableBuilder(
      column: $table.fechaVenta, builder: (column) => column);

  GeneratedColumn<double> get precio =>
      $composableBuilder(column: $table.precio, builder: (column) => column);

  GeneratedColumn<String> get comprador =>
      $composableBuilder(column: $table.comprador, builder: (column) => column);

  $$BovinosTableAnnotationComposer get bovinoId {
    final $$BovinosTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bovinoId,
        referencedTable: $db.bovinos,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinosTableAnnotationComposer(
              $db: $db,
              $table: $db.bovinos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$VentasTableTableManager extends RootTableManager<
    _$AppDatabase,
    $VentasTable,
    Venta,
    $$VentasTableFilterComposer,
    $$VentasTableOrderingComposer,
    $$VentasTableAnnotationComposer,
    $$VentasTableCreateCompanionBuilder,
    $$VentasTableUpdateCompanionBuilder,
    (Venta, $$VentasTableReferences),
    Venta,
    PrefetchHooks Function({bool bovinoId})> {
  $$VentasTableTableManager(_$AppDatabase db, $VentasTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VentasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VentasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VentasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> bovinoId = const Value.absent(),
            Value<DateTime> fechaVenta = const Value.absent(),
            Value<double?> precio = const Value.absent(),
            Value<String?> comprador = const Value.absent(),
          }) =>
              VentasCompanion(
            id: id,
            bovinoId: bovinoId,
            fechaVenta: fechaVenta,
            precio: precio,
            comprador: comprador,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int bovinoId,
            required DateTime fechaVenta,
            Value<double?> precio = const Value.absent(),
            Value<String?> comprador = const Value.absent(),
          }) =>
              VentasCompanion.insert(
            id: id,
            bovinoId: bovinoId,
            fechaVenta: fechaVenta,
            precio: precio,
            comprador: comprador,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$VentasTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({bovinoId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                      dynamic>>(state) {
                if (bovinoId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.bovinoId,
                    referencedTable: $$VentasTableReferences._bovinoIdTable(db),
                    referencedColumn:
                        $$VentasTableReferences._bovinoIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$VentasTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $VentasTable,
    Venta,
    $$VentasTableFilterComposer,
    $$VentasTableOrderingComposer,
    $$VentasTableAnnotationComposer,
    $$VentasTableCreateCompanionBuilder,
    $$VentasTableUpdateCompanionBuilder,
    (Venta, $$VentasTableReferences),
    Venta,
    PrefetchHooks Function({bool bovinoId})>;
typedef $$TorosTableCreateCompanionBuilder = TorosCompanion Function({
  Value<int> id,
  required int bovinoId,
});
typedef $$TorosTableUpdateCompanionBuilder = TorosCompanion Function({
  Value<int> id,
  Value<int> bovinoId,
});

final class $$TorosTableReferences
    extends BaseReferences<_$AppDatabase, $TorosTable, Toro> {
  $$TorosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BovinosTable _bovinoIdTable(_$AppDatabase db) => db.bovinos
      .createAlias($_aliasNameGenerator(db.toros.bovinoId, db.bovinos.id));

  $$BovinosTableProcessedTableManager get bovinoId {
    final $_column = $_itemColumn<int>('bovino_id')!;

    final manager = $$BovinosTableTableManager($_db, $_db.bovinos)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_bovinoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$RegistroReproductivoTable,
      List<RegistroReproductivoData>> _registroReproductivoRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.registroReproductivo,
          aliasName: $_aliasNameGenerator(
              db.toros.id, db.registroReproductivo.toroId));

  $$RegistroReproductivoTableProcessedTableManager
      get registroReproductivoRefs {
    final manager =
        $$RegistroReproductivoTableTableManager($_db, $_db.registroReproductivo)
            .filter((f) => f.toroId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_registroReproductivoRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$TorosTableFilterComposer extends Composer<_$AppDatabase, $TorosTable> {
  $$TorosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  $$BovinosTableFilterComposer get bovinoId {
    final $$BovinosTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bovinoId,
        referencedTable: $db.bovinos,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinosTableFilterComposer(
              $db: $db,
              $table: $db.bovinos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> registroReproductivoRefs(
      Expression<bool> Function($$RegistroReproductivoTableFilterComposer f)
          f) {
    final $$RegistroReproductivoTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.registroReproductivo,
        getReferencedColumn: (t) => t.toroId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RegistroReproductivoTableFilterComposer(
              $db: $db,
              $table: $db.registroReproductivo,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$TorosTableOrderingComposer
    extends Composer<_$AppDatabase, $TorosTable> {
  $$TorosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  $$BovinosTableOrderingComposer get bovinoId {
    final $$BovinosTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bovinoId,
        referencedTable: $db.bovinos,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinosTableOrderingComposer(
              $db: $db,
              $table: $db.bovinos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TorosTableAnnotationComposer
    extends Composer<_$AppDatabase, $TorosTable> {
  $$TorosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  $$BovinosTableAnnotationComposer get bovinoId {
    final $$BovinosTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bovinoId,
        referencedTable: $db.bovinos,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinosTableAnnotationComposer(
              $db: $db,
              $table: $db.bovinos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> registroReproductivoRefs<T extends Object>(
      Expression<T> Function($$RegistroReproductivoTableAnnotationComposer a)
          f) {
    final $$RegistroReproductivoTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.registroReproductivo,
            getReferencedColumn: (t) => t.toroId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$RegistroReproductivoTableAnnotationComposer(
                  $db: $db,
                  $table: $db.registroReproductivo,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$TorosTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TorosTable,
    Toro,
    $$TorosTableFilterComposer,
    $$TorosTableOrderingComposer,
    $$TorosTableAnnotationComposer,
    $$TorosTableCreateCompanionBuilder,
    $$TorosTableUpdateCompanionBuilder,
    (Toro, $$TorosTableReferences),
    Toro,
    PrefetchHooks Function({bool bovinoId, bool registroReproductivoRefs})> {
  $$TorosTableTableManager(_$AppDatabase db, $TorosTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TorosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TorosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TorosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> bovinoId = const Value.absent(),
          }) =>
              TorosCompanion(
            id: id,
            bovinoId: bovinoId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int bovinoId,
          }) =>
              TorosCompanion.insert(
            id: id,
            bovinoId: bovinoId,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$TorosTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {bovinoId = false, registroReproductivoRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (registroReproductivoRefs) db.registroReproductivo
              ],
              addJoins: <
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
                      dynamic>>(state) {
                if (bovinoId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.bovinoId,
                    referencedTable: $$TorosTableReferences._bovinoIdTable(db),
                    referencedColumn:
                        $$TorosTableReferences._bovinoIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (registroReproductivoRefs)
                    await $_getPrefetchedData<Toro, $TorosTable,
                            RegistroReproductivoData>(
                        currentTable: table,
                        referencedTable: $$TorosTableReferences
                            ._registroReproductivoRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$TorosTableReferences(db, table, p0)
                                .registroReproductivoRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.toroId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$TorosTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TorosTable,
    Toro,
    $$TorosTableFilterComposer,
    $$TorosTableOrderingComposer,
    $$TorosTableAnnotationComposer,
    $$TorosTableCreateCompanionBuilder,
    $$TorosTableUpdateCompanionBuilder,
    (Toro, $$TorosTableReferences),
    Toro,
    PrefetchHooks Function({bool bovinoId, bool registroReproductivoRefs})>;
typedef $$VacunasTableCreateCompanionBuilder = VacunasCompanion Function({
  Value<int> id,
  required int bovinoId,
  required String nombreVacuna,
  required DateTime fechaAplicacion,
  Value<String?> descripcion,
  Value<DateTime?> proximaDosis,
});
typedef $$VacunasTableUpdateCompanionBuilder = VacunasCompanion Function({
  Value<int> id,
  Value<int> bovinoId,
  Value<String> nombreVacuna,
  Value<DateTime> fechaAplicacion,
  Value<String?> descripcion,
  Value<DateTime?> proximaDosis,
});

final class $$VacunasTableReferences
    extends BaseReferences<_$AppDatabase, $VacunasTable, Vacuna> {
  $$VacunasTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BovinosTable _bovinoIdTable(_$AppDatabase db) => db.bovinos
      .createAlias($_aliasNameGenerator(db.vacunas.bovinoId, db.bovinos.id));

  $$BovinosTableProcessedTableManager get bovinoId {
    final $_column = $_itemColumn<int>('bovino_id')!;

    final manager = $$BovinosTableTableManager($_db, $_db.bovinos)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_bovinoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$VacunasTableFilterComposer
    extends Composer<_$AppDatabase, $VacunasTable> {
  $$VacunasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nombreVacuna => $composableBuilder(
      column: $table.nombreVacuna, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get fechaAplicacion => $composableBuilder(
      column: $table.fechaAplicacion,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get descripcion => $composableBuilder(
      column: $table.descripcion, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get proximaDosis => $composableBuilder(
      column: $table.proximaDosis, builder: (column) => ColumnFilters(column));

  $$BovinosTableFilterComposer get bovinoId {
    final $$BovinosTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bovinoId,
        referencedTable: $db.bovinos,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinosTableFilterComposer(
              $db: $db,
              $table: $db.bovinos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$VacunasTableOrderingComposer
    extends Composer<_$AppDatabase, $VacunasTable> {
  $$VacunasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nombreVacuna => $composableBuilder(
      column: $table.nombreVacuna,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get fechaAplicacion => $composableBuilder(
      column: $table.fechaAplicacion,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get descripcion => $composableBuilder(
      column: $table.descripcion, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get proximaDosis => $composableBuilder(
      column: $table.proximaDosis,
      builder: (column) => ColumnOrderings(column));

  $$BovinosTableOrderingComposer get bovinoId {
    final $$BovinosTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bovinoId,
        referencedTable: $db.bovinos,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinosTableOrderingComposer(
              $db: $db,
              $table: $db.bovinos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$VacunasTableAnnotationComposer
    extends Composer<_$AppDatabase, $VacunasTable> {
  $$VacunasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombreVacuna => $composableBuilder(
      column: $table.nombreVacuna, builder: (column) => column);

  GeneratedColumn<DateTime> get fechaAplicacion => $composableBuilder(
      column: $table.fechaAplicacion, builder: (column) => column);

  GeneratedColumn<String> get descripcion => $composableBuilder(
      column: $table.descripcion, builder: (column) => column);

  GeneratedColumn<DateTime> get proximaDosis => $composableBuilder(
      column: $table.proximaDosis, builder: (column) => column);

  $$BovinosTableAnnotationComposer get bovinoId {
    final $$BovinosTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bovinoId,
        referencedTable: $db.bovinos,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinosTableAnnotationComposer(
              $db: $db,
              $table: $db.bovinos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$VacunasTableTableManager extends RootTableManager<
    _$AppDatabase,
    $VacunasTable,
    Vacuna,
    $$VacunasTableFilterComposer,
    $$VacunasTableOrderingComposer,
    $$VacunasTableAnnotationComposer,
    $$VacunasTableCreateCompanionBuilder,
    $$VacunasTableUpdateCompanionBuilder,
    (Vacuna, $$VacunasTableReferences),
    Vacuna,
    PrefetchHooks Function({bool bovinoId})> {
  $$VacunasTableTableManager(_$AppDatabase db, $VacunasTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VacunasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VacunasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VacunasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> bovinoId = const Value.absent(),
            Value<String> nombreVacuna = const Value.absent(),
            Value<DateTime> fechaAplicacion = const Value.absent(),
            Value<String?> descripcion = const Value.absent(),
            Value<DateTime?> proximaDosis = const Value.absent(),
          }) =>
              VacunasCompanion(
            id: id,
            bovinoId: bovinoId,
            nombreVacuna: nombreVacuna,
            fechaAplicacion: fechaAplicacion,
            descripcion: descripcion,
            proximaDosis: proximaDosis,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int bovinoId,
            required String nombreVacuna,
            required DateTime fechaAplicacion,
            Value<String?> descripcion = const Value.absent(),
            Value<DateTime?> proximaDosis = const Value.absent(),
          }) =>
              VacunasCompanion.insert(
            id: id,
            bovinoId: bovinoId,
            nombreVacuna: nombreVacuna,
            fechaAplicacion: fechaAplicacion,
            descripcion: descripcion,
            proximaDosis: proximaDosis,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$VacunasTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({bovinoId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                      dynamic>>(state) {
                if (bovinoId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.bovinoId,
                    referencedTable:
                        $$VacunasTableReferences._bovinoIdTable(db),
                    referencedColumn:
                        $$VacunasTableReferences._bovinoIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$VacunasTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $VacunasTable,
    Vacuna,
    $$VacunasTableFilterComposer,
    $$VacunasTableOrderingComposer,
    $$VacunasTableAnnotationComposer,
    $$VacunasTableCreateCompanionBuilder,
    $$VacunasTableUpdateCompanionBuilder,
    (Vacuna, $$VacunasTableReferences),
    Vacuna,
    PrefetchHooks Function({bool bovinoId})>;
typedef $$TratamientosTableCreateCompanionBuilder = TratamientosCompanion
    Function({
  Value<int> id,
  required int bovinoId,
  required String descripcion,
  required DateTime fecha,
  Value<String?> veterinario,
});
typedef $$TratamientosTableUpdateCompanionBuilder = TratamientosCompanion
    Function({
  Value<int> id,
  Value<int> bovinoId,
  Value<String> descripcion,
  Value<DateTime> fecha,
  Value<String?> veterinario,
});

final class $$TratamientosTableReferences
    extends BaseReferences<_$AppDatabase, $TratamientosTable, Tratamiento> {
  $$TratamientosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BovinosTable _bovinoIdTable(_$AppDatabase db) =>
      db.bovinos.createAlias(
          $_aliasNameGenerator(db.tratamientos.bovinoId, db.bovinos.id));

  $$BovinosTableProcessedTableManager get bovinoId {
    final $_column = $_itemColumn<int>('bovino_id')!;

    final manager = $$BovinosTableTableManager($_db, $_db.bovinos)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_bovinoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$TratamientosTableFilterComposer
    extends Composer<_$AppDatabase, $TratamientosTable> {
  $$TratamientosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get descripcion => $composableBuilder(
      column: $table.descripcion, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get fecha => $composableBuilder(
      column: $table.fecha, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get veterinario => $composableBuilder(
      column: $table.veterinario, builder: (column) => ColumnFilters(column));

  $$BovinosTableFilterComposer get bovinoId {
    final $$BovinosTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bovinoId,
        referencedTable: $db.bovinos,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinosTableFilterComposer(
              $db: $db,
              $table: $db.bovinos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TratamientosTableOrderingComposer
    extends Composer<_$AppDatabase, $TratamientosTable> {
  $$TratamientosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get descripcion => $composableBuilder(
      column: $table.descripcion, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get fecha => $composableBuilder(
      column: $table.fecha, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get veterinario => $composableBuilder(
      column: $table.veterinario, builder: (column) => ColumnOrderings(column));

  $$BovinosTableOrderingComposer get bovinoId {
    final $$BovinosTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bovinoId,
        referencedTable: $db.bovinos,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinosTableOrderingComposer(
              $db: $db,
              $table: $db.bovinos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TratamientosTableAnnotationComposer
    extends Composer<_$AppDatabase, $TratamientosTable> {
  $$TratamientosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get descripcion => $composableBuilder(
      column: $table.descripcion, builder: (column) => column);

  GeneratedColumn<DateTime> get fecha =>
      $composableBuilder(column: $table.fecha, builder: (column) => column);

  GeneratedColumn<String> get veterinario => $composableBuilder(
      column: $table.veterinario, builder: (column) => column);

  $$BovinosTableAnnotationComposer get bovinoId {
    final $$BovinosTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bovinoId,
        referencedTable: $db.bovinos,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinosTableAnnotationComposer(
              $db: $db,
              $table: $db.bovinos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TratamientosTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TratamientosTable,
    Tratamiento,
    $$TratamientosTableFilterComposer,
    $$TratamientosTableOrderingComposer,
    $$TratamientosTableAnnotationComposer,
    $$TratamientosTableCreateCompanionBuilder,
    $$TratamientosTableUpdateCompanionBuilder,
    (Tratamiento, $$TratamientosTableReferences),
    Tratamiento,
    PrefetchHooks Function({bool bovinoId})> {
  $$TratamientosTableTableManager(_$AppDatabase db, $TratamientosTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TratamientosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TratamientosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TratamientosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> bovinoId = const Value.absent(),
            Value<String> descripcion = const Value.absent(),
            Value<DateTime> fecha = const Value.absent(),
            Value<String?> veterinario = const Value.absent(),
          }) =>
              TratamientosCompanion(
            id: id,
            bovinoId: bovinoId,
            descripcion: descripcion,
            fecha: fecha,
            veterinario: veterinario,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int bovinoId,
            required String descripcion,
            required DateTime fecha,
            Value<String?> veterinario = const Value.absent(),
          }) =>
              TratamientosCompanion.insert(
            id: id,
            bovinoId: bovinoId,
            descripcion: descripcion,
            fecha: fecha,
            veterinario: veterinario,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$TratamientosTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({bovinoId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                      dynamic>>(state) {
                if (bovinoId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.bovinoId,
                    referencedTable:
                        $$TratamientosTableReferences._bovinoIdTable(db),
                    referencedColumn:
                        $$TratamientosTableReferences._bovinoIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$TratamientosTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TratamientosTable,
    Tratamiento,
    $$TratamientosTableFilterComposer,
    $$TratamientosTableOrderingComposer,
    $$TratamientosTableAnnotationComposer,
    $$TratamientosTableCreateCompanionBuilder,
    $$TratamientosTableUpdateCompanionBuilder,
    (Tratamiento, $$TratamientosTableReferences),
    Tratamiento,
    PrefetchHooks Function({bool bovinoId})>;
typedef $$RegistroReproductivoTableCreateCompanionBuilder
    = RegistroReproductivoCompanion Function({
  Value<int> id,
  required int bovinoId,
  required String tipo,
  Value<String?> diagnostico,
  required DateTime fecha,
  Value<DateTime?> fechaProbableParto,
  Value<int?> toroId,
});
typedef $$RegistroReproductivoTableUpdateCompanionBuilder
    = RegistroReproductivoCompanion Function({
  Value<int> id,
  Value<int> bovinoId,
  Value<String> tipo,
  Value<String?> diagnostico,
  Value<DateTime> fecha,
  Value<DateTime?> fechaProbableParto,
  Value<int?> toroId,
});

final class $$RegistroReproductivoTableReferences extends BaseReferences<
    _$AppDatabase, $RegistroReproductivoTable, RegistroReproductivoData> {
  $$RegistroReproductivoTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $BovinosTable _bovinoIdTable(_$AppDatabase db) =>
      db.bovinos.createAlias($_aliasNameGenerator(
          db.registroReproductivo.bovinoId, db.bovinos.id));

  $$BovinosTableProcessedTableManager get bovinoId {
    final $_column = $_itemColumn<int>('bovino_id')!;

    final manager = $$BovinosTableTableManager($_db, $_db.bovinos)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_bovinoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $TorosTable _toroIdTable(_$AppDatabase db) => db.toros.createAlias(
      $_aliasNameGenerator(db.registroReproductivo.toroId, db.toros.id));

  $$TorosTableProcessedTableManager? get toroId {
    final $_column = $_itemColumn<int>('toro_id');
    if ($_column == null) return null;
    final manager = $$TorosTableTableManager($_db, $_db.toros)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_toroIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$RegistroReproductivoTableFilterComposer
    extends Composer<_$AppDatabase, $RegistroReproductivoTable> {
  $$RegistroReproductivoTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tipo => $composableBuilder(
      column: $table.tipo, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get diagnostico => $composableBuilder(
      column: $table.diagnostico, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get fecha => $composableBuilder(
      column: $table.fecha, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get fechaProbableParto => $composableBuilder(
      column: $table.fechaProbableParto,
      builder: (column) => ColumnFilters(column));

  $$BovinosTableFilterComposer get bovinoId {
    final $$BovinosTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bovinoId,
        referencedTable: $db.bovinos,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinosTableFilterComposer(
              $db: $db,
              $table: $db.bovinos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TorosTableFilterComposer get toroId {
    final $$TorosTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.toroId,
        referencedTable: $db.toros,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TorosTableFilterComposer(
              $db: $db,
              $table: $db.toros,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$RegistroReproductivoTableOrderingComposer
    extends Composer<_$AppDatabase, $RegistroReproductivoTable> {
  $$RegistroReproductivoTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tipo => $composableBuilder(
      column: $table.tipo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get diagnostico => $composableBuilder(
      column: $table.diagnostico, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get fecha => $composableBuilder(
      column: $table.fecha, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get fechaProbableParto => $composableBuilder(
      column: $table.fechaProbableParto,
      builder: (column) => ColumnOrderings(column));

  $$BovinosTableOrderingComposer get bovinoId {
    final $$BovinosTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bovinoId,
        referencedTable: $db.bovinos,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinosTableOrderingComposer(
              $db: $db,
              $table: $db.bovinos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TorosTableOrderingComposer get toroId {
    final $$TorosTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.toroId,
        referencedTable: $db.toros,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TorosTableOrderingComposer(
              $db: $db,
              $table: $db.toros,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$RegistroReproductivoTableAnnotationComposer
    extends Composer<_$AppDatabase, $RegistroReproductivoTable> {
  $$RegistroReproductivoTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tipo =>
      $composableBuilder(column: $table.tipo, builder: (column) => column);

  GeneratedColumn<String> get diagnostico => $composableBuilder(
      column: $table.diagnostico, builder: (column) => column);

  GeneratedColumn<DateTime> get fecha =>
      $composableBuilder(column: $table.fecha, builder: (column) => column);

  GeneratedColumn<DateTime> get fechaProbableParto => $composableBuilder(
      column: $table.fechaProbableParto, builder: (column) => column);

  $$BovinosTableAnnotationComposer get bovinoId {
    final $$BovinosTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bovinoId,
        referencedTable: $db.bovinos,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinosTableAnnotationComposer(
              $db: $db,
              $table: $db.bovinos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TorosTableAnnotationComposer get toroId {
    final $$TorosTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.toroId,
        referencedTable: $db.toros,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TorosTableAnnotationComposer(
              $db: $db,
              $table: $db.toros,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$RegistroReproductivoTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RegistroReproductivoTable,
    RegistroReproductivoData,
    $$RegistroReproductivoTableFilterComposer,
    $$RegistroReproductivoTableOrderingComposer,
    $$RegistroReproductivoTableAnnotationComposer,
    $$RegistroReproductivoTableCreateCompanionBuilder,
    $$RegistroReproductivoTableUpdateCompanionBuilder,
    (RegistroReproductivoData, $$RegistroReproductivoTableReferences),
    RegistroReproductivoData,
    PrefetchHooks Function({bool bovinoId, bool toroId})> {
  $$RegistroReproductivoTableTableManager(
      _$AppDatabase db, $RegistroReproductivoTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RegistroReproductivoTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RegistroReproductivoTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RegistroReproductivoTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> bovinoId = const Value.absent(),
            Value<String> tipo = const Value.absent(),
            Value<String?> diagnostico = const Value.absent(),
            Value<DateTime> fecha = const Value.absent(),
            Value<DateTime?> fechaProbableParto = const Value.absent(),
            Value<int?> toroId = const Value.absent(),
          }) =>
              RegistroReproductivoCompanion(
            id: id,
            bovinoId: bovinoId,
            tipo: tipo,
            diagnostico: diagnostico,
            fecha: fecha,
            fechaProbableParto: fechaProbableParto,
            toroId: toroId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int bovinoId,
            required String tipo,
            Value<String?> diagnostico = const Value.absent(),
            required DateTime fecha,
            Value<DateTime?> fechaProbableParto = const Value.absent(),
            Value<int?> toroId = const Value.absent(),
          }) =>
              RegistroReproductivoCompanion.insert(
            id: id,
            bovinoId: bovinoId,
            tipo: tipo,
            diagnostico: diagnostico,
            fecha: fecha,
            fechaProbableParto: fechaProbableParto,
            toroId: toroId,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$RegistroReproductivoTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({bovinoId = false, toroId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                      dynamic>>(state) {
                if (bovinoId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.bovinoId,
                    referencedTable: $$RegistroReproductivoTableReferences
                        ._bovinoIdTable(db),
                    referencedColumn: $$RegistroReproductivoTableReferences
                        ._bovinoIdTable(db)
                        .id,
                  ) as T;
                }
                if (toroId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.toroId,
                    referencedTable:
                        $$RegistroReproductivoTableReferences._toroIdTable(db),
                    referencedColumn: $$RegistroReproductivoTableReferences
                        ._toroIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$RegistroReproductivoTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $RegistroReproductivoTable,
        RegistroReproductivoData,
        $$RegistroReproductivoTableFilterComposer,
        $$RegistroReproductivoTableOrderingComposer,
        $$RegistroReproductivoTableAnnotationComposer,
        $$RegistroReproductivoTableCreateCompanionBuilder,
        $$RegistroReproductivoTableUpdateCompanionBuilder,
        (RegistroReproductivoData, $$RegistroReproductivoTableReferences),
        RegistroReproductivoData,
        PrefetchHooks Function({bool bovinoId, bool toroId})>;
typedef $$FotosTableCreateCompanionBuilder = FotosCompanion Function({
  Value<int> id,
  required int bovinoId,
  required String rutaFoto,
  Value<DateTime> fechaCaptura,
  Value<String?> descripcion,
});
typedef $$FotosTableUpdateCompanionBuilder = FotosCompanion Function({
  Value<int> id,
  Value<int> bovinoId,
  Value<String> rutaFoto,
  Value<DateTime> fechaCaptura,
  Value<String?> descripcion,
});

final class $$FotosTableReferences
    extends BaseReferences<_$AppDatabase, $FotosTable, Foto> {
  $$FotosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BovinosTable _bovinoIdTable(_$AppDatabase db) => db.bovinos
      .createAlias($_aliasNameGenerator(db.fotos.bovinoId, db.bovinos.id));

  $$BovinosTableProcessedTableManager get bovinoId {
    final $_column = $_itemColumn<int>('bovino_id')!;

    final manager = $$BovinosTableTableManager($_db, $_db.bovinos)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_bovinoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$FotosTableFilterComposer extends Composer<_$AppDatabase, $FotosTable> {
  $$FotosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get rutaFoto => $composableBuilder(
      column: $table.rutaFoto, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get fechaCaptura => $composableBuilder(
      column: $table.fechaCaptura, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get descripcion => $composableBuilder(
      column: $table.descripcion, builder: (column) => ColumnFilters(column));

  $$BovinosTableFilterComposer get bovinoId {
    final $$BovinosTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bovinoId,
        referencedTable: $db.bovinos,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinosTableFilterComposer(
              $db: $db,
              $table: $db.bovinos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$FotosTableOrderingComposer
    extends Composer<_$AppDatabase, $FotosTable> {
  $$FotosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get rutaFoto => $composableBuilder(
      column: $table.rutaFoto, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get fechaCaptura => $composableBuilder(
      column: $table.fechaCaptura,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get descripcion => $composableBuilder(
      column: $table.descripcion, builder: (column) => ColumnOrderings(column));

  $$BovinosTableOrderingComposer get bovinoId {
    final $$BovinosTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bovinoId,
        referencedTable: $db.bovinos,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinosTableOrderingComposer(
              $db: $db,
              $table: $db.bovinos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$FotosTableAnnotationComposer
    extends Composer<_$AppDatabase, $FotosTable> {
  $$FotosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get rutaFoto =>
      $composableBuilder(column: $table.rutaFoto, builder: (column) => column);

  GeneratedColumn<DateTime> get fechaCaptura => $composableBuilder(
      column: $table.fechaCaptura, builder: (column) => column);

  GeneratedColumn<String> get descripcion => $composableBuilder(
      column: $table.descripcion, builder: (column) => column);

  $$BovinosTableAnnotationComposer get bovinoId {
    final $$BovinosTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bovinoId,
        referencedTable: $db.bovinos,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinosTableAnnotationComposer(
              $db: $db,
              $table: $db.bovinos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$FotosTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FotosTable,
    Foto,
    $$FotosTableFilterComposer,
    $$FotosTableOrderingComposer,
    $$FotosTableAnnotationComposer,
    $$FotosTableCreateCompanionBuilder,
    $$FotosTableUpdateCompanionBuilder,
    (Foto, $$FotosTableReferences),
    Foto,
    PrefetchHooks Function({bool bovinoId})> {
  $$FotosTableTableManager(_$AppDatabase db, $FotosTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FotosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FotosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FotosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> bovinoId = const Value.absent(),
            Value<String> rutaFoto = const Value.absent(),
            Value<DateTime> fechaCaptura = const Value.absent(),
            Value<String?> descripcion = const Value.absent(),
          }) =>
              FotosCompanion(
            id: id,
            bovinoId: bovinoId,
            rutaFoto: rutaFoto,
            fechaCaptura: fechaCaptura,
            descripcion: descripcion,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int bovinoId,
            required String rutaFoto,
            Value<DateTime> fechaCaptura = const Value.absent(),
            Value<String?> descripcion = const Value.absent(),
          }) =>
              FotosCompanion.insert(
            id: id,
            bovinoId: bovinoId,
            rutaFoto: rutaFoto,
            fechaCaptura: fechaCaptura,
            descripcion: descripcion,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$FotosTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({bovinoId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                      dynamic>>(state) {
                if (bovinoId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.bovinoId,
                    referencedTable: $$FotosTableReferences._bovinoIdTable(db),
                    referencedColumn:
                        $$FotosTableReferences._bovinoIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$FotosTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $FotosTable,
    Foto,
    $$FotosTableFilterComposer,
    $$FotosTableOrderingComposer,
    $$FotosTableAnnotationComposer,
    $$FotosTableCreateCompanionBuilder,
    $$FotosTableUpdateCompanionBuilder,
    (Foto, $$FotosTableReferences),
    Foto,
    PrefetchHooks Function({bool bovinoId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$RazasTableTableManager get razas =>
      $$RazasTableTableManager(_db, _db.razas);
  $$LotesTableTableManager get lotes =>
      $$LotesTableTableManager(_db, _db.lotes);
  $$DuenosTableTableManager get duenos =>
      $$DuenosTableTableManager(_db, _db.duenos);
  $$BovinosTableTableManager get bovinos =>
      $$BovinosTableTableManager(_db, _db.bovinos);
  $$PertenenciaTableTableManager get pertenencia =>
      $$PertenenciaTableTableManager(_db, _db.pertenencia);
  $$ProgenieTableTableManager get progenie =>
      $$ProgenieTableTableManager(_db, _db.progenie);
  $$PartosTableTableManager get partos =>
      $$PartosTableTableManager(_db, _db.partos);
  $$VentasTableTableManager get ventas =>
      $$VentasTableTableManager(_db, _db.ventas);
  $$TorosTableTableManager get toros =>
      $$TorosTableTableManager(_db, _db.toros);
  $$VacunasTableTableManager get vacunas =>
      $$VacunasTableTableManager(_db, _db.vacunas);
  $$TratamientosTableTableManager get tratamientos =>
      $$TratamientosTableTableManager(_db, _db.tratamientos);
  $$RegistroReproductivoTableTableManager get registroReproductivo =>
      $$RegistroReproductivoTableTableManager(_db, _db.registroReproductivo);
  $$FotosTableTableManager get fotos =>
      $$FotosTableTableManager(_db, _db.fotos);
}
