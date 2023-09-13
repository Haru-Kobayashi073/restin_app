import 'package:firebase_auth/firebase_auth.dart';
import 'package:search_roof_top_app/models/user_data.dart';

abstract class UserRepository {
  User? get currentUser;

  Future<UserData?> fetchUserData();
}
