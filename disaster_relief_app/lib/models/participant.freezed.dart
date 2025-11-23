// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'participant.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Participant _$ParticipantFromJson(Map<String, dynamic> json) {
  return _Participant.fromJson(json);
}

/// @nodoc
mixin _$Participant {
  @JsonKey(name: 'entity_id')
  String get entityId => throw _privateConstructorUsedError;
  @JsonKey(name: 'entity_type')
  String get entityType =>
      throw _privateConstructorUsedError; // 'mission' or 'shuttle'
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  String get role =>
      throw _privateConstructorUsedError; // 'driver', 'passenger', 'helper', 'commander'
  String get status =>
      throw _privateConstructorUsedError; // 'joined', 'waitlist', 'approved'
  @JsonKey(name: 'is_contact_visible')
  bool get isContactVisible => throw _privateConstructorUsedError;
  @JsonKey(name: 'joined_at')
  DateTime? get joinedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ParticipantCopyWith<Participant> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ParticipantCopyWith<$Res> {
  factory $ParticipantCopyWith(
          Participant value, $Res Function(Participant) then) =
      _$ParticipantCopyWithImpl<$Res, Participant>;
  @useResult
  $Res call(
      {@JsonKey(name: 'entity_id') String entityId,
      @JsonKey(name: 'entity_type') String entityType,
      @JsonKey(name: 'user_id') String userId,
      String role,
      String status,
      @JsonKey(name: 'is_contact_visible') bool isContactVisible,
      @JsonKey(name: 'joined_at') DateTime? joinedAt});
}

/// @nodoc
class _$ParticipantCopyWithImpl<$Res, $Val extends Participant>
    implements $ParticipantCopyWith<$Res> {
  _$ParticipantCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? entityId = null,
    Object? entityType = null,
    Object? userId = null,
    Object? role = null,
    Object? status = null,
    Object? isContactVisible = null,
    Object? joinedAt = freezed,
  }) {
    return _then(_value.copyWith(
      entityId: null == entityId
          ? _value.entityId
          : entityId // ignore: cast_nullable_to_non_nullable
              as String,
      entityType: null == entityType
          ? _value.entityType
          : entityType // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      isContactVisible: null == isContactVisible
          ? _value.isContactVisible
          : isContactVisible // ignore: cast_nullable_to_non_nullable
              as bool,
      joinedAt: freezed == joinedAt
          ? _value.joinedAt
          : joinedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ParticipantImplCopyWith<$Res>
    implements $ParticipantCopyWith<$Res> {
  factory _$$ParticipantImplCopyWith(
          _$ParticipantImpl value, $Res Function(_$ParticipantImpl) then) =
      __$$ParticipantImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'entity_id') String entityId,
      @JsonKey(name: 'entity_type') String entityType,
      @JsonKey(name: 'user_id') String userId,
      String role,
      String status,
      @JsonKey(name: 'is_contact_visible') bool isContactVisible,
      @JsonKey(name: 'joined_at') DateTime? joinedAt});
}

/// @nodoc
class __$$ParticipantImplCopyWithImpl<$Res>
    extends _$ParticipantCopyWithImpl<$Res, _$ParticipantImpl>
    implements _$$ParticipantImplCopyWith<$Res> {
  __$$ParticipantImplCopyWithImpl(
      _$ParticipantImpl _value, $Res Function(_$ParticipantImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? entityId = null,
    Object? entityType = null,
    Object? userId = null,
    Object? role = null,
    Object? status = null,
    Object? isContactVisible = null,
    Object? joinedAt = freezed,
  }) {
    return _then(_$ParticipantImpl(
      entityId: null == entityId
          ? _value.entityId
          : entityId // ignore: cast_nullable_to_non_nullable
              as String,
      entityType: null == entityType
          ? _value.entityType
          : entityType // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      isContactVisible: null == isContactVisible
          ? _value.isContactVisible
          : isContactVisible // ignore: cast_nullable_to_non_nullable
              as bool,
      joinedAt: freezed == joinedAt
          ? _value.joinedAt
          : joinedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ParticipantImpl implements _Participant {
  const _$ParticipantImpl(
      {@JsonKey(name: 'entity_id') required this.entityId,
      @JsonKey(name: 'entity_type') required this.entityType,
      @JsonKey(name: 'user_id') required this.userId,
      this.role = 'helper',
      this.status = 'joined',
      @JsonKey(name: 'is_contact_visible') this.isContactVisible = false,
      @JsonKey(name: 'joined_at') this.joinedAt});

  factory _$ParticipantImpl.fromJson(Map<String, dynamic> json) =>
      _$$ParticipantImplFromJson(json);

  @override
  @JsonKey(name: 'entity_id')
  final String entityId;
  @override
  @JsonKey(name: 'entity_type')
  final String entityType;
// 'mission' or 'shuttle'
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey()
  final String role;
// 'driver', 'passenger', 'helper', 'commander'
  @override
  @JsonKey()
  final String status;
// 'joined', 'waitlist', 'approved'
  @override
  @JsonKey(name: 'is_contact_visible')
  final bool isContactVisible;
  @override
  @JsonKey(name: 'joined_at')
  final DateTime? joinedAt;

  @override
  String toString() {
    return 'Participant(entityId: $entityId, entityType: $entityType, userId: $userId, role: $role, status: $status, isContactVisible: $isContactVisible, joinedAt: $joinedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ParticipantImpl &&
            (identical(other.entityId, entityId) ||
                other.entityId == entityId) &&
            (identical(other.entityType, entityType) ||
                other.entityType == entityType) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.isContactVisible, isContactVisible) ||
                other.isContactVisible == isContactVisible) &&
            (identical(other.joinedAt, joinedAt) ||
                other.joinedAt == joinedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, entityId, entityType, userId,
      role, status, isContactVisible, joinedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ParticipantImplCopyWith<_$ParticipantImpl> get copyWith =>
      __$$ParticipantImplCopyWithImpl<_$ParticipantImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ParticipantImplToJson(
      this,
    );
  }
}

abstract class _Participant implements Participant {
  const factory _Participant(
          {@JsonKey(name: 'entity_id') required final String entityId,
          @JsonKey(name: 'entity_type') required final String entityType,
          @JsonKey(name: 'user_id') required final String userId,
          final String role,
          final String status,
          @JsonKey(name: 'is_contact_visible') final bool isContactVisible,
          @JsonKey(name: 'joined_at') final DateTime? joinedAt}) =
      _$ParticipantImpl;

  factory _Participant.fromJson(Map<String, dynamic> json) =
      _$ParticipantImpl.fromJson;

  @override
  @JsonKey(name: 'entity_id')
  String get entityId;
  @override
  @JsonKey(name: 'entity_type')
  String get entityType;
  @override // 'mission' or 'shuttle'
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  String get role;
  @override // 'driver', 'passenger', 'helper', 'commander'
  String get status;
  @override // 'joined', 'waitlist', 'approved'
  @JsonKey(name: 'is_contact_visible')
  bool get isContactVisible;
  @override
  @JsonKey(name: 'joined_at')
  DateTime? get joinedAt;
  @override
  @JsonKey(ignore: true)
  _$$ParticipantImplCopyWith<_$ParticipantImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
