import 'package:cloud_firestore/cloud_firestore.dart';

String formatTimeAgo(dynamic timestamp) {
  final now = DateTime.now();
  if (timestamp is Timestamp) {
    final dateTime = timestamp.toDate();
    final difference = now.difference(dateTime);

    if (difference.inDays > 365) {
      return '${difference.inDays ~/ 365}年前';
    } else if (difference.inDays >= 30) {
      return '${difference.inDays ~/ 30}ヶ月前';
    } else if (difference.inDays >= 1) {
      return '${difference.inDays}日前';
    } else if (difference.inHours >= 1) {
      return '${difference.inHours}時間前';
    } else if (difference.inMinutes >= 1) {
      return '${difference.inMinutes}分前';
    } else {
      return 'たった今';
    }
  } else {
    return '';
  }
}
