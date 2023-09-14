import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:search_roof_top_app/repositories/file/file_repository.dart';

final authProvider = Provider<FirebaseAuth>(
  (_) => FirebaseAuth.instance,
);

final storageProvider = Provider<FirebaseStorage>(
  (_) => FirebaseStorage.instance,
);

final fileRepositoryImplProvider = Provider<FileRepository>(
  (ref) => FileRepositoryImpl(
    ref.watch(authProvider),
    ref.watch(storageProvider),
  ),
);

class FileRepositoryImpl implements FileRepository {
  FileRepositoryImpl(
    this._auth,
    this._storage,
  );
  final FirebaseAuth _auth;
  final FirebaseStorage _storage;
  static const fileName = 'profile_icon_image.jpg';

  @override
  User? get currentUser => _auth.currentUser;

  @override
  Future<File?> pickImageAndUpload() async {
    final picker = ImagePicker();
    final uid = currentUser!.uid;
    final image = await picker.pickImage(source: ImageSource.gallery);
    final file = File(image!.path);
    final storageRef = _storage.ref().child('users/$uid/$fileName');
    await storageRef.putFile(file);
    return file;
  }

  @override
  Future<Image> getDownloadUrl() async {
    final uid = currentUser!.uid;

    final reference = _storage.ref().child('users/$uid/$fileName');
    final imageUrl = await reference.getDownloadURL();
    return Image.network(imageUrl);
  }

  @override
  Future<void> deleteFile() async {
    final uid = currentUser!.uid;
    final reference = _storage.ref().child('users/$uid/$fileName');
    await reference.delete();
  }
}
