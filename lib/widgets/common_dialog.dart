import 'package:flutter/material.dart';
import 'package:search_roof_top_app/utils/utils.dart';

class CommonDialog extends StatelessWidget {
  const CommonDialog({
    super.key,
    this.isTwicePop = false,
    required this.title,
    required this.cancelText,
    required this.okText,
    this.onPressed,
  });
  final bool isTwicePop;
  final String title;
  final String cancelText;
  final String okText;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      insetPadding: const EdgeInsets.all(32),
      actionsAlignment: MainAxisAlignment.center,
      content: Text(
        title,
        textAlign: TextAlign.center,
      ),
      actions: [
        Container(
          width: 112,
          height: 64,
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: ColorName.mediumGrey,
            ),
            onPressed: () {
              Navigator.pop(context);
              if (isTwicePop) {
                Navigator.pop(context);
                Navigator.pop(context);
              }
            },
            child: Text(
              cancelText,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: ColorName.darkGrey,
              ),
            ),
          ),
        ),
        Container(
          width: 112,
          height: 64,
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: ColorName.black,
            ),
            onPressed: onPressed ?? () => Navigator.pop(context),
            child: Text(
              okText,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: ColorName.amber,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
