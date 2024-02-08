import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_giphy/flutter_giphy.dart';
import 'package:flutter_giphy/repositories/gif_repository.dart';
import 'package:flutter_giphy/utils/language_code.dart';

/// Giphy is a class that handles the fetching and searching of gifs from the Giphy API.
///
/// It uses the GifRepository for making the API calls. and this class can be sued to cater for your own custom UI

class Giphy {
  final String apiKey;
  final String language;
  final GifRepository _gifRepository;

  /// The constructor for the Giphy class.
  ///
  /// It takes a [apiKey] parameter of type String which is the Giphy API key.
  /// It takes a [language] parameter of type String which is the language of the gifs. Default is English.
  /// It takes a [gifRepository] parameter of type GifRepository which is the repository for the gifs. Default is a new instance of GifRepository.
  Giphy(
      {required this.apiKey,
      this.language = GiphyLanguage.English,
      GifRepository? gifRepository})
      : assert(apiKey.trim() != '', 'Parameter apiKey should not be empty.'),
        _gifRepository = gifRepository ?? GifRepository(dio: Dio());

  /// Fetches a trending gif from the Giphy API.
  ///
  /// It takes an [offset] parameter of type int which is the offset for the gifs. Default is 0.
  /// Returns a Future that resolves to a GiphyGif object

  Future<GiphyGif> fetchTrendingGif({int offset = 0}) async {
    late GiphyGif giphyGif;
    try {
      final response = await _gifRepository.fetchTrendingGif(
          apikey: apiKey, offset: offset, language: language);
      response.fold(
        (l) => l,
        (r) {
          giphyGif = r;
        },
      );
    } catch (e) {
      debugPrint(e.toString());
    }
    return giphyGif;
  }

  /// Searches for a gif in the Giphy API.
  ///
  /// It takes an [offset] parameter of type int which is the offset for the gifs. Default is 0.
  /// It takes a [keyword] parameter of type String which is the keyword for the search.
  /// Returns a Future that resolves to a GiphyGif object.

  Future<GiphyGif> searchGif({int offset = 0, required String keyword}) async {
    late GiphyGif giphyGif;
    try {
      final response = await _gifRepository.searchGif(
          apikey: apiKey, offset: offset, keyword: keyword, language: language);
      response.fold(
        (l) => l,
        (r) {
          giphyGif = r;
        },
      );
    } catch (e) {
      debugPrint(e.toString());
    }
    return giphyGif;
  }
}
