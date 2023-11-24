import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/utils/utils.dart';

void main() {
  late ProviderContainer container;
  const uid = 'john';
  const email = 'user_1@example.com';
  const password = 'password1234';
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
      ],
    );
  });

  test('SignUp: ユーザが作成できるか', () async {
    await container.read(authRepositoryProvider).signUp(
          email: email,
          password: password,
        );
    final user = await container.read(authRepositoryProvider).signIn(
          email: email,
          password: password,
        );
    expect(user, uid);
  });
}
