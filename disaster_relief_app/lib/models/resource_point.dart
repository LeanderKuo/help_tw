import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:isar/isar.dart';

part 'resource_point.freezed.dart';
part 'resource_point.g.dart';

@freezed
@Collection()
class ResourcePoint with _$ResourcePoint {
  const ResourcePoint._();

  const factory ResourcePoint({
    required String id,
    required String title,
    String? description,
    @Default('Other') String type, // Water, Shelter, Medical, Food, Other
    required double latitude,
    required double longitude,
    String? address,
    @JsonKey(name: 'expires_at') DateTime? expiresAt,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
    @JsonKey(name: 'created_by') String? createdBy,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    @Default([]) List<String> images,
    @Default([]) List<String> tags,
    @JsonKey(ignore: true) @Id() int? isarId,
  }) = _ResourcePoint;

  factory ResourcePoint.fromJson(Map<String, dynamic> json) =>
      _$ResourcePointFromJson(json);
}

// FNV-1a 64-bit hash algorithm optimized for Dart
int fastHash(String string) {
  var hash = 0x811c9dc5;
  for (var i = 0; i < string.length; i++) {
    hash ^= string.codeUnitAt(i);
    hash *= 0x01000193;
    hash &= 0xFFFFFFFF; // Ensure 32-bit
  }
  return hash;
}
