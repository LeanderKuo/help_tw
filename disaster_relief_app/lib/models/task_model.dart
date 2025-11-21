// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:isar/isar.dart';

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
    @JsonKey(name: 'materials_status') @Default('蝛拙?') String materialsStatus,
    @JsonKey(name: 'participant_count') @Default(0) int participantCount,
    @JsonKey(name: 'required_participants')
    @Default(0)
    int requiredParticipants,
    @Default([]) List<String> images,
    @JsonKey(name: 'assigned_to') String? assignedTo,
    @JsonKey(name: 'created_by') String? createdBy,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    @Default(false) bool isDraft, // Local only flag
    @JsonKey(includeFromJson: false, includeToJson: false) @Id() int? isarId,
  }) = _TaskModel;

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);

  /// Parse Supabase `tasks` rows (geography + snake_case fields).
  factory TaskModel.fromSupabase(Map<String, dynamic> json) {
    final lat = _toDouble(json['lat'] ?? json['latitude']);
    final lng = _toDouble(json['lng'] ?? json['longitude']);
    final isPriority = json['is_priority'] == true;
    final priorityStr =
        (json['priority'] as String?) ?? (isPriority ? 'Emergency' : 'Normal');

    return TaskModel(
      id: json['id'] as String,
      title: (json['title'] ?? '') as String,
      description: json['description'] as String?,
      status: (json['status'] as String?) ?? 'open',
      priority: priorityStr,
      roleLabel: json['role_label'] as String?,
      latitude: lat,
      longitude: lng,
      address: json['address'] as String?,
      materialsStatus: (json['materials_status'] as String?) ?? '蝛拙?',
      participantCount: (json['participant_count'] as num?)?.toInt() ?? 0,
      requiredParticipants:
          (json['required_participants'] as num?)?.toInt() ?? 0,
      images:
          (json['images'] as List?)?.whereType<String>().toList() ?? const [],
      assignedTo: json['assigned_to'] as String?,
      createdBy: json['author_id'] as String? ?? json['created_by'] as String?,
      createdAt: _parseDate(json['created_at']),
      updatedAt: _parseDate(json['updated_at']),
    );
  }

  /// Build payload matching Supabase column names and types.
  Map<String, dynamic> toSupabasePayload({String? authorId}) {
    final normalizedStatus = _normalizeTaskStatus(status);
    final priorityLower = priority.toLowerCase();
    final isPriority = priorityLower == 'emergency' || priorityLower == 'high';
    return {
      'id': id,
      'title': title,
      'description': description,
      'status': normalizedStatus,
      'is_priority': isPriority,
      'role_label': roleLabel,
      'address': address,
      'materials_status': materialsStatus,
      'required_participants': requiredParticipants,
      'author_id': authorId ?? createdBy,
      if (longitude != null && latitude != null)
        'location': 'POINT($longitude $latitude)',
    }..removeWhere((key, value) => value == null);
  }
}

DateTime? _parseDate(dynamic value) {
  if (value == null) return null;
  if (value is DateTime) return value;
  return DateTime.tryParse(value.toString());
}

double? _toDouble(dynamic value) {
  if (value == null) return null;
  if (value is num) return value.toDouble();
  return double.tryParse(value.toString());
}

String _normalizeTaskStatus(String status) {
  final lower = status.toLowerCase().replaceAll(' ', '_');
  if (lower == 'completed') return 'done';
  if (lower == 'cancelled') return 'canceled';
  return lower;
}
