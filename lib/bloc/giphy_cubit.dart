import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_giphy/models/giphy_gif.dart';
import 'package:flutter_giphy/repositories/gif_repository.dart';

part 'giphy_state.dart';

class GiphyCubit extends Cubit<GiphyState> {


  GiphyCubit({required this.gifRepository}) : super(GiphyInitial());

  final GifRepository gifRepository;

  Future<void> fetchTrendingGif() async {
    try {
      emit(GiphyLoading());
      final response = await gifRepository.fetchTrendingGif();
      response.fold((l) => emit(GiphyError(error: l)), (r) =>
          emit(GiphySuccess(gif: r)),);
    } catch (e) {
      emit(GiphyError(error: e.toString()));
    }
  }

}
