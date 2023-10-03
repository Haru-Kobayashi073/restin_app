import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:search_roof_top_app/models/user_data.dart';
import 'package:tuple/tuple.dart';

abstract class UserRepository {
  User? get currentUser;

  Future<UserData?> fetchUserData();

  Future<void> updateUserData({required Tuple2<String, File>imgInfo});
}
