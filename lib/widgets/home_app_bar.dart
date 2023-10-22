import 'package:flutter/material.dart';
import 'package:search_roof_top_app/utils/utils.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key, this.text});
  final String? text;

  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        text ?? '',
        style: AppTextStyle.mapTypeModalTitle,
      ),
      backgroundColor: ColorName.white,
      elevation: 0,
    );
  }
}
