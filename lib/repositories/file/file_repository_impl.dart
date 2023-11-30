import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:search_roof_top_app/repositories/file/file_repository.dart';
import 'package:search_roof_top_app/utils/utils.dart';
import 'package:tuple/tuple.dart';

final fileRepositoryImplProvider =
    Provider<FileRepository>(FileRepositoryImpl.new);

class FileRepositoryImpl implements FileRepository {
  FileRepositoryImpl(ProviderRef<FileRepository> ref)
      : _auth = ref.read(authProvider),
        _storage = ref.read(storageProvider);
  final FirebaseAuth _auth;
  final FirebaseStorage _storage;

  @override
  User? get currentUser => _auth.currentUser;

  @override
  Future<Tuple2<String?, File?>> pickImageAndUpload() async {
    final picker = ImagePicker();
    final fileName = returnJpgFileName();
    final uid = currentUser!.uid;
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      return const Tuple2(null, null);
    }
    final file = File(image.path);
    final storageRef = _storage.ref().child('users').child(uid).child(fileName);
    await storageRef.putFile(file);
    final imageUrl = await storageRef.getDownloadURL();
    return Tuple2(imageUrl, file);
  }

  @override
  Future<void> deleteFile(String url) async {
    final uid = currentUser!.uid;
    final reference = _storage.ref().child('users').child(uid).child(url);
    await reference.delete();
  }
}
