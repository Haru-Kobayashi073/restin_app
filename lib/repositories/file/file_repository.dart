import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

abstract class FileRepository {
  User? get currentUser;

  Future<File?> pickImageAndUpload();

  Future<Image> getDownloadUrl();

  Future<void> deleteFile();
}
