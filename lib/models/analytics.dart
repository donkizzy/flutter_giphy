
import 'package:flutter_giphy/models/onclick.dart';

class Analytics {
  final Onclick? onload;
  final Onclick? onclick;
  final Onclick? onsent;

  Analytics({
    this.onload,
    this.onclick,
    this.onsent,
  });

  factory Analytics.fromJson(Map<String, dynamic> json) => Analytics(
    onload: json["onload"] == null ? null : Onclick.fromJson(json["onload"]),
    onclick: json["onclick"] == null ? null : Onclick.fromJson(json["onclick"]),
    onsent: json["onsent"] == null ? null : Onclick.fromJson(json["onsent"]),
  );

  Map<String, dynamic> toJson() => {
    "onload": onload?.toJson(),
    "onclick": onclick?.toJson(),
    "onsent": onsent?.toJson(),
  };
}