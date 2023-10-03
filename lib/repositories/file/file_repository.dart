import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:tuple/tuple.dart';

abstract class FileRepository {
  User? get currentUser;

  Future<Tuple2<String, File>> pickImageAndUpload();

  Future<void> deleteFile(String url);
}
