part of 'giphy_cubit.dart';

abstract class GiphyState extends Equatable {
  const GiphyState();
}

class GiphyInitial extends GiphyState {
  @override
  List<Object> get props => [];
}

class GiphyLoading extends GiphyState {
  @override
  List<Object> get props => [];
}

class GiphySuccess extends GiphyState {
  const GiphySuccess({required this.gif});

  final GiphyGif gif;

  @override
  List<Object> get props => [gif];
}

class GiphyError extends GiphyState {
  const GiphyError({required this.error});

  final String error;

  @override
  List<Object> get props => [error];
}
