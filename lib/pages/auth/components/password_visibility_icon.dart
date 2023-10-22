import 'package:flutter/material.dart';
import 'package:search_roof_top_app/utils/utils.dart';

class PasswordVisibilityIcon extends StatelessWidget {
  const PasswordVisibilityIcon({
    super.key,
    required this.onPressed,
    required this.visibility,
  });
  final void Function()? onPressed;
  final bool visibility;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: visibility
          ? const Icon(
              Icons.visibility_off,
              color: ColorName.deepGrey,
            )
          : const Icon(
              Icons.visibility,
              color: ColorName.deepGrey,
            ),
    );
  }
}
