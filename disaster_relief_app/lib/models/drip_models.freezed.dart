// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'drip_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LocalizedText _$LocalizedTextFromJson(Map<String, dynamic> json) {
  return _LocalizedText.fromJson(json);
}

/// @nodoc
mixin _$LocalizedText {
  @JsonKey(name: 'zh-TW')
  String get zhTW => throw _privateConstructorUsedError;
  @JsonKey(name: 'en-US')
  String get enUS => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LocalizedTextCopyWith<LocalizedText> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocalizedTextCopyWith<$Res> {
  factory $LocalizedTextCopyWith(
          LocalizedText value, $Res Function(LocalizedText) then) =
      _$LocalizedTextCopyWithImpl<$Res, LocalizedText>;
  @useResult
  $Res call(
      {@JsonKey(name: 'zh-TW') String zhTW,
      @JsonKey(name: 'en-US') String enUS});
}

/// @nodoc
class _$LocalizedTextCopyWithImpl<$Res, $Val extends LocalizedText>
    implements $LocalizedTextCopyWith<$Res> {
  _$LocalizedTextCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? zhTW = null,
    Object? enUS = null,
  }) {
    return _then(_value.copyWith(
      zhTW: null == zhTW
          ? _value.zhTW
          : zhTW // ignore: cast_nullable_to_non_nullable
              as String,
      enUS: null == enUS
          ? _value.enUS
          : enUS // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LocalizedTextImplCopyWith<$Res>
    implements $LocalizedTextCopyWith<$Res> {
  factory _$$LocalizedTextImplCopyWith(
          _$LocalizedTextImpl value, $Res Function(_$LocalizedTextImpl) then) =
      __$$LocalizedTextImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'zh-TW') String zhTW,
      @JsonKey(name: 'en-US') String enUS});
}

/// @nodoc
class __$$LocalizedTextImplCopyWithImpl<$Res>
    extends _$LocalizedTextCopyWithImpl<$Res, _$LocalizedTextImpl>
    implements _$$LocalizedTextImplCopyWith<$Res> {
  __$$LocalizedTextImplCopyWithImpl(
      _$LocalizedTextImpl _value, $Res Function(_$LocalizedTextImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? zhTW = null,
    Object? enUS = null,
  }) {
    return _then(_$LocalizedTextImpl(
      zhTW: null == zhTW
          ? _value.zhTW
          : zhTW // ignore: cast_nullable_to_non_nullable
              as String,
      enUS: null == enUS
          ? _value.enUS
          : enUS // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LocalizedTextImpl implements _LocalizedText {
  const _$LocalizedTextImpl(
      {@JsonKey(name: 'zh-TW') required this.zhTW,
      @JsonKey(name: 'en-US') required this.enUS});

  factory _$LocalizedTextImpl.fromJson(Map<String, dynamic> json) =>
      _$$LocalizedTextImplFromJson(json);

  @override
  @JsonKey(name: 'zh-TW')
  final String zhTW;
  @override
  @JsonKey(name: 'en-US')
  final String enUS;

  @override
  String toString() {
    return 'LocalizedText(zhTW: $zhTW, enUS: $enUS)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocalizedTextImpl &&
            (identical(other.zhTW, zhTW) || other.zhTW == zhTW) &&
            (identical(other.enUS, enUS) || other.enUS == enUS));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, zhTW, enUS);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LocalizedTextImplCopyWith<_$LocalizedTextImpl> get copyWith =>
      __$$LocalizedTextImplCopyWithImpl<_$LocalizedTextImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LocalizedTextImplToJson(
      this,
    );
  }
}

abstract class _LocalizedText implements LocalizedText {
  const factory _LocalizedText(
          {@JsonKey(name: 'zh-TW') required final String zhTW,
          @JsonKey(name: 'en-US') required final String enUS}) =
      _$LocalizedTextImpl;

  factory _LocalizedText.fromJson(Map<String, dynamic> json) =
      _$LocalizedTextImpl.fromJson;

  @override
  @JsonKey(name: 'zh-TW')
  String get zhTW;
  @override
  @JsonKey(name: 'en-US')
  String get enUS;
  @override
  @JsonKey(ignore: true)
  _$$LocalizedTextImplCopyWith<_$LocalizedTextImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GeoLocation _$GeoLocationFromJson(Map<String, dynamic> json) {
  return _GeoLocation.fromJson(json);
}

/// @nodoc
mixin _$GeoLocation {
  double get lat => throw _privateConstructorUsedError;
  double get lng => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  String? get geohash => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GeoLocationCopyWith<GeoLocation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GeoLocationCopyWith<$Res> {
  factory $GeoLocationCopyWith(
          GeoLocation value, $Res Function(GeoLocation) then) =
      _$GeoLocationCopyWithImpl<$Res, GeoLocation>;
  @useResult
  $Res call({double lat, double lng, String address, String? geohash});
}

/// @nodoc
class _$GeoLocationCopyWithImpl<$Res, $Val extends GeoLocation>
    implements $GeoLocationCopyWith<$Res> {
  _$GeoLocationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lat = null,
    Object? lng = null,
    Object? address = null,
    Object? geohash = freezed,
  }) {
    return _then(_value.copyWith(
      lat: null == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      lng: null == lng
          ? _value.lng
          : lng // ignore: cast_nullable_to_non_nullable
              as double,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      geohash: freezed == geohash
          ? _value.geohash
          : geohash // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GeoLocationImplCopyWith<$Res>
    implements $GeoLocationCopyWith<$Res> {
  factory _$$GeoLocationImplCopyWith(
          _$GeoLocationImpl value, $Res Function(_$GeoLocationImpl) then) =
      __$$GeoLocationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double lat, double lng, String address, String? geohash});
}

/// @nodoc
class __$$GeoLocationImplCopyWithImpl<$Res>
    extends _$GeoLocationCopyWithImpl<$Res, _$GeoLocationImpl>
    implements _$$GeoLocationImplCopyWith<$Res> {
  __$$GeoLocationImplCopyWithImpl(
      _$GeoLocationImpl _value, $Res Function(_$GeoLocationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lat = null,
    Object? lng = null,
    Object? address = null,
    Object? geohash = freezed,
  }) {
    return _then(_$GeoLocationImpl(
      lat: null == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      lng: null == lng
          ? _value.lng
          : lng // ignore: cast_nullable_to_non_nullable
              as double,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      geohash: freezed == geohash
          ? _value.geohash
          : geohash // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GeoLocationImpl implements _GeoLocation {
  const _$GeoLocationImpl(
      {required this.lat,
      required this.lng,
      required this.address,
      this.geohash});

  factory _$GeoLocationImpl.fromJson(Map<String, dynamic> json) =>
      _$$GeoLocationImplFromJson(json);

  @override
  final double lat;
  @override
  final double lng;
  @override
  final String address;
  @override
  final String? geohash;

  @override
  String toString() {
    return 'GeoLocation(lat: $lat, lng: $lng, address: $address, geohash: $geohash)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GeoLocationImpl &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.lng, lng) || other.lng == lng) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.geohash, geohash) || other.geohash == geohash));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, lat, lng, address, geohash);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GeoLocationImplCopyWith<_$GeoLocationImpl> get copyWith =>
      __$$GeoLocationImplCopyWithImpl<_$GeoLocationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GeoLocationImplToJson(
      this,
    );
  }
}

abstract class _GeoLocation implements GeoLocation {
  const factory _GeoLocation(
      {required final double lat,
      required final double lng,
      required final String address,
      final String? geohash}) = _$GeoLocationImpl;

  factory _GeoLocation.fromJson(Map<String, dynamic> json) =
      _$GeoLocationImpl.fromJson;

  @override
  double get lat;
  @override
  double get lng;
  @override
  String get address;
  @override
  String? get geohash;
  @override
  @JsonKey(ignore: true)
  _$$GeoLocationImplCopyWith<_$GeoLocationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MissionRequirements _$MissionRequirementsFromJson(Map<String, dynamic> json) {
  return _MissionRequirements.fromJson(json);
}

/// @nodoc
mixin _$MissionRequirements {
  List<String> get materials => throw _privateConstructorUsedError;
  @JsonKey(name: 'manpower_needed')
  int get manpowerNeeded => throw _privateConstructorUsedError;
  @JsonKey(name: 'manpower_current')
  int get manpowerCurrent => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MissionRequirementsCopyWith<MissionRequirements> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MissionRequirementsCopyWith<$Res> {
  factory $MissionRequirementsCopyWith(
          MissionRequirements value, $Res Function(MissionRequirements) then) =
      _$MissionRequirementsCopyWithImpl<$Res, MissionRequirements>;
  @useResult
  $Res call(
      {List<String> materials,
      @JsonKey(name: 'manpower_needed') int manpowerNeeded,
      @JsonKey(name: 'manpower_current') int manpowerCurrent});
}

/// @nodoc
class _$MissionRequirementsCopyWithImpl<$Res, $Val extends MissionRequirements>
    implements $MissionRequirementsCopyWith<$Res> {
  _$MissionRequirementsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? materials = null,
    Object? manpowerNeeded = null,
    Object? manpowerCurrent = null,
  }) {
    return _then(_value.copyWith(
      materials: null == materials
          ? _value.materials
          : materials // ignore: cast_nullable_to_non_nullable
              as List<String>,
      manpowerNeeded: null == manpowerNeeded
          ? _value.manpowerNeeded
          : manpowerNeeded // ignore: cast_nullable_to_non_nullable
              as int,
      manpowerCurrent: null == manpowerCurrent
          ? _value.manpowerCurrent
          : manpowerCurrent // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MissionRequirementsImplCopyWith<$Res>
    implements $MissionRequirementsCopyWith<$Res> {
  factory _$$MissionRequirementsImplCopyWith(_$MissionRequirementsImpl value,
          $Res Function(_$MissionRequirementsImpl) then) =
      __$$MissionRequirementsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<String> materials,
      @JsonKey(name: 'manpower_needed') int manpowerNeeded,
      @JsonKey(name: 'manpower_current') int manpowerCurrent});
}

/// @nodoc
class __$$MissionRequirementsImplCopyWithImpl<$Res>
    extends _$MissionRequirementsCopyWithImpl<$Res, _$MissionRequirementsImpl>
    implements _$$MissionRequirementsImplCopyWith<$Res> {
  __$$MissionRequirementsImplCopyWithImpl(_$MissionRequirementsImpl _value,
      $Res Function(_$MissionRequirementsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? materials = null,
    Object? manpowerNeeded = null,
    Object? manpowerCurrent = null,
  }) {
    return _then(_$MissionRequirementsImpl(
      materials: null == materials
          ? _value._materials
          : materials // ignore: cast_nullable_to_non_nullable
              as List<String>,
      manpowerNeeded: null == manpowerNeeded
          ? _value.manpowerNeeded
          : manpowerNeeded // ignore: cast_nullable_to_non_nullable
              as int,
      manpowerCurrent: null == manpowerCurrent
          ? _value.manpowerCurrent
          : manpowerCurrent // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MissionRequirementsImpl implements _MissionRequirements {
  const _$MissionRequirementsImpl(
      {final List<String> materials = const <String>[],
      @JsonKey(name: 'manpower_needed') this.manpowerNeeded = 0,
      @JsonKey(name: 'manpower_current') this.manpowerCurrent = 0})
      : _materials = materials;

  factory _$MissionRequirementsImpl.fromJson(Map<String, dynamic> json) =>
      _$$MissionRequirementsImplFromJson(json);

  final List<String> _materials;
  @override
  @JsonKey()
  List<String> get materials {
    if (_materials is EqualUnmodifiableListView) return _materials;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_materials);
  }

  @override
  @JsonKey(name: 'manpower_needed')
  final int manpowerNeeded;
  @override
  @JsonKey(name: 'manpower_current')
  final int manpowerCurrent;

  @override
  String toString() {
    return 'MissionRequirements(materials: $materials, manpowerNeeded: $manpowerNeeded, manpowerCurrent: $manpowerCurrent)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MissionRequirementsImpl &&
            const DeepCollectionEquality()
                .equals(other._materials, _materials) &&
            (identical(other.manpowerNeeded, manpowerNeeded) ||
                other.manpowerNeeded == manpowerNeeded) &&
            (identical(other.manpowerCurrent, manpowerCurrent) ||
                other.manpowerCurrent == manpowerCurrent));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_materials),
      manpowerNeeded,
      manpowerCurrent);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MissionRequirementsImplCopyWith<_$MissionRequirementsImpl> get copyWith =>
      __$$MissionRequirementsImplCopyWithImpl<_$MissionRequirementsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MissionRequirementsImplToJson(
      this,
    );
  }
}

abstract class _MissionRequirements implements MissionRequirements {
  const factory _MissionRequirements(
          {final List<String> materials,
          @JsonKey(name: 'manpower_needed') final int manpowerNeeded,
          @JsonKey(name: 'manpower_current') final int manpowerCurrent}) =
      _$MissionRequirementsImpl;

  factory _MissionRequirements.fromJson(Map<String, dynamic> json) =
      _$MissionRequirementsImpl.fromJson;

  @override
  List<String> get materials;
  @override
  @JsonKey(name: 'manpower_needed')
  int get manpowerNeeded;
  @override
  @JsonKey(name: 'manpower_current')
  int get manpowerCurrent;
  @override
  @JsonKey(ignore: true)
  _$$MissionRequirementsImplCopyWith<_$MissionRequirementsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Mission _$MissionFromJson(Map<String, dynamic> json) {
  return _Mission.fromJson(json);
}

/// @nodoc
mixin _$Mission {
  String get id => throw _privateConstructorUsedError;
  LocalizedText get title => throw _privateConstructorUsedError;
  LocalizedText? get description => throw _privateConstructorUsedError;
  List<MissionType> get types => throw _privateConstructorUsedError;
  MissionStatus get status => throw _privateConstructorUsedError;
  bool get priority => throw _privateConstructorUsedError;
  MissionRequirements get requirements => throw _privateConstructorUsedError;
  GeoLocation get location => throw _privateConstructorUsedError;
  @JsonKey(name: 'contact_name')
  String? get contactName => throw _privateConstructorUsedError;
  @JsonKey(name: 'contact_phone_masked')
  String? get contactPhoneMasked => throw _privateConstructorUsedError;
  @JsonKey(name: 'creator_id')
  String get creatorId => throw _privateConstructorUsedError;
  @JsonKey(name: 'chat_room_id')
  String? get chatRoomId => throw _privateConstructorUsedError;
  @JsonKey(name: 'participant_count')
  int get participantCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MissionCopyWith<Mission> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MissionCopyWith<$Res> {
  factory $MissionCopyWith(Mission value, $Res Function(Mission) then) =
      _$MissionCopyWithImpl<$Res, Mission>;
  @useResult
  $Res call(
      {String id,
      LocalizedText title,
      LocalizedText? description,
      List<MissionType> types,
      MissionStatus status,
      bool priority,
      MissionRequirements requirements,
      GeoLocation location,
      @JsonKey(name: 'contact_name') String? contactName,
      @JsonKey(name: 'contact_phone_masked') String? contactPhoneMasked,
      @JsonKey(name: 'creator_id') String creatorId,
      @JsonKey(name: 'chat_room_id') String? chatRoomId,
      @JsonKey(name: 'participant_count') int participantCount,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt});

  $LocalizedTextCopyWith<$Res> get title;
  $LocalizedTextCopyWith<$Res>? get description;
  $MissionRequirementsCopyWith<$Res> get requirements;
  $GeoLocationCopyWith<$Res> get location;
}

/// @nodoc
class _$MissionCopyWithImpl<$Res, $Val extends Mission>
    implements $MissionCopyWith<$Res> {
  _$MissionCopyWithImpl(this._value, this._then);

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
    Object? types = null,
    Object? status = null,
    Object? priority = null,
    Object? requirements = null,
    Object? location = null,
    Object? contactName = freezed,
    Object? contactPhoneMasked = freezed,
    Object? creatorId = null,
    Object? chatRoomId = freezed,
    Object? participantCount = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as LocalizedText,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as LocalizedText?,
      types: null == types
          ? _value.types
          : types // ignore: cast_nullable_to_non_nullable
              as List<MissionType>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as MissionStatus,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as bool,
      requirements: null == requirements
          ? _value.requirements
          : requirements // ignore: cast_nullable_to_non_nullable
              as MissionRequirements,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as GeoLocation,
      contactName: freezed == contactName
          ? _value.contactName
          : contactName // ignore: cast_nullable_to_non_nullable
              as String?,
      contactPhoneMasked: freezed == contactPhoneMasked
          ? _value.contactPhoneMasked
          : contactPhoneMasked // ignore: cast_nullable_to_non_nullable
              as String?,
      creatorId: null == creatorId
          ? _value.creatorId
          : creatorId // ignore: cast_nullable_to_non_nullable
              as String,
      chatRoomId: freezed == chatRoomId
          ? _value.chatRoomId
          : chatRoomId // ignore: cast_nullable_to_non_nullable
              as String?,
      participantCount: null == participantCount
          ? _value.participantCount
          : participantCount // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $LocalizedTextCopyWith<$Res> get title {
    return $LocalizedTextCopyWith<$Res>(_value.title, (value) {
      return _then(_value.copyWith(title: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $LocalizedTextCopyWith<$Res>? get description {
    if (_value.description == null) {
      return null;
    }

    return $LocalizedTextCopyWith<$Res>(_value.description!, (value) {
      return _then(_value.copyWith(description: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $MissionRequirementsCopyWith<$Res> get requirements {
    return $MissionRequirementsCopyWith<$Res>(_value.requirements, (value) {
      return _then(_value.copyWith(requirements: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $GeoLocationCopyWith<$Res> get location {
    return $GeoLocationCopyWith<$Res>(_value.location, (value) {
      return _then(_value.copyWith(location: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MissionImplCopyWith<$Res> implements $MissionCopyWith<$Res> {
  factory _$$MissionImplCopyWith(
          _$MissionImpl value, $Res Function(_$MissionImpl) then) =
      __$$MissionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      LocalizedText title,
      LocalizedText? description,
      List<MissionType> types,
      MissionStatus status,
      bool priority,
      MissionRequirements requirements,
      GeoLocation location,
      @JsonKey(name: 'contact_name') String? contactName,
      @JsonKey(name: 'contact_phone_masked') String? contactPhoneMasked,
      @JsonKey(name: 'creator_id') String creatorId,
      @JsonKey(name: 'chat_room_id') String? chatRoomId,
      @JsonKey(name: 'participant_count') int participantCount,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt});

  @override
  $LocalizedTextCopyWith<$Res> get title;
  @override
  $LocalizedTextCopyWith<$Res>? get description;
  @override
  $MissionRequirementsCopyWith<$Res> get requirements;
  @override
  $GeoLocationCopyWith<$Res> get location;
}

/// @nodoc
class __$$MissionImplCopyWithImpl<$Res>
    extends _$MissionCopyWithImpl<$Res, _$MissionImpl>
    implements _$$MissionImplCopyWith<$Res> {
  __$$MissionImplCopyWithImpl(
      _$MissionImpl _value, $Res Function(_$MissionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = freezed,
    Object? types = null,
    Object? status = null,
    Object? priority = null,
    Object? requirements = null,
    Object? location = null,
    Object? contactName = freezed,
    Object? contactPhoneMasked = freezed,
    Object? creatorId = null,
    Object? chatRoomId = freezed,
    Object? participantCount = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$MissionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as LocalizedText,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as LocalizedText?,
      types: null == types
          ? _value._types
          : types // ignore: cast_nullable_to_non_nullable
              as List<MissionType>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as MissionStatus,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as bool,
      requirements: null == requirements
          ? _value.requirements
          : requirements // ignore: cast_nullable_to_non_nullable
              as MissionRequirements,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as GeoLocation,
      contactName: freezed == contactName
          ? _value.contactName
          : contactName // ignore: cast_nullable_to_non_nullable
              as String?,
      contactPhoneMasked: freezed == contactPhoneMasked
          ? _value.contactPhoneMasked
          : contactPhoneMasked // ignore: cast_nullable_to_non_nullable
              as String?,
      creatorId: null == creatorId
          ? _value.creatorId
          : creatorId // ignore: cast_nullable_to_non_nullable
              as String,
      chatRoomId: freezed == chatRoomId
          ? _value.chatRoomId
          : chatRoomId // ignore: cast_nullable_to_non_nullable
              as String?,
      participantCount: null == participantCount
          ? _value.participantCount
          : participantCount // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MissionImpl implements _Mission {
  const _$MissionImpl(
      {required this.id,
      required this.title,
      this.description,
      final List<MissionType> types = const <MissionType>[],
      this.status = MissionStatus.open,
      this.priority = false,
      this.requirements = const MissionRequirements(),
      required this.location,
      @JsonKey(name: 'contact_name') this.contactName,
      @JsonKey(name: 'contact_phone_masked') this.contactPhoneMasked,
      @JsonKey(name: 'creator_id') required this.creatorId,
      @JsonKey(name: 'chat_room_id') this.chatRoomId,
      @JsonKey(name: 'participant_count') this.participantCount = 0,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt})
      : _types = types;

  factory _$MissionImpl.fromJson(Map<String, dynamic> json) =>
      _$$MissionImplFromJson(json);

  @override
  final String id;
  @override
  final LocalizedText title;
  @override
  final LocalizedText? description;
  final List<MissionType> _types;
  @override
  @JsonKey()
  List<MissionType> get types {
    if (_types is EqualUnmodifiableListView) return _types;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_types);
  }

  @override
  @JsonKey()
  final MissionStatus status;
  @override
  @JsonKey()
  final bool priority;
  @override
  @JsonKey()
  final MissionRequirements requirements;
  @override
  final GeoLocation location;
  @override
  @JsonKey(name: 'contact_name')
  final String? contactName;
  @override
  @JsonKey(name: 'contact_phone_masked')
  final String? contactPhoneMasked;
  @override
  @JsonKey(name: 'creator_id')
  final String creatorId;
  @override
  @JsonKey(name: 'chat_room_id')
  final String? chatRoomId;
  @override
  @JsonKey(name: 'participant_count')
  final int participantCount;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Mission(id: $id, title: $title, description: $description, types: $types, status: $status, priority: $priority, requirements: $requirements, location: $location, contactName: $contactName, contactPhoneMasked: $contactPhoneMasked, creatorId: $creatorId, chatRoomId: $chatRoomId, participantCount: $participantCount, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MissionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._types, _types) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.requirements, requirements) ||
                other.requirements == requirements) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.contactName, contactName) ||
                other.contactName == contactName) &&
            (identical(other.contactPhoneMasked, contactPhoneMasked) ||
                other.contactPhoneMasked == contactPhoneMasked) &&
            (identical(other.creatorId, creatorId) ||
                other.creatorId == creatorId) &&
            (identical(other.chatRoomId, chatRoomId) ||
                other.chatRoomId == chatRoomId) &&
            (identical(other.participantCount, participantCount) ||
                other.participantCount == participantCount) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      description,
      const DeepCollectionEquality().hash(_types),
      status,
      priority,
      requirements,
      location,
      contactName,
      contactPhoneMasked,
      creatorId,
      chatRoomId,
      participantCount,
      createdAt,
      updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MissionImplCopyWith<_$MissionImpl> get copyWith =>
      __$$MissionImplCopyWithImpl<_$MissionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MissionImplToJson(
      this,
    );
  }
}

abstract class _Mission implements Mission {
  const factory _Mission(
      {required final String id,
      required final LocalizedText title,
      final LocalizedText? description,
      final List<MissionType> types,
      final MissionStatus status,
      final bool priority,
      final MissionRequirements requirements,
      required final GeoLocation location,
      @JsonKey(name: 'contact_name') final String? contactName,
      @JsonKey(name: 'contact_phone_masked') final String? contactPhoneMasked,
      @JsonKey(name: 'creator_id') required final String creatorId,
      @JsonKey(name: 'chat_room_id') final String? chatRoomId,
      @JsonKey(name: 'participant_count') final int participantCount,
      @JsonKey(name: 'created_at') final DateTime? createdAt,
      @JsonKey(name: 'updated_at') final DateTime? updatedAt}) = _$MissionImpl;

  factory _Mission.fromJson(Map<String, dynamic> json) = _$MissionImpl.fromJson;

  @override
  String get id;
  @override
  LocalizedText get title;
  @override
  LocalizedText? get description;
  @override
  List<MissionType> get types;
  @override
  MissionStatus get status;
  @override
  bool get priority;
  @override
  MissionRequirements get requirements;
  @override
  GeoLocation get location;
  @override
  @JsonKey(name: 'contact_name')
  String? get contactName;
  @override
  @JsonKey(name: 'contact_phone_masked')
  String? get contactPhoneMasked;
  @override
  @JsonKey(name: 'creator_id')
  String get creatorId;
  @override
  @JsonKey(name: 'chat_room_id')
  String? get chatRoomId;
  @override
  @JsonKey(name: 'participant_count')
  int get participantCount;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$MissionImplCopyWith<_$MissionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MissionParticipant _$MissionParticipantFromJson(Map<String, dynamic> json) {
  return _MissionParticipant.fromJson(json);
}

/// @nodoc
mixin _$MissionParticipant {
  @JsonKey(name: 'mission_id')
  String get missionId => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_visible')
  bool get isVisible => throw _privateConstructorUsedError;
  @JsonKey(name: 'joined_at')
  DateTime? get joinedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MissionParticipantCopyWith<MissionParticipant> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MissionParticipantCopyWith<$Res> {
  factory $MissionParticipantCopyWith(
          MissionParticipant value, $Res Function(MissionParticipant) then) =
      _$MissionParticipantCopyWithImpl<$Res, MissionParticipant>;
  @useResult
  $Res call(
      {@JsonKey(name: 'mission_id') String missionId,
      @JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'is_visible') bool isVisible,
      @JsonKey(name: 'joined_at') DateTime? joinedAt});
}

/// @nodoc
class _$MissionParticipantCopyWithImpl<$Res, $Val extends MissionParticipant>
    implements $MissionParticipantCopyWith<$Res> {
  _$MissionParticipantCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? missionId = null,
    Object? userId = null,
    Object? isVisible = null,
    Object? joinedAt = freezed,
  }) {
    return _then(_value.copyWith(
      missionId: null == missionId
          ? _value.missionId
          : missionId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      isVisible: null == isVisible
          ? _value.isVisible
          : isVisible // ignore: cast_nullable_to_non_nullable
              as bool,
      joinedAt: freezed == joinedAt
          ? _value.joinedAt
          : joinedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MissionParticipantImplCopyWith<$Res>
    implements $MissionParticipantCopyWith<$Res> {
  factory _$$MissionParticipantImplCopyWith(_$MissionParticipantImpl value,
          $Res Function(_$MissionParticipantImpl) then) =
      __$$MissionParticipantImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'mission_id') String missionId,
      @JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'is_visible') bool isVisible,
      @JsonKey(name: 'joined_at') DateTime? joinedAt});
}

/// @nodoc
class __$$MissionParticipantImplCopyWithImpl<$Res>
    extends _$MissionParticipantCopyWithImpl<$Res, _$MissionParticipantImpl>
    implements _$$MissionParticipantImplCopyWith<$Res> {
  __$$MissionParticipantImplCopyWithImpl(_$MissionParticipantImpl _value,
      $Res Function(_$MissionParticipantImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? missionId = null,
    Object? userId = null,
    Object? isVisible = null,
    Object? joinedAt = freezed,
  }) {
    return _then(_$MissionParticipantImpl(
      missionId: null == missionId
          ? _value.missionId
          : missionId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      isVisible: null == isVisible
          ? _value.isVisible
          : isVisible // ignore: cast_nullable_to_non_nullable
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
class _$MissionParticipantImpl implements _MissionParticipant {
  const _$MissionParticipantImpl(
      {@JsonKey(name: 'mission_id') required this.missionId,
      @JsonKey(name: 'user_id') required this.userId,
      @JsonKey(name: 'is_visible') this.isVisible = true,
      @JsonKey(name: 'joined_at') this.joinedAt});

  factory _$MissionParticipantImpl.fromJson(Map<String, dynamic> json) =>
      _$$MissionParticipantImplFromJson(json);

  @override
  @JsonKey(name: 'mission_id')
  final String missionId;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey(name: 'is_visible')
  final bool isVisible;
  @override
  @JsonKey(name: 'joined_at')
  final DateTime? joinedAt;

  @override
  String toString() {
    return 'MissionParticipant(missionId: $missionId, userId: $userId, isVisible: $isVisible, joinedAt: $joinedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MissionParticipantImpl &&
            (identical(other.missionId, missionId) ||
                other.missionId == missionId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.isVisible, isVisible) ||
                other.isVisible == isVisible) &&
            (identical(other.joinedAt, joinedAt) ||
                other.joinedAt == joinedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, missionId, userId, isVisible, joinedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MissionParticipantImplCopyWith<_$MissionParticipantImpl> get copyWith =>
      __$$MissionParticipantImplCopyWithImpl<_$MissionParticipantImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MissionParticipantImplToJson(
      this,
    );
  }
}

abstract class _MissionParticipant implements MissionParticipant {
  const factory _MissionParticipant(
          {@JsonKey(name: 'mission_id') required final String missionId,
          @JsonKey(name: 'user_id') required final String userId,
          @JsonKey(name: 'is_visible') final bool isVisible,
          @JsonKey(name: 'joined_at') final DateTime? joinedAt}) =
      _$MissionParticipantImpl;

  factory _MissionParticipant.fromJson(Map<String, dynamic> json) =
      _$MissionParticipantImpl.fromJson;

  @override
  @JsonKey(name: 'mission_id')
  String get missionId;
  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  @JsonKey(name: 'is_visible')
  bool get isVisible;
  @override
  @JsonKey(name: 'joined_at')
  DateTime? get joinedAt;
  @override
  @JsonKey(ignore: true)
  _$$MissionParticipantImplCopyWith<_$MissionParticipantImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MissionMessage _$MissionMessageFromJson(Map<String, dynamic> json) {
  return _MissionMessage.fromJson(json);
}

/// @nodoc
mixin _$MissionMessage {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'mission_id')
  String get missionId => throw _privateConstructorUsedError;
  @JsonKey(name: 'author_id')
  String get authorId => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'expires_at')
  DateTime? get expiresAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MissionMessageCopyWith<MissionMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MissionMessageCopyWith<$Res> {
  factory $MissionMessageCopyWith(
          MissionMessage value, $Res Function(MissionMessage) then) =
      _$MissionMessageCopyWithImpl<$Res, MissionMessage>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'mission_id') String missionId,
      @JsonKey(name: 'author_id') String authorId,
      String content,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'expires_at') DateTime? expiresAt});
}

/// @nodoc
class _$MissionMessageCopyWithImpl<$Res, $Val extends MissionMessage>
    implements $MissionMessageCopyWith<$Res> {
  _$MissionMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? missionId = null,
    Object? authorId = null,
    Object? content = null,
    Object? createdAt = freezed,
    Object? expiresAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      missionId: null == missionId
          ? _value.missionId
          : missionId // ignore: cast_nullable_to_non_nullable
              as String,
      authorId: null == authorId
          ? _value.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MissionMessageImplCopyWith<$Res>
    implements $MissionMessageCopyWith<$Res> {
  factory _$$MissionMessageImplCopyWith(_$MissionMessageImpl value,
          $Res Function(_$MissionMessageImpl) then) =
      __$$MissionMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'mission_id') String missionId,
      @JsonKey(name: 'author_id') String authorId,
      String content,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'expires_at') DateTime? expiresAt});
}

/// @nodoc
class __$$MissionMessageImplCopyWithImpl<$Res>
    extends _$MissionMessageCopyWithImpl<$Res, _$MissionMessageImpl>
    implements _$$MissionMessageImplCopyWith<$Res> {
  __$$MissionMessageImplCopyWithImpl(
      _$MissionMessageImpl _value, $Res Function(_$MissionMessageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? missionId = null,
    Object? authorId = null,
    Object? content = null,
    Object? createdAt = freezed,
    Object? expiresAt = freezed,
  }) {
    return _then(_$MissionMessageImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      missionId: null == missionId
          ? _value.missionId
          : missionId // ignore: cast_nullable_to_non_nullable
              as String,
      authorId: null == authorId
          ? _value.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MissionMessageImpl implements _MissionMessage {
  const _$MissionMessageImpl(
      {required this.id,
      @JsonKey(name: 'mission_id') required this.missionId,
      @JsonKey(name: 'author_id') required this.authorId,
      required this.content,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'expires_at') this.expiresAt});

  factory _$MissionMessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$MissionMessageImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'mission_id')
  final String missionId;
  @override
  @JsonKey(name: 'author_id')
  final String authorId;
  @override
  final String content;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'expires_at')
  final DateTime? expiresAt;

  @override
  String toString() {
    return 'MissionMessage(id: $id, missionId: $missionId, authorId: $authorId, content: $content, createdAt: $createdAt, expiresAt: $expiresAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MissionMessageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.missionId, missionId) ||
                other.missionId == missionId) &&
            (identical(other.authorId, authorId) ||
                other.authorId == authorId) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, missionId, authorId, content, createdAt, expiresAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MissionMessageImplCopyWith<_$MissionMessageImpl> get copyWith =>
      __$$MissionMessageImplCopyWithImpl<_$MissionMessageImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MissionMessageImplToJson(
      this,
    );
  }
}

abstract class _MissionMessage implements MissionMessage {
  const factory _MissionMessage(
          {required final String id,
          @JsonKey(name: 'mission_id') required final String missionId,
          @JsonKey(name: 'author_id') required final String authorId,
          required final String content,
          @JsonKey(name: 'created_at') final DateTime? createdAt,
          @JsonKey(name: 'expires_at') final DateTime? expiresAt}) =
      _$MissionMessageImpl;

  factory _MissionMessage.fromJson(Map<String, dynamic> json) =
      _$MissionMessageImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'mission_id')
  String get missionId;
  @override
  @JsonKey(name: 'author_id')
  String get authorId;
  @override
  String get content;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'expires_at')
  DateTime? get expiresAt;
  @override
  @JsonKey(ignore: true)
  _$$MissionMessageImplCopyWith<_$MissionMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ShuttleVehicleInfo _$ShuttleVehicleInfoFromJson(Map<String, dynamic> json) {
  return _ShuttleVehicleInfo.fromJson(json);
}

/// @nodoc
mixin _$ShuttleVehicleInfo {
  String get type => throw _privateConstructorUsedError;
  String? get plate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ShuttleVehicleInfoCopyWith<ShuttleVehicleInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShuttleVehicleInfoCopyWith<$Res> {
  factory $ShuttleVehicleInfoCopyWith(
          ShuttleVehicleInfo value, $Res Function(ShuttleVehicleInfo) then) =
      _$ShuttleVehicleInfoCopyWithImpl<$Res, ShuttleVehicleInfo>;
  @useResult
  $Res call({String type, String? plate});
}

/// @nodoc
class _$ShuttleVehicleInfoCopyWithImpl<$Res, $Val extends ShuttleVehicleInfo>
    implements $ShuttleVehicleInfoCopyWith<$Res> {
  _$ShuttleVehicleInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? plate = freezed,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      plate: freezed == plate
          ? _value.plate
          : plate // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ShuttleVehicleInfoImplCopyWith<$Res>
    implements $ShuttleVehicleInfoCopyWith<$Res> {
  factory _$$ShuttleVehicleInfoImplCopyWith(_$ShuttleVehicleInfoImpl value,
          $Res Function(_$ShuttleVehicleInfoImpl) then) =
      __$$ShuttleVehicleInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String type, String? plate});
}

/// @nodoc
class __$$ShuttleVehicleInfoImplCopyWithImpl<$Res>
    extends _$ShuttleVehicleInfoCopyWithImpl<$Res, _$ShuttleVehicleInfoImpl>
    implements _$$ShuttleVehicleInfoImplCopyWith<$Res> {
  __$$ShuttleVehicleInfoImplCopyWithImpl(_$ShuttleVehicleInfoImpl _value,
      $Res Function(_$ShuttleVehicleInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? plate = freezed,
  }) {
    return _then(_$ShuttleVehicleInfoImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      plate: freezed == plate
          ? _value.plate
          : plate // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ShuttleVehicleInfoImpl implements _ShuttleVehicleInfo {
  const _$ShuttleVehicleInfoImpl({required this.type, this.plate});

  factory _$ShuttleVehicleInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShuttleVehicleInfoImplFromJson(json);

  @override
  final String type;
  @override
  final String? plate;

  @override
  String toString() {
    return 'ShuttleVehicleInfo(type: $type, plate: $plate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShuttleVehicleInfoImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.plate, plate) || other.plate == plate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, type, plate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ShuttleVehicleInfoImplCopyWith<_$ShuttleVehicleInfoImpl> get copyWith =>
      __$$ShuttleVehicleInfoImplCopyWithImpl<_$ShuttleVehicleInfoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ShuttleVehicleInfoImplToJson(
      this,
    );
  }
}

abstract class _ShuttleVehicleInfo implements ShuttleVehicleInfo {
  const factory _ShuttleVehicleInfo(
      {required final String type,
      final String? plate}) = _$ShuttleVehicleInfoImpl;

  factory _ShuttleVehicleInfo.fromJson(Map<String, dynamic> json) =
      _$ShuttleVehicleInfoImpl.fromJson;

  @override
  String get type;
  @override
  String? get plate;
  @override
  @JsonKey(ignore: true)
  _$$ShuttleVehicleInfoImplCopyWith<_$ShuttleVehicleInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ShuttleRoute _$ShuttleRouteFromJson(Map<String, dynamic> json) {
  return _ShuttleRoute.fromJson(json);
}

/// @nodoc
mixin _$ShuttleRoute {
  GeoLocation get origin => throw _privateConstructorUsedError;
  GeoLocation get destination => throw _privateConstructorUsedError;
  List<GeoLocation> get stops => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ShuttleRouteCopyWith<ShuttleRoute> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShuttleRouteCopyWith<$Res> {
  factory $ShuttleRouteCopyWith(
          ShuttleRoute value, $Res Function(ShuttleRoute) then) =
      _$ShuttleRouteCopyWithImpl<$Res, ShuttleRoute>;
  @useResult
  $Res call(
      {GeoLocation origin, GeoLocation destination, List<GeoLocation> stops});

  $GeoLocationCopyWith<$Res> get origin;
  $GeoLocationCopyWith<$Res> get destination;
}

/// @nodoc
class _$ShuttleRouteCopyWithImpl<$Res, $Val extends ShuttleRoute>
    implements $ShuttleRouteCopyWith<$Res> {
  _$ShuttleRouteCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? origin = null,
    Object? destination = null,
    Object? stops = null,
  }) {
    return _then(_value.copyWith(
      origin: null == origin
          ? _value.origin
          : origin // ignore: cast_nullable_to_non_nullable
              as GeoLocation,
      destination: null == destination
          ? _value.destination
          : destination // ignore: cast_nullable_to_non_nullable
              as GeoLocation,
      stops: null == stops
          ? _value.stops
          : stops // ignore: cast_nullable_to_non_nullable
              as List<GeoLocation>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $GeoLocationCopyWith<$Res> get origin {
    return $GeoLocationCopyWith<$Res>(_value.origin, (value) {
      return _then(_value.copyWith(origin: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $GeoLocationCopyWith<$Res> get destination {
    return $GeoLocationCopyWith<$Res>(_value.destination, (value) {
      return _then(_value.copyWith(destination: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ShuttleRouteImplCopyWith<$Res>
    implements $ShuttleRouteCopyWith<$Res> {
  factory _$$ShuttleRouteImplCopyWith(
          _$ShuttleRouteImpl value, $Res Function(_$ShuttleRouteImpl) then) =
      __$$ShuttleRouteImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {GeoLocation origin, GeoLocation destination, List<GeoLocation> stops});

  @override
  $GeoLocationCopyWith<$Res> get origin;
  @override
  $GeoLocationCopyWith<$Res> get destination;
}

/// @nodoc
class __$$ShuttleRouteImplCopyWithImpl<$Res>
    extends _$ShuttleRouteCopyWithImpl<$Res, _$ShuttleRouteImpl>
    implements _$$ShuttleRouteImplCopyWith<$Res> {
  __$$ShuttleRouteImplCopyWithImpl(
      _$ShuttleRouteImpl _value, $Res Function(_$ShuttleRouteImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? origin = null,
    Object? destination = null,
    Object? stops = null,
  }) {
    return _then(_$ShuttleRouteImpl(
      origin: null == origin
          ? _value.origin
          : origin // ignore: cast_nullable_to_non_nullable
              as GeoLocation,
      destination: null == destination
          ? _value.destination
          : destination // ignore: cast_nullable_to_non_nullable
              as GeoLocation,
      stops: null == stops
          ? _value._stops
          : stops // ignore: cast_nullable_to_non_nullable
              as List<GeoLocation>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ShuttleRouteImpl implements _ShuttleRoute {
  const _$ShuttleRouteImpl(
      {required this.origin,
      required this.destination,
      final List<GeoLocation> stops = const <GeoLocation>[]})
      : _stops = stops;

  factory _$ShuttleRouteImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShuttleRouteImplFromJson(json);

  @override
  final GeoLocation origin;
  @override
  final GeoLocation destination;
  final List<GeoLocation> _stops;
  @override
  @JsonKey()
  List<GeoLocation> get stops {
    if (_stops is EqualUnmodifiableListView) return _stops;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_stops);
  }

  @override
  String toString() {
    return 'ShuttleRoute(origin: $origin, destination: $destination, stops: $stops)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShuttleRouteImpl &&
            (identical(other.origin, origin) || other.origin == origin) &&
            (identical(other.destination, destination) ||
                other.destination == destination) &&
            const DeepCollectionEquality().equals(other._stops, _stops));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, origin, destination,
      const DeepCollectionEquality().hash(_stops));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ShuttleRouteImplCopyWith<_$ShuttleRouteImpl> get copyWith =>
      __$$ShuttleRouteImplCopyWithImpl<_$ShuttleRouteImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ShuttleRouteImplToJson(
      this,
    );
  }
}

abstract class _ShuttleRoute implements ShuttleRoute {
  const factory _ShuttleRoute(
      {required final GeoLocation origin,
      required final GeoLocation destination,
      final List<GeoLocation> stops}) = _$ShuttleRouteImpl;

  factory _ShuttleRoute.fromJson(Map<String, dynamic> json) =
      _$ShuttleRouteImpl.fromJson;

  @override
  GeoLocation get origin;
  @override
  GeoLocation get destination;
  @override
  List<GeoLocation> get stops;
  @override
  @JsonKey(ignore: true)
  _$$ShuttleRouteImplCopyWith<_$ShuttleRouteImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ShuttleSchedule _$ShuttleScheduleFromJson(Map<String, dynamic> json) {
  return _ShuttleSchedule.fromJson(json);
}

/// @nodoc
mixin _$ShuttleSchedule {
  @JsonKey(name: 'depart_at')
  DateTime get departAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'arrive_at')
  DateTime? get arriveAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ShuttleScheduleCopyWith<ShuttleSchedule> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShuttleScheduleCopyWith<$Res> {
  factory $ShuttleScheduleCopyWith(
          ShuttleSchedule value, $Res Function(ShuttleSchedule) then) =
      _$ShuttleScheduleCopyWithImpl<$Res, ShuttleSchedule>;
  @useResult
  $Res call(
      {@JsonKey(name: 'depart_at') DateTime departAt,
      @JsonKey(name: 'arrive_at') DateTime? arriveAt});
}

/// @nodoc
class _$ShuttleScheduleCopyWithImpl<$Res, $Val extends ShuttleSchedule>
    implements $ShuttleScheduleCopyWith<$Res> {
  _$ShuttleScheduleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? departAt = null,
    Object? arriveAt = freezed,
  }) {
    return _then(_value.copyWith(
      departAt: null == departAt
          ? _value.departAt
          : departAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      arriveAt: freezed == arriveAt
          ? _value.arriveAt
          : arriveAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ShuttleScheduleImplCopyWith<$Res>
    implements $ShuttleScheduleCopyWith<$Res> {
  factory _$$ShuttleScheduleImplCopyWith(_$ShuttleScheduleImpl value,
          $Res Function(_$ShuttleScheduleImpl) then) =
      __$$ShuttleScheduleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'depart_at') DateTime departAt,
      @JsonKey(name: 'arrive_at') DateTime? arriveAt});
}

/// @nodoc
class __$$ShuttleScheduleImplCopyWithImpl<$Res>
    extends _$ShuttleScheduleCopyWithImpl<$Res, _$ShuttleScheduleImpl>
    implements _$$ShuttleScheduleImplCopyWith<$Res> {
  __$$ShuttleScheduleImplCopyWithImpl(
      _$ShuttleScheduleImpl _value, $Res Function(_$ShuttleScheduleImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? departAt = null,
    Object? arriveAt = freezed,
  }) {
    return _then(_$ShuttleScheduleImpl(
      departAt: null == departAt
          ? _value.departAt
          : departAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      arriveAt: freezed == arriveAt
          ? _value.arriveAt
          : arriveAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ShuttleScheduleImpl implements _ShuttleSchedule {
  const _$ShuttleScheduleImpl(
      {@JsonKey(name: 'depart_at') required this.departAt,
      @JsonKey(name: 'arrive_at') this.arriveAt});

  factory _$ShuttleScheduleImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShuttleScheduleImplFromJson(json);

  @override
  @JsonKey(name: 'depart_at')
  final DateTime departAt;
  @override
  @JsonKey(name: 'arrive_at')
  final DateTime? arriveAt;

  @override
  String toString() {
    return 'ShuttleSchedule(departAt: $departAt, arriveAt: $arriveAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShuttleScheduleImpl &&
            (identical(other.departAt, departAt) ||
                other.departAt == departAt) &&
            (identical(other.arriveAt, arriveAt) ||
                other.arriveAt == arriveAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, departAt, arriveAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ShuttleScheduleImplCopyWith<_$ShuttleScheduleImpl> get copyWith =>
      __$$ShuttleScheduleImplCopyWithImpl<_$ShuttleScheduleImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ShuttleScheduleImplToJson(
      this,
    );
  }
}

abstract class _ShuttleSchedule implements ShuttleSchedule {
  const factory _ShuttleSchedule(
          {@JsonKey(name: 'depart_at') required final DateTime departAt,
          @JsonKey(name: 'arrive_at') final DateTime? arriveAt}) =
      _$ShuttleScheduleImpl;

  factory _ShuttleSchedule.fromJson(Map<String, dynamic> json) =
      _$ShuttleScheduleImpl.fromJson;

  @override
  @JsonKey(name: 'depart_at')
  DateTime get departAt;
  @override
  @JsonKey(name: 'arrive_at')
  DateTime? get arriveAt;
  @override
  @JsonKey(ignore: true)
  _$$ShuttleScheduleImplCopyWith<_$ShuttleScheduleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ShuttleCapacity _$ShuttleCapacityFromJson(Map<String, dynamic> json) {
  return _ShuttleCapacity.fromJson(json);
}

/// @nodoc
mixin _$ShuttleCapacity {
  int get total => throw _privateConstructorUsedError;
  int get taken => throw _privateConstructorUsedError;
  int get remaining => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ShuttleCapacityCopyWith<ShuttleCapacity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShuttleCapacityCopyWith<$Res> {
  factory $ShuttleCapacityCopyWith(
          ShuttleCapacity value, $Res Function(ShuttleCapacity) then) =
      _$ShuttleCapacityCopyWithImpl<$Res, ShuttleCapacity>;
  @useResult
  $Res call({int total, int taken, int remaining});
}

/// @nodoc
class _$ShuttleCapacityCopyWithImpl<$Res, $Val extends ShuttleCapacity>
    implements $ShuttleCapacityCopyWith<$Res> {
  _$ShuttleCapacityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? total = null,
    Object? taken = null,
    Object? remaining = null,
  }) {
    return _then(_value.copyWith(
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      taken: null == taken
          ? _value.taken
          : taken // ignore: cast_nullable_to_non_nullable
              as int,
      remaining: null == remaining
          ? _value.remaining
          : remaining // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ShuttleCapacityImplCopyWith<$Res>
    implements $ShuttleCapacityCopyWith<$Res> {
  factory _$$ShuttleCapacityImplCopyWith(_$ShuttleCapacityImpl value,
          $Res Function(_$ShuttleCapacityImpl) then) =
      __$$ShuttleCapacityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int total, int taken, int remaining});
}

/// @nodoc
class __$$ShuttleCapacityImplCopyWithImpl<$Res>
    extends _$ShuttleCapacityCopyWithImpl<$Res, _$ShuttleCapacityImpl>
    implements _$$ShuttleCapacityImplCopyWith<$Res> {
  __$$ShuttleCapacityImplCopyWithImpl(
      _$ShuttleCapacityImpl _value, $Res Function(_$ShuttleCapacityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? total = null,
    Object? taken = null,
    Object? remaining = null,
  }) {
    return _then(_$ShuttleCapacityImpl(
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      taken: null == taken
          ? _value.taken
          : taken // ignore: cast_nullable_to_non_nullable
              as int,
      remaining: null == remaining
          ? _value.remaining
          : remaining // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ShuttleCapacityImpl implements _ShuttleCapacity {
  const _$ShuttleCapacityImpl(
      {required this.total, required this.taken, required this.remaining});

  factory _$ShuttleCapacityImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShuttleCapacityImplFromJson(json);

  @override
  final int total;
  @override
  final int taken;
  @override
  final int remaining;

  @override
  String toString() {
    return 'ShuttleCapacity(total: $total, taken: $taken, remaining: $remaining)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShuttleCapacityImpl &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.taken, taken) || other.taken == taken) &&
            (identical(other.remaining, remaining) ||
                other.remaining == remaining));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, total, taken, remaining);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ShuttleCapacityImplCopyWith<_$ShuttleCapacityImpl> get copyWith =>
      __$$ShuttleCapacityImplCopyWithImpl<_$ShuttleCapacityImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ShuttleCapacityImplToJson(
      this,
    );
  }
}

abstract class _ShuttleCapacity implements ShuttleCapacity {
  const factory _ShuttleCapacity(
      {required final int total,
      required final int taken,
      required final int remaining}) = _$ShuttleCapacityImpl;

  factory _ShuttleCapacity.fromJson(Map<String, dynamic> json) =
      _$ShuttleCapacityImpl.fromJson;

  @override
  int get total;
  @override
  int get taken;
  @override
  int get remaining;
  @override
  @JsonKey(ignore: true)
  _$$ShuttleCapacityImplCopyWith<_$ShuttleCapacityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Shuttle _$ShuttleFromJson(Map<String, dynamic> json) {
  return _Shuttle.fromJson(json);
}

/// @nodoc
mixin _$Shuttle {
  String get id => throw _privateConstructorUsedError;
  LocalizedText get title => throw _privateConstructorUsedError;
  LocalizedText? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'vehicle_info')
  ShuttleVehicleInfo get vehicleInfo => throw _privateConstructorUsedError;
  List<ShuttlePurpose> get purposes => throw _privateConstructorUsedError;
  ShuttleRoute get route => throw _privateConstructorUsedError;
  ShuttleSchedule get schedule => throw _privateConstructorUsedError;
  ShuttleCapacity get capacity => throw _privateConstructorUsedError;
  @JsonKey(name: 'cost_type')
  ShuttleCostType get costType => throw _privateConstructorUsedError;
  ShuttleStatus get status => throw _privateConstructorUsedError;
  bool get priority => throw _privateConstructorUsedError;
  @JsonKey(name: 'contact_name')
  String? get contactName => throw _privateConstructorUsedError;
  @JsonKey(name: 'contact_phone_masked')
  String? get contactPhoneMasked => throw _privateConstructorUsedError;
  @JsonKey(name: 'creator_id')
  String get creatorId => throw _privateConstructorUsedError;
  @JsonKey(name: 'chat_room_id')
  String? get chatRoomId => throw _privateConstructorUsedError;
  @JsonKey(name: 'participants_snapshot')
  List<String> get participantsSnapshot => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ShuttleCopyWith<Shuttle> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShuttleCopyWith<$Res> {
  factory $ShuttleCopyWith(Shuttle value, $Res Function(Shuttle) then) =
      _$ShuttleCopyWithImpl<$Res, Shuttle>;
  @useResult
  $Res call(
      {String id,
      LocalizedText title,
      LocalizedText? description,
      @JsonKey(name: 'vehicle_info') ShuttleVehicleInfo vehicleInfo,
      List<ShuttlePurpose> purposes,
      ShuttleRoute route,
      ShuttleSchedule schedule,
      ShuttleCapacity capacity,
      @JsonKey(name: 'cost_type') ShuttleCostType costType,
      ShuttleStatus status,
      bool priority,
      @JsonKey(name: 'contact_name') String? contactName,
      @JsonKey(name: 'contact_phone_masked') String? contactPhoneMasked,
      @JsonKey(name: 'creator_id') String creatorId,
      @JsonKey(name: 'chat_room_id') String? chatRoomId,
      @JsonKey(name: 'participants_snapshot') List<String> participantsSnapshot,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt});

  $LocalizedTextCopyWith<$Res> get title;
  $LocalizedTextCopyWith<$Res>? get description;
  $ShuttleVehicleInfoCopyWith<$Res> get vehicleInfo;
  $ShuttleRouteCopyWith<$Res> get route;
  $ShuttleScheduleCopyWith<$Res> get schedule;
  $ShuttleCapacityCopyWith<$Res> get capacity;
}

/// @nodoc
class _$ShuttleCopyWithImpl<$Res, $Val extends Shuttle>
    implements $ShuttleCopyWith<$Res> {
  _$ShuttleCopyWithImpl(this._value, this._then);

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
    Object? vehicleInfo = null,
    Object? purposes = null,
    Object? route = null,
    Object? schedule = null,
    Object? capacity = null,
    Object? costType = null,
    Object? status = null,
    Object? priority = null,
    Object? contactName = freezed,
    Object? contactPhoneMasked = freezed,
    Object? creatorId = null,
    Object? chatRoomId = freezed,
    Object? participantsSnapshot = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as LocalizedText,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as LocalizedText?,
      vehicleInfo: null == vehicleInfo
          ? _value.vehicleInfo
          : vehicleInfo // ignore: cast_nullable_to_non_nullable
              as ShuttleVehicleInfo,
      purposes: null == purposes
          ? _value.purposes
          : purposes // ignore: cast_nullable_to_non_nullable
              as List<ShuttlePurpose>,
      route: null == route
          ? _value.route
          : route // ignore: cast_nullable_to_non_nullable
              as ShuttleRoute,
      schedule: null == schedule
          ? _value.schedule
          : schedule // ignore: cast_nullable_to_non_nullable
              as ShuttleSchedule,
      capacity: null == capacity
          ? _value.capacity
          : capacity // ignore: cast_nullable_to_non_nullable
              as ShuttleCapacity,
      costType: null == costType
          ? _value.costType
          : costType // ignore: cast_nullable_to_non_nullable
              as ShuttleCostType,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ShuttleStatus,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as bool,
      contactName: freezed == contactName
          ? _value.contactName
          : contactName // ignore: cast_nullable_to_non_nullable
              as String?,
      contactPhoneMasked: freezed == contactPhoneMasked
          ? _value.contactPhoneMasked
          : contactPhoneMasked // ignore: cast_nullable_to_non_nullable
              as String?,
      creatorId: null == creatorId
          ? _value.creatorId
          : creatorId // ignore: cast_nullable_to_non_nullable
              as String,
      chatRoomId: freezed == chatRoomId
          ? _value.chatRoomId
          : chatRoomId // ignore: cast_nullable_to_non_nullable
              as String?,
      participantsSnapshot: null == participantsSnapshot
          ? _value.participantsSnapshot
          : participantsSnapshot // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $LocalizedTextCopyWith<$Res> get title {
    return $LocalizedTextCopyWith<$Res>(_value.title, (value) {
      return _then(_value.copyWith(title: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $LocalizedTextCopyWith<$Res>? get description {
    if (_value.description == null) {
      return null;
    }

    return $LocalizedTextCopyWith<$Res>(_value.description!, (value) {
      return _then(_value.copyWith(description: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ShuttleVehicleInfoCopyWith<$Res> get vehicleInfo {
    return $ShuttleVehicleInfoCopyWith<$Res>(_value.vehicleInfo, (value) {
      return _then(_value.copyWith(vehicleInfo: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ShuttleRouteCopyWith<$Res> get route {
    return $ShuttleRouteCopyWith<$Res>(_value.route, (value) {
      return _then(_value.copyWith(route: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ShuttleScheduleCopyWith<$Res> get schedule {
    return $ShuttleScheduleCopyWith<$Res>(_value.schedule, (value) {
      return _then(_value.copyWith(schedule: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ShuttleCapacityCopyWith<$Res> get capacity {
    return $ShuttleCapacityCopyWith<$Res>(_value.capacity, (value) {
      return _then(_value.copyWith(capacity: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ShuttleImplCopyWith<$Res> implements $ShuttleCopyWith<$Res> {
  factory _$$ShuttleImplCopyWith(
          _$ShuttleImpl value, $Res Function(_$ShuttleImpl) then) =
      __$$ShuttleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      LocalizedText title,
      LocalizedText? description,
      @JsonKey(name: 'vehicle_info') ShuttleVehicleInfo vehicleInfo,
      List<ShuttlePurpose> purposes,
      ShuttleRoute route,
      ShuttleSchedule schedule,
      ShuttleCapacity capacity,
      @JsonKey(name: 'cost_type') ShuttleCostType costType,
      ShuttleStatus status,
      bool priority,
      @JsonKey(name: 'contact_name') String? contactName,
      @JsonKey(name: 'contact_phone_masked') String? contactPhoneMasked,
      @JsonKey(name: 'creator_id') String creatorId,
      @JsonKey(name: 'chat_room_id') String? chatRoomId,
      @JsonKey(name: 'participants_snapshot') List<String> participantsSnapshot,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt});

  @override
  $LocalizedTextCopyWith<$Res> get title;
  @override
  $LocalizedTextCopyWith<$Res>? get description;
  @override
  $ShuttleVehicleInfoCopyWith<$Res> get vehicleInfo;
  @override
  $ShuttleRouteCopyWith<$Res> get route;
  @override
  $ShuttleScheduleCopyWith<$Res> get schedule;
  @override
  $ShuttleCapacityCopyWith<$Res> get capacity;
}

/// @nodoc
class __$$ShuttleImplCopyWithImpl<$Res>
    extends _$ShuttleCopyWithImpl<$Res, _$ShuttleImpl>
    implements _$$ShuttleImplCopyWith<$Res> {
  __$$ShuttleImplCopyWithImpl(
      _$ShuttleImpl _value, $Res Function(_$ShuttleImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = freezed,
    Object? vehicleInfo = null,
    Object? purposes = null,
    Object? route = null,
    Object? schedule = null,
    Object? capacity = null,
    Object? costType = null,
    Object? status = null,
    Object? priority = null,
    Object? contactName = freezed,
    Object? contactPhoneMasked = freezed,
    Object? creatorId = null,
    Object? chatRoomId = freezed,
    Object? participantsSnapshot = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$ShuttleImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as LocalizedText,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as LocalizedText?,
      vehicleInfo: null == vehicleInfo
          ? _value.vehicleInfo
          : vehicleInfo // ignore: cast_nullable_to_non_nullable
              as ShuttleVehicleInfo,
      purposes: null == purposes
          ? _value._purposes
          : purposes // ignore: cast_nullable_to_non_nullable
              as List<ShuttlePurpose>,
      route: null == route
          ? _value.route
          : route // ignore: cast_nullable_to_non_nullable
              as ShuttleRoute,
      schedule: null == schedule
          ? _value.schedule
          : schedule // ignore: cast_nullable_to_non_nullable
              as ShuttleSchedule,
      capacity: null == capacity
          ? _value.capacity
          : capacity // ignore: cast_nullable_to_non_nullable
              as ShuttleCapacity,
      costType: null == costType
          ? _value.costType
          : costType // ignore: cast_nullable_to_non_nullable
              as ShuttleCostType,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ShuttleStatus,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as bool,
      contactName: freezed == contactName
          ? _value.contactName
          : contactName // ignore: cast_nullable_to_non_nullable
              as String?,
      contactPhoneMasked: freezed == contactPhoneMasked
          ? _value.contactPhoneMasked
          : contactPhoneMasked // ignore: cast_nullable_to_non_nullable
              as String?,
      creatorId: null == creatorId
          ? _value.creatorId
          : creatorId // ignore: cast_nullable_to_non_nullable
              as String,
      chatRoomId: freezed == chatRoomId
          ? _value.chatRoomId
          : chatRoomId // ignore: cast_nullable_to_non_nullable
              as String?,
      participantsSnapshot: null == participantsSnapshot
          ? _value._participantsSnapshot
          : participantsSnapshot // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ShuttleImpl implements _Shuttle {
  const _$ShuttleImpl(
      {required this.id,
      required this.title,
      this.description,
      @JsonKey(name: 'vehicle_info') required this.vehicleInfo,
      final List<ShuttlePurpose> purposes = const <ShuttlePurpose>[],
      required this.route,
      required this.schedule,
      required this.capacity,
      @JsonKey(name: 'cost_type') this.costType = ShuttleCostType.free,
      this.status = ShuttleStatus.open,
      this.priority = false,
      @JsonKey(name: 'contact_name') this.contactName,
      @JsonKey(name: 'contact_phone_masked') this.contactPhoneMasked,
      @JsonKey(name: 'creator_id') required this.creatorId,
      @JsonKey(name: 'chat_room_id') this.chatRoomId,
      @JsonKey(name: 'participants_snapshot')
      final List<String> participantsSnapshot = const <String>[],
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt})
      : _purposes = purposes,
        _participantsSnapshot = participantsSnapshot;

  factory _$ShuttleImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShuttleImplFromJson(json);

  @override
  final String id;
  @override
  final LocalizedText title;
  @override
  final LocalizedText? description;
  @override
  @JsonKey(name: 'vehicle_info')
  final ShuttleVehicleInfo vehicleInfo;
  final List<ShuttlePurpose> _purposes;
  @override
  @JsonKey()
  List<ShuttlePurpose> get purposes {
    if (_purposes is EqualUnmodifiableListView) return _purposes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_purposes);
  }

  @override
  final ShuttleRoute route;
  @override
  final ShuttleSchedule schedule;
  @override
  final ShuttleCapacity capacity;
  @override
  @JsonKey(name: 'cost_type')
  final ShuttleCostType costType;
  @override
  @JsonKey()
  final ShuttleStatus status;
  @override
  @JsonKey()
  final bool priority;
  @override
  @JsonKey(name: 'contact_name')
  final String? contactName;
  @override
  @JsonKey(name: 'contact_phone_masked')
  final String? contactPhoneMasked;
  @override
  @JsonKey(name: 'creator_id')
  final String creatorId;
  @override
  @JsonKey(name: 'chat_room_id')
  final String? chatRoomId;
  final List<String> _participantsSnapshot;
  @override
  @JsonKey(name: 'participants_snapshot')
  List<String> get participantsSnapshot {
    if (_participantsSnapshot is EqualUnmodifiableListView)
      return _participantsSnapshot;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_participantsSnapshot);
  }

  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Shuttle(id: $id, title: $title, description: $description, vehicleInfo: $vehicleInfo, purposes: $purposes, route: $route, schedule: $schedule, capacity: $capacity, costType: $costType, status: $status, priority: $priority, contactName: $contactName, contactPhoneMasked: $contactPhoneMasked, creatorId: $creatorId, chatRoomId: $chatRoomId, participantsSnapshot: $participantsSnapshot, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShuttleImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.vehicleInfo, vehicleInfo) ||
                other.vehicleInfo == vehicleInfo) &&
            const DeepCollectionEquality().equals(other._purposes, _purposes) &&
            (identical(other.route, route) || other.route == route) &&
            (identical(other.schedule, schedule) ||
                other.schedule == schedule) &&
            (identical(other.capacity, capacity) ||
                other.capacity == capacity) &&
            (identical(other.costType, costType) ||
                other.costType == costType) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.contactName, contactName) ||
                other.contactName == contactName) &&
            (identical(other.contactPhoneMasked, contactPhoneMasked) ||
                other.contactPhoneMasked == contactPhoneMasked) &&
            (identical(other.creatorId, creatorId) ||
                other.creatorId == creatorId) &&
            (identical(other.chatRoomId, chatRoomId) ||
                other.chatRoomId == chatRoomId) &&
            const DeepCollectionEquality()
                .equals(other._participantsSnapshot, _participantsSnapshot) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      description,
      vehicleInfo,
      const DeepCollectionEquality().hash(_purposes),
      route,
      schedule,
      capacity,
      costType,
      status,
      priority,
      contactName,
      contactPhoneMasked,
      creatorId,
      chatRoomId,
      const DeepCollectionEquality().hash(_participantsSnapshot),
      createdAt,
      updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ShuttleImplCopyWith<_$ShuttleImpl> get copyWith =>
      __$$ShuttleImplCopyWithImpl<_$ShuttleImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ShuttleImplToJson(
      this,
    );
  }
}

abstract class _Shuttle implements Shuttle {
  const factory _Shuttle(
      {required final String id,
      required final LocalizedText title,
      final LocalizedText? description,
      @JsonKey(name: 'vehicle_info')
      required final ShuttleVehicleInfo vehicleInfo,
      final List<ShuttlePurpose> purposes,
      required final ShuttleRoute route,
      required final ShuttleSchedule schedule,
      required final ShuttleCapacity capacity,
      @JsonKey(name: 'cost_type') final ShuttleCostType costType,
      final ShuttleStatus status,
      final bool priority,
      @JsonKey(name: 'contact_name') final String? contactName,
      @JsonKey(name: 'contact_phone_masked') final String? contactPhoneMasked,
      @JsonKey(name: 'creator_id') required final String creatorId,
      @JsonKey(name: 'chat_room_id') final String? chatRoomId,
      @JsonKey(name: 'participants_snapshot')
      final List<String> participantsSnapshot,
      @JsonKey(name: 'created_at') final DateTime? createdAt,
      @JsonKey(name: 'updated_at') final DateTime? updatedAt}) = _$ShuttleImpl;

  factory _Shuttle.fromJson(Map<String, dynamic> json) = _$ShuttleImpl.fromJson;

  @override
  String get id;
  @override
  LocalizedText get title;
  @override
  LocalizedText? get description;
  @override
  @JsonKey(name: 'vehicle_info')
  ShuttleVehicleInfo get vehicleInfo;
  @override
  List<ShuttlePurpose> get purposes;
  @override
  ShuttleRoute get route;
  @override
  ShuttleSchedule get schedule;
  @override
  ShuttleCapacity get capacity;
  @override
  @JsonKey(name: 'cost_type')
  ShuttleCostType get costType;
  @override
  ShuttleStatus get status;
  @override
  bool get priority;
  @override
  @JsonKey(name: 'contact_name')
  String? get contactName;
  @override
  @JsonKey(name: 'contact_phone_masked')
  String? get contactPhoneMasked;
  @override
  @JsonKey(name: 'creator_id')
  String get creatorId;
  @override
  @JsonKey(name: 'chat_room_id')
  String? get chatRoomId;
  @override
  @JsonKey(name: 'participants_snapshot')
  List<String> get participantsSnapshot;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$ShuttleImplCopyWith<_$ShuttleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ShuttleParticipant _$ShuttleParticipantFromJson(Map<String, dynamic> json) {
  return _ShuttleParticipant.fromJson(json);
}

/// @nodoc
mixin _$ShuttleParticipant {
  @JsonKey(name: 'shuttle_id')
  String get shuttleId => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  String get role => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_visible')
  bool get isVisible => throw _privateConstructorUsedError;
  @JsonKey(name: 'joined_at')
  DateTime? get joinedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ShuttleParticipantCopyWith<ShuttleParticipant> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShuttleParticipantCopyWith<$Res> {
  factory $ShuttleParticipantCopyWith(
          ShuttleParticipant value, $Res Function(ShuttleParticipant) then) =
      _$ShuttleParticipantCopyWithImpl<$Res, ShuttleParticipant>;
  @useResult
  $Res call(
      {@JsonKey(name: 'shuttle_id') String shuttleId,
      @JsonKey(name: 'user_id') String userId,
      String role,
      @JsonKey(name: 'is_visible') bool isVisible,
      @JsonKey(name: 'joined_at') DateTime? joinedAt});
}

/// @nodoc
class _$ShuttleParticipantCopyWithImpl<$Res, $Val extends ShuttleParticipant>
    implements $ShuttleParticipantCopyWith<$Res> {
  _$ShuttleParticipantCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? shuttleId = null,
    Object? userId = null,
    Object? role = null,
    Object? isVisible = null,
    Object? joinedAt = freezed,
  }) {
    return _then(_value.copyWith(
      shuttleId: null == shuttleId
          ? _value.shuttleId
          : shuttleId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      isVisible: null == isVisible
          ? _value.isVisible
          : isVisible // ignore: cast_nullable_to_non_nullable
              as bool,
      joinedAt: freezed == joinedAt
          ? _value.joinedAt
          : joinedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ShuttleParticipantImplCopyWith<$Res>
    implements $ShuttleParticipantCopyWith<$Res> {
  factory _$$ShuttleParticipantImplCopyWith(_$ShuttleParticipantImpl value,
          $Res Function(_$ShuttleParticipantImpl) then) =
      __$$ShuttleParticipantImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'shuttle_id') String shuttleId,
      @JsonKey(name: 'user_id') String userId,
      String role,
      @JsonKey(name: 'is_visible') bool isVisible,
      @JsonKey(name: 'joined_at') DateTime? joinedAt});
}

/// @nodoc
class __$$ShuttleParticipantImplCopyWithImpl<$Res>
    extends _$ShuttleParticipantCopyWithImpl<$Res, _$ShuttleParticipantImpl>
    implements _$$ShuttleParticipantImplCopyWith<$Res> {
  __$$ShuttleParticipantImplCopyWithImpl(_$ShuttleParticipantImpl _value,
      $Res Function(_$ShuttleParticipantImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? shuttleId = null,
    Object? userId = null,
    Object? role = null,
    Object? isVisible = null,
    Object? joinedAt = freezed,
  }) {
    return _then(_$ShuttleParticipantImpl(
      shuttleId: null == shuttleId
          ? _value.shuttleId
          : shuttleId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      isVisible: null == isVisible
          ? _value.isVisible
          : isVisible // ignore: cast_nullable_to_non_nullable
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
class _$ShuttleParticipantImpl implements _ShuttleParticipant {
  const _$ShuttleParticipantImpl(
      {@JsonKey(name: 'shuttle_id') required this.shuttleId,
      @JsonKey(name: 'user_id') required this.userId,
      this.role = 'passenger',
      @JsonKey(name: 'is_visible') this.isVisible = true,
      @JsonKey(name: 'joined_at') this.joinedAt});

  factory _$ShuttleParticipantImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShuttleParticipantImplFromJson(json);

  @override
  @JsonKey(name: 'shuttle_id')
  final String shuttleId;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey()
  final String role;
  @override
  @JsonKey(name: 'is_visible')
  final bool isVisible;
  @override
  @JsonKey(name: 'joined_at')
  final DateTime? joinedAt;

  @override
  String toString() {
    return 'ShuttleParticipant(shuttleId: $shuttleId, userId: $userId, role: $role, isVisible: $isVisible, joinedAt: $joinedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShuttleParticipantImpl &&
            (identical(other.shuttleId, shuttleId) ||
                other.shuttleId == shuttleId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.isVisible, isVisible) ||
                other.isVisible == isVisible) &&
            (identical(other.joinedAt, joinedAt) ||
                other.joinedAt == joinedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, shuttleId, userId, role, isVisible, joinedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ShuttleParticipantImplCopyWith<_$ShuttleParticipantImpl> get copyWith =>
      __$$ShuttleParticipantImplCopyWithImpl<_$ShuttleParticipantImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ShuttleParticipantImplToJson(
      this,
    );
  }
}

abstract class _ShuttleParticipant implements ShuttleParticipant {
  const factory _ShuttleParticipant(
          {@JsonKey(name: 'shuttle_id') required final String shuttleId,
          @JsonKey(name: 'user_id') required final String userId,
          final String role,
          @JsonKey(name: 'is_visible') final bool isVisible,
          @JsonKey(name: 'joined_at') final DateTime? joinedAt}) =
      _$ShuttleParticipantImpl;

  factory _ShuttleParticipant.fromJson(Map<String, dynamic> json) =
      _$ShuttleParticipantImpl.fromJson;

  @override
  @JsonKey(name: 'shuttle_id')
  String get shuttleId;
  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  String get role;
  @override
  @JsonKey(name: 'is_visible')
  bool get isVisible;
  @override
  @JsonKey(name: 'joined_at')
  DateTime? get joinedAt;
  @override
  @JsonKey(ignore: true)
  _$$ShuttleParticipantImplCopyWith<_$ShuttleParticipantImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ShuttleMessage _$ShuttleMessageFromJson(Map<String, dynamic> json) {
  return _ShuttleMessage.fromJson(json);
}

/// @nodoc
mixin _$ShuttleMessage {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'shuttle_id')
  String get shuttleId => throw _privateConstructorUsedError;
  @JsonKey(name: 'author_id')
  String get authorId => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'expires_at')
  DateTime? get expiresAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ShuttleMessageCopyWith<ShuttleMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShuttleMessageCopyWith<$Res> {
  factory $ShuttleMessageCopyWith(
          ShuttleMessage value, $Res Function(ShuttleMessage) then) =
      _$ShuttleMessageCopyWithImpl<$Res, ShuttleMessage>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'shuttle_id') String shuttleId,
      @JsonKey(name: 'author_id') String authorId,
      String content,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'expires_at') DateTime? expiresAt});
}

/// @nodoc
class _$ShuttleMessageCopyWithImpl<$Res, $Val extends ShuttleMessage>
    implements $ShuttleMessageCopyWith<$Res> {
  _$ShuttleMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? shuttleId = null,
    Object? authorId = null,
    Object? content = null,
    Object? createdAt = freezed,
    Object? expiresAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      shuttleId: null == shuttleId
          ? _value.shuttleId
          : shuttleId // ignore: cast_nullable_to_non_nullable
              as String,
      authorId: null == authorId
          ? _value.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ShuttleMessageImplCopyWith<$Res>
    implements $ShuttleMessageCopyWith<$Res> {
  factory _$$ShuttleMessageImplCopyWith(_$ShuttleMessageImpl value,
          $Res Function(_$ShuttleMessageImpl) then) =
      __$$ShuttleMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'shuttle_id') String shuttleId,
      @JsonKey(name: 'author_id') String authorId,
      String content,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'expires_at') DateTime? expiresAt});
}

/// @nodoc
class __$$ShuttleMessageImplCopyWithImpl<$Res>
    extends _$ShuttleMessageCopyWithImpl<$Res, _$ShuttleMessageImpl>
    implements _$$ShuttleMessageImplCopyWith<$Res> {
  __$$ShuttleMessageImplCopyWithImpl(
      _$ShuttleMessageImpl _value, $Res Function(_$ShuttleMessageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? shuttleId = null,
    Object? authorId = null,
    Object? content = null,
    Object? createdAt = freezed,
    Object? expiresAt = freezed,
  }) {
    return _then(_$ShuttleMessageImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      shuttleId: null == shuttleId
          ? _value.shuttleId
          : shuttleId // ignore: cast_nullable_to_non_nullable
              as String,
      authorId: null == authorId
          ? _value.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ShuttleMessageImpl implements _ShuttleMessage {
  const _$ShuttleMessageImpl(
      {required this.id,
      @JsonKey(name: 'shuttle_id') required this.shuttleId,
      @JsonKey(name: 'author_id') required this.authorId,
      required this.content,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'expires_at') this.expiresAt});

  factory _$ShuttleMessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShuttleMessageImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'shuttle_id')
  final String shuttleId;
  @override
  @JsonKey(name: 'author_id')
  final String authorId;
  @override
  final String content;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'expires_at')
  final DateTime? expiresAt;

  @override
  String toString() {
    return 'ShuttleMessage(id: $id, shuttleId: $shuttleId, authorId: $authorId, content: $content, createdAt: $createdAt, expiresAt: $expiresAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShuttleMessageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.shuttleId, shuttleId) ||
                other.shuttleId == shuttleId) &&
            (identical(other.authorId, authorId) ||
                other.authorId == authorId) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, shuttleId, authorId, content, createdAt, expiresAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ShuttleMessageImplCopyWith<_$ShuttleMessageImpl> get copyWith =>
      __$$ShuttleMessageImplCopyWithImpl<_$ShuttleMessageImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ShuttleMessageImplToJson(
      this,
    );
  }
}

abstract class _ShuttleMessage implements ShuttleMessage {
  const factory _ShuttleMessage(
          {required final String id,
          @JsonKey(name: 'shuttle_id') required final String shuttleId,
          @JsonKey(name: 'author_id') required final String authorId,
          required final String content,
          @JsonKey(name: 'created_at') final DateTime? createdAt,
          @JsonKey(name: 'expires_at') final DateTime? expiresAt}) =
      _$ShuttleMessageImpl;

  factory _ShuttleMessage.fromJson(Map<String, dynamic> json) =
      _$ShuttleMessageImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'shuttle_id')
  String get shuttleId;
  @override
  @JsonKey(name: 'author_id')
  String get authorId;
  @override
  String get content;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'expires_at')
  DateTime? get expiresAt;
  @override
  @JsonKey(ignore: true)
  _$$ShuttleMessageImplCopyWith<_$ShuttleMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ResourcePoint _$ResourcePointFromJson(Map<String, dynamic> json) {
  return _ResourcePoint.fromJson(json);
}

/// @nodoc
mixin _$ResourcePoint {
  String get id => throw _privateConstructorUsedError;
  LocalizedText get title => throw _privateConstructorUsedError;
  LocalizedText? get description => throw _privateConstructorUsedError;
  List<ResourceCategory> get categories => throw _privateConstructorUsedError;
  @JsonKey(name: 'status')
  ResourceStatus get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'expiry')
  DateTime? get expiry => throw _privateConstructorUsedError;
  GeoLocation get location => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  @JsonKey(name: 'contact_masked_phone')
  String? get contactMaskedPhone => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_by')
  String get createdBy => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ResourcePointCopyWith<ResourcePoint> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResourcePointCopyWith<$Res> {
  factory $ResourcePointCopyWith(
          ResourcePoint value, $Res Function(ResourcePoint) then) =
      _$ResourcePointCopyWithImpl<$Res, ResourcePoint>;
  @useResult
  $Res call(
      {String id,
      LocalizedText title,
      LocalizedText? description,
      List<ResourceCategory> categories,
      @JsonKey(name: 'status') ResourceStatus status,
      @JsonKey(name: 'expiry') DateTime? expiry,
      GeoLocation location,
      String? address,
      @JsonKey(name: 'contact_masked_phone') String? contactMaskedPhone,
      @JsonKey(name: 'created_by') String createdBy,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt});

  $LocalizedTextCopyWith<$Res> get title;
  $LocalizedTextCopyWith<$Res>? get description;
  $GeoLocationCopyWith<$Res> get location;
}

/// @nodoc
class _$ResourcePointCopyWithImpl<$Res, $Val extends ResourcePoint>
    implements $ResourcePointCopyWith<$Res> {
  _$ResourcePointCopyWithImpl(this._value, this._then);

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
    Object? categories = null,
    Object? status = null,
    Object? expiry = freezed,
    Object? location = null,
    Object? address = freezed,
    Object? contactMaskedPhone = freezed,
    Object? createdBy = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as LocalizedText,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as LocalizedText?,
      categories: null == categories
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<ResourceCategory>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ResourceStatus,
      expiry: freezed == expiry
          ? _value.expiry
          : expiry // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as GeoLocation,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      contactMaskedPhone: freezed == contactMaskedPhone
          ? _value.contactMaskedPhone
          : contactMaskedPhone // ignore: cast_nullable_to_non_nullable
              as String?,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $LocalizedTextCopyWith<$Res> get title {
    return $LocalizedTextCopyWith<$Res>(_value.title, (value) {
      return _then(_value.copyWith(title: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $LocalizedTextCopyWith<$Res>? get description {
    if (_value.description == null) {
      return null;
    }

    return $LocalizedTextCopyWith<$Res>(_value.description!, (value) {
      return _then(_value.copyWith(description: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $GeoLocationCopyWith<$Res> get location {
    return $GeoLocationCopyWith<$Res>(_value.location, (value) {
      return _then(_value.copyWith(location: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ResourcePointImplCopyWith<$Res>
    implements $ResourcePointCopyWith<$Res> {
  factory _$$ResourcePointImplCopyWith(
          _$ResourcePointImpl value, $Res Function(_$ResourcePointImpl) then) =
      __$$ResourcePointImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      LocalizedText title,
      LocalizedText? description,
      List<ResourceCategory> categories,
      @JsonKey(name: 'status') ResourceStatus status,
      @JsonKey(name: 'expiry') DateTime? expiry,
      GeoLocation location,
      String? address,
      @JsonKey(name: 'contact_masked_phone') String? contactMaskedPhone,
      @JsonKey(name: 'created_by') String createdBy,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt});

  @override
  $LocalizedTextCopyWith<$Res> get title;
  @override
  $LocalizedTextCopyWith<$Res>? get description;
  @override
  $GeoLocationCopyWith<$Res> get location;
}

/// @nodoc
class __$$ResourcePointImplCopyWithImpl<$Res>
    extends _$ResourcePointCopyWithImpl<$Res, _$ResourcePointImpl>
    implements _$$ResourcePointImplCopyWith<$Res> {
  __$$ResourcePointImplCopyWithImpl(
      _$ResourcePointImpl _value, $Res Function(_$ResourcePointImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = freezed,
    Object? categories = null,
    Object? status = null,
    Object? expiry = freezed,
    Object? location = null,
    Object? address = freezed,
    Object? contactMaskedPhone = freezed,
    Object? createdBy = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$ResourcePointImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as LocalizedText,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as LocalizedText?,
      categories: null == categories
          ? _value._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<ResourceCategory>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ResourceStatus,
      expiry: freezed == expiry
          ? _value.expiry
          : expiry // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as GeoLocation,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      contactMaskedPhone: freezed == contactMaskedPhone
          ? _value.contactMaskedPhone
          : contactMaskedPhone // ignore: cast_nullable_to_non_nullable
              as String?,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ResourcePointImpl implements _ResourcePoint {
  const _$ResourcePointImpl(
      {required this.id,
      required this.title,
      this.description,
      final List<ResourceCategory> categories = const <ResourceCategory>[],
      @JsonKey(name: 'status') this.status = ResourceStatus.active,
      @JsonKey(name: 'expiry') this.expiry,
      required this.location,
      this.address,
      @JsonKey(name: 'contact_masked_phone') this.contactMaskedPhone,
      @JsonKey(name: 'created_by') required this.createdBy,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt})
      : _categories = categories;

  factory _$ResourcePointImpl.fromJson(Map<String, dynamic> json) =>
      _$$ResourcePointImplFromJson(json);

  @override
  final String id;
  @override
  final LocalizedText title;
  @override
  final LocalizedText? description;
  final List<ResourceCategory> _categories;
  @override
  @JsonKey()
  List<ResourceCategory> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  @override
  @JsonKey(name: 'status')
  final ResourceStatus status;
  @override
  @JsonKey(name: 'expiry')
  final DateTime? expiry;
  @override
  final GeoLocation location;
  @override
  final String? address;
  @override
  @JsonKey(name: 'contact_masked_phone')
  final String? contactMaskedPhone;
  @override
  @JsonKey(name: 'created_by')
  final String createdBy;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'ResourcePoint(id: $id, title: $title, description: $description, categories: $categories, status: $status, expiry: $expiry, location: $location, address: $address, contactMaskedPhone: $contactMaskedPhone, createdBy: $createdBy, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResourcePointImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.expiry, expiry) || other.expiry == expiry) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.contactMaskedPhone, contactMaskedPhone) ||
                other.contactMaskedPhone == contactMaskedPhone) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      description,
      const DeepCollectionEquality().hash(_categories),
      status,
      expiry,
      location,
      address,
      contactMaskedPhone,
      createdBy,
      createdAt,
      updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ResourcePointImplCopyWith<_$ResourcePointImpl> get copyWith =>
      __$$ResourcePointImplCopyWithImpl<_$ResourcePointImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ResourcePointImplToJson(
      this,
    );
  }
}

abstract class _ResourcePoint implements ResourcePoint {
  const factory _ResourcePoint(
      {required final String id,
      required final LocalizedText title,
      final LocalizedText? description,
      final List<ResourceCategory> categories,
      @JsonKey(name: 'status') final ResourceStatus status,
      @JsonKey(name: 'expiry') final DateTime? expiry,
      required final GeoLocation location,
      final String? address,
      @JsonKey(name: 'contact_masked_phone') final String? contactMaskedPhone,
      @JsonKey(name: 'created_by') required final String createdBy,
      @JsonKey(name: 'created_at') final DateTime? createdAt,
      @JsonKey(name: 'updated_at')
      final DateTime? updatedAt}) = _$ResourcePointImpl;

  factory _ResourcePoint.fromJson(Map<String, dynamic> json) =
      _$ResourcePointImpl.fromJson;

  @override
  String get id;
  @override
  LocalizedText get title;
  @override
  LocalizedText? get description;
  @override
  List<ResourceCategory> get categories;
  @override
  @JsonKey(name: 'status')
  ResourceStatus get status;
  @override
  @JsonKey(name: 'expiry')
  DateTime? get expiry;
  @override
  GeoLocation get location;
  @override
  String? get address;
  @override
  @JsonKey(name: 'contact_masked_phone')
  String? get contactMaskedPhone;
  @override
  @JsonKey(name: 'created_by')
  String get createdBy;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$ResourcePointImplCopyWith<_$ResourcePointImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ChatRoom _$ChatRoomFromJson(Map<String, dynamic> json) {
  return _ChatRoom.fromJson(json);
}

/// @nodoc
mixin _$ChatRoom {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'entity_type')
  String get entityType => throw _privateConstructorUsedError;
  @JsonKey(name: 'entity_id')
  String get entityId => throw _privateConstructorUsedError;
  @JsonKey(name: 'expires_at')
  DateTime? get expiresAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_by')
  String? get createdBy => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChatRoomCopyWith<ChatRoom> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatRoomCopyWith<$Res> {
  factory $ChatRoomCopyWith(ChatRoom value, $Res Function(ChatRoom) then) =
      _$ChatRoomCopyWithImpl<$Res, ChatRoom>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'entity_type') String entityType,
      @JsonKey(name: 'entity_id') String entityId,
      @JsonKey(name: 'expires_at') DateTime? expiresAt,
      @JsonKey(name: 'created_by') String? createdBy,
      @JsonKey(name: 'created_at') DateTime? createdAt});
}

/// @nodoc
class _$ChatRoomCopyWithImpl<$Res, $Val extends ChatRoom>
    implements $ChatRoomCopyWith<$Res> {
  _$ChatRoomCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? entityType = null,
    Object? entityId = null,
    Object? expiresAt = freezed,
    Object? createdBy = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      entityType: null == entityType
          ? _value.entityType
          : entityType // ignore: cast_nullable_to_non_nullable
              as String,
      entityId: null == entityId
          ? _value.entityId
          : entityId // ignore: cast_nullable_to_non_nullable
              as String,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChatRoomImplCopyWith<$Res>
    implements $ChatRoomCopyWith<$Res> {
  factory _$$ChatRoomImplCopyWith(
          _$ChatRoomImpl value, $Res Function(_$ChatRoomImpl) then) =
      __$$ChatRoomImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'entity_type') String entityType,
      @JsonKey(name: 'entity_id') String entityId,
      @JsonKey(name: 'expires_at') DateTime? expiresAt,
      @JsonKey(name: 'created_by') String? createdBy,
      @JsonKey(name: 'created_at') DateTime? createdAt});
}

/// @nodoc
class __$$ChatRoomImplCopyWithImpl<$Res>
    extends _$ChatRoomCopyWithImpl<$Res, _$ChatRoomImpl>
    implements _$$ChatRoomImplCopyWith<$Res> {
  __$$ChatRoomImplCopyWithImpl(
      _$ChatRoomImpl _value, $Res Function(_$ChatRoomImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? entityType = null,
    Object? entityId = null,
    Object? expiresAt = freezed,
    Object? createdBy = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$ChatRoomImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      entityType: null == entityType
          ? _value.entityType
          : entityType // ignore: cast_nullable_to_non_nullable
              as String,
      entityId: null == entityId
          ? _value.entityId
          : entityId // ignore: cast_nullable_to_non_nullable
              as String,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatRoomImpl implements _ChatRoom {
  const _$ChatRoomImpl(
      {required this.id,
      @JsonKey(name: 'entity_type') required this.entityType,
      @JsonKey(name: 'entity_id') required this.entityId,
      @JsonKey(name: 'expires_at') this.expiresAt,
      @JsonKey(name: 'created_by') this.createdBy,
      @JsonKey(name: 'created_at') this.createdAt});

  factory _$ChatRoomImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatRoomImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'entity_type')
  final String entityType;
  @override
  @JsonKey(name: 'entity_id')
  final String entityId;
  @override
  @JsonKey(name: 'expires_at')
  final DateTime? expiresAt;
  @override
  @JsonKey(name: 'created_by')
  final String? createdBy;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  @override
  String toString() {
    return 'ChatRoom(id: $id, entityType: $entityType, entityId: $entityId, expiresAt: $expiresAt, createdBy: $createdBy, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatRoomImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.entityType, entityType) ||
                other.entityType == entityType) &&
            (identical(other.entityId, entityId) ||
                other.entityId == entityId) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, entityType, entityId, expiresAt, createdBy, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatRoomImplCopyWith<_$ChatRoomImpl> get copyWith =>
      __$$ChatRoomImplCopyWithImpl<_$ChatRoomImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatRoomImplToJson(
      this,
    );
  }
}

abstract class _ChatRoom implements ChatRoom {
  const factory _ChatRoom(
      {required final String id,
      @JsonKey(name: 'entity_type') required final String entityType,
      @JsonKey(name: 'entity_id') required final String entityId,
      @JsonKey(name: 'expires_at') final DateTime? expiresAt,
      @JsonKey(name: 'created_by') final String? createdBy,
      @JsonKey(name: 'created_at') final DateTime? createdAt}) = _$ChatRoomImpl;

  factory _ChatRoom.fromJson(Map<String, dynamic> json) =
      _$ChatRoomImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'entity_type')
  String get entityType;
  @override
  @JsonKey(name: 'entity_id')
  String get entityId;
  @override
  @JsonKey(name: 'expires_at')
  DateTime? get expiresAt;
  @override
  @JsonKey(name: 'created_by')
  String? get createdBy;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$ChatRoomImplCopyWith<_$ChatRoomImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NotificationEvent _$NotificationEventFromJson(Map<String, dynamic> json) {
  return _NotificationEvent.fromJson(json);
}

/// @nodoc
mixin _$NotificationEvent {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'entity_type')
  String get entityType => throw _privateConstructorUsedError;
  @JsonKey(name: 'entity_id')
  String get entityId => throw _privateConstructorUsedError;
  NotificationPayload get payload => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NotificationEventCopyWith<NotificationEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationEventCopyWith<$Res> {
  factory $NotificationEventCopyWith(
          NotificationEvent value, $Res Function(NotificationEvent) then) =
      _$NotificationEventCopyWithImpl<$Res, NotificationEvent>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'entity_type') String entityType,
      @JsonKey(name: 'entity_id') String entityId,
      NotificationPayload payload,
      @JsonKey(name: 'created_at') DateTime? createdAt});

  $NotificationPayloadCopyWith<$Res> get payload;
}

/// @nodoc
class _$NotificationEventCopyWithImpl<$Res, $Val extends NotificationEvent>
    implements $NotificationEventCopyWith<$Res> {
  _$NotificationEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? entityType = null,
    Object? entityId = null,
    Object? payload = null,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      entityType: null == entityType
          ? _value.entityType
          : entityType // ignore: cast_nullable_to_non_nullable
              as String,
      entityId: null == entityId
          ? _value.entityId
          : entityId // ignore: cast_nullable_to_non_nullable
              as String,
      payload: null == payload
          ? _value.payload
          : payload // ignore: cast_nullable_to_non_nullable
              as NotificationPayload,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $NotificationPayloadCopyWith<$Res> get payload {
    return $NotificationPayloadCopyWith<$Res>(_value.payload, (value) {
      return _then(_value.copyWith(payload: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$NotificationEventImplCopyWith<$Res>
    implements $NotificationEventCopyWith<$Res> {
  factory _$$NotificationEventImplCopyWith(_$NotificationEventImpl value,
          $Res Function(_$NotificationEventImpl) then) =
      __$$NotificationEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'entity_type') String entityType,
      @JsonKey(name: 'entity_id') String entityId,
      NotificationPayload payload,
      @JsonKey(name: 'created_at') DateTime? createdAt});

  @override
  $NotificationPayloadCopyWith<$Res> get payload;
}

/// @nodoc
class __$$NotificationEventImplCopyWithImpl<$Res>
    extends _$NotificationEventCopyWithImpl<$Res, _$NotificationEventImpl>
    implements _$$NotificationEventImplCopyWith<$Res> {
  __$$NotificationEventImplCopyWithImpl(_$NotificationEventImpl _value,
      $Res Function(_$NotificationEventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? entityType = null,
    Object? entityId = null,
    Object? payload = null,
    Object? createdAt = freezed,
  }) {
    return _then(_$NotificationEventImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      entityType: null == entityType
          ? _value.entityType
          : entityType // ignore: cast_nullable_to_non_nullable
              as String,
      entityId: null == entityId
          ? _value.entityId
          : entityId // ignore: cast_nullable_to_non_nullable
              as String,
      payload: null == payload
          ? _value.payload
          : payload // ignore: cast_nullable_to_non_nullable
              as NotificationPayload,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationEventImpl implements _NotificationEvent {
  const _$NotificationEventImpl(
      {required this.id,
      @JsonKey(name: 'entity_type') required this.entityType,
      @JsonKey(name: 'entity_id') required this.entityId,
      required this.payload,
      @JsonKey(name: 'created_at') this.createdAt});

  factory _$NotificationEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotificationEventImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'entity_type')
  final String entityType;
  @override
  @JsonKey(name: 'entity_id')
  final String entityId;
  @override
  final NotificationPayload payload;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  @override
  String toString() {
    return 'NotificationEvent(id: $id, entityType: $entityType, entityId: $entityId, payload: $payload, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationEventImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.entityType, entityType) ||
                other.entityType == entityType) &&
            (identical(other.entityId, entityId) ||
                other.entityId == entityId) &&
            (identical(other.payload, payload) || other.payload == payload) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, entityType, entityId, payload, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationEventImplCopyWith<_$NotificationEventImpl> get copyWith =>
      __$$NotificationEventImplCopyWithImpl<_$NotificationEventImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationEventImplToJson(
      this,
    );
  }
}

abstract class _NotificationEvent implements NotificationEvent {
  const factory _NotificationEvent(
          {required final int id,
          @JsonKey(name: 'entity_type') required final String entityType,
          @JsonKey(name: 'entity_id') required final String entityId,
          required final NotificationPayload payload,
          @JsonKey(name: 'created_at') final DateTime? createdAt}) =
      _$NotificationEventImpl;

  factory _NotificationEvent.fromJson(Map<String, dynamic> json) =
      _$NotificationEventImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'entity_type')
  String get entityType;
  @override
  @JsonKey(name: 'entity_id')
  String get entityId;
  @override
  NotificationPayload get payload;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$NotificationEventImplCopyWith<_$NotificationEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NotificationPayload _$NotificationPayloadFromJson(Map<String, dynamic> json) {
  return _NotificationPayload.fromJson(json);
}

/// @nodoc
mixin _$NotificationPayload {
  @JsonKey(name: 'changed_fields')
  List<String> get changedFields => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NotificationPayloadCopyWith<NotificationPayload> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationPayloadCopyWith<$Res> {
  factory $NotificationPayloadCopyWith(
          NotificationPayload value, $Res Function(NotificationPayload) then) =
      _$NotificationPayloadCopyWithImpl<$Res, NotificationPayload>;
  @useResult
  $Res call(
      {@JsonKey(name: 'changed_fields') List<String> changedFields,
      String status,
      @JsonKey(name: 'updated_at') DateTime? updatedAt});
}

/// @nodoc
class _$NotificationPayloadCopyWithImpl<$Res, $Val extends NotificationPayload>
    implements $NotificationPayloadCopyWith<$Res> {
  _$NotificationPayloadCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? changedFields = null,
    Object? status = null,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      changedFields: null == changedFields
          ? _value.changedFields
          : changedFields // ignore: cast_nullable_to_non_nullable
              as List<String>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NotificationPayloadImplCopyWith<$Res>
    implements $NotificationPayloadCopyWith<$Res> {
  factory _$$NotificationPayloadImplCopyWith(_$NotificationPayloadImpl value,
          $Res Function(_$NotificationPayloadImpl) then) =
      __$$NotificationPayloadImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'changed_fields') List<String> changedFields,
      String status,
      @JsonKey(name: 'updated_at') DateTime? updatedAt});
}

/// @nodoc
class __$$NotificationPayloadImplCopyWithImpl<$Res>
    extends _$NotificationPayloadCopyWithImpl<$Res, _$NotificationPayloadImpl>
    implements _$$NotificationPayloadImplCopyWith<$Res> {
  __$$NotificationPayloadImplCopyWithImpl(_$NotificationPayloadImpl _value,
      $Res Function(_$NotificationPayloadImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? changedFields = null,
    Object? status = null,
    Object? updatedAt = freezed,
  }) {
    return _then(_$NotificationPayloadImpl(
      changedFields: null == changedFields
          ? _value._changedFields
          : changedFields // ignore: cast_nullable_to_non_nullable
              as List<String>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationPayloadImpl implements _NotificationPayload {
  const _$NotificationPayloadImpl(
      {@JsonKey(name: 'changed_fields')
      final List<String> changedFields = const <String>[],
      required this.status,
      @JsonKey(name: 'updated_at') this.updatedAt})
      : _changedFields = changedFields;

  factory _$NotificationPayloadImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotificationPayloadImplFromJson(json);

  final List<String> _changedFields;
  @override
  @JsonKey(name: 'changed_fields')
  List<String> get changedFields {
    if (_changedFields is EqualUnmodifiableListView) return _changedFields;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_changedFields);
  }

  @override
  final String status;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'NotificationPayload(changedFields: $changedFields, status: $status, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationPayloadImpl &&
            const DeepCollectionEquality()
                .equals(other._changedFields, _changedFields) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_changedFields), status, updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationPayloadImplCopyWith<_$NotificationPayloadImpl> get copyWith =>
      __$$NotificationPayloadImplCopyWithImpl<_$NotificationPayloadImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationPayloadImplToJson(
      this,
    );
  }
}

abstract class _NotificationPayload implements NotificationPayload {
  const factory _NotificationPayload(
          {@JsonKey(name: 'changed_fields') final List<String> changedFields,
          required final String status,
          @JsonKey(name: 'updated_at') final DateTime? updatedAt}) =
      _$NotificationPayloadImpl;

  factory _NotificationPayload.fromJson(Map<String, dynamic> json) =
      _$NotificationPayloadImpl.fromJson;

  @override
  @JsonKey(name: 'changed_fields')
  List<String> get changedFields;
  @override
  String get status;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$NotificationPayloadImplCopyWith<_$NotificationPayloadImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
