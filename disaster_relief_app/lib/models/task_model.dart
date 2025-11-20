import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:isar/isar.dart';
import 'resource_point.dart'; // For fastHash

part 'task_model.freezed.dart';
part 'task_model.g.dart';

@freezed
@Collection()
class TaskModel with _$TaskModel {
  const TaskModel._();

  const factory TaskModel({
    required String id,
    required String title,
    String? description,
    @Default('Open') String status, // Open, In Progress, Completed, Cancelled
    @Default('Normal') String priority, // Low, Normal, High, Emergency
    @JsonKey(name: 'role_label') String? roleLabel,
    double? latitude,
    double? longitude,
    String? address,
    @JsonKey(name: 'materials_status') @Default('穩定') String materialsStatus,
    @JsonKey(name: 'participant_count') @Default(0) int participantCount,
    @JsonKey(name: 'required_participants') @Default(0) int requiredParticipants,
    @Default([]) List<String> images,
    @JsonKey(name: 'assigned_to') String? assignedTo,
    @JsonKey(name: 'created_by') String? createdBy,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    @Default(false) bool isDraft, // Local only flag
    @JsonKey(ignore: true) @Id() int? isarId,
  }) = _TaskModel;

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);
}
