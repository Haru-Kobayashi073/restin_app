import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/repositories/file/file_repository_impl.dart';
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
        storageProvider.overrideWithValue(
          MockFirebaseStorage(),
        ),
      ],
    );
  });

  test('PickImageAndUpload: 画像URLと画像ファイルが返ってくる', () async {
    final file =
        await container.read(fileRepositoryImplProvider).pickImageAndUpload();
    expect(file.item1, isNotNull);
    expect(file.item2, isNotNull);
  });
}
