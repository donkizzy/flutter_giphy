abstract class ApiConfig {
  static String baseUrl = 'https://api.giphy.com/v1/gifs';

  static String trendingGifs({required String apiKey, required int offset}) =>
      '$baseUrl/trending?api_key=$apiKey&limit=25&offset=$offset&rating=g&bundle=messaging_non_clips';

  static String searchGifs(
          {required String apiKey,
          required int offset,
          required String keyword}) =>
      '$baseUrl/search?api_key=$apiKey&q=$keyword&limit=25&offset=$offset&rating=g&bundle=messaging_non_clips';
}
