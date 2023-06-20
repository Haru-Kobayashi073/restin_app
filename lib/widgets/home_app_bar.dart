import 'package:flutter/material.dart';
import 'package:search_roof_top_app/utils/utils.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Search Roof Top'),
      backgroundColor: ColorName.white,
      elevation: 0,
    );
  }
}
