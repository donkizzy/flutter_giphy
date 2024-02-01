import 'package:equatable/equatable.dart';
import 'package:flutter_giphy/models/analytics.dart';
import 'package:flutter_giphy/models/giphy_images.dart';
import 'package:flutter_giphy/models/giphy_user.dart';

class GiphyData extends Equatable {
  const GiphyData({
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
        type: json['type'] as String?,
        id: json['id'] as String?,
        url: json['url'] as String?,
        slug: json['slug'] as String?,
        bitlyGifUrl: json['bitly_gif_url'] as String?,
        bitlyUrl: json['bitly_url'] as String?,
        embedUrl: json['embed_url'] as String?,
        username: json['username'] as String?,
        source: json['source'] as String?,
        title: json['title'] as String?,
        rating: json['rating'] as String?,
        contentUrl: json['content_url'] as String?,
        sourceTld: json['source_tld'] as String?,
        sourcePostUrl: json['source_post_url'] as String?,
        isSticker: json['is_sticker'] as int?,
        importDatetime: json['import_datetime'] == null ? null : DateTime.parse(json['import_datetime'] as String),
        trendingDatetime: json['trending_datetime'] as String?,
        images: json['images'] == null ? null : GifImages.fromJson(json['images'] as Map<String, dynamic>),
        user: json['user'] == null ? null : User.fromJson(json['user'] as Map<String, dynamic>),
        analyticsResponsePayload: json['analytics_response_payload'] as String?,
        analytics: json['analytics'] == null ? null : Analytics.fromJson(json['analytics'] as Map<String, dynamic>),
      );
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

  Map<String, dynamic> toJson() => {
        'type': type,
        'id': id,
        'url': url,
        'slug': slug,
        'bitly_gif_url': bitlyGifUrl,
        'bitly_url': bitlyUrl,
        'embed_url': embedUrl,
        'username': username,
        'source': source,
        'title': title,
        'rating': rating,
        'content_url': contentUrl,
        'source_tld': sourceTld,
        'source_post_url': sourcePostUrl,
        'is_sticker': isSticker,
        'import_datetime': importDatetime?.toIso8601String(),
        'trending_datetime': trendingDatetime,
        'images': images?.toJson(),
        'user': user?.toJson(),
        'analytics_response_payload': analyticsResponsePayload,
        'analytics': analytics?.toJson(),
      };

  @override
  List<Object?> get props => [
        type,
        id,
        url,
        slug,
        bitlyGifUrl,
        bitlyUrl,
        embedUrl,
        username,
        source,
        title,
        rating,
        contentUrl,
        sourceTld,
        sourcePostUrl,
        isSticker,
        importDatetime,
        trendingDatetime,
        images,
        user,
        analyticsResponsePayload,
        analytics,
      ];
}
