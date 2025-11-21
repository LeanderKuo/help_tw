// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'resource_point.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ResourcePoint _$ResourcePointFromJson(Map<String, dynamic> json) {
  return _ResourcePoint.fromJson(json);
}

/// @nodoc
mixin _$ResourcePoint {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String get type =>
      throw _privateConstructorUsedError; // Water, Shelter, Medical, Food, Other
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  @JsonKey(name: 'expires_at')
  DateTime? get expiresAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  bool get isActive => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_by')
  String? get createdBy => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  List<String> get images => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  @Id()
  int? get isarId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ResourcePointCopyWith<ResourcePoint> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResourcePointCopyWith<$Res> {
  factory $ResourcePointCopyWith(
    ResourcePoint value,
    $Res Function(ResourcePoint) then,
  ) = _$ResourcePointCopyWithImpl<$Res, ResourcePoint>;
  @useResult
  $Res call({
    String id,
    String title,
    String? description,
    String type,
    double latitude,
    double longitude,
    String? address,
    @JsonKey(name: 'expires_at') DateTime? expiresAt,
    @JsonKey(name: 'is_active') bool isActive,
    @JsonKey(name: 'created_by') String? createdBy,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    List<String> images,
    List<String> tags,
    @JsonKey(includeFromJson: false, includeToJson: false) @Id() int? isarId,
  });
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
    Object? type = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? address = freezed,
    Object? expiresAt = freezed,
    Object? isActive = null,
    Object? createdBy = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? images = null,
    Object? tags = null,
    Object? isarId = freezed,
  }) {
    return _then(
      _value.copyWith(
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
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            latitude: null == latitude
                ? _value.latitude
                : latitude // ignore: cast_nullable_to_non_nullable
                      as double,
            longitude: null == longitude
                ? _value.longitude
                : longitude // ignore: cast_nullable_to_non_nullable
                      as double,
            address: freezed == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                      as String?,
            expiresAt: freezed == expiresAt
                ? _value.expiresAt
                : expiresAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
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
            images: null == images
                ? _value.images
                : images // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            tags: null == tags
                ? _value.tags
                : tags // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            isarId: freezed == isarId
                ? _value.isarId
                : isarId // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ResourcePointImplCopyWith<$Res>
    implements $ResourcePointCopyWith<$Res> {
  factory _$$ResourcePointImplCopyWith(
    _$ResourcePointImpl value,
    $Res Function(_$ResourcePointImpl) then,
  ) = __$$ResourcePointImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String? description,
    String type,
    double latitude,
    double longitude,
    String? address,
    @JsonKey(name: 'expires_at') DateTime? expiresAt,
    @JsonKey(name: 'is_active') bool isActive,
    @JsonKey(name: 'created_by') String? createdBy,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    List<String> images,
    List<String> tags,
    @JsonKey(includeFromJson: false, includeToJson: false) @Id() int? isarId,
  });
}

/// @nodoc
class __$$ResourcePointImplCopyWithImpl<$Res>
    extends _$ResourcePointCopyWithImpl<$Res, _$ResourcePointImpl>
    implements _$$ResourcePointImplCopyWith<$Res> {
  __$$ResourcePointImplCopyWithImpl(
    _$ResourcePointImpl _value,
    $Res Function(_$ResourcePointImpl) _then,
  ) : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = freezed,
    Object? type = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? address = freezed,
    Object? expiresAt = freezed,
    Object? isActive = null,
    Object? createdBy = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? images = null,
    Object? tags = null,
    Object? isarId = freezed,
  }) {
    return _then(
      _$ResourcePointImpl(
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
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        latitude: null == latitude
            ? _value.latitude
            : latitude // ignore: cast_nullable_to_non_nullable
                  as double,
        longitude: null == longitude
            ? _value.longitude
            : longitude // ignore: cast_nullable_to_non_nullable
                  as double,
        address: freezed == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
                  as String?,
        expiresAt: freezed == expiresAt
            ? _value.expiresAt
            : expiresAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
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
        images: null == images
            ? _value._images
            : images // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        tags: null == tags
            ? _value._tags
            : tags // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        isarId: freezed == isarId
            ? _value.isarId
            : isarId // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ResourcePointImpl extends _ResourcePoint {
  const _$ResourcePointImpl({
    required this.id,
    required this.title,
    this.description,
    this.type = 'Other',
    required this.latitude,
    required this.longitude,
    this.address,
    @JsonKey(name: 'expires_at') this.expiresAt,
    @JsonKey(name: 'is_active') this.isActive = true,
    @JsonKey(name: 'created_by') this.createdBy,
    @JsonKey(name: 'created_at') this.createdAt,
    @JsonKey(name: 'updated_at') this.updatedAt,
    final List<String> images = const [],
    final List<String> tags = const [],
    @JsonKey(includeFromJson: false, includeToJson: false) @Id() this.isarId,
  }) : _images = images,
       _tags = tags,
       super._();

  factory _$ResourcePointImpl.fromJson(Map<String, dynamic> json) =>
      _$$ResourcePointImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String? description;
  @override
  @JsonKey()
  final String type;
  // Water, Shelter, Medical, Food, Other
  @override
  final double latitude;
  @override
  final double longitude;
  @override
  final String? address;
  @override
  @JsonKey(name: 'expires_at')
  final DateTime? expiresAt;
  @override
  @JsonKey(name: 'is_active')
  final bool isActive;
  @override
  @JsonKey(name: 'created_by')
  final String? createdBy;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
  final List<String> _images;
  @override
  @JsonKey()
  List<String> get images {
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_images);
  }

  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @Id()
  final int? isarId;

  @override
  String toString() {
    return 'ResourcePoint(id: $id, title: $title, description: $description, type: $type, latitude: $latitude, longitude: $longitude, address: $address, expiresAt: $expiresAt, isActive: $isActive, createdBy: $createdBy, createdAt: $createdAt, updatedAt: $updatedAt, images: $images, tags: $tags, isarId: $isarId)';
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
            (identical(other.type, type) || other.type == type) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality().equals(other._images, _images) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.isarId, isarId) || other.isarId == isarId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    description,
    type,
    latitude,
    longitude,
    address,
    expiresAt,
    isActive,
    createdBy,
    createdAt,
    updatedAt,
    const DeepCollectionEquality().hash(_images),
    const DeepCollectionEquality().hash(_tags),
    isarId,
  );

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ResourcePointImplCopyWith<_$ResourcePointImpl> get copyWith =>
      __$$ResourcePointImplCopyWithImpl<_$ResourcePointImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ResourcePointImplToJson(this);
  }
}

abstract class _ResourcePoint extends ResourcePoint {
  const factory _ResourcePoint({
    required final String id,
    required final String title,
    final String? description,
    final String type,
    required final double latitude,
    required final double longitude,
    final String? address,
    @JsonKey(name: 'expires_at') final DateTime? expiresAt,
    @JsonKey(name: 'is_active') final bool isActive,
    @JsonKey(name: 'created_by') final String? createdBy,
    @JsonKey(name: 'created_at') final DateTime? createdAt,
    @JsonKey(name: 'updated_at') final DateTime? updatedAt,
    final List<String> images,
    final List<String> tags,
    @JsonKey(includeFromJson: false, includeToJson: false)
    @Id()
    final int? isarId,
  }) = _$ResourcePointImpl;
  const _ResourcePoint._() : super._();

  factory _ResourcePoint.fromJson(Map<String, dynamic> json) =
      _$ResourcePointImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String? get description;
  @override
  String get type;
  @override // Water, Shelter, Medical, Food, Other
  double get latitude;
  @override
  double get longitude;
  @override
  String? get address;
  @override
  @JsonKey(name: 'expires_at')
  DateTime? get expiresAt;
  @override
  @JsonKey(name: 'is_active')
  bool get isActive;
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
  List<String> get images;
  @override
  List<String> get tags;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @Id()
  int? get isarId;
  @override
  @JsonKey(ignore: true)
  _$$ResourcePointImplCopyWith<_$ResourcePointImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
