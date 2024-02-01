import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_giphy/flutter_giphy.dart';
import 'package:flutter_giphy/repositories/gif_repository.dart';
import 'package:flutter_giphy/utils/language_code.dart';

class Giphy {
  final String apiKey;
  final String language;
  final GifRepository _gifRepository;

  Giphy({required this.apiKey, this.language = GiphyLanguage.English, GifRepository? gifRepository})
      : assert(apiKey.trim() != '', 'Parameter apiKey should not be empty.'),
        _gifRepository = gifRepository ?? GifRepository(dio: Dio());

  Future<GiphyGif> fetchTrendingGif({int offset = 0}) async {
    late GiphyGif giphyGif;
    try {
      final response = await _gifRepository.fetchTrendingGif(apikey: apiKey, offset: offset, language: language);
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

  Future<GiphyGif> searchGif({int offset = 0, required String keyword}) async {
    late GiphyGif giphyGif;
    try {
      final response =
          await _gifRepository.searchGif(apikey: apiKey, offset: offset, keyword: keyword, language: language);
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
