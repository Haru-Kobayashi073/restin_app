import 'package:freezed_annotation/freezed_annotation.dart';

part 'marker_data.freezed.dart';
part 'marker_data.g.dart';

@freezed
abstract class MarkerData with _$MarkerData {
  const factory MarkerData({
    required String creatorId,
    required String markerId,
    required dynamic createdAt,
    required String title,
    required String description,
    String? imageUrl,
    required double latitude,
    required double longitude,
    List<String>? bookMarkedUserIds,
    bool? isGeofenceActive,
  }) = _MarkerData;

  factory MarkerData.fromJson(Map<String, dynamic> json) =>
      _$MarkerDataFromJson(json);
}
