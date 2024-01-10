import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_giphy/bloc/giphy_cubit.dart';
import 'package:flutter_giphy/models/giphy_data.dart';
import 'package:flutter_giphy/repositories/gif_repository.dart';
import 'package:flutter_giphy/utils/lazy_load_scroll_view.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shimmer/shimmer.dart';

/// Flutter Giphy makes it easy fou you be use Giphy in your flutter apps
class FlutterGiphy {
  FlutterGiphy();

  static int _offset = 0;
  static  List<GiphyData> _trendingGifs = [];
  static final Dio _dio = Dio();
  static final GifRepository _gifRepository = GifRepository(dio: _dio);

  static final GiphyCubit _giphyCubit = GiphyCubit(gifRepository: _gifRepository);

  static void showGifPicker({
    required BuildContext context,
    required String apikey,
    InputDecoration? decoration,
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
              decoration: decoration ??
                  InputDecoration(
                    hintText: 'Search Gif',
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
                    return LazyLoadScrollView(
                      onEndOfPage: () => loadMore(apikey),
                      child: MasonryGridView.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 4,
                        crossAxisSpacing: 4,
                        padding: const EdgeInsets.all(10),
                        itemCount: _trendingGifs.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return CachedNetworkImage(
                            imageUrl: _trendingGifs[index].images?.original?.url ?? '',
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
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          );
                        },
                      ),
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

  static loadMore(String apiKey) {
    _offset++;
    _giphyCubit.fetchTrendingGif(apikey: apiKey, offset: _offset);
  }
}
