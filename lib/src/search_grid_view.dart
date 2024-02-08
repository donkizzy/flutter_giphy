import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_giphy/bloc/giphy_cubit.dart';
import 'package:flutter_giphy/models/giphy_data.dart';
import 'package:flutter_giphy/src/gif_grid_view.dart';
import 'package:flutter_giphy/utils/debouncer.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shimmer/shimmer.dart';

/// SearchGridView is a stateful widget that displays a grid of gifs based on a search query.
///
/// It uses the GiphyCubit for state management and the Debouncer for debouncing the search input.
class SearchGridView extends StatefulWidget {
  /// The widget to display while the gif is loading.
  final Widget? loadingWidget;

  /// The widget to display when an error occurs.
  final Widget? errorWidget;

  /// The GiphyCubit for state management.
  final GiphyCubit giphyCubit;

  /// The Giphy API key.
  final String apikey;

  /// The TextEditingController for the search input.
  final TextEditingController searchController;

  /// Callback function that is called when a gif is selected.
  final ValueChanged<GiphyData> onSelected;

  /// The language of the gifs.
  final String language;

  /// Constructor for the SearchGridView class.
  ///
  /// It takes a [loadingWidget] parameter of type Widget which is the widget to display while the gif is loading.
  /// It takes an [errorWidget] parameter of type Widget which is the widget to display when an error occurs.
  /// It takes a [giphyCubit] parameter of type GiphyCubit which is the GiphyCubit for state management.
  /// It takes an [apikey] parameter of type String which is the Giphy API key.
  /// It takes a [searchController] parameter of type TextEditingController which is the TextEditingController for the search input.
  /// It takes an [onSelected] parameter of type ValueChanged<GiphyData> which is the callback function that is called when a gif is selected.
  /// It takes a [language] parameter of type String which is the language of the gifs.
  const SearchGridView(
      {super.key,
      this.loadingWidget,
      this.errorWidget,
      required this.giphyCubit,
      required this.apikey,
      required this.searchController,
      required this.onSelected,
      required this.language});

  @override
  State<SearchGridView> createState() => _SearchGridViewState();
}

class _SearchGridViewState extends State<SearchGridView> {
  /// The list of gifs that match the search query.
  List<GiphyData> searchGifs = [];

  /// The Debouncer for debouncing the search input.
  late final Debouncer debouncer;

  @override
  void initState() {
    /// Initialize the Debouncer with a delay of 500 milliseconds.
    debouncer = Debouncer(milliseconds: 500);

    /// Add a listener to the searchController that calls the search function when the search input changes.
    widget.searchController.addListener(() {
      search(widget.apikey,
          keyword: widget.searchController.text, isFirstFetch: true);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GiphyCubit, GiphyState>(
      bloc: widget.giphyCubit,
      buildWhen: (previous, current) {
        return current is GiphyLoading ||
            current is SearchGifSuccess ||
            current is SearchGifError ||
            current is GiphyInitial;
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
        if (state is SearchGifError) {
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
                      onPressed: () => search(widget.apikey,
                          keyword: widget.searchController.text),
                      child: const Text('Retry'),
                    )
                  ],
                ),
              );
        }
        if (state is SearchGifSuccess) {
          return GifGridView(
            gifs: searchGifs,
            onEndOfPage: () {
              search(widget.apikey,
                  offset: searchGifs.length,
                  isFirstFetch: false,
                  keyword: widget.searchController.text);
            },
            loadingWidget: widget.loadingWidget,
            onSelected: widget.onSelected,
          );
        }
        return const SizedBox.shrink();
      },
      listener: (BuildContext context, GiphyState state) {
        if (state is GiphyInitial) {
          searchGifs.clear();
        }

        if (state is SearchGifSuccess) {
          searchGifs.addAll(state.gif.data ?? []);
        }
      },
    );
  }

  /// Searches for a gif in the Giphy API.
  ///
  /// It takes an [apiKey] parameter of type String which is the Giphy API key.
  /// It takes an [offset] parameter of type int which is the offset for the gifs. Default is 0.
  /// It takes a [keyword] parameter of type String which is the keyword for the search.
  /// It takes an [isFirstFetch] parameter of type bool which indicates if it is the first fetch. Default is true.
  /// It uses the Debouncer to debounce the search input.
  void search(String apiKey,
      {int offset = 0, required String keyword, bool isFirstFetch = true}) {
    debouncer.run(() {
      widget.giphyCubit.searchGif(
        apikey: apiKey,
        offset: offset,
        keyword: keyword,
        isFirstFetch: isFirstFetch,
        language: widget.language,
      );
    });
  }

  @override
  void dispose() {
    /// Cancel the Debouncer when the widget is disposed.
    debouncer.cancel();
    super.dispose();
  }
}
