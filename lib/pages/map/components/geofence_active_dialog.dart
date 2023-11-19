import 'package:flutter/material.dart';
import 'package:search_roof_top_app/utils/utils.dart';

class GeofenceActiveDialog extends StatelessWidget {
  const GeofenceActiveDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      insetPadding: const EdgeInsets.all(32),
      actionsPadding: const EdgeInsets.symmetric(horizontal: 32),
      title: const Text(
        '情報の正確性について',
        style: AppTextStyle.bold,
      ),
      content: const Text(
        geofenceActiveInformationDialog,
      ),
      actions: [
        Container(
          width: 112,
          height: 64,
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: FilledButton(
            style: FilledButton.styleFrom(backgroundColor: ColorName.black),
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'OK',
              style: TextStyle(
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
