import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_giphy/models/giphy_gif.dart';
import 'package:flutter_giphy/repositories/gif_repository.dart';

part 'giphy_state.dart';

class GiphyCubit extends Cubit<GiphyState> {
  GiphyCubit({required this.gifRepository}) : super(GiphyInitial());

  final GifRepository gifRepository;

  Future<void> fetchTrendingGif(
      {required String apikey,
      required int offset,
      required bool isFirstFetch,
      required String language}) async {
    try {
      if (isFirstFetch) {
        emit(GiphyLoading());
      }
      final response = await gifRepository.fetchTrendingGif(apikey: apikey, offset: offset,language: language);
      response.fold(
        (l) => emit(GiphyError(error: l)),
        (r) => emit(GiphySuccess(gif: r)),
      );
    } catch (e) {
      emit(GiphyError(error: e.toString()));
    }
  }

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
      final response =
          await gifRepository.searchGif(apikey: apikey, offset: offset,keyword: keyword,language: language);
      response.fold(
        (l) => emit(SearchGifError(error: l)),
        (r) => emit(SearchGifSuccess(gif: r)),
      );
    } catch (e) {
      emit(SearchGifError(error: e.toString()));
    }
  }
}
