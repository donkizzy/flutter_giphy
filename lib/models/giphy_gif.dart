import 'package:flutter_giphy/models/giphy_data.dart';
import 'package:flutter_giphy/models/giphy_meta.dart';
import 'package:flutter_giphy/models/pagination.dart';

class GiphyGif {
  GiphyGif({
    this.data,
    this.pagination,
    this.meta,
  });

  factory GiphyGif.fromJson(Map<String, dynamic> json) => GiphyGif(
        data: json["data"] == null
            ? []
            : List<GiphyData>.from((json["data"] as List<dynamic>)
                .map((x) => GiphyData.fromJson(x as Map<String, dynamic>)),),
        pagination: json["pagination"] == null
            ? null
            : Pagination.fromJson(json["pagination"] as Map<String, dynamic>),
        meta: json["meta"] == null
            ? null
            : Meta.fromJson(json["meta"] as Map<String, dynamic>),
      );

  final List<GiphyData>? data;
  final Pagination? pagination;
  final Meta? meta;

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? <GiphyData>[]
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "pagination": pagination?.toJson(),
        "meta": meta?.toJson(),
      };
}
