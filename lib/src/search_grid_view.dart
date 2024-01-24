import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_giphy/bloc/giphy_cubit.dart';
import 'package:flutter_giphy/models/giphy_data.dart';
import 'package:flutter_giphy/src/gif_grid_view.dart';
import 'package:flutter_giphy/utils/debouncer.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shimmer/shimmer.dart';

class SearchGridView extends StatefulWidget {
  final Widget? loadingWidget;
  final Widget? errorWidget;
  final GiphyCubit giphyCubit;
  final String apikey;
  final TextEditingController searchController;
  final ValueChanged<GiphyData>? onSelected ;

  const SearchGridView(
      {super.key,
      this.loadingWidget,
      this.errorWidget,
      required this.giphyCubit,
      required this.apikey,
      required this.searchController, this.onSelected});

  @override
  State<SearchGridView> createState() => _SearchGridViewState();
}

class _SearchGridViewState extends State<SearchGridView> {
  List<GiphyData> searchGifs = [];
  late final Debouncer debouncer ;

  @override
  void initState() {
    widget.searchController.addListener(() {
      search(widget.apikey, keyword: widget.searchController.text);
    }
    );


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GiphyCubit, GiphyState>(
      bloc: widget.giphyCubit,
      buildWhen: (previous, current) {
        return current is GiphyLoading ||
            current is SearchGifSuccess ||
            current is SearchGifError;
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
                      onPressed: () =>
                          search(widget.apikey, keyword: widget.searchController.text),
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
        if (state is SearchGifSuccess) {
          searchGifs.addAll(state.gif.data ?? []);
        }
      },
    );
  }

  void search(String apiKey,
      {int offset = 0, required String keyword, bool isFirstFetch = true}) {
    debouncer = Debouncer(milliseconds: 500);
    debouncer.run(() {
      widget.giphyCubit.searchGif(
          apikey: apiKey,
          offset: offset,
          keyword: keyword,
          isFirstFetch: isFirstFetch);
    });
  }

  @override
  void dispose() {
    debouncer.cancel();
    super.dispose();
  }
}

