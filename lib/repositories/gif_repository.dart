import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_giphy/models/giphy_gif.dart';

class GifRepository {
  GifRepository({required this.dio})
      : _dio = Dio(
          BaseOptions(
            connectTimeout: const Duration(seconds: 3),
            receiveTimeout: const Duration(seconds: 3),
          ),
        ) {
    dio.interceptors.add(
      LogInterceptor(
        responseBody: true,
        requestBody: true,
      ),
    );
  }

  final Dio dio;

  final Dio _dio;

  Future<Either<String, GiphyGif>> fetchTrendingGif() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        'https://api.giphy.com/v1/gifs/trending?api_key=eRt8dIjUZHBpdzAjo2ZTAbGJ7f41ET50&limit=25&offset=0&rating=g&bundle=messaging_non_clips',
      );
      if (response.statusCode == 200 && response.data != null) {
        final giphyGif = GiphyGif.fromJson(response.data!,);

        return Right(giphyGif);
      } else {
        return Left(response.statusMessage ?? 'Error');
      }
    } on DioException catch (e) {
      return Left(e.toString());
    }
  }
}
