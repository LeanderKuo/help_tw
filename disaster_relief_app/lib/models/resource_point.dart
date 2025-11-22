// ignore_for_file: invalid_annotation_target

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
    @Default(<String>[]) List<String> categories,
    @Default('active') String status, // active, shortage, closed
    required double latitude,
    required double longitude,
    String? address,
    @JsonKey(name: 'expiry') DateTime? expiry,
    @JsonKey(name: 'contact_masked_phone') String? contactMaskedPhone,
    @JsonKey(name: 'created_by') String? createdBy,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    @Default([]) List<String> images,
    @JsonKey(includeFromJson: false, includeToJson: false) @Id() int? isarId,
  }) = _ResourcePoint;

  factory ResourcePoint.fromJson(Map<String, dynamic> json) =>
      _$ResourcePointFromJson(json);

  /// Parse Supabase `resource_points` rows (jsonb title/description + geography).
  factory ResourcePoint.fromSupabase(Map<String, dynamic> json) {
    final lat = _toDouble(json['lat'] ?? json['latitude']);
    final lng = _toDouble(json['lng'] ?? json['longitude']);
    final geo = json['location'];
    double? parsedLat = lat;
    double? parsedLng = lng;

    if ((parsedLat == null || parsedLng == null) &&
        geo is Map &&
        geo['coordinates'] is List) {
      final coords = (geo['coordinates'] as List);
      if (coords.length >= 2) {
        parsedLng = _toDouble(coords[0]) ?? parsedLng;
        parsedLat = _toDouble(coords[1]) ?? parsedLat;
      }
    }
    final rawType = (json['resource_type'] as String?) ?? 'other';
    final normalizedType = rawType.isEmpty
        ? 'other'
        : '${rawType[0].toUpperCase()}${rawType.substring(1)}';
    final categories = (json['categories'] as List?)?.whereType<String>().toList() ?? const [];
    final status = (json['status'] as String?) ?? 'active';

    return ResourcePoint(
      id: json['id'] as String,
      title: _localizedText(json['title']),
      description: _localizedText(json['description']),
      type: normalizedType,
      categories: categories,
      status: status,
      latitude: parsedLat ?? 0,
      longitude: parsedLng ?? 0,
      address: json['address'] as String?,
      expiry: _parseDate(json['expiry'] ?? json['expires_at']),
      contactMaskedPhone: json['contact_masked_phone'] as String?,
      createdBy: json['created_by'] as String?,
      createdAt: _parseDate(json['created_at']),
      updatedAt: _parseDate(json['updated_at']),
    );
  }

  /// Build a payload that matches Supabase column names.
  /// Now accepts separate translations for title and description.
  Map<String, dynamic> toSupabasePayload({
    String? titleZh,
    String? titleEn,
    String? descriptionZh,
    String? descriptionEn,
  }) {
    final normalizedType = type.toLowerCase();
    return {
      'id': id,
      'title': {
        'zh-TW': titleZh ?? title,
        'en-US': titleEn ?? title,
      },
      if (description != null || descriptionZh != null || descriptionEn != null)
        'description': {
          'zh-TW': descriptionZh ?? description ?? '',
          'en-US': descriptionEn ?? description ?? '',
        },
      'categories': categories.isEmpty ? [normalizedType] : categories,
      'status': status,
      'address': address,
      'location': 'POINT($longitude $latitude)',
      'expiry': expiry?.toIso8601String(),
      'contact_masked_phone': contactMaskedPhone,
      'created_by': createdBy,
    }..removeWhere((key, value) => value == null);
  }
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
