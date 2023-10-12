// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Comment _$$_CommentFromJson(Map<String, dynamic> json) => _$_Comment(
      commentId: json['commentId'] as String,
      creatorId: json['creatorId'] as String,
      comment: json['comment'] as String,
      createdAt: json['createdAt'],
    );

Map<String, dynamic> _$$_CommentToJson(_$_Comment instance) =>
    <String, dynamic>{
      'commentId': instance.commentId,
      'creatorId': instance.creatorId,
      'comment': instance.comment,
      'createdAt': instance.createdAt,
    };
