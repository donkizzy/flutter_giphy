import 'package:dartz/dartz.dart';
import 'package:flutter_giphy/bloc/giphy_cubit.dart';
import 'package:flutter_giphy/models/giphy_gif.dart';
import 'package:flutter_giphy/models/giphy_meta.dart';
import 'package:flutter_giphy/repositories/gif_repository.dart';
import 'package:flutter_giphy/utils/language_code.dart';
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
                apikey: anyNamed('apikey'),
                offset: anyNamed('offset'),
                language: GiphyLanguage.English))
            .thenAnswer((_) async => Right(GiphyGif(
                data: [],
                meta: Meta(status: 200, msg: 'OK', responseId: 'test_id'))));
        return GiphyCubit(gifRepository: mockGifRepository);
      },
      act: (cubit) => cubit.fetchTrendingGif(
          apikey: 'test_api_key',
          offset: 0,
          isFirstFetch: true,
          language: GiphyLanguage.English),
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
                apikey: anyNamed('apikey'),
                offset: anyNamed('offset'),
                language: GiphyLanguage.English))
            .thenAnswer((_) async => Right(GiphyGif(
                data: [],
                meta: Meta(status: 200, msg: 'OK', responseId: 'test_id'))));
        return GiphyCubit(gifRepository: mockGifRepository);
      },
      act: (cubit) => cubit.fetchTrendingGif(
          apikey: 'test_api_key',
          offset: 0,
          isFirstFetch: false,
          language: GiphyLanguage.English),
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
                apikey: anyNamed('apikey'),
                offset: anyNamed('offset'),
                language: GiphyLanguage.English))
            .thenAnswer((_) async => Left('Error'));
        return GiphyCubit(gifRepository: mockGifRepository);
      },
      act: (cubit) => cubit.fetchTrendingGif(
          apikey: 'test_api_key',
          offset: 0,
          isFirstFetch: true,
          language: GiphyLanguage.English),
      expect: () => <GiphyState>[
        GiphyLoading(),
        GiphyError(error: 'Error'),
      ],
    );
  });

  group('Search Gifs', () {
    blocTest<GiphyCubit, GiphyState>(
      'emits [SearchGifLoading, SearchGifSuccess] when searchGif is successful for the first time',
      build: () {
        when(mockGifRepository.searchGif(
                apikey: anyNamed('apikey'),
                offset: anyNamed('offset'),
                keyword: anyNamed('keyword'),
                language: anyNamed('language')))
            .thenAnswer((_) async => Right(GiphyGif(
                data: [],
                meta: Meta(status: 200, msg: 'OK', responseId: 'test_id'))));
        return GiphyCubit(gifRepository: mockGifRepository);
      },
      act: (cubit) => cubit.searchGif(
          apikey: 'test_api_key',
          offset: 0,
          keyword: 'test_keyword',
          isFirstFetch: true,
          language: GiphyLanguage.English),
      expect: () => <GiphyState>[
        GiphyLoading(),
        GiphyInitial(),
        SearchGifSuccess(
            gif: GiphyGif(
                data: [],
                meta: Meta(status: 200, msg: 'OK', responseId: 'test_id'))),
      ],
    );

    blocTest<GiphyCubit, GiphyState>(
      'emits [SearchGifLoading, SearchGifSuccess] when searchGif is successful and fetching the next page',
      build: () {
        when(mockGifRepository.searchGif(
                apikey: anyNamed('apikey'),
                offset: anyNamed('offset'),
                keyword: anyNamed('keyword'),
                language: GiphyLanguage.English))
            .thenAnswer((_) async => Right(GiphyGif(
                data: [],
                meta: Meta(status: 200, msg: 'OK', responseId: 'test_id'))));
        return GiphyCubit(gifRepository: mockGifRepository);
      },
      act: (cubit) => cubit.searchGif(
          apikey: 'test_api_key',
          offset: 0,
          keyword: 'test_keyword',
          isFirstFetch: false,
          language: GiphyLanguage.English),
      expect: () => <GiphyState>[
        SearchGifSuccess(
            gif: GiphyGif(
                data: [],
                meta: Meta(status: 200, msg: 'OK', responseId: 'test_id'))),
      ],
    );

    blocTest<GiphyCubit, GiphyState>(
      'emits [SearchGifLoading, SearchGifError] when searchGif fails',
      build: () {
        when(mockGifRepository.searchGif(
                apikey: anyNamed('apikey'),
                offset: anyNamed('offset'),
                keyword: anyNamed('keyword'),
                language: GiphyLanguage.English))
            .thenAnswer((_) async => Left('Error'));
        return GiphyCubit(gifRepository: mockGifRepository);
      },
      act: (cubit) => cubit.searchGif(
          apikey: 'test_api_key',
          offset: 0,
          keyword: 'test_keyword',
          isFirstFetch: true,
          language: GiphyLanguage.English),
      expect: () => <GiphyState>[
        GiphyLoading(),
        SearchGifError(error: 'Error'),
      ],
    );
  });
}
