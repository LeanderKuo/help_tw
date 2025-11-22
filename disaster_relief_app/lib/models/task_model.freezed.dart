// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TaskModel _$TaskModelFromJson(Map<String, dynamic> json) {
  return _TaskModel.fromJson(json);
}

/// @nodoc
mixin _$TaskModel {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String get status =>
      throw _privateConstructorUsedError; // Open, In Progress, Completed, Cancelled
  String get priority =>
      throw _privateConstructorUsedError; // Low, Normal, High, Emergency
  @JsonKey(name: 'role_label')
  String? get roleLabel => throw _privateConstructorUsedError;
  double? get latitude => throw _privateConstructorUsedError;
  double? get longitude => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  @JsonKey(name: 'materials_status')
  String get materialsStatus => throw _privateConstructorUsedError;
  @JsonKey(name: 'participant_count')
  int get participantCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'required_participants')
  int get requiredParticipants => throw _privateConstructorUsedError;
  List<String> get images => throw _privateConstructorUsedError;
  @JsonKey(name: 'assigned_to')
  String? get assignedTo => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_by')
  String? get createdBy => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  bool get isDraft => throw _privateConstructorUsedError; // Local only flag
  @JsonKey(includeFromJson: false, includeToJson: false)
  @Id()
  int? get isarId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TaskModelCopyWith<TaskModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskModelCopyWith<$Res> {
  factory $TaskModelCopyWith(TaskModel value, $Res Function(TaskModel) then) =
      _$TaskModelCopyWithImpl<$Res, TaskModel>;
  @useResult
  $Res call(
      {String id,
      String title,
      String? description,
      String status,
      String priority,
      @JsonKey(name: 'role_label') String? roleLabel,
      double? latitude,
      double? longitude,
      String? address,
      @JsonKey(name: 'materials_status') String materialsStatus,
      @JsonKey(name: 'participant_count') int participantCount,
      @JsonKey(name: 'required_participants') int requiredParticipants,
      List<String> images,
      @JsonKey(name: 'assigned_to') String? assignedTo,
      @JsonKey(name: 'created_by') String? createdBy,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt,
      bool isDraft,
      @JsonKey(includeFromJson: false, includeToJson: false)
      @Id()
      int? isarId});
}

/// @nodoc
class _$TaskModelCopyWithImpl<$Res, $Val extends TaskModel>
    implements $TaskModelCopyWith<$Res> {
  _$TaskModelCopyWithImpl(this._value, this._then);

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
    Object? priority = null,
    Object? roleLabel = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? address = freezed,
    Object? materialsStatus = null,
    Object? participantCount = null,
    Object? requiredParticipants = null,
    Object? images = null,
    Object? assignedTo = freezed,
    Object? createdBy = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? isDraft = null,
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
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as String,
      roleLabel: freezed == roleLabel
          ? _value.roleLabel
          : roleLabel // ignore: cast_nullable_to_non_nullable
              as String?,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      materialsStatus: null == materialsStatus
          ? _value.materialsStatus
          : materialsStatus // ignore: cast_nullable_to_non_nullable
              as String,
      participantCount: null == participantCount
          ? _value.participantCount
          : participantCount // ignore: cast_nullable_to_non_nullable
              as int,
      requiredParticipants: null == requiredParticipants
          ? _value.requiredParticipants
          : requiredParticipants // ignore: cast_nullable_to_non_nullable
              as int,
      images: null == images
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>,
      assignedTo: freezed == assignedTo
          ? _value.assignedTo
          : assignedTo // ignore: cast_nullable_to_non_nullable
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
      isDraft: null == isDraft
          ? _value.isDraft
          : isDraft // ignore: cast_nullable_to_non_nullable
              as bool,
      isarId: freezed == isarId
          ? _value.isarId
          : isarId // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TaskModelImplCopyWith<$Res>
    implements $TaskModelCopyWith<$Res> {
  factory _$$TaskModelImplCopyWith(
          _$TaskModelImpl value, $Res Function(_$TaskModelImpl) then) =
      __$$TaskModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String? description,
      String status,
      String priority,
      @JsonKey(name: 'role_label') String? roleLabel,
      double? latitude,
      double? longitude,
      String? address,
      @JsonKey(name: 'materials_status') String materialsStatus,
      @JsonKey(name: 'participant_count') int participantCount,
      @JsonKey(name: 'required_participants') int requiredParticipants,
      List<String> images,
      @JsonKey(name: 'assigned_to') String? assignedTo,
      @JsonKey(name: 'created_by') String? createdBy,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt,
      bool isDraft,
      @JsonKey(includeFromJson: false, includeToJson: false)
      @Id()
      int? isarId});
}

/// @nodoc
class __$$TaskModelImplCopyWithImpl<$Res>
    extends _$TaskModelCopyWithImpl<$Res, _$TaskModelImpl>
    implements _$$TaskModelImplCopyWith<$Res> {
  __$$TaskModelImplCopyWithImpl(
      _$TaskModelImpl _value, $Res Function(_$TaskModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = freezed,
    Object? status = null,
    Object? priority = null,
    Object? roleLabel = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? address = freezed,
    Object? materialsStatus = null,
    Object? participantCount = null,
    Object? requiredParticipants = null,
    Object? images = null,
    Object? assignedTo = freezed,
    Object? createdBy = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? isDraft = null,
    Object? isarId = freezed,
  }) {
    return _then(_$TaskModelImpl(
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
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as String,
      roleLabel: freezed == roleLabel
          ? _value.roleLabel
          : roleLabel // ignore: cast_nullable_to_non_nullable
              as String?,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      materialsStatus: null == materialsStatus
          ? _value.materialsStatus
          : materialsStatus // ignore: cast_nullable_to_non_nullable
              as String,
      participantCount: null == participantCount
          ? _value.participantCount
          : participantCount // ignore: cast_nullable_to_non_nullable
              as int,
      requiredParticipants: null == requiredParticipants
          ? _value.requiredParticipants
          : requiredParticipants // ignore: cast_nullable_to_non_nullable
              as int,
      images: null == images
          ? _value._images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>,
      assignedTo: freezed == assignedTo
          ? _value.assignedTo
          : assignedTo // ignore: cast_nullable_to_non_nullable
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
      isDraft: null == isDraft
          ? _value.isDraft
          : isDraft // ignore: cast_nullable_to_non_nullable
              as bool,
      isarId: freezed == isarId
          ? _value.isarId
          : isarId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TaskModelImpl extends _TaskModel {
  const _$TaskModelImpl(
      {required this.id,
      required this.title,
      this.description,
      this.status = 'Open',
      this.priority = 'Normal',
      @JsonKey(name: 'role_label') this.roleLabel,
      this.latitude,
      this.longitude,
      this.address,
      @JsonKey(name: 'materials_status') this.materialsStatus = '穩定',
      @JsonKey(name: 'participant_count') this.participantCount = 0,
      @JsonKey(name: 'required_participants') this.requiredParticipants = 0,
      final List<String> images = const [],
      @JsonKey(name: 'assigned_to') this.assignedTo,
      @JsonKey(name: 'created_by') this.createdBy,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt,
      this.isDraft = false,
      @JsonKey(includeFromJson: false, includeToJson: false) @Id() this.isarId})
      : _images = images,
        super._();

  factory _$TaskModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaskModelImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String? description;
  @override
  @JsonKey()
  final String status;
// Open, In Progress, Completed, Cancelled
  @override
  @JsonKey()
  final String priority;
// Low, Normal, High, Emergency
  @override
  @JsonKey(name: 'role_label')
  final String? roleLabel;
  @override
  final double? latitude;
  @override
  final double? longitude;
  @override
  final String? address;
  @override
  @JsonKey(name: 'materials_status')
  final String materialsStatus;
  @override
  @JsonKey(name: 'participant_count')
  final int participantCount;
  @override
  @JsonKey(name: 'required_participants')
  final int requiredParticipants;
  final List<String> _images;
  @override
  @JsonKey()
  List<String> get images {
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_images);
  }

  @override
  @JsonKey(name: 'assigned_to')
  final String? assignedTo;
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
  @JsonKey()
  final bool isDraft;
// Local only flag
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @Id()
  final int? isarId;

  @override
  String toString() {
    return 'TaskModel(id: $id, title: $title, description: $description, status: $status, priority: $priority, roleLabel: $roleLabel, latitude: $latitude, longitude: $longitude, address: $address, materialsStatus: $materialsStatus, participantCount: $participantCount, requiredParticipants: $requiredParticipants, images: $images, assignedTo: $assignedTo, createdBy: $createdBy, createdAt: $createdAt, updatedAt: $updatedAt, isDraft: $isDraft, isarId: $isarId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.roleLabel, roleLabel) ||
                other.roleLabel == roleLabel) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.materialsStatus, materialsStatus) ||
                other.materialsStatus == materialsStatus) &&
            (identical(other.participantCount, participantCount) ||
                other.participantCount == participantCount) &&
            (identical(other.requiredParticipants, requiredParticipants) ||
                other.requiredParticipants == requiredParticipants) &&
            const DeepCollectionEquality().equals(other._images, _images) &&
            (identical(other.assignedTo, assignedTo) ||
                other.assignedTo == assignedTo) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.isDraft, isDraft) || other.isDraft == isDraft) &&
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
        priority,
        roleLabel,
        latitude,
        longitude,
        address,
        materialsStatus,
        participantCount,
        requiredParticipants,
        const DeepCollectionEquality().hash(_images),
        assignedTo,
        createdBy,
        createdAt,
        updatedAt,
        isDraft,
        isarId
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskModelImplCopyWith<_$TaskModelImpl> get copyWith =>
      __$$TaskModelImplCopyWithImpl<_$TaskModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TaskModelImplToJson(
      this,
    );
  }
}

abstract class _TaskModel extends TaskModel {
  const factory _TaskModel(
      {required final String id,
      required final String title,
      final String? description,
      final String status,
      final String priority,
      @JsonKey(name: 'role_label') final String? roleLabel,
      final double? latitude,
      final double? longitude,
      final String? address,
      @JsonKey(name: 'materials_status') final String materialsStatus,
      @JsonKey(name: 'participant_count') final int participantCount,
      @JsonKey(name: 'required_participants') final int requiredParticipants,
      final List<String> images,
      @JsonKey(name: 'assigned_to') final String? assignedTo,
      @JsonKey(name: 'created_by') final String? createdBy,
      @JsonKey(name: 'created_at') final DateTime? createdAt,
      @JsonKey(name: 'updated_at') final DateTime? updatedAt,
      final bool isDraft,
      @JsonKey(includeFromJson: false, includeToJson: false)
      @Id()
      final int? isarId}) = _$TaskModelImpl;
  const _TaskModel._() : super._();

  factory _TaskModel.fromJson(Map<String, dynamic> json) =
      _$TaskModelImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String? get description;
  @override
  String get status;
  @override // Open, In Progress, Completed, Cancelled
  String get priority;
  @override // Low, Normal, High, Emergency
  @JsonKey(name: 'role_label')
  String? get roleLabel;
  @override
  double? get latitude;
  @override
  double? get longitude;
  @override
  String? get address;
  @override
  @JsonKey(name: 'materials_status')
  String get materialsStatus;
  @override
  @JsonKey(name: 'participant_count')
  int get participantCount;
  @override
  @JsonKey(name: 'required_participants')
  int get requiredParticipants;
  @override
  List<String> get images;
  @override
  @JsonKey(name: 'assigned_to')
  String? get assignedTo;
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
  bool get isDraft;
  @override // Local only flag
  @JsonKey(includeFromJson: false, includeToJson: false)
  @Id()
  int? get isarId;
  @override
  @JsonKey(ignore: true)
  _$$TaskModelImplCopyWith<_$TaskModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
