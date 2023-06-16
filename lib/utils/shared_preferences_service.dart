import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// enum SharedPreferencesKey {
// }

/// SharedPreferences のインスタンスを提供するプロバイダ。
/// ProviderScope の overrides 一で使用する。
final sharedPreferencesProvider =
    Provider<SharedPreferences>((_) => throw UnimplementedError());

/// SharedPreferences によるデータの読み書きをするServiceクラスを提供するプロバイダ
final sharedPreferencesServiceProvider = Provider<SharedPreferencesService>(
  SharedPreferencesService.new,
);

class SharedPreferencesService {
  SharedPreferencesService(this.ref);

  final ProviderRef<SharedPreferencesService> ref;
}
