import 'package:flutter_giphy/models/onclick.dart';

/// [Analytics] holds the analytics [onload] url , [onclick] url ,
/// [onsent] url

class Analytics {
  /// [Analytics] Constructor
  Analytics({
    this.onload,
    this.onclick,
    this.onsent,
  });

  /// Analytics.toJson() factory constructor.
  factory Analytics.fromJson(Map<String, dynamic> json) => Analytics(
        onload: json['onload'] == null
            ? null
            : Onclick.fromJson(
                json['onload'] as Map<String, dynamic>,
              ),
        onclick: json['onclick'] == null
            ? null
            : Onclick.fromJson(
                json['onclick'] as Map<String, dynamic>,
              ),
        onsent: json['onsent'] == null
            ? null
            : Onclick.fromJson(
                json['onsent'] as Map<String, dynamic>,
              ),
      );

  /// onload
  final Onclick? onload;

  /// onload
  final Onclick? onclick;

  /// onload
  final Onclick? onsent;

  Map<String, dynamic> toJson() => {
        'onload': onload?.toJson(),
        'onclick': onclick?.toJson(),
        'onsent': onsent?.toJson(),
      };
}
