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
      '{"name":"ShuttleModel","idName":"isarId","properties":[{"name":"arriveAt","type":"Long"},{"name":"capacity","type":"Long"},{"name":"contactName","type":"String"},{"name":"contactPhoneMasked","type":"String"},{"name":"costType","type":"String"},{"name":"createdAt","type":"Long"},{"name":"createdBy","type":"String"},{"name":"departureTime","type":"Long"},{"name":"description","type":"String"},{"name":"destinationAddress","type":"String"},{"name":"displayId","type":"String"},{"name":"driverId","type":"String"},{"name":"farePerPerson","type":"Double"},{"name":"fareTotal","type":"Double"},{"name":"id","type":"String"},{"name":"isPriority","type":"Bool"},{"name":"originAddress","type":"String"},{"name":"participantIds","type":"StringList"},{"name":"routeEndLat","type":"Double"},{"name":"routeEndLng","type":"Double"},{"name":"routeStartLat","type":"Double"},{"name":"routeStartLng","type":"Double"},{"name":"seatsTaken","type":"Long"},{"name":"signupDeadline","type":"Long"},{"name":"status","type":"String"},{"name":"title","type":"String"},{"name":"updatedAt","type":"Long"}],"indexes":[],"links":[]}',
  idName: 'isarId',
  propertyIds: {
    'arriveAt': 0,
    'capacity': 1,
    'contactName': 2,
    'contactPhoneMasked': 3,
    'costType': 4,
    'createdAt': 5,
    'createdBy': 6,
    'departureTime': 7,
    'description': 8,
    'destinationAddress': 9,
    'displayId': 10,
    'driverId': 11,
    'farePerPerson': 12,
    'fareTotal': 13,
    'id': 14,
    'isPriority': 15,
    'originAddress': 16,
    'participantIds': 17,
    'routeEndLat': 18,
    'routeEndLng': 19,
    'routeStartLat': 20,
    'routeStartLng': 21,
    'seatsTaken': 22,
    'signupDeadline': 23,
    'status': 24,
    'title': 25,
    'updatedAt': 26
  },
  listProperties: {'participantIds'},
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
  final value0 = object.arriveAt;
  final _arriveAt = value0;
  final value1 = object.capacity;
  final _capacity = value1;
  final value2 = object.contactName;
  IsarUint8List? _contactName;
  if (value2 != null) {
    _contactName = IsarBinaryWriter.utf8Encoder.convert(value2);
  }
  dynamicSize += (_contactName?.length ?? 0) as int;
  final value3 = object.contactPhoneMasked;
  IsarUint8List? _contactPhoneMasked;
  if (value3 != null) {
    _contactPhoneMasked = IsarBinaryWriter.utf8Encoder.convert(value3);
  }
  dynamicSize += (_contactPhoneMasked?.length ?? 0) as int;
  final value4 = object.costType;
  final _costType = IsarBinaryWriter.utf8Encoder.convert(value4);
  dynamicSize += (_costType.length) as int;
  final value5 = object.createdAt;
  final _createdAt = value5;
  final value6 = object.createdBy;
  IsarUint8List? _createdBy;
  if (value6 != null) {
    _createdBy = IsarBinaryWriter.utf8Encoder.convert(value6);
  }
  dynamicSize += (_createdBy?.length ?? 0) as int;
  final value7 = object.departureTime;
  final _departureTime = value7;
  final value8 = object.description;
  IsarUint8List? _description;
  if (value8 != null) {
    _description = IsarBinaryWriter.utf8Encoder.convert(value8);
  }
  dynamicSize += (_description?.length ?? 0) as int;
  final value9 = object.destinationAddress;
  IsarUint8List? _destinationAddress;
  if (value9 != null) {
    _destinationAddress = IsarBinaryWriter.utf8Encoder.convert(value9);
  }
  dynamicSize += (_destinationAddress?.length ?? 0) as int;
  final value10 = object.displayId;
  IsarUint8List? _displayId;
  if (value10 != null) {
    _displayId = IsarBinaryWriter.utf8Encoder.convert(value10);
  }
  dynamicSize += (_displayId?.length ?? 0) as int;
  final value11 = object.driverId;
  IsarUint8List? _driverId;
  if (value11 != null) {
    _driverId = IsarBinaryWriter.utf8Encoder.convert(value11);
  }
  dynamicSize += (_driverId?.length ?? 0) as int;
  final value12 = object.farePerPerson;
  final _farePerPerson = value12;
  final value13 = object.fareTotal;
  final _fareTotal = value13;
  final value14 = object.id;
  final _id = IsarBinaryWriter.utf8Encoder.convert(value14);
  dynamicSize += (_id.length) as int;
  final value15 = object.isPriority;
  final _isPriority = value15;
  final value16 = object.originAddress;
  IsarUint8List? _originAddress;
  if (value16 != null) {
    _originAddress = IsarBinaryWriter.utf8Encoder.convert(value16);
  }
  dynamicSize += (_originAddress?.length ?? 0) as int;
  final value17 = object.participantIds;
  dynamicSize += (value17.length) * 8;
  final bytesList17 = <IsarUint8List>[];
  for (var str in value17) {
    final bytes = IsarBinaryWriter.utf8Encoder.convert(str);
    bytesList17.add(bytes);
    dynamicSize += bytes.length as int;
  }
  final _participantIds = bytesList17;
  final value18 = object.routeEndLat;
  final _routeEndLat = value18;
  final value19 = object.routeEndLng;
  final _routeEndLng = value19;
  final value20 = object.routeStartLat;
  final _routeStartLat = value20;
  final value21 = object.routeStartLng;
  final _routeStartLng = value21;
  final value22 = object.seatsTaken;
  final _seatsTaken = value22;
  final value23 = object.signupDeadline;
  final _signupDeadline = value23;
  final value24 = object.status;
  final _status = IsarBinaryWriter.utf8Encoder.convert(value24);
  dynamicSize += (_status.length) as int;
  final value25 = object.title;
  final _title = IsarBinaryWriter.utf8Encoder.convert(value25);
  dynamicSize += (_title.length) as int;
  final value26 = object.updatedAt;
  final _updatedAt = value26;
  final size = staticSize + dynamicSize;

  rawObj.buffer = alloc(size);
  rawObj.buffer_length = size;
  final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
  final writer = IsarBinaryWriter(buffer, staticSize);
  writer.writeDateTime(offsets[0], _arriveAt);
  writer.writeLong(offsets[1], _capacity);
  writer.writeBytes(offsets[2], _contactName);
  writer.writeBytes(offsets[3], _contactPhoneMasked);
  writer.writeBytes(offsets[4], _costType);
  writer.writeDateTime(offsets[5], _createdAt);
  writer.writeBytes(offsets[6], _createdBy);
  writer.writeDateTime(offsets[7], _departureTime);
  writer.writeBytes(offsets[8], _description);
  writer.writeBytes(offsets[9], _destinationAddress);
  writer.writeBytes(offsets[10], _displayId);
  writer.writeBytes(offsets[11], _driverId);
  writer.writeDouble(offsets[12], _farePerPerson);
  writer.writeDouble(offsets[13], _fareTotal);
  writer.writeBytes(offsets[14], _id);
  writer.writeBool(offsets[15], _isPriority);
  writer.writeBytes(offsets[16], _originAddress);
  writer.writeStringList(offsets[17], _participantIds);
  writer.writeDouble(offsets[18], _routeEndLat);
  writer.writeDouble(offsets[19], _routeEndLng);
  writer.writeDouble(offsets[20], _routeStartLat);
  writer.writeDouble(offsets[21], _routeStartLng);
  writer.writeLong(offsets[22], _seatsTaken);
  writer.writeDateTime(offsets[23], _signupDeadline);
  writer.writeBytes(offsets[24], _status);
  writer.writeBytes(offsets[25], _title);
  writer.writeDateTime(offsets[26], _updatedAt);
}

ShuttleModel _shuttleModelDeserializeNative(
    IsarCollection<ShuttleModel> collection,
    int id,
    IsarBinaryReader reader,
    List<int> offsets) {
  final object = ShuttleModel(
    arriveAt: reader.readDateTimeOrNull(offsets[0]),
    capacity: reader.readLong(offsets[1]),
    contactName: reader.readStringOrNull(offsets[2]),
    contactPhoneMasked: reader.readStringOrNull(offsets[3]),
    costType: reader.readString(offsets[4]),
    createdAt: reader.readDateTimeOrNull(offsets[5]),
    createdBy: reader.readStringOrNull(offsets[6]),
    departureTime: reader.readDateTimeOrNull(offsets[7]),
    description: reader.readStringOrNull(offsets[8]),
    destinationAddress: reader.readStringOrNull(offsets[9]),
    displayId: reader.readStringOrNull(offsets[10]),
    driverId: reader.readStringOrNull(offsets[11]),
    farePerPerson: reader.readDoubleOrNull(offsets[12]),
    fareTotal: reader.readDoubleOrNull(offsets[13]),
    id: reader.readString(offsets[14]),
    isPriority: reader.readBool(offsets[15]),
    isarId: id,
    originAddress: reader.readStringOrNull(offsets[16]),
    participantIds: reader.readStringList(offsets[17]) ?? [],
    routeEndLat: reader.readDoubleOrNull(offsets[18]),
    routeEndLng: reader.readDoubleOrNull(offsets[19]),
    routeStartLat: reader.readDoubleOrNull(offsets[20]),
    routeStartLng: reader.readDoubleOrNull(offsets[21]),
    seatsTaken: reader.readLong(offsets[22]),
    signupDeadline: reader.readDateTimeOrNull(offsets[23]),
    status: reader.readString(offsets[24]),
    title: reader.readString(offsets[25]),
    updatedAt: reader.readDateTimeOrNull(offsets[26]),
  );
  return object;
}

P _shuttleModelDeserializePropNative<P>(
    int id, IsarBinaryReader reader, int propertyIndex, int offset) {
  switch (propertyIndex) {
    case -1:
      return id as P;
    case 0:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readStringOrNull(offset)) as P;
    case 11:
      return (reader.readStringOrNull(offset)) as P;
    case 12:
      return (reader.readDoubleOrNull(offset)) as P;
    case 13:
      return (reader.readDoubleOrNull(offset)) as P;
    case 14:
      return (reader.readString(offset)) as P;
    case 15:
      return (reader.readBool(offset)) as P;
    case 16:
      return (reader.readStringOrNull(offset)) as P;
    case 17:
      return (reader.readStringList(offset) ?? []) as P;
    case 18:
      return (reader.readDoubleOrNull(offset)) as P;
    case 19:
      return (reader.readDoubleOrNull(offset)) as P;
    case 20:
      return (reader.readDoubleOrNull(offset)) as P;
    case 21:
      return (reader.readDoubleOrNull(offset)) as P;
    case 22:
      return (reader.readLong(offset)) as P;
    case 23:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 24:
      return (reader.readString(offset)) as P;
    case 25:
      return (reader.readString(offset)) as P;
    case 26:
      return (reader.readDateTimeOrNull(offset)) as P;
    default:
      throw 'Illegal propertyIndex';
  }
}

dynamic _shuttleModelSerializeWeb(
    IsarCollection<ShuttleModel> collection, ShuttleModel object) {
  final jsObj = IsarNative.newJsObject();
  IsarNative.jsObjectSet(
      jsObj, 'arriveAt', object.arriveAt?.toUtc().millisecondsSinceEpoch);
  IsarNative.jsObjectSet(jsObj, 'capacity', object.capacity);
  IsarNative.jsObjectSet(jsObj, 'contactName', object.contactName);
  IsarNative.jsObjectSet(
      jsObj, 'contactPhoneMasked', object.contactPhoneMasked);
  IsarNative.jsObjectSet(jsObj, 'costType', object.costType);
  IsarNative.jsObjectSet(
      jsObj, 'createdAt', object.createdAt?.toUtc().millisecondsSinceEpoch);
  IsarNative.jsObjectSet(jsObj, 'createdBy', object.createdBy);
  IsarNative.jsObjectSet(jsObj, 'departureTime',
      object.departureTime?.toUtc().millisecondsSinceEpoch);
  IsarNative.jsObjectSet(jsObj, 'description', object.description);
  IsarNative.jsObjectSet(
      jsObj, 'destinationAddress', object.destinationAddress);
  IsarNative.jsObjectSet(jsObj, 'displayId', object.displayId);
  IsarNative.jsObjectSet(jsObj, 'driverId', object.driverId);
  IsarNative.jsObjectSet(jsObj, 'farePerPerson', object.farePerPerson);
  IsarNative.jsObjectSet(jsObj, 'fareTotal', object.fareTotal);
  IsarNative.jsObjectSet(jsObj, 'id', object.id);
  IsarNative.jsObjectSet(jsObj, 'isPriority', object.isPriority);
  IsarNative.jsObjectSet(jsObj, 'isarId', object.isarId);
  IsarNative.jsObjectSet(jsObj, 'originAddress', object.originAddress);
  IsarNative.jsObjectSet(jsObj, 'participantIds', object.participantIds);
  IsarNative.jsObjectSet(jsObj, 'routeEndLat', object.routeEndLat);
  IsarNative.jsObjectSet(jsObj, 'routeEndLng', object.routeEndLng);
  IsarNative.jsObjectSet(jsObj, 'routeStartLat', object.routeStartLat);
  IsarNative.jsObjectSet(jsObj, 'routeStartLng', object.routeStartLng);
  IsarNative.jsObjectSet(jsObj, 'seatsTaken', object.seatsTaken);
  IsarNative.jsObjectSet(jsObj, 'signupDeadline',
      object.signupDeadline?.toUtc().millisecondsSinceEpoch);
  IsarNative.jsObjectSet(jsObj, 'status', object.status);
  IsarNative.jsObjectSet(jsObj, 'title', object.title);
  IsarNative.jsObjectSet(
      jsObj, 'updatedAt', object.updatedAt?.toUtc().millisecondsSinceEpoch);
  return jsObj;
}

ShuttleModel _shuttleModelDeserializeWeb(
    IsarCollection<ShuttleModel> collection, dynamic jsObj) {
  final object = ShuttleModel(
    arriveAt: IsarNative.jsObjectGet(jsObj, 'arriveAt') != null
        ? DateTime.fromMillisecondsSinceEpoch(
                IsarNative.jsObjectGet(jsObj, 'arriveAt'),
                isUtc: true)
            .toLocal()
        : null,
    capacity:
        IsarNative.jsObjectGet(jsObj, 'capacity') ?? double.negativeInfinity,
    contactName: IsarNative.jsObjectGet(jsObj, 'contactName'),
    contactPhoneMasked: IsarNative.jsObjectGet(jsObj, 'contactPhoneMasked'),
    costType: IsarNative.jsObjectGet(jsObj, 'costType') ?? '',
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
    destinationAddress: IsarNative.jsObjectGet(jsObj, 'destinationAddress'),
    displayId: IsarNative.jsObjectGet(jsObj, 'displayId'),
    driverId: IsarNative.jsObjectGet(jsObj, 'driverId'),
    farePerPerson: IsarNative.jsObjectGet(jsObj, 'farePerPerson'),
    fareTotal: IsarNative.jsObjectGet(jsObj, 'fareTotal'),
    id: IsarNative.jsObjectGet(jsObj, 'id') ?? '',
    isPriority: IsarNative.jsObjectGet(jsObj, 'isPriority') ?? false,
    isarId: IsarNative.jsObjectGet(jsObj, 'isarId'),
    originAddress: IsarNative.jsObjectGet(jsObj, 'originAddress'),
    participantIds: (IsarNative.jsObjectGet(jsObj, 'participantIds') as List?)
            ?.map((e) => e ?? '')
            .toList()
            .cast<String>() ??
        [],
    routeEndLat: IsarNative.jsObjectGet(jsObj, 'routeEndLat'),
    routeEndLng: IsarNative.jsObjectGet(jsObj, 'routeEndLng'),
    routeStartLat: IsarNative.jsObjectGet(jsObj, 'routeStartLat'),
    routeStartLng: IsarNative.jsObjectGet(jsObj, 'routeStartLng'),
    seatsTaken:
        IsarNative.jsObjectGet(jsObj, 'seatsTaken') ?? double.negativeInfinity,
    signupDeadline: IsarNative.jsObjectGet(jsObj, 'signupDeadline') != null
        ? DateTime.fromMillisecondsSinceEpoch(
                IsarNative.jsObjectGet(jsObj, 'signupDeadline'),
                isUtc: true)
            .toLocal()
        : null,
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
    case 'arriveAt':
      return (IsarNative.jsObjectGet(jsObj, 'arriveAt') != null
          ? DateTime.fromMillisecondsSinceEpoch(
                  IsarNative.jsObjectGet(jsObj, 'arriveAt'),
                  isUtc: true)
              .toLocal()
          : null) as P;
    case 'capacity':
      return (IsarNative.jsObjectGet(jsObj, 'capacity') ??
          double.negativeInfinity) as P;
    case 'contactName':
      return (IsarNative.jsObjectGet(jsObj, 'contactName')) as P;
    case 'contactPhoneMasked':
      return (IsarNative.jsObjectGet(jsObj, 'contactPhoneMasked')) as P;
    case 'costType':
      return (IsarNative.jsObjectGet(jsObj, 'costType') ?? '') as P;
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
    case 'destinationAddress':
      return (IsarNative.jsObjectGet(jsObj, 'destinationAddress')) as P;
    case 'displayId':
      return (IsarNative.jsObjectGet(jsObj, 'displayId')) as P;
    case 'driverId':
      return (IsarNative.jsObjectGet(jsObj, 'driverId')) as P;
    case 'farePerPerson':
      return (IsarNative.jsObjectGet(jsObj, 'farePerPerson')) as P;
    case 'fareTotal':
      return (IsarNative.jsObjectGet(jsObj, 'fareTotal')) as P;
    case 'id':
      return (IsarNative.jsObjectGet(jsObj, 'id') ?? '') as P;
    case 'isPriority':
      return (IsarNative.jsObjectGet(jsObj, 'isPriority') ?? false) as P;
    case 'isarId':
      return (IsarNative.jsObjectGet(jsObj, 'isarId')) as P;
    case 'originAddress':
      return (IsarNative.jsObjectGet(jsObj, 'originAddress')) as P;
    case 'participantIds':
      return ((IsarNative.jsObjectGet(jsObj, 'participantIds') as List?)
              ?.map((e) => e ?? '')
              .toList()
              .cast<String>() ??
          []) as P;
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
    case 'signupDeadline':
      return (IsarNative.jsObjectGet(jsObj, 'signupDeadline') != null
          ? DateTime.fromMillisecondsSinceEpoch(
                  IsarNative.jsObjectGet(jsObj, 'signupDeadline'),
                  isUtc: true)
              .toLocal()
          : null) as P;
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
      arriveAtIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'arriveAt',
      value: null,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      arriveAtEqualTo(DateTime? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'arriveAt',
      value: value,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      arriveAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'arriveAt',
      value: value,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      arriveAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'arriveAt',
      value: value,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      arriveAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'arriveAt',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

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
      contactNameIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'contactName',
      value: null,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      contactNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'contactName',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      contactNameGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'contactName',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      contactNameLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'contactName',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      contactNameBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'contactName',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      contactNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'contactName',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      contactNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'contactName',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      contactNameContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'contactName',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      contactNameMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'contactName',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      contactPhoneMaskedIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'contactPhoneMasked',
      value: null,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      contactPhoneMaskedEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'contactPhoneMasked',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      contactPhoneMaskedGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'contactPhoneMasked',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      contactPhoneMaskedLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'contactPhoneMasked',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      contactPhoneMaskedBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'contactPhoneMasked',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      contactPhoneMaskedStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'contactPhoneMasked',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      contactPhoneMaskedEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'contactPhoneMasked',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      contactPhoneMaskedContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'contactPhoneMasked',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      contactPhoneMaskedMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'contactPhoneMasked',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      costTypeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'costType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      costTypeGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'costType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      costTypeLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'costType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      costTypeBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'costType',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      costTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'costType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      costTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'costType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      costTypeContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'costType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      costTypeMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'costType',
      value: pattern,
      caseSensitive: caseSensitive,
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
      destinationAddressIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'destinationAddress',
      value: null,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      destinationAddressEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'destinationAddress',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      destinationAddressGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'destinationAddress',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      destinationAddressLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'destinationAddress',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      destinationAddressBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'destinationAddress',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      destinationAddressStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'destinationAddress',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      destinationAddressEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'destinationAddress',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      destinationAddressContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'destinationAddress',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      destinationAddressMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'destinationAddress',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      displayIdIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'displayId',
      value: null,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      displayIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'displayId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      displayIdGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'displayId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      displayIdLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'displayId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      displayIdBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'displayId',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      displayIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'displayId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      displayIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'displayId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      displayIdContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'displayId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      displayIdMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'displayId',
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

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      farePerPersonIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'farePerPerson',
      value: null,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      farePerPersonGreaterThan(double? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: false,
      property: 'farePerPerson',
      value: value,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      farePerPersonLessThan(double? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: false,
      property: 'farePerPerson',
      value: value,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      farePerPersonBetween(double? lower, double? upper) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'farePerPerson',
      lower: lower,
      includeLower: false,
      upper: upper,
      includeUpper: false,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      fareTotalIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'fareTotal',
      value: null,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      fareTotalGreaterThan(double? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: false,
      property: 'fareTotal',
      value: value,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      fareTotalLessThan(double? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: false,
      property: 'fareTotal',
      value: value,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      fareTotalBetween(double? lower, double? upper) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'fareTotal',
      lower: lower,
      includeLower: false,
      upper: upper,
      includeUpper: false,
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
      isPriorityEqualTo(bool value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'isPriority',
      value: value,
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
      originAddressIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'originAddress',
      value: null,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      originAddressEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'originAddress',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      originAddressGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'originAddress',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      originAddressLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'originAddress',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      originAddressBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'originAddress',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      originAddressStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'originAddress',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      originAddressEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'originAddress',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      originAddressContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'originAddress',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      originAddressMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'originAddress',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      participantIdsAnyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'participantIds',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      participantIdsAnyGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'participantIds',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      participantIdsAnyLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'participantIds',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      participantIdsAnyBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'participantIds',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      participantIdsAnyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'participantIds',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      participantIdsAnyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'participantIds',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      participantIdsAnyContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'participantIds',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      participantIdsAnyMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'participantIds',
      value: pattern,
      caseSensitive: caseSensitive,
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

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      signupDeadlineIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'signupDeadline',
      value: null,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      signupDeadlineEqualTo(DateTime? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'signupDeadline',
      value: value,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      signupDeadlineGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'signupDeadline',
      value: value,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      signupDeadlineLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'signupDeadline',
      value: value,
    ));
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterFilterCondition>
      signupDeadlineBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'signupDeadline',
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
  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> sortByArriveAt() {
    return addSortByInternal('arriveAt', Sort.asc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> sortByArriveAtDesc() {
    return addSortByInternal('arriveAt', Sort.desc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> sortByCapacity() {
    return addSortByInternal('capacity', Sort.asc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> sortByCapacityDesc() {
    return addSortByInternal('capacity', Sort.desc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> sortByContactName() {
    return addSortByInternal('contactName', Sort.asc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy>
      sortByContactNameDesc() {
    return addSortByInternal('contactName', Sort.desc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy>
      sortByContactPhoneMasked() {
    return addSortByInternal('contactPhoneMasked', Sort.asc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy>
      sortByContactPhoneMaskedDesc() {
    return addSortByInternal('contactPhoneMasked', Sort.desc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> sortByCostType() {
    return addSortByInternal('costType', Sort.asc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> sortByCostTypeDesc() {
    return addSortByInternal('costType', Sort.desc);
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

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy>
      sortByDestinationAddress() {
    return addSortByInternal('destinationAddress', Sort.asc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy>
      sortByDestinationAddressDesc() {
    return addSortByInternal('destinationAddress', Sort.desc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> sortByDisplayId() {
    return addSortByInternal('displayId', Sort.asc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> sortByDisplayIdDesc() {
    return addSortByInternal('displayId', Sort.desc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> sortByDriverId() {
    return addSortByInternal('driverId', Sort.asc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> sortByDriverIdDesc() {
    return addSortByInternal('driverId', Sort.desc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> sortByFarePerPerson() {
    return addSortByInternal('farePerPerson', Sort.asc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy>
      sortByFarePerPersonDesc() {
    return addSortByInternal('farePerPerson', Sort.desc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> sortByFareTotal() {
    return addSortByInternal('fareTotal', Sort.asc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> sortByFareTotalDesc() {
    return addSortByInternal('fareTotal', Sort.desc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> sortByIsPriority() {
    return addSortByInternal('isPriority', Sort.asc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy>
      sortByIsPriorityDesc() {
    return addSortByInternal('isPriority', Sort.desc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> sortByIsarId() {
    return addSortByInternal('isarId', Sort.asc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> sortByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.desc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> sortByOriginAddress() {
    return addSortByInternal('originAddress', Sort.asc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy>
      sortByOriginAddressDesc() {
    return addSortByInternal('originAddress', Sort.desc);
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

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy>
      sortBySignupDeadline() {
    return addSortByInternal('signupDeadline', Sort.asc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy>
      sortBySignupDeadlineDesc() {
    return addSortByInternal('signupDeadline', Sort.desc);
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
  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> thenByArriveAt() {
    return addSortByInternal('arriveAt', Sort.asc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> thenByArriveAtDesc() {
    return addSortByInternal('arriveAt', Sort.desc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> thenByCapacity() {
    return addSortByInternal('capacity', Sort.asc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> thenByCapacityDesc() {
    return addSortByInternal('capacity', Sort.desc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> thenByContactName() {
    return addSortByInternal('contactName', Sort.asc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy>
      thenByContactNameDesc() {
    return addSortByInternal('contactName', Sort.desc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy>
      thenByContactPhoneMasked() {
    return addSortByInternal('contactPhoneMasked', Sort.asc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy>
      thenByContactPhoneMaskedDesc() {
    return addSortByInternal('contactPhoneMasked', Sort.desc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> thenByCostType() {
    return addSortByInternal('costType', Sort.asc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> thenByCostTypeDesc() {
    return addSortByInternal('costType', Sort.desc);
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

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy>
      thenByDestinationAddress() {
    return addSortByInternal('destinationAddress', Sort.asc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy>
      thenByDestinationAddressDesc() {
    return addSortByInternal('destinationAddress', Sort.desc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> thenByDisplayId() {
    return addSortByInternal('displayId', Sort.asc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> thenByDisplayIdDesc() {
    return addSortByInternal('displayId', Sort.desc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> thenByDriverId() {
    return addSortByInternal('driverId', Sort.asc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> thenByDriverIdDesc() {
    return addSortByInternal('driverId', Sort.desc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> thenByFarePerPerson() {
    return addSortByInternal('farePerPerson', Sort.asc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy>
      thenByFarePerPersonDesc() {
    return addSortByInternal('farePerPerson', Sort.desc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> thenByFareTotal() {
    return addSortByInternal('fareTotal', Sort.asc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> thenByFareTotalDesc() {
    return addSortByInternal('fareTotal', Sort.desc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> thenByIsPriority() {
    return addSortByInternal('isPriority', Sort.asc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy>
      thenByIsPriorityDesc() {
    return addSortByInternal('isPriority', Sort.desc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> thenByIsarId() {
    return addSortByInternal('isarId', Sort.asc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> thenByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.desc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy> thenByOriginAddress() {
    return addSortByInternal('originAddress', Sort.asc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy>
      thenByOriginAddressDesc() {
    return addSortByInternal('originAddress', Sort.desc);
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

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy>
      thenBySignupDeadline() {
    return addSortByInternal('signupDeadline', Sort.asc);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QAfterSortBy>
      thenBySignupDeadlineDesc() {
    return addSortByInternal('signupDeadline', Sort.desc);
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
  QueryBuilder<ShuttleModel, ShuttleModel, QDistinct> distinctByArriveAt() {
    return addDistinctByInternal('arriveAt');
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QDistinct> distinctByCapacity() {
    return addDistinctByInternal('capacity');
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QDistinct> distinctByContactName(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('contactName', caseSensitive: caseSensitive);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QDistinct>
      distinctByContactPhoneMasked({bool caseSensitive = true}) {
    return addDistinctByInternal('contactPhoneMasked',
        caseSensitive: caseSensitive);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QDistinct> distinctByCostType(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('costType', caseSensitive: caseSensitive);
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

  QueryBuilder<ShuttleModel, ShuttleModel, QDistinct>
      distinctByDestinationAddress({bool caseSensitive = true}) {
    return addDistinctByInternal('destinationAddress',
        caseSensitive: caseSensitive);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QDistinct> distinctByDisplayId(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('displayId', caseSensitive: caseSensitive);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QDistinct> distinctByDriverId(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('driverId', caseSensitive: caseSensitive);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QDistinct>
      distinctByFarePerPerson() {
    return addDistinctByInternal('farePerPerson');
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QDistinct> distinctByFareTotal() {
    return addDistinctByInternal('fareTotal');
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QDistinct> distinctById(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('id', caseSensitive: caseSensitive);
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QDistinct> distinctByIsPriority() {
    return addDistinctByInternal('isPriority');
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QDistinct> distinctByIsarId() {
    return addDistinctByInternal('isarId');
  }

  QueryBuilder<ShuttleModel, ShuttleModel, QDistinct> distinctByOriginAddress(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('originAddress', caseSensitive: caseSensitive);
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

  QueryBuilder<ShuttleModel, ShuttleModel, QDistinct>
      distinctBySignupDeadline() {
    return addDistinctByInternal('signupDeadline');
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
  QueryBuilder<ShuttleModel, DateTime?, QQueryOperations> arriveAtProperty() {
    return addPropertyNameInternal('arriveAt');
  }

  QueryBuilder<ShuttleModel, int, QQueryOperations> capacityProperty() {
    return addPropertyNameInternal('capacity');
  }

  QueryBuilder<ShuttleModel, String?, QQueryOperations> contactNameProperty() {
    return addPropertyNameInternal('contactName');
  }

  QueryBuilder<ShuttleModel, String?, QQueryOperations>
      contactPhoneMaskedProperty() {
    return addPropertyNameInternal('contactPhoneMasked');
  }

  QueryBuilder<ShuttleModel, String, QQueryOperations> costTypeProperty() {
    return addPropertyNameInternal('costType');
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

  QueryBuilder<ShuttleModel, String?, QQueryOperations>
      destinationAddressProperty() {
    return addPropertyNameInternal('destinationAddress');
  }

  QueryBuilder<ShuttleModel, String?, QQueryOperations> displayIdProperty() {
    return addPropertyNameInternal('displayId');
  }

  QueryBuilder<ShuttleModel, String?, QQueryOperations> driverIdProperty() {
    return addPropertyNameInternal('driverId');
  }

  QueryBuilder<ShuttleModel, double?, QQueryOperations>
      farePerPersonProperty() {
    return addPropertyNameInternal('farePerPerson');
  }

  QueryBuilder<ShuttleModel, double?, QQueryOperations> fareTotalProperty() {
    return addPropertyNameInternal('fareTotal');
  }

  QueryBuilder<ShuttleModel, String, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<ShuttleModel, bool, QQueryOperations> isPriorityProperty() {
    return addPropertyNameInternal('isPriority');
  }

  QueryBuilder<ShuttleModel, int?, QQueryOperations> isarIdProperty() {
    return addPropertyNameInternal('isarId');
  }

  QueryBuilder<ShuttleModel, String?, QQueryOperations>
      originAddressProperty() {
    return addPropertyNameInternal('originAddress');
  }

  QueryBuilder<ShuttleModel, List<String>, QQueryOperations>
      participantIdsProperty() {
    return addPropertyNameInternal('participantIds');
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

  QueryBuilder<ShuttleModel, DateTime?, QQueryOperations>
      signupDeadlineProperty() {
    return addPropertyNameInternal('signupDeadline');
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
      displayId: json['display_id'] as String?,
      title: json['title'] as String,
      description: json['description'] as String?,
      status: json['status'] as String? ?? 'Scheduled',
      routeStartLat: (json['route_start_lat'] as num?)?.toDouble(),
      routeStartLng: (json['route_start_lng'] as num?)?.toDouble(),
      routeEndLat: (json['route_end_lat'] as num?)?.toDouble(),
      routeEndLng: (json['route_end_lng'] as num?)?.toDouble(),
      originAddress: json['origin_address'] as String?,
      destinationAddress: json['destination_address'] as String?,
      departureTime: json['departure_time'] == null
          ? null
          : DateTime.parse(json['departure_time'] as String),
      arriveAt: json['arrive_at'] == null
          ? null
          : DateTime.parse(json['arrive_at'] as String),
      signupDeadline: json['signup_deadline'] == null
          ? null
          : DateTime.parse(json['signup_deadline'] as String),
      costType: json['cost_type'] as String? ?? 'free',
      fareTotal: (json['fare_total'] as num?)?.toDouble(),
      farePerPerson: (json['fare_per_person'] as num?)?.toDouble(),
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
      vehicle: json['vehicle'] as Map<String, dynamic>?,
      contactName: json['contact_name'] as String?,
      contactPhoneMasked: json['contact_phone_masked'] as String?,
      participantIds: (json['participants'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      isPriority: json['is_priority'] as bool? ?? false,
    );

Map<String, dynamic> _$$ShuttleModelImplToJson(_$ShuttleModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'display_id': instance.displayId,
      'title': instance.title,
      'description': instance.description,
      'status': instance.status,
      'route_start_lat': instance.routeStartLat,
      'route_start_lng': instance.routeStartLng,
      'route_end_lat': instance.routeEndLat,
      'route_end_lng': instance.routeEndLng,
      'origin_address': instance.originAddress,
      'destination_address': instance.destinationAddress,
      'departure_time': instance.departureTime?.toIso8601String(),
      'arrive_at': instance.arriveAt?.toIso8601String(),
      'signup_deadline': instance.signupDeadline?.toIso8601String(),
      'cost_type': instance.costType,
      'fare_total': instance.fareTotal,
      'fare_per_person': instance.farePerPerson,
      'capacity': instance.capacity,
      'seats_taken': instance.seatsTaken,
      'driver_id': instance.driverId,
      'created_by': instance.createdBy,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'vehicle': instance.vehicle,
      'contact_name': instance.contactName,
      'contact_phone_masked': instance.contactPhoneMasked,
      'participants': instance.participantIds,
      'is_priority': instance.isPriority,
    };
