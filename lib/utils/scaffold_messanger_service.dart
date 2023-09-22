import 'package:flutter/material.dart';
import 'package:search_roof_top_app/utils/utils.dart';

class ScaffoldMessengerService {
  ScaffoldMessengerService._();

  /// スナックバーを表示する。
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
      showSuccessSnackBar(
    BuildContext context,
    String message, {
    bool removeCurrentSnackBar = true,
    Duration duration = defaultSnackBarDuration,
  }) {
    if (removeCurrentSnackBar) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
    }
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: defaultSnackBarBehavior,
        duration: duration,
      ),
    );
  }

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
      showExceptionSnackBar(
    BuildContext context,
    String message, {
    bool removeCurrentSnackBar = true,
    Duration duration = defaultSnackBarDuration,
  }) {
    if (removeCurrentSnackBar) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
    }
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: defaultSnackBarBehavior,
        duration: duration,
      ),
    );
  }

  /// Exception 起点でスナックバーを表示する。
  /// Dart の Exception 型の場合は toString() 冒頭を取り除いて
  /// 差し支えのないメッセージに置換しておく。
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
      showSnackBarByException(Exception e, BuildContext context) {
    final message =
        e.toString().replaceAll('Exception: ', '').replaceAll('Exception', '');
    return showExceptionSnackBar(
      context,
      message.ifIsEmpty(generalExceptionMessage),
    );
  }
}
