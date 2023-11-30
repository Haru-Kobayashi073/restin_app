import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/utils/utils.dart';

void main() {
  late ProviderContainer container;
  const uid = 'john';
  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    final mockUser = MockUser(isAnonymous: true, uid: uid);
    container = ProviderContainer(
      overrides: [
        authProvider.overrideWithValue(
          MockFirebaseAuth(mockUser: mockUser),
        ),
        firestoreProvider.overrideWithValue(
          FakeFirebaseFirestore(),
        ),
        storageProvider.overrideWithValue(
          MockFirebaseStorage(),
        ),
      ],
    );
  });

  test('FetchUserData: ユーザーを作成し、取得できる', () async {
    final userRepository = container.read(userRepositoryProvider);
    await userRepository.createUserData(uid, null);
    final response = userRepository.fetchUserData(uid);
    expect(response, isNotNull);
  });

  test('UpdateUserdata: ユーザー情報を更新できるか', () async {
    final userRepository = container.read(userRepositoryProvider);
    await userRepository.createUserData(uid, null);
    await userRepository.updateUserData(userName: 'testJohn');
    final response = await userRepository.fetchUserData(uid);
    expect(response.uid, 'testJohn');
  });

  test('FetchUserMarkers: ユーザーが作成した全投稿', () async {
    final userRepository = container.read(userRepositoryProvider);
    final response = await userRepository.fetchUserMarkers(uid);
    expect(response, response is List<Marker>);
  });

  test('SwitchBookMark: 投稿を保存できる機能', () async {
    final userRepository = container.read(userRepositoryProvider);
    final response = await userRepository.switchBookMark(
      markerId: 'testMarkerId',
    );
    expect(response, true);
  });

  test('BlockUser: ブロック機能によってデータベースに被ブロック者Uidが返ってくる', () async {
    final userRepository = container.read(userRepositoryProvider);
    await userRepository.blockUser(blockedUid: uid);
    final response = await userRepository.fetchUserMarkers(uid);
    expect(response, true);
  });
}
