import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_giphy/models/giphy_data.dart';
import 'package:flutter_giphy/utils/lazy_load_scroll_view.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shimmer/shimmer.dart';

class GifGridView extends StatefulWidget {
  final List<GiphyData> gifs;
  final VoidCallback? onEndOfPage;

  final Widget? loadingWidget;
  final ValueChanged<GiphyData> onSelected ;

  const GifGridView(
      {super.key,
      required this.gifs,
      this.onEndOfPage,
       this.loadingWidget, required this.onSelected});

  @override
  State<GifGridView> createState() => _GifGridViewState();
}

class _GifGridViewState extends State<GifGridView> {
  @override
  Widget build(BuildContext context) {
    return LazyLoadScrollView(
      onEndOfPage:  widget.onEndOfPage ?? () {},
      child: MasonryGridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        padding: const EdgeInsets.all(10),
        itemCount: widget.gifs.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: (){
              widget.onSelected.call(widget.gifs[index]);
              Navigator.pop(context);
            },
            child: CachedNetworkImage(
              imageUrl: widget.gifs[index].images?.original?.url ?? '',
              placeholder: (context, url) {
                return widget.loadingWidget ??
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
              errorWidget: (context, url, error) =>
              const Icon(Icons.error),
            ),
          );
        },
      ),
    );
  }
}
