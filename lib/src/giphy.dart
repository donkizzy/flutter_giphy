import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_giphy/flutter_giphy.dart';
import 'package:flutter_giphy/repositories/gif_repository.dart';
import 'package:flutter_giphy/utils/language_code.dart';

class Giphy {
  final String apiKey;
  final String language;

  Giphy({required this.apiKey, this.language = GiphyLanguage.English})
      : assert(apiKey.trim() != '', 'Parameter apiKey should not be empty.');

  static final GifRepository _gifRepository = GifRepository(dio: Dio());

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

  Future<Either<String, GiphyGif>> searchGif(
      {int offset = 0, required String keyword}) async {
    try {
      final response = await _gifRepository.searchGif(
          apikey: apiKey, offset: offset, keyword: keyword, language: language);
      response.fold(
        (l) => l,
        (r) => r,
      );
    } catch (e) {
      return Left(e.toString());
    }
    return Left('Error');
  }
}
