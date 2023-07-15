import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/pages/map/components/map_components.dart';
import 'package:search_roof_top_app/utils/utils.dart';

class TabActionsButton extends HookConsumerWidget {
  const TabActionsButton({
    super.key,
    required this.onPressed,
  });
  final void Function() onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isOpened = useState(false);

    /// FloatingActionButton のアニメーションを制御
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 300),
    );

    /// ActionButton の位置を変更
    final translateButton = useAnimation(
      Tween<double>(begin: 56, end: -14).animate(
        CurvedAnimation(
          parent: animationController,
          curve: const Interval(0, 0.75, curve: Curves.easeOut),
        ),
      ),
    );

    /// FloatingActionButton の背景色を変更
    final buttonColor = useAnimation(
      ColorTween(begin: ColorName.amber, end: Colors.white).animate(
        CurvedAnimation(
          parent: animationController,
          curve: const Interval(0, 1),
        ),
      ),
    );

    /// ボタンがクリックされたときにアニメーションを開始または停止
    void animate() {
      if (!isOpened.value) {
        animationController.forward();
      } else {
        animationController.reverse();
      }
      isOpened.value = !isOpened.value;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Transform.translate(
          offset: Offset(0, translateButton * 2.0),
          child: ActionButton(
            isOpened: isOpened.value,
            onPressed: () {
              showModalBottomSheet<void>(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                context: context,
                builder: (context) {
                  return const SelectMapTypeModal();
                },
              );
            },
            icon: Assets.icons.changeMapType,
          ),
        ),
        Transform.translate(
          offset: Offset(0, translateButton),
          child: ActionButton(
            isOpened: isOpened.value,
            onPressed: onPressed,
            icon: Assets.icons.currentPosition,
          ),
        ),
        FloatingActionButton(
          backgroundColor: buttonColor,
          onPressed: animate,
          child: AnimatedIcon(
            icon: AnimatedIcons.menu_close,
            progress: animationController,
          ),
        ),
      ],
    );
  }
}
