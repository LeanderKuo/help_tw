// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resource_point.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, unused_local_variable

extension GetResourcePointCollection on Isar {
  IsarCollection<ResourcePoint> get resourcePoints => getCollection();
}

const ResourcePointSchema = CollectionSchema(
  name: 'ResourcePoint',
  schema:
      '{"name":"ResourcePoint","idName":"isarId","properties":[{"name":"address","type":"String"},{"name":"categories","type":"StringList"},{"name":"contactMaskedPhone","type":"String"},{"name":"createdAt","type":"Long"},{"name":"createdBy","type":"String"},{"name":"description","type":"String"},{"name":"expiry","type":"Long"},{"name":"id","type":"String"},{"name":"images","type":"StringList"},{"name":"latitude","type":"Double"},{"name":"longitude","type":"Double"},{"name":"status","type":"String"},{"name":"title","type":"String"},{"name":"type","type":"String"},{"name":"updatedAt","type":"Long"}],"indexes":[],"links":[]}',
  idName: 'isarId',
  propertyIds: {
    'address': 0,
    'categories': 1,
    'contactMaskedPhone': 2,
    'createdAt': 3,
    'createdBy': 4,
    'description': 5,
    'expiry': 6,
    'id': 7,
    'images': 8,
    'latitude': 9,
    'longitude': 10,
    'status': 11,
    'title': 12,
    'type': 13,
    'updatedAt': 14
  },
  listProperties: {'categories', 'images'},
  indexIds: {},
  indexValueTypes: {},
  linkIds: {},
  backlinkLinkNames: {},
  getId: _resourcePointGetId,
  getLinks: _resourcePointGetLinks,
  attachLinks: _resourcePointAttachLinks,
  serializeNative: _resourcePointSerializeNative,
  deserializeNative: _resourcePointDeserializeNative,
  deserializePropNative: _resourcePointDeserializePropNative,
  serializeWeb: _resourcePointSerializeWeb,
  deserializeWeb: _resourcePointDeserializeWeb,
  deserializePropWeb: _resourcePointDeserializePropWeb,
  version: 3,
);

int? _resourcePointGetId(ResourcePoint object) {
  if (object.isarId == Isar.autoIncrement) {
    return null;
  } else {
    return object.isarId;
  }
}

List<IsarLinkBase> _resourcePointGetLinks(ResourcePoint object) {
  return [];
}

void _resourcePointSerializeNative(
    IsarCollection<ResourcePoint> collection,
    IsarRawObject rawObj,
    ResourcePoint object,
    int staticSize,
    List<int> offsets,
    AdapterAlloc alloc) {
  var dynamicSize = 0;
  final value0 = object.address;
  IsarUint8List? _address;
  if (value0 != null) {
    _address = IsarBinaryWriter.utf8Encoder.convert(value0);
  }
  dynamicSize += (_address?.length ?? 0) as int;
  final value1 = object.categories;
  dynamicSize += (value1.length) * 8;
  final bytesList1 = <IsarUint8List>[];
  for (var str in value1) {
    final bytes = IsarBinaryWriter.utf8Encoder.convert(str);
    bytesList1.add(bytes);
    dynamicSize += bytes.length as int;
  }
  final _categories = bytesList1;
  final value2 = object.contactMaskedPhone;
  IsarUint8List? _contactMaskedPhone;
  if (value2 != null) {
    _contactMaskedPhone = IsarBinaryWriter.utf8Encoder.convert(value2);
  }
  dynamicSize += (_contactMaskedPhone?.length ?? 0) as int;
  final value3 = object.createdAt;
  final _createdAt = value3;
  final value4 = object.createdBy;
  IsarUint8List? _createdBy;
  if (value4 != null) {
    _createdBy = IsarBinaryWriter.utf8Encoder.convert(value4);
  }
  dynamicSize += (_createdBy?.length ?? 0) as int;
  final value5 = object.description;
  IsarUint8List? _description;
  if (value5 != null) {
    _description = IsarBinaryWriter.utf8Encoder.convert(value5);
  }
  dynamicSize += (_description?.length ?? 0) as int;
  final value6 = object.expiry;
  final _expiry = value6;
  final value7 = object.id;
  final _id = IsarBinaryWriter.utf8Encoder.convert(value7);
  dynamicSize += (_id.length) as int;
  final value8 = object.images;
  dynamicSize += (value8.length) * 8;
  final bytesList8 = <IsarUint8List>[];
  for (var str in value8) {
    final bytes = IsarBinaryWriter.utf8Encoder.convert(str);
    bytesList8.add(bytes);
    dynamicSize += bytes.length as int;
  }
  final _images = bytesList8;
  final value9 = object.latitude;
  final _latitude = value9;
  final value10 = object.longitude;
  final _longitude = value10;
  final value11 = object.status;
  final _status = IsarBinaryWriter.utf8Encoder.convert(value11);
  dynamicSize += (_status.length) as int;
  final value12 = object.title;
  final _title = IsarBinaryWriter.utf8Encoder.convert(value12);
  dynamicSize += (_title.length) as int;
  final value13 = object.type;
  final _type = IsarBinaryWriter.utf8Encoder.convert(value13);
  dynamicSize += (_type.length) as int;
  final value14 = object.updatedAt;
  final _updatedAt = value14;
  final size = staticSize + dynamicSize;

  rawObj.buffer = alloc(size);
  rawObj.buffer_length = size;
  final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
  final writer = IsarBinaryWriter(buffer, staticSize);
  writer.writeBytes(offsets[0], _address);
  writer.writeStringList(offsets[1], _categories);
  writer.writeBytes(offsets[2], _contactMaskedPhone);
  writer.writeDateTime(offsets[3], _createdAt);
  writer.writeBytes(offsets[4], _createdBy);
  writer.writeBytes(offsets[5], _description);
  writer.writeDateTime(offsets[6], _expiry);
  writer.writeBytes(offsets[7], _id);
  writer.writeStringList(offsets[8], _images);
  writer.writeDouble(offsets[9], _latitude);
  writer.writeDouble(offsets[10], _longitude);
  writer.writeBytes(offsets[11], _status);
  writer.writeBytes(offsets[12], _title);
  writer.writeBytes(offsets[13], _type);
  writer.writeDateTime(offsets[14], _updatedAt);
}

ResourcePoint _resourcePointDeserializeNative(
    IsarCollection<ResourcePoint> collection,
    int id,
    IsarBinaryReader reader,
    List<int> offsets) {
  final object = ResourcePoint(
    address: reader.readStringOrNull(offsets[0]),
    categories: reader.readStringList(offsets[1]) ?? [],
    contactMaskedPhone: reader.readStringOrNull(offsets[2]),
    createdAt: reader.readDateTimeOrNull(offsets[3]),
    createdBy: reader.readStringOrNull(offsets[4]),
    description: reader.readStringOrNull(offsets[5]),
    expiry: reader.readDateTimeOrNull(offsets[6]),
    id: reader.readString(offsets[7]),
    images: reader.readStringList(offsets[8]) ?? [],
    isarId: id,
    latitude: reader.readDouble(offsets[9]),
    longitude: reader.readDouble(offsets[10]),
    status: reader.readString(offsets[11]),
    title: reader.readString(offsets[12]),
    type: reader.readString(offsets[13]),
    updatedAt: reader.readDateTimeOrNull(offsets[14]),
  );
  return object;
}

P _resourcePointDeserializePropNative<P>(
    int id, IsarBinaryReader reader, int propertyIndex, int offset) {
  switch (propertyIndex) {
    case -1:
      return id as P;
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringList(offset) ?? []) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readStringList(offset) ?? []) as P;
    case 9:
      return (reader.readDouble(offset)) as P;
    case 10:
      return (reader.readDouble(offset)) as P;
    case 11:
      return (reader.readString(offset)) as P;
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

dynamic _resourcePointSerializeWeb(
    IsarCollection<ResourcePoint> collection, ResourcePoint object) {
  final jsObj = IsarNative.newJsObject();
  IsarNative.jsObjectSet(jsObj, 'address', object.address);
  IsarNative.jsObjectSet(jsObj, 'categories', object.categories);
  IsarNative.jsObjectSet(
      jsObj, 'contactMaskedPhone', object.contactMaskedPhone);
  IsarNative.jsObjectSet(
      jsObj, 'createdAt', object.createdAt?.toUtc().millisecondsSinceEpoch);
  IsarNative.jsObjectSet(jsObj, 'createdBy', object.createdBy);
  IsarNative.jsObjectSet(jsObj, 'description', object.description);
  IsarNative.jsObjectSet(
      jsObj, 'expiry', object.expiry?.toUtc().millisecondsSinceEpoch);
  IsarNative.jsObjectSet(jsObj, 'id', object.id);
  IsarNative.jsObjectSet(jsObj, 'images', object.images);
  IsarNative.jsObjectSet(jsObj, 'isarId', object.isarId);
  IsarNative.jsObjectSet(jsObj, 'latitude', object.latitude);
  IsarNative.jsObjectSet(jsObj, 'longitude', object.longitude);
  IsarNative.jsObjectSet(jsObj, 'status', object.status);
  IsarNative.jsObjectSet(jsObj, 'title', object.title);
  IsarNative.jsObjectSet(jsObj, 'type', object.type);
  IsarNative.jsObjectSet(
      jsObj, 'updatedAt', object.updatedAt?.toUtc().millisecondsSinceEpoch);
  return jsObj;
}

ResourcePoint _resourcePointDeserializeWeb(
    IsarCollection<ResourcePoint> collection, dynamic jsObj) {
  final object = ResourcePoint(
    address: IsarNative.jsObjectGet(jsObj, 'address'),
    categories: (IsarNative.jsObjectGet(jsObj, 'categories') as List?)
            ?.map((e) => e ?? '')
            .toList()
            .cast<String>() ??
        [],
    contactMaskedPhone: IsarNative.jsObjectGet(jsObj, 'contactMaskedPhone'),
    createdAt: IsarNative.jsObjectGet(jsObj, 'createdAt') != null
        ? DateTime.fromMillisecondsSinceEpoch(
                IsarNative.jsObjectGet(jsObj, 'createdAt'),
                isUtc: true)
            .toLocal()
        : null,
    createdBy: IsarNative.jsObjectGet(jsObj, 'createdBy'),
    description: IsarNative.jsObjectGet(jsObj, 'description'),
    expiry: IsarNative.jsObjectGet(jsObj, 'expiry') != null
        ? DateTime.fromMillisecondsSinceEpoch(
                IsarNative.jsObjectGet(jsObj, 'expiry'),
                isUtc: true)
            .toLocal()
        : null,
    id: IsarNative.jsObjectGet(jsObj, 'id') ?? '',
    images: (IsarNative.jsObjectGet(jsObj, 'images') as List?)
            ?.map((e) => e ?? '')
            .toList()
            .cast<String>() ??
        [],
    isarId: IsarNative.jsObjectGet(jsObj, 'isarId'),
    latitude:
        IsarNative.jsObjectGet(jsObj, 'latitude') ?? double.negativeInfinity,
    longitude:
        IsarNative.jsObjectGet(jsObj, 'longitude') ?? double.negativeInfinity,
    status: IsarNative.jsObjectGet(jsObj, 'status') ?? '',
    title: IsarNative.jsObjectGet(jsObj, 'title') ?? '',
    type: IsarNative.jsObjectGet(jsObj, 'type') ?? '',
    updatedAt: IsarNative.jsObjectGet(jsObj, 'updatedAt') != null
        ? DateTime.fromMillisecondsSinceEpoch(
                IsarNative.jsObjectGet(jsObj, 'updatedAt'),
                isUtc: true)
            .toLocal()
        : null,
  );
  return object;
}

P _resourcePointDeserializePropWeb<P>(Object jsObj, String propertyName) {
  switch (propertyName) {
    case 'address':
      return (IsarNative.jsObjectGet(jsObj, 'address')) as P;
    case 'categories':
      return ((IsarNative.jsObjectGet(jsObj, 'categories') as List?)
              ?.map((e) => e ?? '')
              .toList()
              .cast<String>() ??
          []) as P;
    case 'contactMaskedPhone':
      return (IsarNative.jsObjectGet(jsObj, 'contactMaskedPhone')) as P;
    case 'createdAt':
      return (IsarNative.jsObjectGet(jsObj, 'createdAt') != null
          ? DateTime.fromMillisecondsSinceEpoch(
                  IsarNative.jsObjectGet(jsObj, 'createdAt'),
                  isUtc: true)
              .toLocal()
          : null) as P;
    case 'createdBy':
      return (IsarNative.jsObjectGet(jsObj, 'createdBy')) as P;
    case 'description':
      return (IsarNative.jsObjectGet(jsObj, 'description')) as P;
    case 'expiry':
      return (IsarNative.jsObjectGet(jsObj, 'expiry') != null
          ? DateTime.fromMillisecondsSinceEpoch(
                  IsarNative.jsObjectGet(jsObj, 'expiry'),
                  isUtc: true)
              .toLocal()
          : null) as P;
    case 'id':
      return (IsarNative.jsObjectGet(jsObj, 'id') ?? '') as P;
    case 'images':
      return ((IsarNative.jsObjectGet(jsObj, 'images') as List?)
              ?.map((e) => e ?? '')
              .toList()
              .cast<String>() ??
          []) as P;
    case 'isarId':
      return (IsarNative.jsObjectGet(jsObj, 'isarId')) as P;
    case 'latitude':
      return (IsarNative.jsObjectGet(jsObj, 'latitude') ??
          double.negativeInfinity) as P;
    case 'longitude':
      return (IsarNative.jsObjectGet(jsObj, 'longitude') ??
          double.negativeInfinity) as P;
    case 'status':
      return (IsarNative.jsObjectGet(jsObj, 'status') ?? '') as P;
    case 'title':
      return (IsarNative.jsObjectGet(jsObj, 'title') ?? '') as P;
    case 'type':
      return (IsarNative.jsObjectGet(jsObj, 'type') ?? '') as P;
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

void _resourcePointAttachLinks(
    IsarCollection col, int id, ResourcePoint object) {}

extension ResourcePointQueryWhereSort
    on QueryBuilder<ResourcePoint, ResourcePoint, QWhere> {
  QueryBuilder<ResourcePoint, ResourcePoint, QAfterWhere> anyIsarId() {
    return addWhereClauseInternal(const IdWhereClause.any());
  }
}

extension ResourcePointQueryWhere
    on QueryBuilder<ResourcePoint, ResourcePoint, QWhereClause> {
  QueryBuilder<ResourcePoint, ResourcePoint, QAfterWhereClause> isarIdEqualTo(
      int isarId) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: isarId,
      includeLower: true,
      upper: isarId,
      includeUpper: true,
    ));
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterWhereClause>
      isarIdNotEqualTo(int isarId) {
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

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterWhereClause>
      isarIdGreaterThan(int isarId, {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.greaterThan(lower: isarId, includeLower: include),
    );
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterWhereClause> isarIdLessThan(
      int isarId,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.lessThan(upper: isarId, includeUpper: include),
    );
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterWhereClause> isarIdBetween(
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

extension ResourcePointQueryFilter
    on QueryBuilder<ResourcePoint, ResourcePoint, QFilterCondition> {
  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
      addressIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'address',
      value: null,
    ));
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
      addressEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'address',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
      addressGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'address',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
      addressLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'address',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
      addressBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'address',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
      addressStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'address',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
      addressEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'address',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
      addressContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'address',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
      addressMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'address',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
      categoriesAnyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'categories',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
      categoriesAnyGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'categories',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
      categoriesAnyLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'categories',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
      categoriesAnyBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'categories',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
      categoriesAnyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'categories',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
      categoriesAnyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'categories',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
      categoriesAnyContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'categories',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
      categoriesAnyMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'categories',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
      contactMaskedPhoneIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'contactMaskedPhone',
      value: null,
    ));
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
      contactMaskedPhoneEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'contactMaskedPhone',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
      contactMaskedPhoneGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'contactMaskedPhone',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
      contactMaskedPhoneLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'contactMaskedPhone',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
      contactMaskedPhoneBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'contactMaskedPhone',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
      contactMaskedPhoneStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'contactMaskedPhone',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
      contactMaskedPhoneEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'contactMaskedPhone',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
      contactMaskedPhoneContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'contactMaskedPhone',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
      contactMaskedPhoneMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'contactMaskedPhone',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
      createdAtIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'createdAt',
      value: null,
    ));
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
      createdAtEqualTo(DateTime? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'createdAt',
      value: value,
    ));
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
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

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
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

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
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

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
      createdByIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'createdBy',
      value: null,
    ));
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
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

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
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

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
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

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
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

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
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

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
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

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
      createdByContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'createdBy',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
      createdByMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'createdBy',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
      descriptionIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'description',
      value: null,
    ));
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
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

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
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

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
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

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
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

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
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

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
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

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
      descriptionContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'description',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
      descriptionMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'description',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
      expiryIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'expiry',
      value: null,
    ));
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
      expiryEqualTo(DateTime? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'expiry',
      value: value,
    ));
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
      expiryGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'expiry',
      value: value,
    ));
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
      expiryLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'expiry',
      value: value,
    ));
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
      expiryBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'expiry',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition> idEqualTo(
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

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition> idBetween(
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

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
      idStartsWith(
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

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition> idEndsWith(
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

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition> idContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition> idMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'id',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
      imagesAnyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'images',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
      imagesAnyGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'images',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
      imagesAnyLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'images',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
      imagesAnyBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'images',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
      imagesAnyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'images',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
      imagesAnyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'images',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
      imagesAnyContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'images',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
      imagesAnyMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'images',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
      isarIdIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'isarId',
      value: null,
    ));
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
      isarIdEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
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

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
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

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
      isarIdBetween(
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

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
      latitudeGreaterThan(double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: false,
      property: 'latitude',
      value: value,
    ));
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
      latitudeLessThan(double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: false,
      property: 'latitude',
      value: value,
    ));
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
      latitudeBetween(double lower, double upper) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'latitude',
      lower: lower,
      includeLower: false,
      upper: upper,
      includeUpper: false,
    ));
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
      longitudeGreaterThan(double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: false,
      property: 'longitude',
      value: value,
    ));
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
      longitudeLessThan(double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: false,
      property: 'longitude',
      value: value,
    ));
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
      longitudeBetween(double lower, double upper) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'longitude',
      lower: lower,
      includeLower: false,
      upper: upper,
      includeUpper: false,
    ));
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
      statusEqualTo(
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

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
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

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
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

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
      statusBetween(
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

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
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

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
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

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
      statusContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'status',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
      statusMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'status',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
      titleEqualTo(
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

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
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

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
      titleLessThan(
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

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
      titleBetween(
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

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
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

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
      titleEndsWith(
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

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
      titleContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'title',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
      titleMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'title',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition> typeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'type',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
      typeGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'type',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
      typeLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'type',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition> typeBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'type',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
      typeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'type',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
      typeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'type',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
      typeContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'type',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition> typeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'type',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
      updatedAtIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'updatedAt',
      value: null,
    ));
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
      updatedAtEqualTo(DateTime? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'updatedAt',
      value: value,
    ));
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
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

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
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

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterFilterCondition>
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

extension ResourcePointQueryLinks
    on QueryBuilder<ResourcePoint, ResourcePoint, QFilterCondition> {}

extension ResourcePointQueryWhereSortBy
    on QueryBuilder<ResourcePoint, ResourcePoint, QSortBy> {
  QueryBuilder<ResourcePoint, ResourcePoint, QAfterSortBy> sortByAddress() {
    return addSortByInternal('address', Sort.asc);
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterSortBy> sortByAddressDesc() {
    return addSortByInternal('address', Sort.desc);
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterSortBy>
      sortByContactMaskedPhone() {
    return addSortByInternal('contactMaskedPhone', Sort.asc);
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterSortBy>
      sortByContactMaskedPhoneDesc() {
    return addSortByInternal('contactMaskedPhone', Sort.desc);
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterSortBy> sortByCreatedAt() {
    return addSortByInternal('createdAt', Sort.asc);
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterSortBy>
      sortByCreatedAtDesc() {
    return addSortByInternal('createdAt', Sort.desc);
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterSortBy> sortByCreatedBy() {
    return addSortByInternal('createdBy', Sort.asc);
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterSortBy>
      sortByCreatedByDesc() {
    return addSortByInternal('createdBy', Sort.desc);
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterSortBy> sortByDescription() {
    return addSortByInternal('description', Sort.asc);
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterSortBy>
      sortByDescriptionDesc() {
    return addSortByInternal('description', Sort.desc);
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterSortBy> sortByExpiry() {
    return addSortByInternal('expiry', Sort.asc);
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterSortBy> sortByExpiryDesc() {
    return addSortByInternal('expiry', Sort.desc);
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterSortBy> sortByIsarId() {
    return addSortByInternal('isarId', Sort.asc);
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterSortBy> sortByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.desc);
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterSortBy> sortByLatitude() {
    return addSortByInternal('latitude', Sort.asc);
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterSortBy>
      sortByLatitudeDesc() {
    return addSortByInternal('latitude', Sort.desc);
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterSortBy> sortByLongitude() {
    return addSortByInternal('longitude', Sort.asc);
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterSortBy>
      sortByLongitudeDesc() {
    return addSortByInternal('longitude', Sort.desc);
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterSortBy> sortByStatus() {
    return addSortByInternal('status', Sort.asc);
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterSortBy> sortByStatusDesc() {
    return addSortByInternal('status', Sort.desc);
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterSortBy> sortByTitle() {
    return addSortByInternal('title', Sort.asc);
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterSortBy> sortByTitleDesc() {
    return addSortByInternal('title', Sort.desc);
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterSortBy> sortByType() {
    return addSortByInternal('type', Sort.asc);
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterSortBy> sortByTypeDesc() {
    return addSortByInternal('type', Sort.desc);
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterSortBy> sortByUpdatedAt() {
    return addSortByInternal('updatedAt', Sort.asc);
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterSortBy>
      sortByUpdatedAtDesc() {
    return addSortByInternal('updatedAt', Sort.desc);
  }
}

extension ResourcePointQueryWhereSortThenBy
    on QueryBuilder<ResourcePoint, ResourcePoint, QSortThenBy> {
  QueryBuilder<ResourcePoint, ResourcePoint, QAfterSortBy> thenByAddress() {
    return addSortByInternal('address', Sort.asc);
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterSortBy> thenByAddressDesc() {
    return addSortByInternal('address', Sort.desc);
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterSortBy>
      thenByContactMaskedPhone() {
    return addSortByInternal('contactMaskedPhone', Sort.asc);
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterSortBy>
      thenByContactMaskedPhoneDesc() {
    return addSortByInternal('contactMaskedPhone', Sort.desc);
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterSortBy> thenByCreatedAt() {
    return addSortByInternal('createdAt', Sort.asc);
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterSortBy>
      thenByCreatedAtDesc() {
    return addSortByInternal('createdAt', Sort.desc);
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterSortBy> thenByCreatedBy() {
    return addSortByInternal('createdBy', Sort.asc);
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterSortBy>
      thenByCreatedByDesc() {
    return addSortByInternal('createdBy', Sort.desc);
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterSortBy> thenByDescription() {
    return addSortByInternal('description', Sort.asc);
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterSortBy>
      thenByDescriptionDesc() {
    return addSortByInternal('description', Sort.desc);
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterSortBy> thenByExpiry() {
    return addSortByInternal('expiry', Sort.asc);
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterSortBy> thenByExpiryDesc() {
    return addSortByInternal('expiry', Sort.desc);
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterSortBy> thenByIsarId() {
    return addSortByInternal('isarId', Sort.asc);
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterSortBy> thenByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.desc);
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterSortBy> thenByLatitude() {
    return addSortByInternal('latitude', Sort.asc);
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterSortBy>
      thenByLatitudeDesc() {
    return addSortByInternal('latitude', Sort.desc);
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterSortBy> thenByLongitude() {
    return addSortByInternal('longitude', Sort.asc);
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterSortBy>
      thenByLongitudeDesc() {
    return addSortByInternal('longitude', Sort.desc);
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterSortBy> thenByStatus() {
    return addSortByInternal('status', Sort.asc);
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterSortBy> thenByStatusDesc() {
    return addSortByInternal('status', Sort.desc);
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterSortBy> thenByTitle() {
    return addSortByInternal('title', Sort.asc);
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterSortBy> thenByTitleDesc() {
    return addSortByInternal('title', Sort.desc);
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterSortBy> thenByType() {
    return addSortByInternal('type', Sort.asc);
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterSortBy> thenByTypeDesc() {
    return addSortByInternal('type', Sort.desc);
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterSortBy> thenByUpdatedAt() {
    return addSortByInternal('updatedAt', Sort.asc);
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QAfterSortBy>
      thenByUpdatedAtDesc() {
    return addSortByInternal('updatedAt', Sort.desc);
  }
}

extension ResourcePointQueryWhereDistinct
    on QueryBuilder<ResourcePoint, ResourcePoint, QDistinct> {
  QueryBuilder<ResourcePoint, ResourcePoint, QDistinct> distinctByAddress(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('address', caseSensitive: caseSensitive);
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QDistinct>
      distinctByContactMaskedPhone({bool caseSensitive = true}) {
    return addDistinctByInternal('contactMaskedPhone',
        caseSensitive: caseSensitive);
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QDistinct> distinctByCreatedAt() {
    return addDistinctByInternal('createdAt');
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QDistinct> distinctByCreatedBy(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('createdBy', caseSensitive: caseSensitive);
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QDistinct> distinctByDescription(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('description', caseSensitive: caseSensitive);
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QDistinct> distinctByExpiry() {
    return addDistinctByInternal('expiry');
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QDistinct> distinctById(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('id', caseSensitive: caseSensitive);
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QDistinct> distinctByIsarId() {
    return addDistinctByInternal('isarId');
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QDistinct> distinctByLatitude() {
    return addDistinctByInternal('latitude');
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QDistinct> distinctByLongitude() {
    return addDistinctByInternal('longitude');
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QDistinct> distinctByStatus(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('status', caseSensitive: caseSensitive);
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QDistinct> distinctByTitle(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('title', caseSensitive: caseSensitive);
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QDistinct> distinctByType(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('type', caseSensitive: caseSensitive);
  }

  QueryBuilder<ResourcePoint, ResourcePoint, QDistinct> distinctByUpdatedAt() {
    return addDistinctByInternal('updatedAt');
  }
}

extension ResourcePointQueryProperty
    on QueryBuilder<ResourcePoint, ResourcePoint, QQueryProperty> {
  QueryBuilder<ResourcePoint, String?, QQueryOperations> addressProperty() {
    return addPropertyNameInternal('address');
  }

  QueryBuilder<ResourcePoint, List<String>, QQueryOperations>
      categoriesProperty() {
    return addPropertyNameInternal('categories');
  }

  QueryBuilder<ResourcePoint, String?, QQueryOperations>
      contactMaskedPhoneProperty() {
    return addPropertyNameInternal('contactMaskedPhone');
  }

  QueryBuilder<ResourcePoint, DateTime?, QQueryOperations> createdAtProperty() {
    return addPropertyNameInternal('createdAt');
  }

  QueryBuilder<ResourcePoint, String?, QQueryOperations> createdByProperty() {
    return addPropertyNameInternal('createdBy');
  }

  QueryBuilder<ResourcePoint, String?, QQueryOperations> descriptionProperty() {
    return addPropertyNameInternal('description');
  }

  QueryBuilder<ResourcePoint, DateTime?, QQueryOperations> expiryProperty() {
    return addPropertyNameInternal('expiry');
  }

  QueryBuilder<ResourcePoint, String, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<ResourcePoint, List<String>, QQueryOperations> imagesProperty() {
    return addPropertyNameInternal('images');
  }

  QueryBuilder<ResourcePoint, int?, QQueryOperations> isarIdProperty() {
    return addPropertyNameInternal('isarId');
  }

  QueryBuilder<ResourcePoint, double, QQueryOperations> latitudeProperty() {
    return addPropertyNameInternal('latitude');
  }

  QueryBuilder<ResourcePoint, double, QQueryOperations> longitudeProperty() {
    return addPropertyNameInternal('longitude');
  }

  QueryBuilder<ResourcePoint, String, QQueryOperations> statusProperty() {
    return addPropertyNameInternal('status');
  }

  QueryBuilder<ResourcePoint, String, QQueryOperations> titleProperty() {
    return addPropertyNameInternal('title');
  }

  QueryBuilder<ResourcePoint, String, QQueryOperations> typeProperty() {
    return addPropertyNameInternal('type');
  }

  QueryBuilder<ResourcePoint, DateTime?, QQueryOperations> updatedAtProperty() {
    return addPropertyNameInternal('updatedAt');
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ResourcePointImpl _$$ResourcePointImplFromJson(Map<String, dynamic> json) =>
    _$ResourcePointImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      type: json['type'] as String? ?? 'Other',
      categories: (json['categories'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      status: json['status'] as String? ?? 'active',
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      address: json['address'] as String?,
      expiry: json['expiry'] == null
          ? null
          : DateTime.parse(json['expiry'] as String),
      contactMaskedPhone: json['contact_masked_phone'] as String?,
      createdBy: json['created_by'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$ResourcePointImplToJson(_$ResourcePointImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'type': instance.type,
      'categories': instance.categories,
      'status': instance.status,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'address': instance.address,
      'expiry': instance.expiry?.toIso8601String(),
      'contact_masked_phone': instance.contactMaskedPhone,
      'created_by': instance.createdBy,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'images': instance.images,
    };
