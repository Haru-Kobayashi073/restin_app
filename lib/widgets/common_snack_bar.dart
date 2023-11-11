import 'package:flutter/material.dart';
import 'package:search_roof_top_app/utils/utils.dart';

class CommonSnackBar extends SnackBar {
  CommonSnackBar({
    super.key,
    required String message,
    super.backgroundColor = ColorName.black,
    required super.duration,
    bool isSuccess = true,
  }) : super(
          content: Row(
            children: [
              isSuccess
                  ? const Icon(
                      Icons.check_rounded,
                      color: ColorName.green,
                    )
                  : const Icon(
                      Icons.error_outline_outlined,
                      color: ColorName.red,
                    ),
              const SizedBox(width: 8),
              Text(
                message,
                style: TextStyle(
                  color: isSuccess ? ColorName.green : ColorName.red,
                ),
              ),
            ],
          ),
          behavior: defaultSnackBarBehavior,
        );
}
