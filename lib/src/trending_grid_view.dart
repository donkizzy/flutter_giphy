import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_giphy/bloc/giphy_cubit.dart';
import 'package:flutter_giphy/models/giphy_data.dart';
import 'package:flutter_giphy/src/gif_grid_view.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shimmer/shimmer.dart';

/// TrendingGridView is a stateful widget that displays a grid of trending gifs.
///
/// It uses the GiphyCubit for state management.
class TrendingGridView extends StatefulWidget {
  /// The widget to display while the gif is loading.
  final Widget? loadingWidget;

  /// The widget to display when an error occurs.
  final Widget? errorWidget;

  /// The GiphyCubit for state management.
  final GiphyCubit giphyCubit;

  /// The Giphy API key.
  final String apikey;

  /// Callback function that is called when a gif is selected.
  final ValueChanged<GiphyData> onSelected;

  /// The language of the gifs.
  final String language;

  /// Constructor for the TrendingGridView class.
  ///
  /// It takes a [loadingWidget] parameter of type Widget which is the widget to display while the gif is loading.
  /// It takes an [errorWidget] parameter of type Widget which is the widget to display when an error occurs.
  /// It takes a [giphyCubit] parameter of type GiphyCubit which is the GiphyCubit for state management.
  /// It takes an [apikey] parameter of type String which is the Giphy API key.
  /// It takes an [onSelected] parameter of type ValueChanged<GiphyData> which is the callback function that is called when a gif is selected.
  /// It takes a [language] parameter of type String which is the language of the gifs.
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
  /// The list of trending gifs.
  List<GiphyData> trendingGifs = [];

  @override
  void initState() {
    /// Load more gifs when the widget is initialized.
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

  /// Loads more trending gifs from the Giphy API.
  ///
  /// It takes an [apiKey] parameter of type String which is the Giphy API key.
  /// It takes an [offset] parameter of type int which is the offset for the gifs. Default is 0.
  /// It takes an [isFirstFetch] parameter of type bool which indicates if it is the first fetch. Default is true.
  void loadMore(
    String apiKey, {
    int offset = 0,
    bool isFirstFetch = true,
  }) {
    widget.giphyCubit.fetchTrendingGif(
        apikey: apiKey,
        offset: offset,
        isFirstFetch: isFirstFetch,
        language: widget.language);
  }
}
