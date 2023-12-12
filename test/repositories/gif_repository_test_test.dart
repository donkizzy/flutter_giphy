import 'package:dartz_test/dartz_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter_giphy/models/giphy_gif.dart';
import 'package:flutter_giphy/repositories/gif_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'gif_repository_test_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  group('description', () {
    late GifRepository _gifRepository;
    late MockDio mockDio;

    setUp(() {
      mockDio = MockDio();
      _gifRepository = GifRepository(dio: mockDio);
    });

    test('Test Success for Fetch Trending Gifs', () async {
      final dataResponse = {
        "data": [
          {
            "type": "gif",
            "id": "DDkZETHtyhWNXOlb4R",
            "url":
                "https://giphy.com/gifs/netflix-bayard-rustin-movie-netflix-DDkZETHtyhWNXOlb4R",
            "slug": "netflix-bayard-rustin-movie-netflix-DDkZETHtyhWNXOlb4R",
            "bitly_gif_url": "https://gph.is/g/4bnmbrv",
            "bitly_url": "https://gph.is/g/4bnmbrv",
            "embed_url": "https://giphy.com/embed/DDkZETHtyhWNXOlb4R",
            "username": "netflix",
            "source": "",
            "title": "Colman Domingo GIF by NETFLIX",
            "rating": "g",
            "content_url": "",
            "source_tld": "",
            "source_post_url": "",
            "is_sticker": 0,
            "import_datetime": "2023-09-01 20:44:47",
            "trending_datetime": "2023-12-12 16:59:06",
            "images": {
              "original": {
                "height": "480",
                "width": "480",
                "size": "2061959",
                "url":
                    "https://media4.giphy.com/media/DDkZETHtyhWNXOlb4R/giphy.gif?cid=ed0d52ad4lhaq9cw4tgzhqllehwo0duyg0fovxpmwtqbl945&ep=v1_gifs_trending&rid=giphy.gif&ct=g",
                "mp4_size": "250962",
                "mp4":
                    "https://media4.giphy.com/media/DDkZETHtyhWNXOlb4R/giphy.mp4?cid=ed0d52ad4lhaq9cw4tgzhqllehwo0duyg0fovxpmwtqbl945&ep=v1_gifs_trending&rid=giphy.mp4&ct=g",
                "webp_size": "474694",
                "webp":
                    "https://media4.giphy.com/media/DDkZETHtyhWNXOlb4R/giphy.webp?cid=ed0d52ad4lhaq9cw4tgzhqllehwo0duyg0fovxpmwtqbl945&ep=v1_gifs_trending&rid=giphy.webp&ct=g",
                "frames": "28",
                "hash": "216c8ab7217acf26c962e9d450f2cfdc",
              },
              "fixed_height": {
                "height": "200",
                "width": "200",
                "size": "353571",
                "url":
                    "https://media4.giphy.com/media/DDkZETHtyhWNXOlb4R/200.gif?cid=ed0d52ad4lhaq9cw4tgzhqllehwo0duyg0fovxpmwtqbl945&ep=v1_gifs_trending&rid=200.gif&ct=g",
                "mp4_size": "68277",
                "mp4":
                    "https://media4.giphy.com/media/DDkZETHtyhWNXOlb4R/200.mp4?cid=ed0d52ad4lhaq9cw4tgzhqllehwo0duyg0fovxpmwtqbl945&ep=v1_gifs_trending&rid=200.mp4&ct=g",
                "webp_size": "162768",
                "webp":
                    "https://media4.giphy.com/media/DDkZETHtyhWNXOlb4R/200.webp?cid=ed0d52ad4lhaq9cw4tgzhqllehwo0duyg0fovxpmwtqbl945&ep=v1_gifs_trending&rid=200.webp&ct=g",
              },
              "fixed_height_downsampled": {
                "height": "200",
                "width": "200",
                "size": "92100",
                "url":
                    "https://media4.giphy.com/media/DDkZETHtyhWNXOlb4R/200_d.gif?cid=ed0d52ad4lhaq9cw4tgzhqllehwo0duyg0fovxpmwtqbl945&ep=v1_gifs_trending&rid=200_d.gif&ct=g",
                "webp_size": "62038",
                "webp":
                    "https://media4.giphy.com/media/DDkZETHtyhWNXOlb4R/200_d.webp?cid=ed0d52ad4lhaq9cw4tgzhqllehwo0duyg0fovxpmwtqbl945&ep=v1_gifs_trending&rid=200_d.webp&ct=g",
              },
              "fixed_height_small": {
                "height": "100",
                "width": "100",
                "size": "121426",
                "url":
                    "https://media4.giphy.com/media/DDkZETHtyhWNXOlb4R/100.gif?cid=ed0d52ad4lhaq9cw4tgzhqllehwo0duyg0fovxpmwtqbl945&ep=v1_gifs_trending&rid=100.gif&ct=g",
                "mp4_size": "26356",
                "mp4":
                    "https://media4.giphy.com/media/DDkZETHtyhWNXOlb4R/100.mp4?cid=ed0d52ad4lhaq9cw4tgzhqllehwo0duyg0fovxpmwtqbl945&ep=v1_gifs_trending&rid=100.mp4&ct=g",
                "webp_size": "67972",
                "webp":
                    "https://media4.giphy.com/media/DDkZETHtyhWNXOlb4R/100.webp?cid=ed0d52ad4lhaq9cw4tgzhqllehwo0duyg0fovxpmwtqbl945&ep=v1_gifs_trending&rid=100.webp&ct=g",
              },
              "fixed_width": {
                "height": "200",
                "width": "200",
                "size": "353571",
                "url":
                    "https://media4.giphy.com/media/DDkZETHtyhWNXOlb4R/200w.gif?cid=ed0d52ad4lhaq9cw4tgzhqllehwo0duyg0fovxpmwtqbl945&ep=v1_gifs_trending&rid=200w.gif&ct=g",
                "mp4_size": "68277",
                "mp4":
                    "https://media4.giphy.com/media/DDkZETHtyhWNXOlb4R/200w.mp4?cid=ed0d52ad4lhaq9cw4tgzhqllehwo0duyg0fovxpmwtqbl945&ep=v1_gifs_trending&rid=200w.mp4&ct=g",
                "webp_size": "162768",
                "webp":
                    "https://media4.giphy.com/media/DDkZETHtyhWNXOlb4R/200w.webp?cid=ed0d52ad4lhaq9cw4tgzhqllehwo0duyg0fovxpmwtqbl945&ep=v1_gifs_trending&rid=200w.webp&ct=g",
              },
              "fixed_width_downsampled": {
                "height": "200",
                "width": "200",
                "size": "92100",
                "url":
                    "https://media4.giphy.com/media/DDkZETHtyhWNXOlb4R/200w_d.gif?cid=ed0d52ad4lhaq9cw4tgzhqllehwo0duyg0fovxpmwtqbl945&ep=v1_gifs_trending&rid=200w_d.gif&ct=g",
                "webp_size": "62038",
                "webp":
                    "https://media4.giphy.com/media/DDkZETHtyhWNXOlb4R/200w_d.webp?cid=ed0d52ad4lhaq9cw4tgzhqllehwo0duyg0fovxpmwtqbl945&ep=v1_gifs_trending&rid=200w_d.webp&ct=g",
              },
              "fixed_width_small": {
                "height": "100",
                "width": "100",
                "size": "121426",
                "url":
                    "https://media4.giphy.com/media/DDkZETHtyhWNXOlb4R/100w.gif?cid=ed0d52ad4lhaq9cw4tgzhqllehwo0duyg0fovxpmwtqbl945&ep=v1_gifs_trending&rid=100w.gif&ct=g",
                "mp4_size": "26356",
                "mp4":
                    "https://media4.giphy.com/media/DDkZETHtyhWNXOlb4R/100w.mp4?cid=ed0d52ad4lhaq9cw4tgzhqllehwo0duyg0fovxpmwtqbl945&ep=v1_gifs_trending&rid=100w.mp4&ct=g",
                "webp_size": "67972",
                "webp":
                    "https://media4.giphy.com/media/DDkZETHtyhWNXOlb4R/100w.webp?cid=ed0d52ad4lhaq9cw4tgzhqllehwo0duyg0fovxpmwtqbl945&ep=v1_gifs_trending&rid=100w.webp&ct=g",
              },
            },
            "user": {
              "avatar_url":
                  "https://media0.giphy.com/avatars/netflix/4oBuhqPAhFem.png",
              "banner_image": "",
              "banner_url": "",
              "profile_url": "https://giphy.com/netflix/",
              "username": "netflix",
              "display_name": "NETFLIX",
              "description":
                  "See What's Next in entertainment and Netflix original series, movies, TV, docs, and comedies. You can stream Netflix anytime, anywhere, on any device.",
              "instagram_url": "",
              "website_url": "http://netflix.com",
              "is_verified": true,
            },
            "analytics_response_payload":
                "e=Z2lmX2lkPUREa1pFVEh0eWhXTlhPbGI0UiZldmVudF90eXBlPUdJRl9UUkVORElORyZjaWQ9ZWQwZDUyYWQ0bGhhcTljdzR0Z3pocWxsZWh3bzBkdXlnMGZvdnhwbXd0cWJsOTQ1JmN0PWc",
            "analytics": {
              "onload": {
                "url":
                    "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPUREa1pFVEh0eWhXTlhPbGI0UiZldmVudF90eXBlPUdJRl9UUkVORElORyZjaWQ9ZWQwZDUyYWQ0bGhhcTljdzR0Z3pocWxsZWh3bzBkdXlnMGZvdnhwbXd0cWJsOTQ1JmN0PWc&action_type=SEEN",
              },
              "onclick": {
                "url":
                    "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPUREa1pFVEh0eWhXTlhPbGI0UiZldmVudF90eXBlPUdJRl9UUkVORElORyZjaWQ9ZWQwZDUyYWQ0bGhhcTljdzR0Z3pocWxsZWh3bzBkdXlnMGZvdnhwbXd0cWJsOTQ1JmN0PWc&action_type=CLICK",
              },
              "onsent": {
                "url":
                    "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPUREa1pFVEh0eWhXTlhPbGI0UiZldmVudF90eXBlPUdJRl9UUkVORElORyZjaWQ9ZWQwZDUyYWQ0bGhhcTljdzR0Z3pocWxsZWh3bzBkdXlnMGZvdnhwbXd0cWJsOTQ1JmN0PWc&action_type=SENT",
              },
            },
          },
        ],
        "pagination": {"total_count": 2640, "count": 25, "offset": 0},
        "meta": {
          "status": 200,
          "msg": "OK",
          "response_id": "4lhaq9cw4tgzhqllehwo0duyg0fovxpmwtqbl945",
        },
      };

      when(
        mockDio.get<Map<String, dynamic>>(
          'https://api.giphy.com/v1/gifs/trending?api_key=eRt8dIjUZHBpdzAjo2ZTAbGJ7f41ET50&limit=25&offset=0&rating=g&bundle=messaging_non_clips',
        ),
      ).thenAnswer((_) async => Response(
            statusCode: 200,
            requestOptions: RequestOptions(),
            data: dataResponse,
          ),);

      final result = await _gifRepository.fetchTrendingGif();

      final value = result.getRightOrFailTest();
      expect(value, isA<GiphyGif>());
    });
  });
}
