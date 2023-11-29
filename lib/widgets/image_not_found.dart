import 'package:flutter/material.dart';
import 'package:search_roof_top_app/utils/utils.dart';

class ImageNotFound extends StatelessWidget {
  const ImageNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: context.deviceHeight * 0.3,
      decoration: BoxDecoration(
        color: ColorName.lightAmber,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.image_not_supported_outlined,
            size: 56,
            color: ColorName.darkGrey,
          ),
          Text(
            '画像がありません',
            style: TextStyle(
              color: ColorName.darkGrey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
