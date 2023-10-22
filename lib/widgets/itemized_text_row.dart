import 'package:flutter/material.dart';
import 'package:search_roof_top_app/utils/utils.dart';

class ItemizedTextRow extends StatelessWidget {
  const ItemizedTextRow({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '・',
          style: AppTextStyle.greyText,
        ),
        Expanded(
          child: Text(
            text,
            style: AppTextStyle.greyText,
          ),
        ),
      ],
    );
  }
}
