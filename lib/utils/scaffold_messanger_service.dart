import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/utils/utils.dart';

final scaffoldKeyProvider = Provider(
  (_) => GlobalKey<ScaffoldMessengerState>(),
);

final scaffoldMessengerServiceProvider =
    Provider.autoDispose(ScaffoldMessengerService.new);

/// ツリー上部の ScaffoldMessenger 上でスナックバーやダイアログの表示を操作する。
/// Operate showing dialog or snackbar
/// on ScaffoldMessenger set on the above of tree.
class ScaffoldMessengerService {
  ScaffoldMessengerService(this._ref);

  final AutoDisposeProviderRef<ScaffoldMessengerService> _ref;

  GlobalKey<ScaffoldMessengerState> get scaffoldKey =>
      _ref.read(scaffoldKeyProvider);

  /// showDialog で指定したビルダー関数を返す。
  /// Return builder function of showDialog
  ///
  /// エラーに関しては別で [AsyncValueErrorDialog] を用いて対応する。
  /// Error handling depends on using [AsyncValueErrorDialog].
  Future<T?> showDialogByBuilder<T>({
    required Widget Function(BuildContext) builder,
    bool barrierDismissible = true,
  }) {
    return showDialog<T>(
      context: scaffoldKey.currentContext!,
      barrierDismissible: barrierDismissible,
      builder: builder,
    );
  }

  /// スナックバーを表示する。
  /// Show a snackbar.
  ///
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
    String message, {
    bool removeCurrentSnackBar = true,
    Duration duration = defaultSnackBarDuration,
  }) {
    final scaffoldMessengerState = scaffoldKey.currentState;
    if (removeCurrentSnackBar && scaffoldMessengerState != null) {
      scaffoldMessengerState.removeCurrentSnackBar();
    }
    if (scaffoldMessengerState != null) {
      return scaffoldMessengerState.showSnackBar(
        SnackBar(
          content: Text(
            message,
          ),
          backgroundColor: ColorName.black,
          behavior: defaultSnackBarBehavior,
          duration: duration,
        ),
      );
    } else {
      throw Exception('scaffoldMessengerState is null.');
    }
  }

  /// スナックバーを表示する。
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSuccessSnackBar(
    String message, {
    bool removeCurrentSnackBar = true,
    Duration duration = defaultSnackBarDuration,
  }) {
    final scaffoldMessengerState = scaffoldKey.currentState;
    if (removeCurrentSnackBar && scaffoldMessengerState != null) {
      scaffoldMessengerState.removeCurrentSnackBar();
    }
    if (scaffoldMessengerState != null) {
      return scaffoldMessengerState.showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: defaultSnackBarBehavior,
          duration: duration,
        ),
      );
    } else {
      throw Exception('scaffoldMessengerState is null.');
    }
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
      showExceptionSnackBar(
    String message, {
    bool removeCurrentSnackBar = true,
    Duration duration = defaultSnackBarDuration,
  }) {
    final scaffoldMessengerState = scaffoldKey.currentState;
    if (removeCurrentSnackBar && scaffoldMessengerState != null) {
      scaffoldMessengerState.removeCurrentSnackBar();
    }
    if (scaffoldMessengerState != null) {
      return scaffoldMessengerState.showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: defaultSnackBarBehavior,
          duration: duration,
        ),
      );
    } else {
      throw Exception('scaffoldMessengerState is null.');
    }
  }

  /// Exception 起点でスナックバーを表示する。
  /// Dart の Exception 型の場合は toString() 冒頭を取り除いて
  /// 差し支えのないメッセージに置換しておく。
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
      showSnackBarByException(Exception e) {
    final message =
        e.toString().replaceAll('Exception: ', '').replaceAll('Exception', '');
    return showExceptionSnackBar(message.ifIsEmpty(generalExceptionMessage));
  }
}
