import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:isar/isar.dart';

part 'resource_point.freezed.dart';
part 'resource_point.g.dart';

@freezed
@Collection(ignore: {'copyWith'})
class ResourcePoint with _$ResourcePoint {
  const ResourcePoint._();

  const factory ResourcePoint({
    required String id,
    required String title,
    String? description,
    @Default('Other') String type, // Water, Shelter, Medical, Food, Other
    required double latitude,
    required double longitude,
    @Default(true) bool isActive,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    @Default([]) List<String> images,
  }) = _ResourcePoint;

  factory ResourcePoint.fromJson(Map<String, dynamic> json) =>
      _$ResourcePointFromJson(json);
      
  // Isar Id
  Id get isarId => fastHash(id);
}

// FNV-1a 64-bit hash algorithm optimized for Dart
int fastHash(String string) {
  var hash = 0xcbf29ce484222325;

  var i = 0;
  while (i < string.length) {
    final codeUnit = string.codeUnitAt(i++);
    hash ^= codeUnit >> 8;
    hash *= 0x100000001b3;
    hash ^= codeUnit & 0xFF;
    hash *= 0x100000001b3;
  }

  return hash;
}
