import 'package:flutter_giphy/models/giphy_user.dart';
import 'package:flutter_giphy/models/analytics.dart';
import 'package:flutter_giphy/models/giphy_images.dart';


class GiphyData {
  final String? type;
  final String? id;
  final String? url;
  final String? slug;
  final String? bitlyGifUrl;
  final String? bitlyUrl;
  final String? embedUrl;
  final String? username;
  final String? source;
  final String? title;
  final String? rating;
  final String? contentUrl;
  final String? sourceTld;
  final String? sourcePostUrl;
  final int? isSticker;
  final DateTime? importDatetime;
  final String? trendingDatetime;
  final GifImages? images;
  final User? user;
  final String? analyticsResponsePayload;
  final Analytics? analytics;

  GiphyData({
    this.type,
    this.id,
    this.url,
    this.slug,
    this.bitlyGifUrl,
    this.bitlyUrl,
    this.embedUrl,
    this.username,
    this.source,
    this.title,
    this.rating,
    this.contentUrl,
    this.sourceTld,
    this.sourcePostUrl,
    this.isSticker,
    this.importDatetime,
    this.trendingDatetime,
    this.images,
    this.user,
    this.analyticsResponsePayload,
    this.analytics,
  });

  factory GiphyData.fromJson(Map<String, dynamic> json) => GiphyData(
    type: json["type"],
    id: json["id"],
    url: json["url"],
    slug: json["slug"],
    bitlyGifUrl: json["bitly_gif_url"],
    bitlyUrl: json["bitly_url"],
    embedUrl: json["embed_url"],
    username: json["username"],
    source: json["source"],
    title: json["title"],
    rating: json["rating"],
    contentUrl: json["content_url"],
    sourceTld: json["source_tld"],
    sourcePostUrl: json["source_post_url"],
    isSticker: json["is_sticker"],
    importDatetime: json["import_datetime"] == null ? null : DateTime.parse(json["import_datetime"]),
    trendingDatetime: json["trending_datetime"],
    images: json["images"] == null ? null : GifImages.fromJson(json["images"]),
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    analyticsResponsePayload: json["analytics_response_payload"],
    analytics: json["analytics"] == null ? null : Analytics.fromJson(json["analytics"]),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "id": id,
    "url": url,
    "slug": slug,
    "bitly_gif_url": bitlyGifUrl,
    "bitly_url": bitlyUrl,
    "embed_url": embedUrl,
    "username": username,
    "source": source,
    "title": title,
    "rating": rating,
    "content_url": contentUrl,
    "source_tld": sourceTld,
    "source_post_url": sourcePostUrl,
    "is_sticker": isSticker,
    "import_datetime": importDatetime?.toIso8601String(),
    "trending_datetime": trendingDatetime,
    "images": images?.toJson(),
    "user": user?.toJson(),
    "analytics_response_payload": analyticsResponsePayload,
    "analytics": analytics?.toJson(),
  };
}