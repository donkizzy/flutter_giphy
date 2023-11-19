import 'package:flutter_giphy/models/giphy_data.dart';
import 'package:flutter_giphy/models/giphy_meta.dart';
import 'package:flutter_giphy/models/pagination.dart';

class GiphyGif {
  final List<GiphyData>? data;
  final Pagination? pagination;
  final Meta? meta;

  GiphyGif({
    this.data,
    this.pagination,
    this.meta,
  });

  factory GiphyGif.fromJson(Map<String, dynamic> json) => GiphyGif(
    data: json["data"] == null ? [] : List<GiphyData>.from(json["data"]!.map((x) => GiphyData.fromJson(x))),
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
    meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "pagination": pagination?.toJson(),
    "meta": meta?.toJson(),
  };
}








