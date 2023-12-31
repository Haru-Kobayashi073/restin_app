import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum SharedPreferencesKey { uid, isFirstLaunch }

/// SharedPreferences のインスタンスを提供するプロバイダ。
/// ProviderScope の overrides 一で使用する。
final sharedPreferencesProvider =
    Provider<SharedPreferences>((_) => throw UnimplementedError());

/// SharedPreferences によるデータの読み書きをするServiceクラスを提供するプロバイダ
final sharedPreferencesServiceProvider =
    Provider<SharedPreferencesService>((ref) {
  final sharedPreferences = ref.watch(sharedPreferencesProvider);
  return SharedPreferencesService(ref, sharedPreferences);
});

class SharedPreferencesService {
  SharedPreferencesService(this.ref, this.sharedPreferences);

  final ProviderRef<SharedPreferencesService> ref;
  final SharedPreferences sharedPreferences;

  Future<void> setAuthCredentials({required String uid}) async {
    await _setString(SharedPreferencesKey.uid, uid);
  }

  String getAuthCredentials() {
    return _getString(SharedPreferencesKey.uid);
  }

  Future<void> deleteAuthCredentials() async {
    await _remove(SharedPreferencesKey.uid);
  }

  Future<void> setIsFirstLaunch({required bool isFirstLaunch}) async {
    await _setBool(SharedPreferencesKey.isFirstLaunch, isFirstLaunch);
  }

  bool getIsFirstLaunch() {
    return _getBool(SharedPreferencesKey.isFirstLaunch);
  }

  /// String 型のキー・バリューペアを保存する
  Future<bool> _setString(SharedPreferencesKey key, String value) async {
    return sharedPreferences.setString(key.name, value);
  }

  /// String 型のキー・バリューを取得する
  String _getString(SharedPreferencesKey key) {
    return sharedPreferences.getString(key.name) ?? '';
  }

  /// Bool 型のキー・バリューペアを保存する
  Future<bool> _setBool(SharedPreferencesKey key, bool value) async {
    return sharedPreferences.setBool(key.name, value);
  }

  /// Bool 型のキー・バリューを取得する
  bool _getBool(SharedPreferencesKey key) {
    return sharedPreferences.getBool(key.name) ?? true;
  }

  /// 指定したキー名のキー・バリューを削除する
  Future<void> _remove(SharedPreferencesKey key) async {
    await sharedPreferences.remove(key.name);
  }
}
