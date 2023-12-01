import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
import 'package:search_roof_top_app/features/google_map/google_map.dart';
import 'package:search_roof_top_app/widgets/widgets.dart';

class FloatSearchBar extends HookConsumerWidget {
  const FloatSearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final controller = useState(FloatingSearchBarController());
    final query = useState<String>('');

    return FloatingSearchBar(
      controller: controller.value,
      borderRadius: BorderRadius.circular(24),
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 400),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0,
      width: isPortrait ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 500),
      clearQueryOnClose: false,
      automaticallyImplyBackButton: false,
      onQueryChanged: (text) {
        query.value = text;
      },
      transition: ExpandingFloatingSearchBarTransition(),
      leadingActions: [
        FloatingSearchBarAction(
          showIfOpened: true,
          showIfClosed: false,
          child: CircularButton(
            icon: const Icon(Icons.arrow_back_ios_rounded),
            padding: EdgeInsets.zero,
            onPressed: () => controller.value.close(),
          ),
        ),
      ],
      actions: [
        FloatingSearchBarAction.searchToClear(),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            color: Colors.white,
            elevation: 4,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: query.value.isNotEmpty
                  ? ref
                      .watch(
                        searchMarkerDataProvider(query.value),
                      )
                      .when(
                        data: (markers) {
                          return markers!
                              .map(
                                (marker) => SearchResultCard(
                                  markerData: marker,
                                  controller: controller.value,
                                  removeState: () => query.value = '',
                                ),
                              )
                              .toList();
                        },
                        error: (error, stackTrace) => [
                          ErrorPage(
                            error: error,
                            onTapReload: () => ref.invalidate(
                              searchMarkerDataProvider(query.value),
                            ),
                          ),
                        ],
                        loading: () => [const Loading()],
                      )
                  : ref.watch(fetchAllMarkerDataProvider).when(
                        data: (markers) {
                          return markers
                              .map(
                                (marker) => SearchResultCard(
                                  markerData: marker,
                                  controller: controller.value,
                                  removeState: () => query.value = '',
                                ),
                              )
                              .toList();
                        },
                        error: (error, stackTrace) => [
                          ErrorPage(
                            error: error,
                            onTapReload: () => ref.invalidate(
                              fetchAllMarkerDataProvider,
                            ),
                          ),
                        ],
                        loading: () => [
                          const Loading(),
                        ],
                      ),
            ),
          ),
        );
      },
    );
  }
}
