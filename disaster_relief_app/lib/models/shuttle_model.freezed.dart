// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shuttle_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ShuttleModel _$ShuttleModelFromJson(Map<String, dynamic> json) {
  return _ShuttleModel.fromJson(json);
}

/// @nodoc
mixin _$ShuttleModel {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String get status =>
      throw _privateConstructorUsedError; // Scheduled, En Route, Arrived, Cancelled
  @JsonKey(name: 'route_start_lat')
  double? get routeStartLat => throw _privateConstructorUsedError;
  @JsonKey(name: 'route_start_lng')
  double? get routeStartLng => throw _privateConstructorUsedError;
  @JsonKey(name: 'route_end_lat')
  double? get routeEndLat => throw _privateConstructorUsedError;
  @JsonKey(name: 'route_end_lng')
  double? get routeEndLng => throw _privateConstructorUsedError;
  @JsonKey(name: 'origin_address')
  String? get originAddress => throw _privateConstructorUsedError;
  @JsonKey(name: 'destination_address')
  String? get destinationAddress => throw _privateConstructorUsedError;
  @JsonKey(name: 'departure_time')
  DateTime? get departureTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'signup_deadline')
  DateTime? get signupDeadline => throw _privateConstructorUsedError;
  @JsonKey(name: 'cost_type')
  String get costType => throw _privateConstructorUsedError;
  @JsonKey(name: 'fare_total')
  double? get fareTotal => throw _privateConstructorUsedError;
  @JsonKey(name: 'fare_per_person')
  double? get farePerPerson => throw _privateConstructorUsedError;
  int get capacity => throw _privateConstructorUsedError;
  @JsonKey(name: 'seats_taken')
  int get seatsTaken => throw _privateConstructorUsedError;
  @JsonKey(name: 'driver_id')
  String? get driverId => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_by')
  String? get createdBy => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  @Id()
  int? get isarId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ShuttleModelCopyWith<ShuttleModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShuttleModelCopyWith<$Res> {
  factory $ShuttleModelCopyWith(
          ShuttleModel value, $Res Function(ShuttleModel) then) =
      _$ShuttleModelCopyWithImpl<$Res, ShuttleModel>;
  @useResult
  $Res call(
      {String id,
      String title,
      String? description,
      String status,
      @JsonKey(name: 'route_start_lat') double? routeStartLat,
      @JsonKey(name: 'route_start_lng') double? routeStartLng,
      @JsonKey(name: 'route_end_lat') double? routeEndLat,
      @JsonKey(name: 'route_end_lng') double? routeEndLng,
      @JsonKey(name: 'origin_address') String? originAddress,
      @JsonKey(name: 'destination_address') String? destinationAddress,
      @JsonKey(name: 'departure_time') DateTime? departureTime,
      @JsonKey(name: 'signup_deadline') DateTime? signupDeadline,
      @JsonKey(name: 'cost_type') String costType,
      @JsonKey(name: 'fare_total') double? fareTotal,
      @JsonKey(name: 'fare_per_person') double? farePerPerson,
      int capacity,
      @JsonKey(name: 'seats_taken') int seatsTaken,
      @JsonKey(name: 'driver_id') String? driverId,
      @JsonKey(name: 'created_by') String? createdBy,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt,
      @JsonKey(ignore: true) @Id() int? isarId});
}

/// @nodoc
class _$ShuttleModelCopyWithImpl<$Res, $Val extends ShuttleModel>
    implements $ShuttleModelCopyWith<$Res> {
  _$ShuttleModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = freezed,
    Object? status = null,
    Object? routeStartLat = freezed,
    Object? routeStartLng = freezed,
    Object? routeEndLat = freezed,
    Object? routeEndLng = freezed,
    Object? originAddress = freezed,
    Object? destinationAddress = freezed,
    Object? departureTime = freezed,
    Object? signupDeadline = freezed,
    Object? costType = null,
    Object? fareTotal = freezed,
    Object? farePerPerson = freezed,
    Object? capacity = null,
    Object? seatsTaken = null,
    Object? driverId = freezed,
    Object? createdBy = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? isarId = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      routeStartLat: freezed == routeStartLat
          ? _value.routeStartLat
          : routeStartLat // ignore: cast_nullable_to_non_nullable
              as double?,
      routeStartLng: freezed == routeStartLng
          ? _value.routeStartLng
          : routeStartLng // ignore: cast_nullable_to_non_nullable
              as double?,
      routeEndLat: freezed == routeEndLat
          ? _value.routeEndLat
          : routeEndLat // ignore: cast_nullable_to_non_nullable
              as double?,
      routeEndLng: freezed == routeEndLng
          ? _value.routeEndLng
          : routeEndLng // ignore: cast_nullable_to_non_nullable
              as double?,
      originAddress: freezed == originAddress
          ? _value.originAddress
          : originAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      destinationAddress: freezed == destinationAddress
          ? _value.destinationAddress
          : destinationAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      departureTime: freezed == departureTime
          ? _value.departureTime
          : departureTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      signupDeadline: freezed == signupDeadline
          ? _value.signupDeadline
          : signupDeadline // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      costType: null == costType
          ? _value.costType
          : costType // ignore: cast_nullable_to_non_nullable
              as String,
      fareTotal: freezed == fareTotal
          ? _value.fareTotal
          : fareTotal // ignore: cast_nullable_to_non_nullable
              as double?,
      farePerPerson: freezed == farePerPerson
          ? _value.farePerPerson
          : farePerPerson // ignore: cast_nullable_to_non_nullable
              as double?,
      capacity: null == capacity
          ? _value.capacity
          : capacity // ignore: cast_nullable_to_non_nullable
              as int,
      seatsTaken: null == seatsTaken
          ? _value.seatsTaken
          : seatsTaken // ignore: cast_nullable_to_non_nullable
              as int,
      driverId: freezed == driverId
          ? _value.driverId
          : driverId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isarId: freezed == isarId
          ? _value.isarId
          : isarId // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ShuttleModelImplCopyWith<$Res>
    implements $ShuttleModelCopyWith<$Res> {
  factory _$$ShuttleModelImplCopyWith(
          _$ShuttleModelImpl value, $Res Function(_$ShuttleModelImpl) then) =
      __$$ShuttleModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String? description,
      String status,
      @JsonKey(name: 'route_start_lat') double? routeStartLat,
      @JsonKey(name: 'route_start_lng') double? routeStartLng,
      @JsonKey(name: 'route_end_lat') double? routeEndLat,
      @JsonKey(name: 'route_end_lng') double? routeEndLng,
      @JsonKey(name: 'origin_address') String? originAddress,
      @JsonKey(name: 'destination_address') String? destinationAddress,
      @JsonKey(name: 'departure_time') DateTime? departureTime,
      @JsonKey(name: 'signup_deadline') DateTime? signupDeadline,
      @JsonKey(name: 'cost_type') String costType,
      @JsonKey(name: 'fare_total') double? fareTotal,
      @JsonKey(name: 'fare_per_person') double? farePerPerson,
      int capacity,
      @JsonKey(name: 'seats_taken') int seatsTaken,
      @JsonKey(name: 'driver_id') String? driverId,
      @JsonKey(name: 'created_by') String? createdBy,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt,
      @JsonKey(ignore: true) @Id() int? isarId});
}

/// @nodoc
class __$$ShuttleModelImplCopyWithImpl<$Res>
    extends _$ShuttleModelCopyWithImpl<$Res, _$ShuttleModelImpl>
    implements _$$ShuttleModelImplCopyWith<$Res> {
  __$$ShuttleModelImplCopyWithImpl(
      _$ShuttleModelImpl _value, $Res Function(_$ShuttleModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = freezed,
    Object? status = null,
    Object? routeStartLat = freezed,
    Object? routeStartLng = freezed,
    Object? routeEndLat = freezed,
    Object? routeEndLng = freezed,
    Object? originAddress = freezed,
    Object? destinationAddress = freezed,
    Object? departureTime = freezed,
    Object? signupDeadline = freezed,
    Object? costType = null,
    Object? fareTotal = freezed,
    Object? farePerPerson = freezed,
    Object? capacity = null,
    Object? seatsTaken = null,
    Object? driverId = freezed,
    Object? createdBy = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? isarId = freezed,
  }) {
    return _then(_$ShuttleModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      routeStartLat: freezed == routeStartLat
          ? _value.routeStartLat
          : routeStartLat // ignore: cast_nullable_to_non_nullable
              as double?,
      routeStartLng: freezed == routeStartLng
          ? _value.routeStartLng
          : routeStartLng // ignore: cast_nullable_to_non_nullable
              as double?,
      routeEndLat: freezed == routeEndLat
          ? _value.routeEndLat
          : routeEndLat // ignore: cast_nullable_to_non_nullable
              as double?,
      routeEndLng: freezed == routeEndLng
          ? _value.routeEndLng
          : routeEndLng // ignore: cast_nullable_to_non_nullable
              as double?,
      originAddress: freezed == originAddress
          ? _value.originAddress
          : originAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      destinationAddress: freezed == destinationAddress
          ? _value.destinationAddress
          : destinationAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      departureTime: freezed == departureTime
          ? _value.departureTime
          : departureTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      signupDeadline: freezed == signupDeadline
          ? _value.signupDeadline
          : signupDeadline // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      costType: null == costType
          ? _value.costType
          : costType // ignore: cast_nullable_to_non_nullable
              as String,
      fareTotal: freezed == fareTotal
          ? _value.fareTotal
          : fareTotal // ignore: cast_nullable_to_non_nullable
              as double?,
      farePerPerson: freezed == farePerPerson
          ? _value.farePerPerson
          : farePerPerson // ignore: cast_nullable_to_non_nullable
              as double?,
      capacity: null == capacity
          ? _value.capacity
          : capacity // ignore: cast_nullable_to_non_nullable
              as int,
      seatsTaken: null == seatsTaken
          ? _value.seatsTaken
          : seatsTaken // ignore: cast_nullable_to_non_nullable
              as int,
      driverId: freezed == driverId
          ? _value.driverId
          : driverId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isarId: freezed == isarId
          ? _value.isarId
          : isarId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ShuttleModelImpl extends _ShuttleModel {
  const _$ShuttleModelImpl(
      {required this.id,
      required this.title,
      this.description,
      this.status = 'Scheduled',
      @JsonKey(name: 'route_start_lat') this.routeStartLat,
      @JsonKey(name: 'route_start_lng') this.routeStartLng,
      @JsonKey(name: 'route_end_lat') this.routeEndLat,
      @JsonKey(name: 'route_end_lng') this.routeEndLng,
      @JsonKey(name: 'origin_address') this.originAddress,
      @JsonKey(name: 'destination_address') this.destinationAddress,
      @JsonKey(name: 'departure_time') this.departureTime,
      @JsonKey(name: 'signup_deadline') this.signupDeadline,
      @JsonKey(name: 'cost_type') this.costType = 'free',
      @JsonKey(name: 'fare_total') this.fareTotal,
      @JsonKey(name: 'fare_per_person') this.farePerPerson,
      this.capacity = 0,
      @JsonKey(name: 'seats_taken') this.seatsTaken = 0,
      @JsonKey(name: 'driver_id') this.driverId,
      @JsonKey(name: 'created_by') this.createdBy,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt,
      @JsonKey(ignore: true) @Id() this.isarId})
      : super._();

  factory _$ShuttleModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShuttleModelImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String? description;
  @override
  @JsonKey()
  final String status;
// Scheduled, En Route, Arrived, Cancelled
  @override
  @JsonKey(name: 'route_start_lat')
  final double? routeStartLat;
  @override
  @JsonKey(name: 'route_start_lng')
  final double? routeStartLng;
  @override
  @JsonKey(name: 'route_end_lat')
  final double? routeEndLat;
  @override
  @JsonKey(name: 'route_end_lng')
  final double? routeEndLng;
  @override
  @JsonKey(name: 'origin_address')
  final String? originAddress;
  @override
  @JsonKey(name: 'destination_address')
  final String? destinationAddress;
  @override
  @JsonKey(name: 'departure_time')
  final DateTime? departureTime;
  @override
  @JsonKey(name: 'signup_deadline')
  final DateTime? signupDeadline;
  @override
  @JsonKey(name: 'cost_type')
  final String costType;
  @override
  @JsonKey(name: 'fare_total')
  final double? fareTotal;
  @override
  @JsonKey(name: 'fare_per_person')
  final double? farePerPerson;
  @override
  @JsonKey()
  final int capacity;
  @override
  @JsonKey(name: 'seats_taken')
  final int seatsTaken;
  @override
  @JsonKey(name: 'driver_id')
  final String? driverId;
  @override
  @JsonKey(name: 'created_by')
  final String? createdBy;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
  @override
  @JsonKey(ignore: true)
  @Id()
  final int? isarId;

  @override
  String toString() {
    return 'ShuttleModel(id: $id, title: $title, description: $description, status: $status, routeStartLat: $routeStartLat, routeStartLng: $routeStartLng, routeEndLat: $routeEndLat, routeEndLng: $routeEndLng, originAddress: $originAddress, destinationAddress: $destinationAddress, departureTime: $departureTime, signupDeadline: $signupDeadline, costType: $costType, fareTotal: $fareTotal, farePerPerson: $farePerPerson, capacity: $capacity, seatsTaken: $seatsTaken, driverId: $driverId, createdBy: $createdBy, createdAt: $createdAt, updatedAt: $updatedAt, isarId: $isarId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShuttleModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.routeStartLat, routeStartLat) ||
                other.routeStartLat == routeStartLat) &&
            (identical(other.routeStartLng, routeStartLng) ||
                other.routeStartLng == routeStartLng) &&
            (identical(other.routeEndLat, routeEndLat) ||
                other.routeEndLat == routeEndLat) &&
            (identical(other.routeEndLng, routeEndLng) ||
                other.routeEndLng == routeEndLng) &&
            (identical(other.originAddress, originAddress) ||
                other.originAddress == originAddress) &&
            (identical(other.destinationAddress, destinationAddress) ||
                other.destinationAddress == destinationAddress) &&
            (identical(other.departureTime, departureTime) ||
                other.departureTime == departureTime) &&
            (identical(other.signupDeadline, signupDeadline) ||
                other.signupDeadline == signupDeadline) &&
            (identical(other.costType, costType) ||
                other.costType == costType) &&
            (identical(other.fareTotal, fareTotal) ||
                other.fareTotal == fareTotal) &&
            (identical(other.farePerPerson, farePerPerson) ||
                other.farePerPerson == farePerPerson) &&
            (identical(other.capacity, capacity) ||
                other.capacity == capacity) &&
            (identical(other.seatsTaken, seatsTaken) ||
                other.seatsTaken == seatsTaken) &&
            (identical(other.driverId, driverId) ||
                other.driverId == driverId) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.isarId, isarId) || other.isarId == isarId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        title,
        description,
        status,
        routeStartLat,
        routeStartLng,
        routeEndLat,
        routeEndLng,
        originAddress,
        destinationAddress,
        departureTime,
        signupDeadline,
        costType,
        fareTotal,
        farePerPerson,
        capacity,
        seatsTaken,
        driverId,
        createdBy,
        createdAt,
        updatedAt,
        isarId
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ShuttleModelImplCopyWith<_$ShuttleModelImpl> get copyWith =>
      __$$ShuttleModelImplCopyWithImpl<_$ShuttleModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ShuttleModelImplToJson(
      this,
    );
  }
}

abstract class _ShuttleModel extends ShuttleModel {
  const factory _ShuttleModel(
      {required final String id,
      required final String title,
      final String? description,
      final String status,
      @JsonKey(name: 'route_start_lat') final double? routeStartLat,
      @JsonKey(name: 'route_start_lng') final double? routeStartLng,
      @JsonKey(name: 'route_end_lat') final double? routeEndLat,
      @JsonKey(name: 'route_end_lng') final double? routeEndLng,
      @JsonKey(name: 'origin_address') final String? originAddress,
      @JsonKey(name: 'destination_address') final String? destinationAddress,
      @JsonKey(name: 'departure_time') final DateTime? departureTime,
      @JsonKey(name: 'signup_deadline') final DateTime? signupDeadline,
      @JsonKey(name: 'cost_type') final String costType,
      @JsonKey(name: 'fare_total') final double? fareTotal,
      @JsonKey(name: 'fare_per_person') final double? farePerPerson,
      final int capacity,
      @JsonKey(name: 'seats_taken') final int seatsTaken,
      @JsonKey(name: 'driver_id') final String? driverId,
      @JsonKey(name: 'created_by') final String? createdBy,
      @JsonKey(name: 'created_at') final DateTime? createdAt,
      @JsonKey(name: 'updated_at') final DateTime? updatedAt,
      @JsonKey(ignore: true) @Id() final int? isarId}) = _$ShuttleModelImpl;
  const _ShuttleModel._() : super._();

  factory _ShuttleModel.fromJson(Map<String, dynamic> json) =
      _$ShuttleModelImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String? get description;
  @override
  String get status;
  @override // Scheduled, En Route, Arrived, Cancelled
  @JsonKey(name: 'route_start_lat')
  double? get routeStartLat;
  @override
  @JsonKey(name: 'route_start_lng')
  double? get routeStartLng;
  @override
  @JsonKey(name: 'route_end_lat')
  double? get routeEndLat;
  @override
  @JsonKey(name: 'route_end_lng')
  double? get routeEndLng;
  @override
  @JsonKey(name: 'origin_address')
  String? get originAddress;
  @override
  @JsonKey(name: 'destination_address')
  String? get destinationAddress;
  @override
  @JsonKey(name: 'departure_time')
  DateTime? get departureTime;
  @override
  @JsonKey(name: 'signup_deadline')
  DateTime? get signupDeadline;
  @override
  @JsonKey(name: 'cost_type')
  String get costType;
  @override
  @JsonKey(name: 'fare_total')
  double? get fareTotal;
  @override
  @JsonKey(name: 'fare_per_person')
  double? get farePerPerson;
  @override
  int get capacity;
  @override
  @JsonKey(name: 'seats_taken')
  int get seatsTaken;
  @override
  @JsonKey(name: 'driver_id')
  String? get driverId;
  @override
  @JsonKey(name: 'created_by')
  String? get createdBy;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  @Id()
  int? get isarId;
  @override
  @JsonKey(ignore: true)
  _$$ShuttleModelImplCopyWith<_$ShuttleModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
