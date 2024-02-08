import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_giphy/models/giphy_data.dart';
import 'package:flutter_giphy/utils/lazy_load_scroll_view.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shimmer/shimmer.dart';

/// GifGridView is a stateless widget that displays a grid of gifs.
///
/// It uses the MasonryGridView for the grid layout and CachedNetworkImage for loading and caching the gif images.
class GifGridView extends StatelessWidget {
  /// The list of gifs to display.
  final List<GiphyData> gifs;

  /// Callback function that is called when the end of the page is reached.
  final VoidCallback? onEndOfPage;

  /// The widget to display while the gif is loading.
  final Widget? loadingWidget;

  /// Callback function that is called when a gif is selected.
  final ValueChanged<GiphyData> onSelected;

  /// Constructor for the GifGridView class.
  ///
  /// It takes a [gifs] parameter of type List<GiphyData> which is the list of gifs to display.
  /// It takes an [onEndOfPage] parameter of type VoidCallback which is the callback function that is called when the end of the page is reached.
  /// It takes a [loadingWidget] parameter of type Widget which is the widget to display while the gif is loading.
  /// It takes an [onSelected] parameter of type ValueChanged<GiphyData> which is the callback function that is called when a gif is selected.
  const GifGridView(
      {super.key,
      required this.gifs,
      this.onEndOfPage,
      this.loadingWidget,
      required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return LazyLoadScrollView(
      onEndOfPage: onEndOfPage ?? () {},
      child: MasonryGridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        padding: const EdgeInsets.all(10),
        itemCount: gifs.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              onSelected.call(gifs[index]);
              Navigator.pop(context);
            },
            child: CachedNetworkImage(
              imageUrl: gifs[index].images?.original?.url ?? '',
              placeholder: (context, url) {
                return loadingWidget ??
                    Shimmer.fromColors(
                      baseColor: Colors.grey.withOpacity(0.2),
                      highlightColor: Theme.of(context)
                          .colorScheme
                          .outline
                          .withOpacity(0.1),
                      child: Container(
                        width: double.infinity,
                        height: 150,
                        decoration: const BoxDecoration(
                          color: Colors.black,
                        ),
                      ),
                    );
              },
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          );
        },
      ),
    );
  }
}
