import 'package:flutter/material.dart';
import 'package:search_roof_top_app/utils/utils.dart';

class CommonButton extends StatelessWidget {
  const CommonButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.color,
  });
  final void Function()? onPressed;
  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 64,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: color ?? Theme.of(context).primaryColor,
          side: color != null
              ? const BorderSide(color: ColorName.amber)
              : null,
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: color != null
              ? AppTextStyle.commonButtonYellow
              : AppTextStyle.commonButtonText,
        ),
      ),
    );
  }
}
