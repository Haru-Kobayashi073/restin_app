import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/utils/utils.dart';

void main() {
  late ProviderContainer container;
  const uid = 'john';
  const imageUrl = 'https://restin.com';
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

  test('CreateMarker: マーカー作成をし、取得できる', () async {
    final markerRepository = container.read(markerRepositoryProvider);
    await markerRepository.createMarker(
      marker: const Marker(
        markerId: MarkerId('testMarkerId'),
        infoWindow: InfoWindow(title: 'testTitle', snippet: 'testSnippet'),
      ),
      imageUrl: imageUrl,
    );
    final response = await markerRepository.fetchAllMarkers().first;
    expect(response.first.markerId, 'testMarkerId');
  });

  test('SearchMarkers: マーカー作成をし、検索結果が返ってくる', () async {
    final markerRepository = container.read(markerRepositoryProvider);
    await markerRepository.createMarker(
      marker: const Marker(
        markerId: MarkerId('testMarkerId'),
        infoWindow: InfoWindow(title: 'testTitle', snippet: 'testSnippet'),
      ),
      imageUrl: imageUrl,
    );
    final response = await markerRepository.searchMarkers(query: 'testTitle');
    expect(response.first.title, 'testTitle');
  });

  test('FetchMarkersComments: マーカーに対して、コメントを作成し、取得できる', () async {
    final markerRepository = container.read(markerRepositoryProvider);
    await markerRepository.createMarker(
      marker: const Marker(markerId: MarkerId('testMarkerId')),
      imageUrl: imageUrl,
    );
    await markerRepository.createMarkerComment(
      markerId: 'testMarkerId',
      comment: 'テストコメント',
    );
    final response = await markerRepository.fetchMarkersComments(
      markerId: 'testMarkerId',
    );
    expect(response.first.comment, 'テストコメント');
  });

  test('FetchGeofenceStatus: マーカーのステータスを変更し、取得', () async {
    final markerRepository = container.read(markerRepositoryProvider);
    await markerRepository.createMarker(
      marker: const Marker(markerId: MarkerId('testMarkerId')),
      imageUrl: imageUrl,
    );
    final response =
        await markerRepository.fetchGeofenceStatus(markerId: 'testMarkerId');
    expect(response, true);
  });
}
