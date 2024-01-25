import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_giphy/bloc/giphy_cubit.dart';
import 'package:flutter_giphy/models/giphy_data.dart';
import 'package:flutter_giphy/src/gif_grid_view.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shimmer/shimmer.dart';

class TrendingGridView extends StatefulWidget {
  final Widget? loadingWidget;
  final Widget? errorWidget;
  final GiphyCubit giphyCubit;
  final String apikey;

  final ValueChanged<GiphyData> onSelected;

  final String language;

  const TrendingGridView({
    super.key,
    this.loadingWidget,
    this.errorWidget,
    required this.giphyCubit,
    required this.apikey,
    required this.onSelected,
    required this.language,
  });

  @override
  State<TrendingGridView> createState() => _TrendingGridViewState();
}

class _TrendingGridViewState extends State<TrendingGridView> {
  List<GiphyData> trendingGifs = [];

  @override
  void initState() {
    loadMore(widget.apikey);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GiphyCubit, GiphyState>(
      bloc: widget.giphyCubit,
      buildWhen: (previous, current) {
        return current is GiphyLoading ||
            current is GiphySuccess ||
            current is GiphyError;
      },
      builder: (context, state) {
        if (state is GiphyLoading) {
          return MasonryGridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            padding: const EdgeInsets.all(10),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Shimmer.fromColors(
                baseColor: Colors.grey.withOpacity(0.2),
                highlightColor:
                    Theme.of(context).colorScheme.outline.withOpacity(0.1),
                child: Container(
                  width: double.infinity,
                  height: 150,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                  ),
                ),
              );
            },
          );
        }
        if (state is GiphyError) {
          return widget.errorWidget ??
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.error),
                    const SizedBox(
                      height: 10,
                    ),
                    MaterialButton(
                      onPressed: () => loadMore(widget.apikey),
                      child: const Text('Retry'),
                    )
                  ],
                ),
              );
        }
        if (state is GiphySuccess) {
          return GifGridView(
            gifs: trendingGifs,
            onEndOfPage: () {
              loadMore(widget.apikey,
                  offset: trendingGifs.length, isFirstFetch: false);
            },
            loadingWidget: widget.loadingWidget,
            onSelected: widget.onSelected,
          );
        }
        return const SizedBox.shrink();
      },
      listener: (BuildContext context, GiphyState state) {
        if (state is GiphySuccess) {
          trendingGifs.addAll(state.gif.data ?? []);
        }
      },
    );
  }

  void loadMore(
    String apiKey, {
    int offset = 0,
    bool isFirstFetch = true,
  }) {
    widget.giphyCubit.fetchTrendingGif(
        apikey: apiKey, offset: offset, isFirstFetch: isFirstFetch,language: widget.language);
  }
}
