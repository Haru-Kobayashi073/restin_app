// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'user_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserData _$$_UserDataFromJson(Map<String, dynamic> json) => _$_UserData(
      email: json['email'] as String,
      userName: json['userName'] as String?,
      imageUrl: json['imageUrl'] as String?,
      createdAt: json['createdAt'],
    );

Map<String, dynamic> _$$_UserDataToJson(_$_UserData instance) =>
    <String, dynamic>{
      'email': instance.email,
      'userName': instance.userName,
      'imageUrl': instance.imageUrl,
      'createdAt': instance.createdAt,
    };
