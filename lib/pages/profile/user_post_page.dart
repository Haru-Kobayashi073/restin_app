import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/models/marker_data.dart';
import 'package:search_roof_top_app/pages/profile/components/profile_components.dart';

class UserPostPage extends HookConsumerWidget {
  const UserPostPage({
    super.key,
    required this.markerData,
    this.isUserPostPage = true,
  });
  final List<MarkerData> markerData;
  final bool isUserPostPage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return markerData.isNotEmpty
        ? CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final marker = markerData[index];
                    return UserPostCard(markerData: marker);
                  },
                  childCount: markerData.length,
                ),
              ),
            ],
          )
        : isUserPostPage
            ? const Center(
                child: Text('投稿がありません'),
              )
            : const Center(
                child: Text('保存した投稿がありません'),
              );
  }
}
