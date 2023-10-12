import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment.freezed.dart';
part 'comment.g.dart';

@freezed
abstract class Comment with _$Comment {
  const factory Comment({
    required String commentId,
    required String creatorId,
    required String comment,
    required dynamic createdAt,
    
}) = _Comment;

factory Comment.fromJson(Map<String, dynamic> json) =>_$CommentFromJson(json);
}
