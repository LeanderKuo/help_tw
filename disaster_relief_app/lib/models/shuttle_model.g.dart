// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shuttle_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, unused_local_variable

extension GetShuttleModelCollection on Isar {
  IsarCollection<ShuttleModel> get shuttleModels => getCollection();
}

const ShuttleModelSchema = CollectionSchema(
  name: 'ShuttleModel',
  schema:
      '{"name":"ShuttleModel","idName":"isarId","properties":[{"name":"capacity","type":"Long"},{"name":"createdAt","type":"Long"},{"name":"createdBy","type":"String"},{"name":"departureTime","type":"Long"},{"name":"description","type":"String"},{"name":"driverId","type":"String"},{"name":"id","type":"String"},{"name":"routeEndLat","type":"Double"},{"name":"routeEndLng","type":"Double"},{"name":"routeStartLat","type":"Double"},{"name":"routeStartLng","type":"Double"},{"name":"seatsTaken","type":"Long"},{"name":"status","type":"String"},{"name":"title","type":"String"},{"name":"updatedAt","type":"Long"}],"indexes":[],"links":[]}',
  idName: 'isarId',
  propertyIds: {
    'capacity': 0,
    'createdAt': 1,
    'createdBy': 2,
    'departureTime': 3,
    'description': 4,
    'driverId': 5,
    'id': 6,
    'routeEndLat': 7,
    'routeEndLng': 8,
    'routeStartLat': 9,
    'routeStartLng': 10,
    'seatsTaken': 11,
    'status': 12,
    'title': 13,
    'updatedAt': 14
  },
  listProperties: {},
  indexIds: {},
  indexValueTypes: {},
  linkIds: {},
  backlinkLinkNames: {},
  getId: _shuttleModelGetId,
  getLinks: _shuttleModelGetLinks,
  attachLinks: _shuttleModelAttachLinks,
  serializeNative: _shuttleModelSerializeNative,
  deserializeNative: _shuttleModelDeserializeNative,
  deserializePropNative: _shuttleModelDeserializePropNative,
  serializeWeb: _shuttleModelSerializeWeb,
  deserializeWeb: _shuttleModelDeserializeWeb,
  deserializePropWeb: _shuttleModelDeserializePropWeb,
  version: 3,
);

int? _shuttleModelGetId(ShuttleModel object) {
  if (object.isarId == Isar.autoIncrement) {
    return null;
  } else {
    return object.isarId;
  }
}

List<IsarLinkBase> _shuttleModelGetLinks(ShuttleModel object) {
  return [];
}

void _shuttleModelSerializeNative(
    IsarCollection<ShuttleModel> collection,
    IsarRawObject rawObj,
    ShuttleModel object,
    int staticSize,
    List<int> offsets,
    AdapterAlloc alloc) {
  var dynamicSize = 0;
  final value0 = object.capacity;
  final _capacity = value0;
  final value1 = object.createdAt;
  final _createdAt = value1;
  final value2 = object.createdBy;
  IsarUint8List? _createdBy;
  if (value2 != null) {
    _createdBy = IsarBinaryWriter.utf8Encoder.convert(value2);
  }
  dynamicSize += (_createdBy?.length ?? 0) as int;
  final value3 = object.departureTime;
  final _departureTime = value3;
  final value4 = object.description;
  IsarUint8List? _description;
  if (value4 != null) {
    _description = IsarBinaryWriter.utf8Encoder.convert(value4);
  }
  dynamicSize += (_description?.length ?? 0) as int;
  final value5 = object.driverId;
  IsarUint8List? _driverId;
  if (value5 != null) {
    _driverId = IsarBinaryWriter.utf8Encoder.convert(value5);
  }
  dynamicSize += (_driverId?.length ?? 0) as int;
  final value6 = object.id;
  final _id = IsarBinaryWriter.utf8Encoder.convert(value6);
  dynamicSize += (_id.length) as int;
  final value7 = object.routeEndLat;
  final _routeEndLat = value7;
  final value8 = object.routeEndLng;
  final _routeEndLng = value8;
  final value9 = object.routeStartLat;
  final _routeStartLat = value9;
  final value10 = object.routeStartLng;
  final _routeStartLng = value10;
  final value11 = object.seatsTaken;
  final _seatsTaken = value11;
  final value12 = object.status;
  final _status = IsarBinaryWriter.utf8Encoder.convert(value12);
  dynamicSize += (_status.length) as int;
  final value13 = object.title;
  final _title = IsarBinaryWriter.utf8Encoder.convert(value13);
  dynamicSize += (_title.length) as int;
  final value14 = object.updatedAt;
  final _updatedAt = value14;
  final size = staticSize + dynamicSize;

  rawObj.buffer = alloc(size);
  rawObj.buffer_length = size;
  final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
  final writer = IsarBinaryWriter(buffer, staticSize);
  writer.writeLong(offsets[0], _capacity);
  writer.writeDateTime(offsets[1], _createdAt);
  writer.writeBytes(offsets[2], _createdBy);
  writer.writeDateTime(offsets[3], _departureTime);
  writer.writeBytes(offsets[4], _description);
  writer.writeBytes(offsets[5], _driverId);
  writer.writeBytes(offsets[6], _id);
  writer.writeDouble(offsets[7], _routeEndLat);
  writer.writeDouble(offsets[8], _routeEndLng);
  writer.writeDouble(offsets[9], _routeStartLat);
  writer.writeDouble(offsets[10], _routeStartLng);
  writer.writeLong(offsets[11], _seatsTaken);
  writer.writeBytes(offsets[12], _status);
  writer.writeBytes(offsets[13], _title);
  writer.writeDateTime(offsets[14], _updatedAt);
}

ShuttleModel _shuttleModelDeserializeNative(
    IsarCollection<ShuttleModel> collection,
    int id,
    IsarBinaryReader reader,
    List<int> offsets) {
  final object = ShuttleModel(
    capacity: reader.readLong(offsets[0]),
    createdAt: reader.readDateTimeOrNull(offsets[1]),
    createdBy: reader.readStringOrNull(offsets[2]),
    departureTime: reader.readDateTimeOrNull(offsets[3]),
    description: reader.readStringOrNull(offsets[4]),
    driverId: reader.readStringOrNull(offsets[5]),
    id: reader.readString(offsets[6]),
    isarId: id,
    routeEndLat: reader.readDoubleOrNull(offsets[7]),
    routeEndLng: reader.readDoubleOrNull(offsets[8]),
    routeStartLat: reader.readDoubleOrNull(offsets[9]),
    routeStartLng: reader.readDoubleOrNull(offsets[10]),
    seatsTaken: reader.readLong(offsets[11]),
    status: reader.readString(offsets[12]),
    title: reader.readString(offsets[13]),
    updatedAt: reader.readDateTimeOrNull(offsets[14]),
  );
  return object;
}

P _shuttleModelDeserializePropNative<P>(
    int id, IsarBinaryReader reader, int propertyIndex, int offset) {
  switch (propertyIndex) {
    case -1:
      return id as P;
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readDoubleOrNull(offset)) as P;
    case 8:
      return (reader.readDoubleOrNull(offset)) as P;
    case 9:
      return (reader.readDoubleOrNull(offset)) as P;
    case 10:
      return (reader.readDoubleOrNull(offset)) as P;
    case 11:
      return (reader.readLong(offset)) as P;
    case 12:
      return (reader.readString(offset)) as P;
    case 13:
      return (reader.readString(offset)) as P;
    case 14:
      return (reader.readDateTimeOrNull(offset)) as P;
    default:
      throw 'Illegal propertyIndex';
  }
}

dynamic _shuttleModelSerializeWeb(
    IsarCollection<ShuttleModel> collection, ShuttleModel object) {
  final jsObj = IsarNative.newJsObject();
  IsarNative.jsObjectSet(jsObj, 'capacity', object.capacity);
  IsarNative.jsObjectSet(
      jsObj, 'createdAt', object.createdAt?.toUtc().millisecondsSinceEpoch);
  IsarNative.jsObjectSet(jsObj, 'createdBy', object.createdBy);
  IsarNative.jsObjectSet(jsObj, 'departureTime',
      object.departureTime?.toUtc().millisecondsSinceEpoch);
  IsarNative.jsObjectSet(jsObj, 'description', object.description);
  IsarNative.jsObjectSet(jsObj, 'driverId', object.driverId);
  IsarNative.jsObjectSet(jsObj, 'id', object.id);
  IsarNative.jsObjectSet(jsObj, 'isarId', object.isarId);
  IsarNative.jsObjectSet(jsObj, 'routeEndLat', object.routeEndLat);
  IsarNative.jsObjectSet(jsObj, 'routeEndLng', object.routeEndLng);
  IsarNative.jsObjectSet(jsObj, 'routeStartLat', object.routeStartLat);
  IsarNative.jsObjectSet(jsObj, 'routeStartLng', object.routeStartLng);
  IsarNative.jsObjectSet(jsObj, 'seatsTaken', object.seatsTaken);
  IsarNative.jsObjectSet(jsObj, 'status', object.status);
  IsarNative.jsObjectSet(jsObj, 'title', object.title);
  IsarNative.jsObjectSet(
      jsObj, 'updatedAt', object.updatedAt?.toUtc().millisecondsSinceEpoch);
  return jsObj;
}

ShuttleModel _shuttleModelDeserializeWeb(
    IsarCollection<ShuttleModel> collection, dynamic jsObj) {
  final object = ShuttleModel(
    capacity:
        IsarNative.jsObjectGet(jsObj, 'capacity') ?? double.negativeInfinity,
    createdAt: IsarNative.jsObjectGet(jsObj, 'createdAt') != null
        ? DateTime.fromMillisecondsSinceEpoch(
                IsarNative.jsObjectGet(jsObj, 'createdAt'),
                isUtc: true)
            .toLocal()
        : null,
    createdBy: IsarNative.jsObjectGet(jsObj, 'createdBy'),
    departureTime: IsarNative.jsObjectGet(jsObj, 'departureTime') != null
        ? DateTime.fromMillisecondsSinceEpoch(
                IsarNative.jsObjectGet(jsObj, 'departureTime'),
                isUtc: true)
            .toLocal()
        : null,
    description: IsarNative.jsObjectGet(jsObj, 'description'),
    driverId: IsarNative.jsObjectGet(jsObj, 'driverId'),
    id: IsarNative.jsObjectGet(jsObj, 'id') ?? '',
    isarId: IsarNative.jsObjectGet(jsObj, 'isarId'),
    routeEndLat: IsarNative.jsObjectGet(jsObj, 'routeEndLat'),
    routeEndLng: IsarNative.jsObjectGet(jsObj, 'routeEndLng'),
    routeStartLat: IsarNative.jsObjectGet(jsObj, 'routeStartLat'),
    routeStartLng: IsarNative.jsObjectGet(jsObj, 'routeStartLng'),
    seatsTaken:
        IsarNative.jsObjectGet(jsObj, 'seatsTaken') ?? double.negativeInfinity,
    status: IsarNative.jsObjectGet(jsObj, 'status') ?? '',
    title: IsarNative.jsObjectGet(jsObj, 'title') ?? '',
    updatedAt: IsarNative.jsObjectGet(jsObj, 'updatedAt') != null
        ? DateTime.fromMillisecondsSinceEpoch(
                IsarNative.jsObjectGet(jsObj, 'updatedAt'),
                isUtc: true)
            .toLocal()
        : null,
  );
  return object;
}

P _shuttleModelDeserializePropWeb<P>(Object jsObj, String propertyName) {
  switch (propertyName) {
    case 'capacity':
      return (IsarNative.jsObjectGet(jsObj, 'capacity') ??
          double.negativeInfinity) as P;
    case 'createdAt':
      return (IsarNative.jsObjectGet(jsObj, 'createdAt') != null
          ? DateTime.fromMillisecondsSinceEpoch(
                  IsarNative.jsObjectGet(jsObj, 'createdAt'),
                  isUtc: true)
              .toLocal()
          : null) as P;
    case 'createdBy':
      return (IsarNative.jsObjectGet(jsObj, 'createdBy')) as P;
    case 'departureTime':
      return (IsarNative.jsObjectGet(jsObj, 'departureTime') != null
          ? DateTime.fromMillisecondsSinceEpoch(
                  IsarNative.jsObjectGet(jsObj, 'departureTime'),
                  isUtc: true)
              .toLocal()
          : null) as P;
    case 'description':
      return (IsarNative.jsObjectGet(jsObj, 'description')) as P;
    case 'driverId':
      return (IsarNative.jsObjectGet(jsObj, 'driverId')) as P;
    case 'id':
      return (IsarNative.jsObjectGet(jsObj, 'id') ?? '') as P;
    case 'isarId':
      return (IsarNative.jsObjectGet(jsObj, 'isarId')) as P;
    case 'routeEndLat':
      return (IsarNative.jsObjectGet(jsObj, 'routeEndLat')) as P;
    case 'routeEndLng':
      return (IsarNative.jsObjectGet(jsObj, 'routeEndLng')) as P;
    case 'routeStartLat':
      return (IsarNative.jsObjectGet(jsObj, 'routeStartLat')) as P;
    case 'routeStartLng':
      return (IsarNative.jsObjectGet(jsObj, 'routeStartLng')) as P;
    case 'seatsTaken':
      return (IsarNative.jsObjectGet(jsObj, 'seatsTaken') ??
          double.negativeInfinity) as P;
    case 'status':
      return (IsarNative.jsObjectGet(jsObj, 'status') ?? '') as P;
    case 'title':
      return (IsarNative.jsObjectGet(jsObj, 'title') ?? '') as P;
    case 'updatedAt':
      return (IsarNative.jsObjectGet(jsObj, 'updatedAt') != null
          ? DateTime.fromMillisecondsSinceEpoch(
                  IsarNative.jsObjectGet(jsObj, 'updatedAt'),
                  isUtc: true)
              .toLocal()
          : null) as P;
    default:
      throw 'Illegal propertyName';
  }
}

void _shuttleModelAttachLinks(
    IsarCollection col, int id, ShuttleModel object) {}

extension ShuttleModelQueryWhereSort
    on QueryBuilder<ShuttleModel, ShuttleModel, QWhere> {
  QueryBuilder<ShuttleModel, ShuttleModel, QAfterWhere> anyIsarId() {
    return addWhereClauseInternal(const IdWhereClause.any());
  }
}

extension ShuttleModelQueryWhere
    on QueryBuilder<ShuttleModel, ShuttleModel, QWhereClause> {
  QueryBuilder<ShuttleModel, ShuttleModel, QAfterWhereClause> isarIdEqualTo(
      int isarId) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: isarId,
      includeLower: true,
      upper: isarId,
      includeUpper: true,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterWhereClause> isarIdNotEqualTo(
      int isarId) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(
        IdWhereClause.lessThan(upper: isarId, includeUpper: false),
      ).addWhereClauseInternal(
        IdWhereClause.greaterThan(lower: isarId, includeLower: false),
      );
    } else {
      return addWhereClauseInternal(
        IdWhereClause.greaterThan(lower: isarId, includeLower: false),
      ).addWhereClauseInternal(
        IdWhereClause.lessThan(upper: isarId, includeUpper: false),
      );
    }
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterWhereClause> isarIdGreaterThan(
      int isarId,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.greaterThan(lower: isarId, includeLower: include),
    );
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterWhereClause> isarIdLessThan(
      int isarId,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.lessThan(upper: isarId, includeUpper: include),
    );
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterWhereClause> isarIdBetween(
    int lowerIsarId,
    int upperIsarId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: lowerIsarId,
      includeLower: includeLower,
      upper: upperIsarId,
      includeUpper: includeUpper,
    ));
  }
}

extension ShuttleModelQueryFilter
    on QueryBuilder<ShuttleModel, ShuttleModel, QFilterCondition> {
  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      capacityEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'capacity',
      value: value,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      capacityGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'capacity',
      value: value,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      capacityLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'capacity',
      value: value,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      capacityBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'capacity',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      createdAtIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'createdAt',
      value: null,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      createdAtEqualTo(DateTime? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'createdAt',
      value: value,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      createdAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'createdAt',
      value: value,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      createdAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'createdAt',
      value: value,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      createdAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'createdAt',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      createdByIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'createdBy',
      value: null,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      createdByEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'createdBy',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      createdByGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'createdBy',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      createdByLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'createdBy',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      createdByBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'createdBy',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      createdByStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'createdBy',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      createdByEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'createdBy',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      createdByContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'createdBy',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      createdByMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'createdBy',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      departureTimeIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'departureTime',
      value: null,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      departureTimeEqualTo(DateTime? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'departureTime',
      value: value,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      departureTimeGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'departureTime',
      value: value,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      departureTimeLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'departureTime',
      value: value,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      departureTimeBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'departureTime',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      descriptionIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'description',
      value: null,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      descriptionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'description',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      descriptionGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'description',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      descriptionLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'description',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      descriptionBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'description',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      descriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'description',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      descriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'description',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      descriptionContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'description',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      descriptionMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'description',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      driverIdIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'driverId',
      value: null,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      driverIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'driverId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      driverIdGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'driverId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      driverIdLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'driverId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      driverIdBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'driverId',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      driverIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'driverId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      driverIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'driverId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      driverIdContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'driverId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      driverIdMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'driverId',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition> idEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition> idGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition> idLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition> idBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'id',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition> idStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition> idEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition> idContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition> idMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'id',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      isarIdIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'isarId',
      value: null,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition> isarIdEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      isarIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      isarIdLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition> isarIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'isarId',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      routeEndLatIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'routeEndLat',
      value: null,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      routeEndLatGreaterThan(double? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: false,
      property: 'routeEndLat',
      value: value,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      routeEndLatLessThan(double? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: false,
      property: 'routeEndLat',
      value: value,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      routeEndLatBetween(double? lower, double? upper) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'routeEndLat',
      lower: lower,
      includeLower: false,
      upper: upper,
      includeUpper: false,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      routeEndLngIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'routeEndLng',
      value: null,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      routeEndLngGreaterThan(double? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: false,
      property: 'routeEndLng',
      value: value,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      routeEndLngLessThan(double? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: false,
      property: 'routeEndLng',
      value: value,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      routeEndLngBetween(double? lower, double? upper) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'routeEndLng',
      lower: lower,
      includeLower: false,
      upper: upper,
      includeUpper: false,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      routeStartLatIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'routeStartLat',
      value: null,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      routeStartLatGreaterThan(double? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: false,
      property: 'routeStartLat',
      value: value,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      routeStartLatLessThan(double? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: false,
      property: 'routeStartLat',
      value: value,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      routeStartLatBetween(double? lower, double? upper) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'routeStartLat',
      lower: lower,
      includeLower: false,
      upper: upper,
      includeUpper: false,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      routeStartLngIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'routeStartLng',
      value: null,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      routeStartLngGreaterThan(double? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: false,
      property: 'routeStartLng',
      value: value,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      routeStartLngLessThan(double? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: false,
      property: 'routeStartLng',
      value: value,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      routeStartLngBetween(double? lower, double? upper) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'routeStartLng',
      lower: lower,
      includeLower: false,
      upper: upper,
      includeUpper: false,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      seatsTakenEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'seatsTaken',
      value: value,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      seatsTakenGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'seatsTaken',
      value: value,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      seatsTakenLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'seatsTaken',
      value: value,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      seatsTakenBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'seatsTaken',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition> statusEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'status',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      statusGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'status',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      statusLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'status',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition> statusBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'status',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      statusStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'status',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      statusEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'status',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      statusContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'status',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition> statusMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'status',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition> titleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'title',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      titleGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'title',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition> titleLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'title',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition> titleBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'title',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'title',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition> titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'title',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition> titleContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'title',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition> titleMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'title',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      updatedAtIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'updatedAt',
      value: null,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      updatedAtEqualTo(DateTime? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'updatedAt',
      value: value,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      updatedAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'updatedAt',
      value: value,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      updatedAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'updatedAt',
      value: value,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      updatedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'updatedAt',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }
}

extension ShuttleModelQueryLinks
    on QueryBuilder<ShuttleModel, ShuttleModel, QFilterCondition> {}

extension ShuttleModelQueryWhereSortBy
    on QueryBuilder<ShuttleModel, ShuttleModel, QSortBy> {
  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> sortByCapacity() {
    return addSortByInternal('capacity', Sort.asc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> sortByCapacityDesc() {
    return addSortByInternal('capacity', Sort.desc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> sortByCreatedAt() {
    return addSortByInternal('createdAt', Sort.asc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> sortByCreatedAtDesc() {
    return addSortByInternal('createdAt', Sort.desc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> sortByCreatedBy() {
    return addSortByInternal('createdBy', Sort.asc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> sortByCreatedByDesc() {
    return addSortByInternal('createdBy', Sort.desc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> sortByDepartureTime() {
    return addSortByInternal('departureTime', Sort.asc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy>
      sortByDepartureTimeDesc() {
    return addSortByInternal('departureTime', Sort.desc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> sortByDescription() {
    return addSortByInternal('description', Sort.asc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy>
      sortByDescriptionDesc() {
    return addSortByInternal('description', Sort.desc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> sortByDriverId() {
    return addSortByInternal('driverId', Sort.asc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> sortByDriverIdDesc() {
    return addSortByInternal('driverId', Sort.desc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> sortByIsarId() {
    return addSortByInternal('isarId', Sort.asc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> sortByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.desc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> sortByRouteEndLat() {
    return addSortByInternal('routeEndLat', Sort.asc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy>
      sortByRouteEndLatDesc() {
    return addSortByInternal('routeEndLat', Sort.desc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> sortByRouteEndLng() {
    return addSortByInternal('routeEndLng', Sort.asc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy>
      sortByRouteEndLngDesc() {
    return addSortByInternal('routeEndLng', Sort.desc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> sortByRouteStartLat() {
    return addSortByInternal('routeStartLat', Sort.asc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy>
      sortByRouteStartLatDesc() {
    return addSortByInternal('routeStartLat', Sort.desc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> sortByRouteStartLng() {
    return addSortByInternal('routeStartLng', Sort.asc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy>
      sortByRouteStartLngDesc() {
    return addSortByInternal('routeStartLng', Sort.desc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> sortBySeatsTaken() {
    return addSortByInternal('seatsTaken', Sort.asc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy>
      sortBySeatsTakenDesc() {
    return addSortByInternal('seatsTaken', Sort.desc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> sortByStatus() {
    return addSortByInternal('status', Sort.asc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> sortByStatusDesc() {
    return addSortByInternal('status', Sort.desc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> sortByTitle() {
    return addSortByInternal('title', Sort.asc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> sortByTitleDesc() {
    return addSortByInternal('title', Sort.desc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> sortByUpdatedAt() {
    return addSortByInternal('updatedAt', Sort.asc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> sortByUpdatedAtDesc() {
    return addSortByInternal('updatedAt', Sort.desc);
  }
}

extension ShuttleModelQueryWhereSortThenBy
    on QueryBuilder<ShuttleModel, ShuttleModel, QSortThenBy> {
  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> thenByCapacity() {
    return addSortByInternal('capacity', Sort.asc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> thenByCapacityDesc() {
    return addSortByInternal('capacity', Sort.desc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> thenByCreatedAt() {
    return addSortByInternal('createdAt', Sort.asc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> thenByCreatedAtDesc() {
    return addSortByInternal('createdAt', Sort.desc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> thenByCreatedBy() {
    return addSortByInternal('createdBy', Sort.asc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> thenByCreatedByDesc() {
    return addSortByInternal('createdBy', Sort.desc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> thenByDepartureTime() {
    return addSortByInternal('departureTime', Sort.asc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy>
      thenByDepartureTimeDesc() {
    return addSortByInternal('departureTime', Sort.desc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> thenByDescription() {
    return addSortByInternal('description', Sort.asc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy>
      thenByDescriptionDesc() {
    return addSortByInternal('description', Sort.desc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> thenByDriverId() {
    return addSortByInternal('driverId', Sort.asc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> thenByDriverIdDesc() {
    return addSortByInternal('driverId', Sort.desc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> thenByIsarId() {
    return addSortByInternal('isarId', Sort.asc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> thenByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.desc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> thenByRouteEndLat() {
    return addSortByInternal('routeEndLat', Sort.asc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy>
      thenByRouteEndLatDesc() {
    return addSortByInternal('routeEndLat', Sort.desc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> thenByRouteEndLng() {
    return addSortByInternal('routeEndLng', Sort.asc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy>
      thenByRouteEndLngDesc() {
    return addSortByInternal('routeEndLng', Sort.desc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> thenByRouteStartLat() {
    return addSortByInternal('routeStartLat', Sort.asc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy>
      thenByRouteStartLatDesc() {
    return addSortByInternal('routeStartLat', Sort.desc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> thenByRouteStartLng() {
    return addSortByInternal('routeStartLng', Sort.asc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy>
      thenByRouteStartLngDesc() {
    return addSortByInternal('routeStartLng', Sort.desc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> thenBySeatsTaken() {
    return addSortByInternal('seatsTaken', Sort.asc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy>
      thenBySeatsTakenDesc() {
    return addSortByInternal('seatsTaken', Sort.desc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> thenByStatus() {
    return addSortByInternal('status', Sort.asc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> thenByStatusDesc() {
    return addSortByInternal('status', Sort.desc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> thenByTitle() {
    return addSortByInternal('title', Sort.asc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> thenByTitleDesc() {
    return addSortByInternal('title', Sort.desc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> thenByUpdatedAt() {
    return addSortByInternal('updatedAt', Sort.asc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> thenByUpdatedAtDesc() {
    return addSortByInternal('updatedAt', Sort.desc);
  }
}

extension ShuttleModelQueryWhereDistinct
    on QueryBuilder<ShuttleModel, ShuttleModel, QDistinct> {
  QueryBuilder<ShuttleModel, ShuttleModel, QDistinct> distinctByCapacity() {
    return addDistinctByInternal('capacity');
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QDistinct> distinctByCreatedAt() {
    return addDistinctByInternal('createdAt');
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QDistinct> distinctByCreatedBy(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('createdBy', caseSensitive: caseSensitive);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QDistinct>
      distinctByDepartureTime() {
    return addDistinctByInternal('departureTime');
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QDistinct> distinctByDescription(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('description', caseSensitive: caseSensitive);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QDistinct> distinctByDriverId(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('driverId', caseSensitive: caseSensitive);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QDistinct> distinctById(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('id', caseSensitive: caseSensitive);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QDistinct> distinctByIsarId() {
    return addDistinctByInternal('isarId');
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QDistinct> distinctByRouteEndLat() {
    return addDistinctByInternal('routeEndLat');
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QDistinct> distinctByRouteEndLng() {
    return addDistinctByInternal('routeEndLng');
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QDistinct>
      distinctByRouteStartLat() {
    return addDistinctByInternal('routeStartLat');
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QDistinct>
      distinctByRouteStartLng() {
    return addDistinctByInternal('routeStartLng');
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QDistinct> distinctBySeatsTaken() {
    return addDistinctByInternal('seatsTaken');
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QDistinct> distinctByStatus(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('status', caseSensitive: caseSensitive);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QDistinct> distinctByTitle(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('title', caseSensitive: caseSensitive);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QDistinct> distinctByUpdatedAt() {
    return addDistinctByInternal('updatedAt');
  }
}

extension ShuttleModelQueryProperty
    on QueryBuilder<ShuttleModel, ShuttleModel, QQueryProperty> {
  QueryBuilder<ShuttleModel, int, QQueryOperations> capacityProperty() {
    return addPropertyNameInternal('capacity');
  }

  QueryBuilder<ShuttleModel, DateTime?, QQueryOperations> createdAtProperty() {
    return addPropertyNameInternal('createdAt');
  }

  QueryBuilder<ShuttleModel, String?, QQueryOperations> createdByProperty() {
    return addPropertyNameInternal('createdBy');
  }

  QueryBuilder<ShuttleModel, DateTime?, QQueryOperations>
      departureTimeProperty() {
    return addPropertyNameInternal('departureTime');
  }

  QueryBuilder<ShuttleModel, String?, QQueryOperations> descriptionProperty() {
    return addPropertyNameInternal('description');
  }

  QueryBuilder<ShuttleModel, String?, QQueryOperations> driverIdProperty() {
    return addPropertyNameInternal('driverId');
  }

  QueryBuilder<ShuttleModel, String, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<ShuttleModel, int?, QQueryOperations> isarIdProperty() {
    return addPropertyNameInternal('isarId');
  }

  QueryBuilder<ShuttleModel, double?, QQueryOperations> routeEndLatProperty() {
    return addPropertyNameInternal('routeEndLat');
  }

  QueryBuilder<ShuttleModel, double?, QQueryOperations> routeEndLngProperty() {
    return addPropertyNameInternal('routeEndLng');
  }

  QueryBuilder<ShuttleModel, double?, QQueryOperations>
      routeStartLatProperty() {
    return addPropertyNameInternal('routeStartLat');
  }

  QueryBuilder<ShuttleModel, double?, QQueryOperations>
      routeStartLngProperty() {
    return addPropertyNameInternal('routeStartLng');
  }

  QueryBuilder<ShuttleModel, int, QQueryOperations> seatsTakenProperty() {
    return addPropertyNameInternal('seatsTaken');
  }

  QueryBuilder<ShuttleModel, String, QQueryOperations> statusProperty() {
    return addPropertyNameInternal('status');
  }

  QueryBuilder<ShuttleModel, String, QQueryOperations> titleProperty() {
    return addPropertyNameInternal('title');
  }

  QueryBuilder<ShuttleModel, DateTime?, QQueryOperations> updatedAtProperty() {
    return addPropertyNameInternal('updatedAt');
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ShuttleModelImpl _$$ShuttleModelImplFromJson(Map<String, dynamic> json) =>
    _$ShuttleModelImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      status: json['status'] as String? ?? 'Scheduled',
      routeStartLat: (json['route_start_lat'] as num?)?.toDouble(),
      routeStartLng: (json['route_start_lng'] as num?)?.toDouble(),
      routeEndLat: (json['route_end_lat'] as num?)?.toDouble(),
      routeEndLng: (json['route_end_lng'] as num?)?.toDouble(),
      departureTime: json['departure_time'] == null
          ? null
          : DateTime.parse(json['departure_time'] as String),
      capacity: (json['capacity'] as num?)?.toInt() ?? 0,
      seatsTaken: (json['seats_taken'] as num?)?.toInt() ?? 0,
      driverId: json['driver_id'] as String?,
      createdBy: json['created_by'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$ShuttleModelImplToJson(_$ShuttleModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'status': instance.status,
      'route_start_lat': instance.routeStartLat,
      'route_start_lng': instance.routeStartLng,
      'route_end_lat': instance.routeEndLat,
      'route_end_lng': instance.routeEndLng,
      'departure_time': instance.departureTime?.toIso8601String(),
      'capacity': instance.capacity,
      'seats_taken': instance.seatsTaken,
      'driver_id': instance.driverId,
      'created_by': instance.createdBy,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
