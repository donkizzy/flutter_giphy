import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_giphy/bloc/giphy_cubit.dart';
import 'package:flutter_giphy/models/giphy_data.dart';
import 'package:flutter_giphy/repositories/gif_repository.dart';
import 'package:flutter_giphy/src/search_grid_view.dart';
import 'package:flutter_giphy/src/trending_grid_view.dart';

/// Flutter Giphy makes it easy fou you be use Giphy in your flutter app
class FlutterGiphy {
  static final searchController = TextEditingController();
  static final ValueNotifier<bool> searchNotifier = ValueNotifier<bool>(false);

  // GifRepository instance for fetching gifs
  static final GifRepository _gifRepository = GifRepository(dio: Dio());

  // GiphyCubit instance for managing state
  static final GiphyCubit _giphyCubit =
      GiphyCubit(gifRepository: _gifRepository);

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
    final ValueChanged<GiphyData>? onSelected ,
  }) {
    showModalBottomSheet<Widget>(
      context: context,
      backgroundColor: backgroundColor,
      isScrollControlled: true,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.8,
      ),
      builder: (BuildContext context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            children: [
              TextFormField(
                controller: searchController,
                onChanged: (value) {
                  searchNotifier.value = value.isNotEmpty;
                },
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
                child: ValueListenableBuilder(
                  builder: (BuildContext context, bool value, Widget? child) {
                    return value
                        ? SearchGridView(
                            loadingWidget: loadingWidget,
                            errorWidget: errorWidget,
                            giphyCubit: _giphyCubit,
                            apikey: apikey,
                            searchController: searchController,
                            onSelected: onSelected,
                          )
                        : TrendingGridView(
                            loadingWidget: loadingWidget,
                            errorWidget: errorWidget,
                            giphyCubit: _giphyCubit,
                            apikey: apikey,
                      onSelected: onSelected,
                          );
                  },
                  valueListenable: searchNotifier,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static void clearSearch() {
    searchController.clear();
    searchNotifier.value = false;
  }
}
