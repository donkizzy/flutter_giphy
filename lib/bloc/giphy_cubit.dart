import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_giphy/models/giphy_gif.dart';
import 'package:flutter_giphy/repositories/gif_repository.dart';

part 'giphy_state.dart';

/// Searches for a gif in the Giphy API.
///
/// It takes the [apikey], [offset], [keyword], and [language] as parameters.
/// Returns a Future that resolves to an Either type, containing a String error message or a GiphyGif object.
class GiphyCubit extends Cubit<GiphyState> {
  /// The constructor for the GiphyCubit class.
  ///
  /// It takes a [gifRepository] parameter of type GifRepository.
  /// It initializes the state to GiphyInitial.
  GiphyCubit({required this.gifRepository}) : super(GiphyInitial());

  final GifRepository gifRepository;

  /// Fetches a trending gif from the Giphy API.
  ///
  /// It takes the [apikey], [offset], [isFirstFetch], and [language] as parameters.
  /// It emits a GiphyLoading state if it is the first fetch.
  /// It emits a GiphySuccess state if the fetch is successful, or a GiphyError state if an error occurs.
  Future<void> fetchTrendingGif(
      {required String apikey,
      required int offset,
      required bool isFirstFetch,
      required String language}) async {
    try {
      if (isFirstFetch) {
        emit(GiphyLoading());
      }
      final response = await gifRepository.fetchTrendingGif(
          apikey: apikey, offset: offset, language: language);
      response.fold(
        (l) => emit(GiphyError(error: l)),
        (r) => emit(GiphySuccess(gif: r)),
      );
    } catch (e) {
      emit(GiphyError(error: e.toString()));
    }
  }

  /// Searches for a gif in the Giphy API.
  ///
  /// It takes the [apikey], [offset], [isFirstFetch], [keyword], and [language] as parameters.
  /// It emits a GiphyLoading state if it is the first fetch.
  /// It emits a SearchGifSuccess state if the search is successful, or a SearchGifError state if an error occurs.

  Future<void> searchGif(
      {required String apikey,
      required int offset,
      required bool isFirstFetch,
      required String keyword,
      required String language}) async {
    try {
      if (isFirstFetch) {
        emit(GiphyLoading());
      }
      final response = await gifRepository.searchGif(
          apikey: apikey, offset: offset, keyword: keyword, language: language);
      response.fold(
        (l) => emit(SearchGifError(error: l)),
        (r) {
          if (isFirstFetch) {
            emit(GiphyInitial());
          }
          emit(SearchGifSuccess(gif: r));
        },
      );
    } catch (e) {
      emit(SearchGifError(error: e.toString()));
    }
  }
}
