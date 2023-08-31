import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.heroTag,
    required this.onPressed,
    required this.icon,
    required this.isOpened,
  });
  final String heroTag;
  final void Function() onPressed;
  final String icon;
  final bool isOpened;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: heroTag,
      elevation: isOpened ? 5 : 0,
      onPressed: onPressed,
      child: SvgPicture.asset(
        icon,
        width: 30,
        height: 30,
      ),
    );
  }
}
