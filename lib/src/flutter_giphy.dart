import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_giphy/bloc/giphy_cubit.dart';
import 'package:flutter_giphy/models/giphy_data.dart';
import 'package:flutter_giphy/repositories/gif_repository.dart';
import 'package:flutter_giphy/src/gif_grid_view.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shimmer/shimmer.dart';

/// Flutter Giphy makes it easy fou you be use Giphy in your flutter apps
class FlutterGiphy {


  // List to store trending gifs
  static  List<GiphyData> _trendingGifs = [];

  // GifRepository instance for fetching gifs
  static final GifRepository _gifRepository = GifRepository(dio: Dio());

  // GiphyCubit instance for managing state
  static final GiphyCubit _giphyCubit = GiphyCubit(gifRepository: _gifRepository);

  /// Displays a bottom sheet with a gif picker
  ///
  /// [context] is the BuildContext in which the bottom sheet is shown
  /// [apikey] is the Giphy API key
  /// [searchBarDecoration] is the InputDecoration for the search field
  /// [loadingWidget] is the widget shown while gifs are loading
  /// [errorWidget] is the widget shown when an error occurs
  /// [backgroundColor] is the color of the bottom sheet's background

  static void showGifPicker({
    required BuildContext context,
    required String apikey,
    InputDecoration? searchBarDecoration,
    Widget? loadingWidget,
    Widget? errorWidget,
    Color backgroundColor = Colors.white,
  }) {
    loadMore(apikey);
    showModalBottomSheet<Widget>(
      context: context,
      backgroundColor: backgroundColor,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.8,
      ),
      builder: (BuildContext context) {
        return Column(
          children: [
            TextFormField(
              decoration: searchBarDecoration ??
                  InputDecoration(
                    hintText: 'Search Giphy',
                    prefixIcon: Icon(
                      Icons.search,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: BlocConsumer<GiphyCubit, GiphyState>(
                bloc: _giphyCubit,
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
                    );
                  }
                  if (state is GiphyError) {
                    return errorWidget ??
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
                                onPressed: () => loadMore(apikey),
                                child: const Text('Retry'),
                              )
                            ],
                          ),
                        );
                  }
                  if (state is GiphySuccess) {
                    return GifGridView(
                      gifs: _trendingGifs,
                      onEndOfPage: () {
                        loadMore(apikey, offset: _trendingGifs.length,isFirstFetch: false);
                      },
                      loadingWidget: loadingWidget,
                    );
                  }
                  return const SizedBox.shrink();
                },
                listener: (BuildContext context, GiphyState state) {
                  if (state is GiphySuccess) {
                    _trendingGifs.addAll(state.gif.data ?? []);
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }

  static void loadMore(String apiKey, {int offset = 0, bool isFirstFetch = true, }) {
    _giphyCubit.fetchTrendingGif(apikey: apiKey, offset: offset,isFirstFetch: isFirstFetch);
  }
}
