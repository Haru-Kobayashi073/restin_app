import 'package:flutter/material.dart';

/// アニメーション無しのページ遷移
class NoAnimationRoute {
  NoAnimationRoute._();
  static Future<T?> push<T>(
    BuildContext context,
    Widget page, {
    bool rootNavigator = true,
    bool fullscreenDialog = false,
  }) async {
    return Navigator.of(context, rootNavigator: rootNavigator).push<T>(
      PageRouteBuilder<T>(
        pageBuilder: (_, __, ___) => page,
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
        fullscreenDialog: fullscreenDialog,
      ),
    );
  }

  static Future<T?> pushAndRemoveUntil<T>(
    BuildContext context,
    Widget page, {
    bool rootNavigator = true,
    bool fullscreenDialog = false,
  }) async {
    return Navigator.of(context, rootNavigator: rootNavigator)
        .pushAndRemoveUntil<T>(
      PageRouteBuilder<T>(
        pageBuilder: (_, __, ___) => page,
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
        fullscreenDialog: fullscreenDialog,
      ),
      (route) => true,
    );
  }
}
