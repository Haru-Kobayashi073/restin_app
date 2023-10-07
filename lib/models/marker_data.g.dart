// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'marker_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MarkerData _$$_MarkerDataFromJson(Map<String, dynamic> json) =>
    _$_MarkerData(
      creatorId: json['creatorId'] as String,
      markerId: json['markerId'] as String,
      createdAt: json['createdAt'],
      title: json['title'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String?,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      bookMarkedUserIds: (json['bookMarkedUserIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$_MarkerDataToJson(_$_MarkerData instance) =>
    <String, dynamic>{
      'creatorId': instance.creatorId,
      'markerId': instance.markerId,
      'createdAt': instance.createdAt,
      'title': instance.title,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'bookMarkedUserIds': instance.bookMarkedUserIds,
    };
