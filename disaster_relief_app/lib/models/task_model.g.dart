// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, unused_local_variable

extension GetTaskModelCollection on Isar {
  IsarCollection<TaskModel> get taskModels => getCollection();
}

const TaskModelSchema = CollectionSchema(
  name: 'TaskModel',
  schema:
      '{"name":"TaskModel","idName":"isarId","properties":[{"name":"address","type":"String"},{"name":"assignedTo","type":"String"},{"name":"createdAt","type":"Long"},{"name":"createdBy","type":"String"},{"name":"description","type":"String"},{"name":"id","type":"String"},{"name":"images","type":"StringList"},{"name":"isDraft","type":"Bool"},{"name":"latitude","type":"Double"},{"name":"longitude","type":"Double"},{"name":"materialsStatus","type":"String"},{"name":"participantCount","type":"Long"},{"name":"priority","type":"String"},{"name":"requiredParticipants","type":"Long"},{"name":"roleLabel","type":"String"},{"name":"status","type":"String"},{"name":"title","type":"String"},{"name":"updatedAt","type":"Long"}],"indexes":[],"links":[]}',
  idName: 'isarId',
  propertyIds: {
    'address': 0,
    'assignedTo': 1,
    'createdAt': 2,
    'createdBy': 3,
    'description': 4,
    'id': 5,
    'images': 6,
    'isDraft': 7,
    'latitude': 8,
    'longitude': 9,
    'materialsStatus': 10,
    'participantCount': 11,
    'priority': 12,
    'requiredParticipants': 13,
    'roleLabel': 14,
    'status': 15,
    'title': 16,
    'updatedAt': 17
  },
  listProperties: {'images'},
  indexIds: {},
  indexValueTypes: {},
  linkIds: {},
  backlinkLinkNames: {},
  getId: _taskModelGetId,
  getLinks: _taskModelGetLinks,
  attachLinks: _taskModelAttachLinks,
  serializeNative: _taskModelSerializeNative,
  deserializeNative: _taskModelDeserializeNative,
  deserializePropNative: _taskModelDeserializePropNative,
  serializeWeb: _taskModelSerializeWeb,
  deserializeWeb: _taskModelDeserializeWeb,
  deserializePropWeb: _taskModelDeserializePropWeb,
  version: 3,
);

int? _taskModelGetId(TaskModel object) {
  if (object.isarId == Isar.autoIncrement) {
    return null;
  } else {
    return object.isarId;
  }
}

List<IsarLinkBase> _taskModelGetLinks(TaskModel object) {
  return [];
}

void _taskModelSerializeNative(
    IsarCollection<TaskModel> collection,
    IsarRawObject rawObj,
    TaskModel object,
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
  final value1 = object.assignedTo;
  IsarUint8List? _assignedTo;
  if (value1 != null) {
    _assignedTo = IsarBinaryWriter.utf8Encoder.convert(value1);
  }
  dynamicSize += (_assignedTo?.length ?? 0) as int;
  final value2 = object.createdAt;
  final _createdAt = value2;
  final value3 = object.createdBy;
  IsarUint8List? _createdBy;
  if (value3 != null) {
    _createdBy = IsarBinaryWriter.utf8Encoder.convert(value3);
  }
  dynamicSize += (_createdBy?.length ?? 0) as int;
  final value4 = object.description;
  IsarUint8List? _description;
  if (value4 != null) {
    _description = IsarBinaryWriter.utf8Encoder.convert(value4);
  }
  dynamicSize += (_description?.length ?? 0) as int;
  final value5 = object.id;
  final _id = IsarBinaryWriter.utf8Encoder.convert(value5);
  dynamicSize += (_id.length) as int;
  final value6 = object.images;
  dynamicSize += (value6.length) * 8;
  final bytesList6 = <IsarUint8List>[];
  for (var str in value6) {
    final bytes = IsarBinaryWriter.utf8Encoder.convert(str);
    bytesList6.add(bytes);
    dynamicSize += bytes.length as int;
  }
  final _images = bytesList6;
  final value7 = object.isDraft;
  final _isDraft = value7;
  final value8 = object.latitude;
  final _latitude = value8;
  final value9 = object.longitude;
  final _longitude = value9;
  final value10 = object.materialsStatus;
  final _materialsStatus = IsarBinaryWriter.utf8Encoder.convert(value10);
  dynamicSize += (_materialsStatus.length) as int;
  final value11 = object.participantCount;
  final _participantCount = value11;
  final value12 = object.priority;
  final _priority = IsarBinaryWriter.utf8Encoder.convert(value12);
  dynamicSize += (_priority.length) as int;
  final value13 = object.requiredParticipants;
  final _requiredParticipants = value13;
  final value14 = object.roleLabel;
  IsarUint8List? _roleLabel;
  if (value14 != null) {
    _roleLabel = IsarBinaryWriter.utf8Encoder.convert(value14);
  }
  dynamicSize += (_roleLabel?.length ?? 0) as int;
  final value15 = object.status;
  final _status = IsarBinaryWriter.utf8Encoder.convert(value15);
  dynamicSize += (_status.length) as int;
  final value16 = object.title;
  final _title = IsarBinaryWriter.utf8Encoder.convert(value16);
  dynamicSize += (_title.length) as int;
  final value17 = object.updatedAt;
  final _updatedAt = value17;
  final size = staticSize + dynamicSize;

  rawObj.buffer = alloc(size);
  rawObj.buffer_length = size;
  final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
  final writer = IsarBinaryWriter(buffer, staticSize);
  writer.writeBytes(offsets[0], _address);
  writer.writeBytes(offsets[1], _assignedTo);
  writer.writeDateTime(offsets[2], _createdAt);
  writer.writeBytes(offsets[3], _createdBy);
  writer.writeBytes(offsets[4], _description);
  writer.writeBytes(offsets[5], _id);
  writer.writeStringList(offsets[6], _images);
  writer.writeBool(offsets[7], _isDraft);
  writer.writeDouble(offsets[8], _latitude);
  writer.writeDouble(offsets[9], _longitude);
  writer.writeBytes(offsets[10], _materialsStatus);
  writer.writeLong(offsets[11], _participantCount);
  writer.writeBytes(offsets[12], _priority);
  writer.writeLong(offsets[13], _requiredParticipants);
  writer.writeBytes(offsets[14], _roleLabel);
  writer.writeBytes(offsets[15], _status);
  writer.writeBytes(offsets[16], _title);
  writer.writeDateTime(offsets[17], _updatedAt);
}

TaskModel _taskModelDeserializeNative(IsarCollection<TaskModel> collection,
    int id, IsarBinaryReader reader, List<int> offsets) {
  final object = TaskModel(
    address: reader.readStringOrNull(offsets[0]),
    assignedTo: reader.readStringOrNull(offsets[1]),
    createdAt: reader.readDateTimeOrNull(offsets[2]),
    createdBy: reader.readStringOrNull(offsets[3]),
    description: reader.readStringOrNull(offsets[4]),
    id: reader.readString(offsets[5]),
    images: reader.readStringList(offsets[6]) ?? [],
    isDraft: reader.readBool(offsets[7]),
    isarId: id,
    latitude: reader.readDoubleOrNull(offsets[8]),
    longitude: reader.readDoubleOrNull(offsets[9]),
    materialsStatus: reader.readString(offsets[10]),
    participantCount: reader.readLong(offsets[11]),
    priority: reader.readString(offsets[12]),
    requiredParticipants: reader.readLong(offsets[13]),
    roleLabel: reader.readStringOrNull(offsets[14]),
    status: reader.readString(offsets[15]),
    title: reader.readString(offsets[16]),
    updatedAt: reader.readDateTimeOrNull(offsets[17]),
  );
  return object;
}

P _taskModelDeserializePropNative<P>(
    int id, IsarBinaryReader reader, int propertyIndex, int offset) {
  switch (propertyIndex) {
    case -1:
      return id as P;
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readStringList(offset) ?? []) as P;
    case 7:
      return (reader.readBool(offset)) as P;
    case 8:
      return (reader.readDoubleOrNull(offset)) as P;
    case 9:
      return (reader.readDoubleOrNull(offset)) as P;
    case 10:
      return (reader.readString(offset)) as P;
    case 11:
      return (reader.readLong(offset)) as P;
    case 12:
      return (reader.readString(offset)) as P;
    case 13:
      return (reader.readLong(offset)) as P;
    case 14:
      return (reader.readStringOrNull(offset)) as P;
    case 15:
      return (reader.readString(offset)) as P;
    case 16:
      return (reader.readString(offset)) as P;
    case 17:
      return (reader.readDateTimeOrNull(offset)) as P;
    default:
      throw 'Illegal propertyIndex';
  }
}

dynamic _taskModelSerializeWeb(
    IsarCollection<TaskModel> collection, TaskModel object) {
  final jsObj = IsarNative.newJsObject();
  IsarNative.jsObjectSet(jsObj, 'address', object.address);
  IsarNative.jsObjectSet(jsObj, 'assignedTo', object.assignedTo);
  IsarNative.jsObjectSet(
      jsObj, 'createdAt', object.createdAt?.toUtc().millisecondsSinceEpoch);
  IsarNative.jsObjectSet(jsObj, 'createdBy', object.createdBy);
  IsarNative.jsObjectSet(jsObj, 'description', object.description);
  IsarNative.jsObjectSet(jsObj, 'id', object.id);
  IsarNative.jsObjectSet(jsObj, 'images', object.images);
  IsarNative.jsObjectSet(jsObj, 'isDraft', object.isDraft);
  IsarNative.jsObjectSet(jsObj, 'isarId', object.isarId);
  IsarNative.jsObjectSet(jsObj, 'latitude', object.latitude);
  IsarNative.jsObjectSet(jsObj, 'longitude', object.longitude);
  IsarNative.jsObjectSet(jsObj, 'materialsStatus', object.materialsStatus);
  IsarNative.jsObjectSet(jsObj, 'participantCount', object.participantCount);
  IsarNative.jsObjectSet(jsObj, 'priority', object.priority);
  IsarNative.jsObjectSet(
      jsObj, 'requiredParticipants', object.requiredParticipants);
  IsarNative.jsObjectSet(jsObj, 'roleLabel', object.roleLabel);
  IsarNative.jsObjectSet(jsObj, 'status', object.status);
  IsarNative.jsObjectSet(jsObj, 'title', object.title);
  IsarNative.jsObjectSet(
      jsObj, 'updatedAt', object.updatedAt?.toUtc().millisecondsSinceEpoch);
  return jsObj;
}

TaskModel _taskModelDeserializeWeb(
    IsarCollection<TaskModel> collection, dynamic jsObj) {
  final object = TaskModel(
    address: IsarNative.jsObjectGet(jsObj, 'address'),
    assignedTo: IsarNative.jsObjectGet(jsObj, 'assignedTo'),
    createdAt: IsarNative.jsObjectGet(jsObj, 'createdAt') != null
        ? DateTime.fromMillisecondsSinceEpoch(
                IsarNative.jsObjectGet(jsObj, 'createdAt'),
                isUtc: true)
            .toLocal()
        : null,
    createdBy: IsarNative.jsObjectGet(jsObj, 'createdBy'),
    description: IsarNative.jsObjectGet(jsObj, 'description'),
    id: IsarNative.jsObjectGet(jsObj, 'id') ?? '',
    images: (IsarNative.jsObjectGet(jsObj, 'images') as List?)
            ?.map((e) => e ?? '')
            .toList()
            .cast<String>() ??
        [],
    isDraft: IsarNative.jsObjectGet(jsObj, 'isDraft') ?? false,
    isarId: IsarNative.jsObjectGet(jsObj, 'isarId'),
    latitude: IsarNative.jsObjectGet(jsObj, 'latitude'),
    longitude: IsarNative.jsObjectGet(jsObj, 'longitude'),
    materialsStatus: IsarNative.jsObjectGet(jsObj, 'materialsStatus') ?? '',
    participantCount: IsarNative.jsObjectGet(jsObj, 'participantCount') ??
        double.negativeInfinity,
    priority: IsarNative.jsObjectGet(jsObj, 'priority') ?? '',
    requiredParticipants:
        IsarNative.jsObjectGet(jsObj, 'requiredParticipants') ??
            double.negativeInfinity,
    roleLabel: IsarNative.jsObjectGet(jsObj, 'roleLabel'),
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

P _taskModelDeserializePropWeb<P>(Object jsObj, String propertyName) {
  switch (propertyName) {
    case 'address':
      return (IsarNative.jsObjectGet(jsObj, 'address')) as P;
    case 'assignedTo':
      return (IsarNative.jsObjectGet(jsObj, 'assignedTo')) as P;
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
    case 'id':
      return (IsarNative.jsObjectGet(jsObj, 'id') ?? '') as P;
    case 'images':
      return ((IsarNative.jsObjectGet(jsObj, 'images') as List?)
              ?.map((e) => e ?? '')
              .toList()
              .cast<String>() ??
          []) as P;
    case 'isDraft':
      return (IsarNative.jsObjectGet(jsObj, 'isDraft') ?? false) as P;
    case 'isarId':
      return (IsarNative.jsObjectGet(jsObj, 'isarId')) as P;
    case 'latitude':
      return (IsarNative.jsObjectGet(jsObj, 'latitude')) as P;
    case 'longitude':
      return (IsarNative.jsObjectGet(jsObj, 'longitude')) as P;
    case 'materialsStatus':
      return (IsarNative.jsObjectGet(jsObj, 'materialsStatus') ?? '') as P;
    case 'participantCount':
      return (IsarNative.jsObjectGet(jsObj, 'participantCount') ??
          double.negativeInfinity) as P;
    case 'priority':
      return (IsarNative.jsObjectGet(jsObj, 'priority') ?? '') as P;
    case 'requiredParticipants':
      return (IsarNative.jsObjectGet(jsObj, 'requiredParticipants') ??
          double.negativeInfinity) as P;
    case 'roleLabel':
      return (IsarNative.jsObjectGet(jsObj, 'roleLabel')) as P;
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

void _taskModelAttachLinks(IsarCollection col, int id, TaskModel object) {}

extension TaskModelQueryWhereSort
    on QueryBuilder<TaskModel, TaskModel, QWhere> {
  QueryBuilder<TaskModel, TaskModel, QAfterWhere> anyIsarId() {
    return addWhereClauseInternal(const IdWhereClause.any());
  }
}

extension TaskModelQueryWhere
    on QueryBuilder<TaskModel, TaskModel, QWhereClause> {
  QueryBuilder<TaskModel, TaskModel, QAfterWhereClause> isarIdEqualTo(
      int isarId) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: isarId,
      includeLower: true,
      upper: isarId,
      includeUpper: true,
    ));
  }

  QueryBuilder<TaskModel, TaskModel, QAfterWhereClause> isarIdNotEqualTo(
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

  QueryBuilder<TaskModel, TaskModel, QAfterWhereClause> isarIdGreaterThan(
      int isarId,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.greaterThan(lower: isarId, includeLower: include),
    );
  }

  QueryBuilder<TaskModel, TaskModel, QAfterWhereClause> isarIdLessThan(
      int isarId,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.lessThan(upper: isarId, includeUpper: include),
    );
  }

  QueryBuilder<TaskModel, TaskModel, QAfterWhereClause> isarIdBetween(
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

extension TaskModelQueryFilter
    on QueryBuilder<TaskModel, TaskModel, QFilterCondition> {
  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> addressIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'address',
      value: null,
    ));
  }

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> addressEqualTo(
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

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> addressGreaterThan(
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

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> addressLessThan(
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

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> addressBetween(
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

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> addressStartsWith(
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

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> addressEndsWith(
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

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> addressContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'address',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> addressMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'address',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> assignedToIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'assignedTo',
      value: null,
    ));
  }

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> assignedToEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'assignedTo',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition>
      assignedToGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'assignedTo',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> assignedToLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'assignedTo',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> assignedToBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'assignedTo',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition>
      assignedToStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'assignedTo',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> assignedToEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'assignedTo',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> assignedToContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'assignedTo',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> assignedToMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'assignedTo',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> createdAtIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'createdAt',
      value: null,
    ));
  }

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> createdAtEqualTo(
      DateTime? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'createdAt',
      value: value,
    ));
  }

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition>
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

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> createdAtLessThan(
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

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> createdAtBetween(
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

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> createdByIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'createdBy',
      value: null,
    ));
  }

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> createdByEqualTo(
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

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition>
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

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> createdByLessThan(
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

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> createdByBetween(
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

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> createdByStartsWith(
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

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> createdByEndsWith(
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

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> createdByContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'createdBy',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> createdByMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'createdBy',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition>
      descriptionIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'description',
      value: null,
    ));
  }

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> descriptionEqualTo(
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

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition>
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

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> descriptionLessThan(
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

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> descriptionBetween(
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

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition>
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

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> descriptionEndsWith(
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

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> descriptionContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'description',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> descriptionMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'description',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> idEqualTo(
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

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> idBetween(
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

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> idStartsWith(
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

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> idEndsWith(
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

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> idContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> idMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'id',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> imagesAnyEqualTo(
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

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition>
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

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> imagesAnyLessThan(
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

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> imagesAnyBetween(
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

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> imagesAnyStartsWith(
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

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> imagesAnyEndsWith(
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

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> imagesAnyContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'images',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> imagesAnyMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'images',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> isDraftEqualTo(
      bool value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'isDraft',
      value: value,
    ));
  }

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> isarIdIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'isarId',
      value: null,
    ));
  }

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> isarIdEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> isarIdGreaterThan(
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

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> isarIdLessThan(
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

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> isarIdBetween(
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

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> latitudeIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'latitude',
      value: null,
    ));
  }

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> latitudeGreaterThan(
      double? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: false,
      property: 'latitude',
      value: value,
    ));
  }

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> latitudeLessThan(
      double? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: false,
      property: 'latitude',
      value: value,
    ));
  }

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> latitudeBetween(
      double? lower, double? upper) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'latitude',
      lower: lower,
      includeLower: false,
      upper: upper,
      includeUpper: false,
    ));
  }

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> longitudeIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'longitude',
      value: null,
    ));
  }

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition>
      longitudeGreaterThan(double? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: false,
      property: 'longitude',
      value: value,
    ));
  }

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> longitudeLessThan(
      double? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: false,
      property: 'longitude',
      value: value,
    ));
  }

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> longitudeBetween(
      double? lower, double? upper) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'longitude',
      lower: lower,
      includeLower: false,
      upper: upper,
      includeUpper: false,
    ));
  }

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition>
      materialsStatusEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'materialsStatus',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition>
      materialsStatusGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'materialsStatus',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition>
      materialsStatusLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'materialsStatus',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition>
      materialsStatusBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'materialsStatus',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition>
      materialsStatusStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'materialsStatus',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition>
      materialsStatusEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'materialsStatus',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition>
      materialsStatusContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'materialsStatus',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition>
      materialsStatusMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'materialsStatus',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition>
      participantCountEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'participantCount',
      value: value,
    ));
  }

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition>
      participantCountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'participantCount',
      value: value,
    ));
  }

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition>
      participantCountLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'participantCount',
      value: value,
    ));
  }

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition>
      participantCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'participantCount',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> priorityEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'priority',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> priorityGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'priority',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> priorityLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'priority',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> priorityBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'priority',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> priorityStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'priority',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> priorityEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'priority',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> priorityContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'priority',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> priorityMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'priority',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition>
      requiredParticipantsEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'requiredParticipants',
      value: value,
    ));
  }

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition>
      requiredParticipantsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'requiredParticipants',
      value: value,
    ));
  }

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition>
      requiredParticipantsLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'requiredParticipants',
      value: value,
    ));
  }

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition>
      requiredParticipantsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'requiredParticipants',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> roleLabelIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'roleLabel',
      value: null,
    ));
  }

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> roleLabelEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'roleLabel',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition>
      roleLabelGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'roleLabel',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> roleLabelLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'roleLabel',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> roleLabelBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'roleLabel',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> roleLabelStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'roleLabel',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> roleLabelEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'roleLabel',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> roleLabelContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'roleLabel',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> roleLabelMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'roleLabel',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> statusEqualTo(
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

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> statusGreaterThan(
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

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> statusLessThan(
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

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> statusBetween(
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

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> statusStartsWith(
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

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> statusEndsWith(
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

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> statusContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'status',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> statusMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'status',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> titleEqualTo(
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

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> titleGreaterThan(
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

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> titleLessThan(
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

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> titleBetween(
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

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> titleStartsWith(
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

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> titleEndsWith(
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

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> titleContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'title',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> titleMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'title',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> updatedAtIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'updatedAt',
      value: null,
    ));
  }

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> updatedAtEqualTo(
      DateTime? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'updatedAt',
      value: value,
    ));
  }

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition>
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

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> updatedAtLessThan(
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

  QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> updatedAtBetween(
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

extension TaskModelQueryLinks
    on QueryBuilder<TaskModel, TaskModel, QFilterCondition> {}

extension TaskModelQueryWhereSortBy
    on QueryBuilder<TaskModel, TaskModel, QSortBy> {
  QueryBuilder<TaskModel, TaskModel, QAfterSortBy> sortByAddress() {
    return addSortByInternal('address', Sort.asc);
  }

  QueryBuilder<TaskModel, TaskModel, QAfterSortBy> sortByAddressDesc() {
    return addSortByInternal('address', Sort.desc);
  }

  QueryBuilder<TaskModel, TaskModel, QAfterSortBy> sortByAssignedTo() {
    return addSortByInternal('assignedTo', Sort.asc);
  }

  QueryBuilder<TaskModel, TaskModel, QAfterSortBy> sortByAssignedToDesc() {
    return addSortByInternal('assignedTo', Sort.desc);
  }

  QueryBuilder<TaskModel, TaskModel, QAfterSortBy> sortByCreatedAt() {
    return addSortByInternal('createdAt', Sort.asc);
  }

  QueryBuilder<TaskModel, TaskModel, QAfterSortBy> sortByCreatedAtDesc() {
    return addSortByInternal('createdAt', Sort.desc);
  }

  QueryBuilder<TaskModel, TaskModel, QAfterSortBy> sortByCreatedBy() {
    return addSortByInternal('createdBy', Sort.asc);
  }

  QueryBuilder<TaskModel, TaskModel, QAfterSortBy> sortByCreatedByDesc() {
    return addSortByInternal('createdBy', Sort.desc);
  }

  QueryBuilder<TaskModel, TaskModel, QAfterSortBy> sortByDescription() {
    return addSortByInternal('description', Sort.asc);
  }

  QueryBuilder<TaskModel, TaskModel, QAfterSortBy> sortByDescriptionDesc() {
    return addSortByInternal('description', Sort.desc);
  }

  QueryBuilder<TaskModel, TaskModel, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<TaskModel, TaskModel, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<TaskModel, TaskModel, QAfterSortBy> sortByIsDraft() {
    return addSortByInternal('isDraft', Sort.asc);
  }

  QueryBuilder<TaskModel, TaskModel, QAfterSortBy> sortByIsDraftDesc() {
    return addSortByInternal('isDraft', Sort.desc);
  }

  QueryBuilder<TaskModel, TaskModel, QAfterSortBy> sortByIsarId() {
    return addSortByInternal('isarId', Sort.asc);
  }

  QueryBuilder<TaskModel, TaskModel, QAfterSortBy> sortByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.desc);
  }

  QueryBuilder<TaskModel, TaskModel, QAfterSortBy> sortByLatitude() {
    return addSortByInternal('latitude', Sort.asc);
  }

  QueryBuilder<TaskModel, TaskModel, QAfterSortBy> sortByLatitudeDesc() {
    return addSortByInternal('latitude', Sort.desc);
  }

  QueryBuilder<TaskModel, TaskModel, QAfterSortBy> sortByLongitude() {
    return addSortByInternal('longitude', Sort.asc);
  }

  QueryBuilder<TaskModel, TaskModel, QAfterSortBy> sortByLongitudeDesc() {
    return addSortByInternal('longitude', Sort.desc);
  }

  QueryBuilder<TaskModel, TaskModel, QAfterSortBy> sortByMaterialsStatus() {
    return addSortByInternal('materialsStatus', Sort.asc);
  }

  QueryBuilder<TaskModel, TaskModel, QAfterSortBy> sortByMaterialsStatusDesc() {
    return addSortByInternal('materialsStatus', Sort.desc);
  }

  QueryBuilder<TaskModel, TaskModel, QAfterSortBy> sortByParticipantCount() {
    return addSortByInternal('participantCount', Sort.asc);
  }

  QueryBuilder<TaskModel, TaskModel, QAfterSortBy>
      sortByParticipantCountDesc() {
    return addSortByInternal('participantCount', Sort.desc);
  }

  QueryBuilder<TaskModel, TaskModel, QAfterSortBy> sortByPriority() {
    return addSortByInternal('priority', Sort.asc);
  }

  QueryBuilder<TaskModel, TaskModel, QAfterSortBy> sortByPriorityDesc() {
    return addSortByInternal('priority', Sort.desc);
  }

  QueryBuilder<TaskModel, TaskModel, QAfterSortBy>
      sortByRequiredParticipants() {
    return addSortByInternal('requiredParticipants', Sort.asc);
  }

  QueryBuilder<TaskModel, TaskModel, QAfterSortBy>
      sortByRequiredParticipantsDesc() {
    return addSortByInternal('requiredParticipants', Sort.desc);
  }

  QueryBuilder<TaskModel, TaskModel, QAfterSortBy> sortByRoleLabel() {
    return addSortByInternal('roleLabel', Sort.asc);
  }

  QueryBuilder<TaskModel, TaskModel, QAfterSortBy> sortByRoleLabelDesc() {
    return addSortByInternal('roleLabel', Sort.desc);
  }

  QueryBuilder<TaskModel, TaskModel, QAfterSortBy> sortByStatus() {
    return addSortByInternal('status', Sort.asc);
  }

  QueryBuilder<TaskModel, TaskModel, QAfterSortBy> sortByStatusDesc() {
    return addSortByInternal('status', Sort.desc);
  }

  QueryBuilder<TaskModel, TaskModel, QAfterSortBy> sortByTitle() {
    return addSortByInternal('title', Sort.asc);
  }

  QueryBuilder<TaskModel, TaskModel, QAfterSortBy> sortByTitleDesc() {
    return addSortByInternal('title', Sort.desc);
  }

  QueryBuilder<TaskModel, TaskModel, QAfterSortBy> sortByUpdatedAt() {
    return addSortByInternal('updatedAt', Sort.asc);
  }

  QueryBuilder<TaskModel, TaskModel, QAfterSortBy> sortByUpdatedAtDesc() {
    return addSortByInternal('updatedAt', Sort.desc);
  }
}

extension TaskModelQueryWhereSortThenBy
    on QueryBuilder<TaskModel, TaskModel, QSortThenBy> {
  QueryBuilder<TaskModel, TaskModel, QAfterSortBy> thenByAddress() {
    return addSortByInternal('address', Sort.asc);
  }

  QueryBuilder<TaskModel, TaskModel, QAfterSortBy> thenByAddressDesc() {
    return addSortByInternal('address', Sort.desc);
  }

  QueryBuilder<TaskModel, TaskModel, QAfterSortBy> thenByAssignedTo() {
    return addSortByInternal('assignedTo', Sort.asc);
  }

  QueryBuilder<TaskModel, TaskModel, QAfterSortBy> thenByAssignedToDesc() {
    return addSortByInternal('assignedTo', Sort.desc);
  }

  QueryBuilder<TaskModel, TaskModel, QAfterSortBy> thenByCreatedAt() {
    return addSortByInternal('createdAt', Sort.asc);
  }

  QueryBuilder<TaskModel, TaskModel, QAfterSortBy> thenByCreatedAtDesc() {
    return addSortByInternal('createdAt', Sort.desc);
  }

  QueryBuilder<TaskModel, TaskModel, QAfterSortBy> thenByCreatedBy() {
    return addSortByInternal('createdBy', Sort.asc);
  }

  QueryBuilder<TaskModel, TaskModel, QAfterSortBy> thenByCreatedByDesc() {
    return addSortByInternal('createdBy', Sort.desc);
  }

  QueryBuilder<TaskModel, TaskModel, QAfterSortBy> thenByDescription() {
    return addSortByInternal('description', Sort.asc);
  }

  QueryBuilder<TaskModel, TaskModel, QAfterSortBy> thenByDescriptionDesc() {
    return addSortByInternal('description', Sort.desc);
  }

  QueryBuilder<TaskModel, TaskModel, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<TaskModel, TaskModel, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<TaskModel, TaskModel, QAfterSortBy> thenByIsDraft() {
    return addSortByInternal('isDraft', Sort.asc);
  }

  QueryBuilder<TaskModel, TaskModel, QAfterSortBy> thenByIsDraftDesc() {
    return addSortByInternal('isDraft', Sort.desc);
  }

  QueryBuilder<TaskModel, TaskModel, QAfterSortBy> thenByIsarId() {
    return addSortByInternal('isarId', Sort.asc);
  }

  QueryBuilder<TaskModel, TaskModel, QAfterSortBy> thenByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.desc);
  }

  QueryBuilder<TaskModel, TaskModel, QAfterSortBy> thenByLatitude() {
    return addSortByInternal('latitude', Sort.asc);
  }

  QueryBuilder<TaskModel, TaskModel, QAfterSortBy> thenByLatitudeDesc() {
    return addSortByInternal('latitude', Sort.desc);
  }

  QueryBuilder<TaskModel, TaskModel, QAfterSortBy> thenByLongitude() {
    return addSortByInternal('longitude', Sort.asc);
  }

  QueryBuilder<TaskModel, TaskModel, QAfterSortBy> thenByLongitudeDesc() {
    return addSortByInternal('longitude', Sort.desc);
  }

  QueryBuilder<TaskModel, TaskModel, QAfterSortBy> thenByMaterialsStatus() {
    return addSortByInternal('materialsStatus', Sort.asc);
  }

  QueryBuilder<TaskModel, TaskModel, QAfterSortBy> thenByMaterialsStatusDesc() {
    return addSortByInternal('materialsStatus', Sort.desc);
  }

  QueryBuilder<TaskModel, TaskModel, QAfterSortBy> thenByParticipantCount() {
    return addSortByInternal('participantCount', Sort.asc);
  }

  QueryBuilder<TaskModel, TaskModel, QAfterSortBy>
      thenByParticipantCountDesc() {
    return addSortByInternal('participantCount', Sort.desc);
  }

  QueryBuilder<TaskModel, TaskModel, QAfterSortBy> thenByPriority() {
    return addSortByInternal('priority', Sort.asc);
  }

  QueryBuilder<TaskModel, TaskModel, QAfterSortBy> thenByPriorityDesc() {
    return addSortByInternal('priority', Sort.desc);
  }

  QueryBuilder<TaskModel, TaskModel, QAfterSortBy>
      thenByRequiredParticipants() {
    return addSortByInternal('requiredParticipants', Sort.asc);
  }

  QueryBuilder<TaskModel, TaskModel, QAfterSortBy>
      thenByRequiredParticipantsDesc() {
    return addSortByInternal('requiredParticipants', Sort.desc);
  }

  QueryBuilder<TaskModel, TaskModel, QAfterSortBy> thenByRoleLabel() {
    return addSortByInternal('roleLabel', Sort.asc);
  }

  QueryBuilder<TaskModel, TaskModel, QAfterSortBy> thenByRoleLabelDesc() {
    return addSortByInternal('roleLabel', Sort.desc);
  }

  QueryBuilder<TaskModel, TaskModel, QAfterSortBy> thenByStatus() {
    return addSortByInternal('status', Sort.asc);
  }

  QueryBuilder<TaskModel, TaskModel, QAfterSortBy> thenByStatusDesc() {
    return addSortByInternal('status', Sort.desc);
  }

  QueryBuilder<TaskModel, TaskModel, QAfterSortBy> thenByTitle() {
    return addSortByInternal('title', Sort.asc);
  }

  QueryBuilder<TaskModel, TaskModel, QAfterSortBy> thenByTitleDesc() {
    return addSortByInternal('title', Sort.desc);
  }

  QueryBuilder<TaskModel, TaskModel, QAfterSortBy> thenByUpdatedAt() {
    return addSortByInternal('updatedAt', Sort.asc);
  }

  QueryBuilder<TaskModel, TaskModel, QAfterSortBy> thenByUpdatedAtDesc() {
    return addSortByInternal('updatedAt', Sort.desc);
  }
}

extension TaskModelQueryWhereDistinct
    on QueryBuilder<TaskModel, TaskModel, QDistinct> {
  QueryBuilder<TaskModel, TaskModel, QDistinct> distinctByAddress(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('address', caseSensitive: caseSensitive);
  }

  QueryBuilder<TaskModel, TaskModel, QDistinct> distinctByAssignedTo(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('assignedTo', caseSensitive: caseSensitive);
  }

  QueryBuilder<TaskModel, TaskModel, QDistinct> distinctByCreatedAt() {
    return addDistinctByInternal('createdAt');
  }

  QueryBuilder<TaskModel, TaskModel, QDistinct> distinctByCreatedBy(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('createdBy', caseSensitive: caseSensitive);
  }

  QueryBuilder<TaskModel, TaskModel, QDistinct> distinctByDescription(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('description', caseSensitive: caseSensitive);
  }

  QueryBuilder<TaskModel, TaskModel, QDistinct> distinctById(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('id', caseSensitive: caseSensitive);
  }

  QueryBuilder<TaskModel, TaskModel, QDistinct> distinctByIsDraft() {
    return addDistinctByInternal('isDraft');
  }

  QueryBuilder<TaskModel, TaskModel, QDistinct> distinctByIsarId() {
    return addDistinctByInternal('isarId');
  }

  QueryBuilder<TaskModel, TaskModel, QDistinct> distinctByLatitude() {
    return addDistinctByInternal('latitude');
  }

  QueryBuilder<TaskModel, TaskModel, QDistinct> distinctByLongitude() {
    return addDistinctByInternal('longitude');
  }

  QueryBuilder<TaskModel, TaskModel, QDistinct> distinctByMaterialsStatus(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('materialsStatus',
        caseSensitive: caseSensitive);
  }

  QueryBuilder<TaskModel, TaskModel, QDistinct> distinctByParticipantCount() {
    return addDistinctByInternal('participantCount');
  }

  QueryBuilder<TaskModel, TaskModel, QDistinct> distinctByPriority(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('priority', caseSensitive: caseSensitive);
  }

  QueryBuilder<TaskModel, TaskModel, QDistinct>
      distinctByRequiredParticipants() {
    return addDistinctByInternal('requiredParticipants');
  }

  QueryBuilder<TaskModel, TaskModel, QDistinct> distinctByRoleLabel(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('roleLabel', caseSensitive: caseSensitive);
  }

  QueryBuilder<TaskModel, TaskModel, QDistinct> distinctByStatus(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('status', caseSensitive: caseSensitive);
  }

  QueryBuilder<TaskModel, TaskModel, QDistinct> distinctByTitle(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('title', caseSensitive: caseSensitive);
  }

  QueryBuilder<TaskModel, TaskModel, QDistinct> distinctByUpdatedAt() {
    return addDistinctByInternal('updatedAt');
  }
}

extension TaskModelQueryProperty
    on QueryBuilder<TaskModel, TaskModel, QQueryProperty> {
  QueryBuilder<TaskModel, String?, QQueryOperations> addressProperty() {
    return addPropertyNameInternal('address');
  }

  QueryBuilder<TaskModel, String?, QQueryOperations> assignedToProperty() {
    return addPropertyNameInternal('assignedTo');
  }

  QueryBuilder<TaskModel, DateTime?, QQueryOperations> createdAtProperty() {
    return addPropertyNameInternal('createdAt');
  }

  QueryBuilder<TaskModel, String?, QQueryOperations> createdByProperty() {
    return addPropertyNameInternal('createdBy');
  }

  QueryBuilder<TaskModel, String?, QQueryOperations> descriptionProperty() {
    return addPropertyNameInternal('description');
  }

  QueryBuilder<TaskModel, String, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<TaskModel, List<String>, QQueryOperations> imagesProperty() {
    return addPropertyNameInternal('images');
  }

  QueryBuilder<TaskModel, bool, QQueryOperations> isDraftProperty() {
    return addPropertyNameInternal('isDraft');
  }

  QueryBuilder<TaskModel, int?, QQueryOperations> isarIdProperty() {
    return addPropertyNameInternal('isarId');
  }

  QueryBuilder<TaskModel, double?, QQueryOperations> latitudeProperty() {
    return addPropertyNameInternal('latitude');
  }

  QueryBuilder<TaskModel, double?, QQueryOperations> longitudeProperty() {
    return addPropertyNameInternal('longitude');
  }

  QueryBuilder<TaskModel, String, QQueryOperations> materialsStatusProperty() {
    return addPropertyNameInternal('materialsStatus');
  }

  QueryBuilder<TaskModel, int, QQueryOperations> participantCountProperty() {
    return addPropertyNameInternal('participantCount');
  }

  QueryBuilder<TaskModel, String, QQueryOperations> priorityProperty() {
    return addPropertyNameInternal('priority');
  }

  QueryBuilder<TaskModel, int, QQueryOperations>
      requiredParticipantsProperty() {
    return addPropertyNameInternal('requiredParticipants');
  }

  QueryBuilder<TaskModel, String?, QQueryOperations> roleLabelProperty() {
    return addPropertyNameInternal('roleLabel');
  }

  QueryBuilder<TaskModel, String, QQueryOperations> statusProperty() {
    return addPropertyNameInternal('status');
  }

  QueryBuilder<TaskModel, String, QQueryOperations> titleProperty() {
    return addPropertyNameInternal('title');
  }

  QueryBuilder<TaskModel, DateTime?, QQueryOperations> updatedAtProperty() {
    return addPropertyNameInternal('updatedAt');
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TaskModelImpl _$$TaskModelImplFromJson(Map<String, dynamic> json) =>
    _$TaskModelImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      status: json['status'] as String? ?? 'Open',
      priority: json['priority'] as String? ?? 'Normal',
      roleLabel: json['role_label'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      address: json['address'] as String?,
      materialsStatus: json['materials_status'] as String? ?? '蝛拙?',
      participantCount: (json['participant_count'] as num?)?.toInt() ?? 0,
      requiredParticipants:
          (json['required_participants'] as num?)?.toInt() ?? 0,
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      assignedTo: json['assigned_to'] as String?,
      createdBy: json['created_by'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      isDraft: json['isDraft'] as bool? ?? false,
    );

Map<String, dynamic> _$$TaskModelImplToJson(_$TaskModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'status': instance.status,
      'priority': instance.priority,
      'role_label': instance.roleLabel,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'address': instance.address,
      'materials_status': instance.materialsStatus,
      'participant_count': instance.participantCount,
      'required_participants': instance.requiredParticipants,
      'images': instance.images,
      'assigned_to': instance.assignedTo,
      'created_by': instance.createdBy,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'isDraft': instance.isDraft,
    };
