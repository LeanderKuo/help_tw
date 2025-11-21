// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pending_mutation.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, unused_local_variable

extension GetPendingMutationCollection on Isar {
  IsarCollection<PendingMutation> get pendingMutations => getCollection();
}

const PendingMutationSchema = CollectionSchema(
  name: 'PendingMutation',
  schema:
      '{"name":"PendingMutation","idName":"id","properties":[{"name":"createdAt","type":"Long"},{"name":"payload","type":"String"},{"name":"table","type":"String"}],"indexes":[],"links":[]}',
  idName: 'id',
  propertyIds: {'createdAt': 0, 'payload': 1, 'table': 2},
  listProperties: {},
  indexIds: {},
  indexValueTypes: {},
  linkIds: {},
  backlinkLinkNames: {},
  getId: _pendingMutationGetId,
  setId: _pendingMutationSetId,
  getLinks: _pendingMutationGetLinks,
  attachLinks: _pendingMutationAttachLinks,
  serializeNative: _pendingMutationSerializeNative,
  deserializeNative: _pendingMutationDeserializeNative,
  deserializePropNative: _pendingMutationDeserializePropNative,
  serializeWeb: _pendingMutationSerializeWeb,
  deserializeWeb: _pendingMutationDeserializeWeb,
  deserializePropWeb: _pendingMutationDeserializePropWeb,
  version: 3,
);

int? _pendingMutationGetId(PendingMutation object) {
  if (object.id == Isar.autoIncrement) {
    return null;
  } else {
    return object.id;
  }
}

void _pendingMutationSetId(PendingMutation object, int id) {
  object.id = id;
}

List<IsarLinkBase> _pendingMutationGetLinks(PendingMutation object) {
  return [];
}

void _pendingMutationSerializeNative(
    IsarCollection<PendingMutation> collection,
    IsarRawObject rawObj,
    PendingMutation object,
    int staticSize,
    List<int> offsets,
    AdapterAlloc alloc) {
  var dynamicSize = 0;
  final value0 = object.createdAt;
  final _createdAt = value0;
  final value1 = object.payload;
  final _payload = IsarBinaryWriter.utf8Encoder.convert(value1);
  dynamicSize += (_payload.length) as int;
  final value2 = object.table;
  final _table = IsarBinaryWriter.utf8Encoder.convert(value2);
  dynamicSize += (_table.length) as int;
  final size = staticSize + dynamicSize;

  rawObj.buffer = alloc(size);
  rawObj.buffer_length = size;
  final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
  final writer = IsarBinaryWriter(buffer, staticSize);
  writer.writeDateTime(offsets[0], _createdAt);
  writer.writeBytes(offsets[1], _payload);
  writer.writeBytes(offsets[2], _table);
}

PendingMutation _pendingMutationDeserializeNative(
    IsarCollection<PendingMutation> collection,
    int id,
    IsarBinaryReader reader,
    List<int> offsets) {
  final object = PendingMutation(
    createdAt: reader.readDateTime(offsets[0]),
    payload: reader.readString(offsets[1]),
    table: reader.readString(offsets[2]),
  );
  object.id = id;
  return object;
}

P _pendingMutationDeserializePropNative<P>(
    int id, IsarBinaryReader reader, int propertyIndex, int offset) {
  switch (propertyIndex) {
    case -1:
      return id as P;
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    default:
      throw 'Illegal propertyIndex';
  }
}

dynamic _pendingMutationSerializeWeb(
    IsarCollection<PendingMutation> collection, PendingMutation object) {
  final jsObj = IsarNative.newJsObject();
  IsarNative.jsObjectSet(
      jsObj, 'createdAt', object.createdAt.toUtc().millisecondsSinceEpoch);
  IsarNative.jsObjectSet(jsObj, 'id', object.id);
  IsarNative.jsObjectSet(jsObj, 'payload', object.payload);
  IsarNative.jsObjectSet(jsObj, 'table', object.table);
  return jsObj;
}

PendingMutation _pendingMutationDeserializeWeb(
    IsarCollection<PendingMutation> collection, dynamic jsObj) {
  final object = PendingMutation(
    createdAt: IsarNative.jsObjectGet(jsObj, 'createdAt') != null
        ? DateTime.fromMillisecondsSinceEpoch(
                IsarNative.jsObjectGet(jsObj, 'createdAt'),
                isUtc: true)
            .toLocal()
        : DateTime.fromMillisecondsSinceEpoch(0),
    payload: IsarNative.jsObjectGet(jsObj, 'payload') ?? '',
    table: IsarNative.jsObjectGet(jsObj, 'table') ?? '',
  );
  object.id = IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity;
  return object;
}

P _pendingMutationDeserializePropWeb<P>(Object jsObj, String propertyName) {
  switch (propertyName) {
    case 'createdAt':
      return (IsarNative.jsObjectGet(jsObj, 'createdAt') != null
          ? DateTime.fromMillisecondsSinceEpoch(
                  IsarNative.jsObjectGet(jsObj, 'createdAt'),
                  isUtc: true)
              .toLocal()
          : DateTime.fromMillisecondsSinceEpoch(0)) as P;
    case 'id':
      return (IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity)
          as P;
    case 'payload':
      return (IsarNative.jsObjectGet(jsObj, 'payload') ?? '') as P;
    case 'table':
      return (IsarNative.jsObjectGet(jsObj, 'table') ?? '') as P;
    default:
      throw 'Illegal propertyName';
  }
}

void _pendingMutationAttachLinks(
    IsarCollection col, int id, PendingMutation object) {}

extension PendingMutationQueryWhereSort
    on QueryBuilder<PendingMutation, PendingMutation, QWhere> {
  QueryBuilder<PendingMutation, PendingMutation, QAfterWhere> anyId() {
    return addWhereClauseInternal(const IdWhereClause.any());
  }
}

extension PendingMutationQueryWhere
    on QueryBuilder<PendingMutation, PendingMutation, QWhereClause> {
  QueryBuilder<PendingMutation, PendingMutation, QAfterWhereClause> idEqualTo(
      int id) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: id,
      includeLower: true,
      upper: id,
      includeUpper: true,
    ));
  }

  QueryBuilder<PendingMutation, PendingMutation, QAfterWhereClause>
      idNotEqualTo(int id) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(
        IdWhereClause.lessThan(upper: id, includeUpper: false),
      ).addWhereClauseInternal(
        IdWhereClause.greaterThan(lower: id, includeLower: false),
      );
    } else {
      return addWhereClauseInternal(
        IdWhereClause.greaterThan(lower: id, includeLower: false),
      ).addWhereClauseInternal(
        IdWhereClause.lessThan(upper: id, includeUpper: false),
      );
    }
  }

  QueryBuilder<PendingMutation, PendingMutation, QAfterWhereClause>
      idGreaterThan(int id, {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.greaterThan(lower: id, includeLower: include),
    );
  }

  QueryBuilder<PendingMutation, PendingMutation, QAfterWhereClause> idLessThan(
      int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.lessThan(upper: id, includeUpper: include),
    );
  }

  QueryBuilder<PendingMutation, PendingMutation, QAfterWhereClause> idBetween(
    int lowerId,
    int upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: lowerId,
      includeLower: includeLower,
      upper: upperId,
      includeUpper: includeUpper,
    ));
  }
}

extension PendingMutationQueryFilter
    on QueryBuilder<PendingMutation, PendingMutation, QFilterCondition> {
  QueryBuilder<PendingMutation, PendingMutation, QAfterFilterCondition>
      createdAtEqualTo(DateTime value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'createdAt',
      value: value,
    ));
  }

  QueryBuilder<PendingMutation, PendingMutation, QAfterFilterCondition>
      createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'createdAt',
      value: value,
    ));
  }

  QueryBuilder<PendingMutation, PendingMutation, QAfterFilterCondition>
      createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'createdAt',
      value: value,
    ));
  }

  QueryBuilder<PendingMutation, PendingMutation, QAfterFilterCondition>
      createdAtBetween(
    DateTime lower,
    DateTime upper, {
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

  QueryBuilder<PendingMutation, PendingMutation, QAfterFilterCondition>
      idEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<PendingMutation, PendingMutation, QAfterFilterCondition>
      idGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<PendingMutation, PendingMutation, QAfterFilterCondition>
      idLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<PendingMutation, PendingMutation, QAfterFilterCondition>
      idBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'id',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<PendingMutation, PendingMutation, QAfterFilterCondition>
      payloadEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'payload',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<PendingMutation, PendingMutation, QAfterFilterCondition>
      payloadGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'payload',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<PendingMutation, PendingMutation, QAfterFilterCondition>
      payloadLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'payload',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<PendingMutation, PendingMutation, QAfterFilterCondition>
      payloadBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'payload',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<PendingMutation, PendingMutation, QAfterFilterCondition>
      payloadStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'payload',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<PendingMutation, PendingMutation, QAfterFilterCondition>
      payloadEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'payload',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<PendingMutation, PendingMutation, QAfterFilterCondition>
      payloadContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'payload',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<PendingMutation, PendingMutation, QAfterFilterCondition>
      payloadMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'payload',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<PendingMutation, PendingMutation, QAfterFilterCondition>
      tableEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'table',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<PendingMutation, PendingMutation, QAfterFilterCondition>
      tableGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'table',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<PendingMutation, PendingMutation, QAfterFilterCondition>
      tableLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'table',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<PendingMutation, PendingMutation, QAfterFilterCondition>
      tableBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'table',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<PendingMutation, PendingMutation, QAfterFilterCondition>
      tableStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'table',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<PendingMutation, PendingMutation, QAfterFilterCondition>
      tableEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'table',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<PendingMutation, PendingMutation, QAfterFilterCondition>
      tableContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'table',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<PendingMutation, PendingMutation, QAfterFilterCondition>
      tableMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'table',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }
}

extension PendingMutationQueryLinks
    on QueryBuilder<PendingMutation, PendingMutation, QFilterCondition> {}

extension PendingMutationQueryWhereSortBy
    on QueryBuilder<PendingMutation, PendingMutation, QSortBy> {
  QueryBuilder<PendingMutation, PendingMutation, QAfterSortBy>
      sortByCreatedAt() {
    return addSortByInternal('createdAt', Sort.asc);
  }

  QueryBuilder<PendingMutation, PendingMutation, QAfterSortBy>
      sortByCreatedAtDesc() {
    return addSortByInternal('createdAt', Sort.desc);
  }

  QueryBuilder<PendingMutation, PendingMutation, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<PendingMutation, PendingMutation, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<PendingMutation, PendingMutation, QAfterSortBy> sortByPayload() {
    return addSortByInternal('payload', Sort.asc);
  }

  QueryBuilder<PendingMutation, PendingMutation, QAfterSortBy>
      sortByPayloadDesc() {
    return addSortByInternal('payload', Sort.desc);
  }

  QueryBuilder<PendingMutation, PendingMutation, QAfterSortBy> sortByTable() {
    return addSortByInternal('table', Sort.asc);
  }

  QueryBuilder<PendingMutation, PendingMutation, QAfterSortBy>
      sortByTableDesc() {
    return addSortByInternal('table', Sort.desc);
  }
}

extension PendingMutationQueryWhereSortThenBy
    on QueryBuilder<PendingMutation, PendingMutation, QSortThenBy> {
  QueryBuilder<PendingMutation, PendingMutation, QAfterSortBy>
      thenByCreatedAt() {
    return addSortByInternal('createdAt', Sort.asc);
  }

  QueryBuilder<PendingMutation, PendingMutation, QAfterSortBy>
      thenByCreatedAtDesc() {
    return addSortByInternal('createdAt', Sort.desc);
  }

  QueryBuilder<PendingMutation, PendingMutation, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<PendingMutation, PendingMutation, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<PendingMutation, PendingMutation, QAfterSortBy> thenByPayload() {
    return addSortByInternal('payload', Sort.asc);
  }

  QueryBuilder<PendingMutation, PendingMutation, QAfterSortBy>
      thenByPayloadDesc() {
    return addSortByInternal('payload', Sort.desc);
  }

  QueryBuilder<PendingMutation, PendingMutation, QAfterSortBy> thenByTable() {
    return addSortByInternal('table', Sort.asc);
  }

  QueryBuilder<PendingMutation, PendingMutation, QAfterSortBy>
      thenByTableDesc() {
    return addSortByInternal('table', Sort.desc);
  }
}

extension PendingMutationQueryWhereDistinct
    on QueryBuilder<PendingMutation, PendingMutation, QDistinct> {
  QueryBuilder<PendingMutation, PendingMutation, QDistinct>
      distinctByCreatedAt() {
    return addDistinctByInternal('createdAt');
  }

  QueryBuilder<PendingMutation, PendingMutation, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<PendingMutation, PendingMutation, QDistinct> distinctByPayload(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('payload', caseSensitive: caseSensitive);
  }

  QueryBuilder<PendingMutation, PendingMutation, QDistinct> distinctByTable(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('table', caseSensitive: caseSensitive);
  }
}

extension PendingMutationQueryProperty
    on QueryBuilder<PendingMutation, PendingMutation, QQueryProperty> {
  QueryBuilder<PendingMutation, DateTime, QQueryOperations>
      createdAtProperty() {
    return addPropertyNameInternal('createdAt');
  }

  QueryBuilder<PendingMutation, int, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<PendingMutation, String, QQueryOperations> payloadProperty() {
    return addPropertyNameInternal('payload');
  }

  QueryBuilder<PendingMutation, String, QQueryOperations> tableProperty() {
    return addPropertyNameInternal('table');
  }
}
