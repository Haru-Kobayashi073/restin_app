import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/models/marker_data.dart';
import 'package:search_roof_top_app/utils/utils.dart';

class MarkerDetailModal extends HookConsumerWidget {
  const MarkerDetailModal({
    super.key,
    required this.markerData,
  });
  final MarkerData markerData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            height: 4,
            margin: const EdgeInsets.fromLTRB(160, 16, 160, 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: ColorName.mediumGrey,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      markerData.title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: const BoxDecoration(
                          color: ColorName.mediumGrey,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.clear_rounded),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        markerData.description,
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        formatTimeAgo(markerData.createdAt),
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                markerData.imageUrl != null
                    ? Padding(
                        padding: const EdgeInsets.only(top: 16, bottom: 64),
                        child: CachedNetworkImage(
                          imageUrl: markerData.imageUrl!,
                        ),
                      )
                    : const SizedBox(height: 100),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
