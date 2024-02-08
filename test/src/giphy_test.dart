import 'package:dartz/dartz.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_giphy/flutter_giphy.dart';
import 'package:flutter_giphy/models/giphy_gif.dart';
import 'package:flutter_giphy/repositories/gif_repository.dart';
import 'package:flutter_giphy/utils/language_code.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../bloc/giphy_cubit_test.mocks.dart';

@GenerateMocks([GifRepository])
void main() {
  late MockGifRepository gifRepository;
  late final Giphy giphy;
  late final String apikey;

  setUpAll(() async {
    await dotenv.load();
    gifRepository = MockGifRepository();
    apikey = dotenv.env['API_KEY'] ?? '';
    giphy = Giphy(apiKey: apikey, gifRepository: gifRepository);
  });
  group('Fetch Trending gifs', () {
    test('Should return a GiphyGif object when successful', () async {
      when(gifRepository.fetchTrendingGif(
              apikey: apikey, offset: 0, language: GiphyLanguage.English))
          .thenAnswer((_) async => Right(GiphyGif()));
      final response = await giphy.fetchTrendingGif();
      expect(response, isA<GiphyGif>());
    });

    test(
        'Should be null when there is an error',
        () => () async {
              when(gifRepository.fetchTrendingGif(
                      apikey: apikey,
                      offset: 0,
                      language: GiphyLanguage.English))
                  .thenAnswer((_) async => Left('Error'));
              final response = await giphy.fetchTrendingGif();
              expect(response, isA<GiphyGif>());
              expect(response, null);
            });
  });

  group('Search Gifs', () {
    test('Should return a GiphyGif object', () async {
      when(gifRepository.searchGif(
              apikey: apikey,
              offset: 0,
              language: GiphyLanguage.English,
              keyword: 'test'))
          .thenAnswer((_) async => Right(GiphyGif()));
      final response = await giphy.searchGif(keyword: 'test');
      expect(response, isA<GiphyGif>());
    });

    test('Should be null when there is an error', () async {
      when(gifRepository.searchGif(
              apikey: apikey,
              offset: 0,
              language: GiphyLanguage.English,
              keyword: 'test'))
          .thenAnswer((_) async => Left('Error'));
      final response = await giphy.searchGif(keyword: 'test');
      expect(response, isA<GiphyGif>());
      expect(response, null);
    });
  });
}
