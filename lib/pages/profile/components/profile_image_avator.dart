import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:search_roof_top_app/utils/utils.dart';

class ProfileImageAvator extends StatelessWidget {
  const ProfileImageAvator({super.key, required this.imageUrl});
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog<void>(
          context: context,
          builder: (_) {
            return BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 20,
                sigmaY: 20,
              ),
              child: AlertDialog(
                elevation: 0,
                backgroundColor: Colors.transparent,
                content: imageUrl != null
                    ? CircleAvatar(
                        backgroundImage: CachedNetworkImageProvider(
                          imageUrl!,
                        ),
                        radius: 112,
                      )
                    : CircleAvatar(
                        radius: 112,
                        child: SvgPicture.asset(
                          Assets.icons.person,
                        ),
                      ),
              ),
            );
          },
        );
      },
      child: imageUrl != null
          ? CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(
                imageUrl!,
              ),
              radius: 56,
            )
          : CircleAvatar(
              radius: 56,
              child: SvgPicture.asset(
                Assets.icons.person,
                width: 48,
              ),
            ),
    );
  }
}
