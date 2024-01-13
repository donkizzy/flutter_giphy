import 'package:dartz/dartz.dart';
import 'package:flutter_giphy/bloc/giphy_cubit.dart';
import 'package:flutter_giphy/models/giphy_gif.dart';
import 'package:flutter_giphy/models/giphy_meta.dart';
import 'package:flutter_giphy/repositories/gif_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';

import 'giphy_cubit_test.mocks.dart';

@GenerateMocks([GifRepository])
void main() {
  final mockGifRepository = MockGifRepository();

  group('Fetch Trending Gifs', () {

    blocTest<GiphyCubit, GiphyState>(
      'emits [GiphyLoading, GiphySuccess] when fetchTrendingGif is successful',
      build: () {

        when(mockGifRepository.fetchTrendingGif(
                apikey: anyNamed('apikey'), offset: anyNamed('offset')))
            .thenAnswer((_) async => Right(GiphyGif(
                data: [],
                meta: Meta(status: 200, msg: 'OK', responseId: 'test_id'))));
        return GiphyCubit(gifRepository: mockGifRepository);
      },
      act: (cubit) => cubit.fetchTrendingGif(
          apikey: 'test_api_key', offset: 0, isFirstFetch: true),
      expect: () => <GiphyState>[
        GiphyLoading(),
        GiphySuccess(
            gif: GiphyGif(
                data: [],
                meta: Meta(status: 200, msg: 'OK', responseId: 'test_id'))),
      ],
    );

    blocTest<GiphyCubit, GiphyState>(
      'emits [GiphyLoading, GiphySuccess] when fetchTrendingGif is fetching more gifs',
      build: () {

        when(mockGifRepository.fetchTrendingGif(
                apikey: anyNamed('apikey'), offset: anyNamed('offset')))
            .thenAnswer((_) async => Right(GiphyGif(
                data: [],
                meta: Meta(status: 200, msg: 'OK', responseId: 'test_id'))));
        return GiphyCubit(gifRepository: mockGifRepository);
      },
      act: (cubit) => cubit.fetchTrendingGif(
          apikey: 'test_api_key', offset: 0, isFirstFetch: false),
      expect: () => <GiphyState>[
        GiphySuccess(
            gif: GiphyGif(
                data: [],
                meta: Meta(status: 200, msg: 'OK', responseId: 'test_id'))),
      ],
    );

    blocTest<GiphyCubit, GiphyState>(
      'emits [GiphyLoading, GiphyError] when fetchTrendingGif fails',
      build: () {
        when(mockGifRepository.fetchTrendingGif(
                apikey: anyNamed('apikey'), offset: anyNamed('offset')))
            .thenAnswer((_) async => Left('Error'));
        return GiphyCubit(gifRepository: mockGifRepository);
      },
      act: (cubit) => cubit.fetchTrendingGif(
          apikey: 'test_api_key', offset: 0, isFirstFetch: true),
      expect: () => <GiphyState>[
        GiphyLoading(),
        GiphyError(error: 'Error'),
      ],
    );
  });
}
