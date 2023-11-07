import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_data.freezed.dart';
part 'user_data.g.dart';

@freezed
abstract class UserData with _$UserData {
  const factory UserData({
    required String uid,
    required String email,
    String? userName,
    String? imageUrl,
    required dynamic createdAt,
    List<String>? bookMarkMarkerIds,
    List<String>? blockedUids,
    required int markersCounts,
  }) = _UserData;

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);
}
