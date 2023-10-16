// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserData _$$_UserDataFromJson(Map<String, dynamic> json) => _$_UserData(
      uid: json['uid'] as String,
      email: json['email'] as String,
      userName: json['userName'] as String?,
      imageUrl: json['imageUrl'] as String?,
      createdAt: json['createdAt'],
      bookMarkMarkerIds: (json['bookMarkMarkerIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$_UserDataToJson(_$_UserData instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'userName': instance.userName,
      'imageUrl': instance.imageUrl,
      'createdAt': instance.createdAt,
      'bookMarkMarkerIds': instance.bookMarkMarkerIds,
    };
