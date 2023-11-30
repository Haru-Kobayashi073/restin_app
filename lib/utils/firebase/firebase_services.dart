import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/repositories/auth/auth_repository.dart';
import 'package:search_roof_top_app/repositories/auth/auth_repository_impl.dart';
import 'package:search_roof_top_app/repositories/file/file_repository.dart';
import 'package:search_roof_top_app/repositories/file/file_repository_impl.dart';
import 'package:search_roof_top_app/repositories/marker/marker_repository.dart';
import 'package:search_roof_top_app/repositories/marker/marker_repository_impl.dart';
import 'package:search_roof_top_app/repositories/user/user_repository.dart';
import 'package:search_roof_top_app/repositories/user/user_repository_impl.dart';

final authProvider = Provider<FirebaseAuth>(
  (_) => FirebaseAuth.instance,
);

final firestoreProvider = Provider<FirebaseFirestore>(
  (_) => FirebaseFirestore.instance,
);

final storageProvider = Provider<FirebaseStorage>(
  (_) => FirebaseStorage.instance,
);

final authRepositoryProvider = Provider<AuthRepository>(AuthRepositoryImpl.new);

final fileRepositoryProvider = Provider<FileRepository>(FileRepositoryImpl.new);

final markerRepositoryProvider =
    Provider<MarkerRepository>(MarkerRepositoryImpl.new);

final userRepositoryProvider = Provider<UserRepository>(UserRepositoryImpl.new);
