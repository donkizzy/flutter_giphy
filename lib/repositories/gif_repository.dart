import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_giphy/models/giphy_gif.dart';
import 'package:flutter_giphy/utils/constants.dart';

class GifRepository {
  GifRepository({required this.dio})
      : _dio = Dio(
          BaseOptions(
            connectTimeout: const Duration(seconds: 3),
            receiveTimeout: const Duration(seconds: 3),
          ),
        );

  final Dio dio;

  final Dio _dio;

  Future<Either<String, GiphyGif>> fetchTrendingGif(
      {required String apikey,
      required int offset,
      required String language}) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        ApiConfig.trendingGifs(
            apiKey: apikey, offset: offset, language: language),
      );
      if (response.statusCode == 200 && response.data != null) {
        final giphyGif = GiphyGif.fromJson(
          response.data!,
        );

        return Right(giphyGif);
      } else {
        return Left(response.statusMessage ?? 'Error');
      }
    } on DioException catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, GiphyGif>> searchGif(
      {required String apikey,
      required int offset,
      required String keyword,
      required String language}) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        ApiConfig.searchGifs(
            apiKey: apikey,
            offset: offset,
            keyword: keyword,
            language: language),
      );
      if (response.statusCode == 200 && response.data != null) {
        final giphyGif = GiphyGif.fromJson(
          response.data!,
        );
        return Right(giphyGif);
      } else {
        return Left(response.statusMessage ?? 'Error');
      }
    } on DioException catch (e) {
      return Left(e.toString());
    }
  }
}
