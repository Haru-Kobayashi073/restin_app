import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:search_roof_top_app/models/marker_data.dart';
import 'package:search_roof_top_app/models/user_data.dart';
import 'package:tuple/tuple.dart';

abstract class UserRepository {
  User? get currentUser;

  Future<UserData> fetchUserData();

  Future<void> updateUserData({
    String? userName,
    Tuple2<String, File>? imgInfo,
  });

  Future<List<MarkerData>?> fetchUserMarkers();

  Future<void> switchBookMark({required String markerId});

  Future<List<MarkerData>?> fetchUserBookMarkMarkers();
}
