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
    @JsonKey(name: 'materials_status') @Default('穩定') String materialsStatus,
    @JsonKey(name: 'participant_count') @Default(0) int participantCount,
    @JsonKey(name: 'required_participants') @Default(0) int requiredParticipants,
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

  /// Parse Supabase `missions` rows.
  factory TaskModel.fromSupabase(Map<String, dynamic> json) {
    final location = json['location'] as Map<String, dynamic>?;
    final lat = _toDouble(location?['lat'] ?? json['lat'] ?? json['latitude']);
    final lng = _toDouble(location?['lng'] ?? json['lng'] ?? json['longitude']);
    final isPriority = json['priority'] == true || json['is_priority'] == true;
    final priorityStr = isPriority ? 'Emergency' : 'Normal';

    final requirements = json['requirements'] as Map<String, dynamic>?;
    final manpowerNeeded =
        (requirements?['manpower_needed'] as num?)?.toInt() ?? 0;
    final materials = (requirements?['materials'] as List?) ?? const [];

    return TaskModel(
      id: json['id'] as String,
      title: _localizedText(json['title']),
      description: _localizedText(json['description']),
      status: (json['status'] as String?) ?? 'open',
      priority: priorityStr,
      roleLabel: json['role_label'] as String?,
      latitude: lat,
      longitude: lng,
      address: location?['address'] as String?,
      materialsStatus: materials.isNotEmpty ? '需求' : '穩定',
      participantCount: (json['participant_count'] as num?)?.toInt() ?? 0,
      requiredParticipants: manpowerNeeded,
      images:
          (json['images'] as List?)?.whereType<String>().toList() ?? const [],
      assignedTo: json['assigned_to'] as String?,
      createdBy: json['creator_id'] as String? ?? json['created_by'] as String?,
      createdAt: _parseDate(json['created_at']),
      updatedAt: _parseDate(json['updated_at']),
    );
  }

  /// Build payload matching Supabase column names and types.
  Map<String, dynamic> toSupabasePayload({String? authorId}) {
    final normalizedStatus = _normalizeTaskStatus(status);
    final priorityLower = priority.toLowerCase();
    final isPriority = priorityLower == 'emergency' || priorityLower == 'high';
    final locationJson = (longitude != null && latitude != null)
        ? {
            'lat': latitude,
            'lng': longitude,
            if (address != null) 'address': address,
          }
        : null;
    final requirementsJson = {
      'materials': <String>[],
      'manpower_needed': requiredParticipants,
      'manpower_current': 0,
    };
    return {
      'id': id,
      'title': {'zh-TW': title, 'en-US': title},
      if (description != null)
        'description': {'zh-TW': description, 'en-US': description},
      'status': normalizedStatus,
      'priority': isPriority,
      'requirements': requirementsJson,
      if (locationJson != null) 'location': locationJson,
      'creator_id': authorId ?? createdBy,
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

String _localizedText(dynamic payload) {
  if (payload == null) return '';
  if (payload is String) return payload;
  if (payload is Map) {
    final zh = payload['zh-TW'] ?? payload['zh_tw'];
    final en = payload['en-US'] ?? payload['en_us'];
    return (zh ?? en ?? '').toString();
  }
  return payload.toString();
}
