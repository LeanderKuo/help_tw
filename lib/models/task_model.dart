import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:isar/isar.dart';
import 'resource_point.dart'; // For fastHash

part 'task_model.freezed.dart';
part 'task_model.g.dart';

@freezed
@Collection(ignore: {'copyWith'})
class TaskModel with _$TaskModel {
  const TaskModel._();

  const factory TaskModel({
    required String id,
    required String title,
    String? description,
    @Default('Open') String status, // Open, In Progress, Completed, Cancelled
    @Default('Normal') String priority, // Low, Normal, High, Emergency
    double? latitude,
    double? longitude,
    @Default([]) List<String> images,
    @JsonKey(name: 'assigned_to') String? assignedTo,
    @JsonKey(name: 'created_by') String? createdBy,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    @Default(false) bool isDraft, // Local only flag
  }) = _TaskModel;

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);

  Id get isarId => fastHash(id);
}
