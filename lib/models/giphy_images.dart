
import 'package:flutter_giphy/models/fixed_height.dart';

class GifImages {
  final FixedHeight? original;
  final FixedHeight? fixedHeight;
  final FixedHeight? fixedHeightDownsampled;
  final FixedHeight? fixedHeightSmall;
  final FixedHeight? fixedWidth;
  final FixedHeight? fixedWidthDownsampled;
  final FixedHeight? fixedWidthSmall;

  GifImages({
    this.original,
    this.fixedHeight,
    this.fixedHeightDownsampled,
    this.fixedHeightSmall,
    this.fixedWidth,
    this.fixedWidthDownsampled,
    this.fixedWidthSmall,
  });

  factory GifImages.fromJson(Map<String, dynamic> json) => GifImages(
    original: json["original"] == null ? null : FixedHeight.fromJson(json["original"]),
    fixedHeight: json["fixed_height"] == null ? null : FixedHeight.fromJson(json["fixed_height"]),
    fixedHeightDownsampled: json["fixed_height_downsampled"] == null ? null : FixedHeight.fromJson(json["fixed_height_downsampled"]),
    fixedHeightSmall: json["fixed_height_small"] == null ? null : FixedHeight.fromJson(json["fixed_height_small"]),
    fixedWidth: json["fixed_width"] == null ? null : FixedHeight.fromJson(json["fixed_width"]),
    fixedWidthDownsampled: json["fixed_width_downsampled"] == null ? null : FixedHeight.fromJson(json["fixed_width_downsampled"]),
    fixedWidthSmall: json["fixed_width_small"] == null ? null : FixedHeight.fromJson(json["fixed_width_small"]),
  );

  Map<String, dynamic> toJson() => {
    "original": original?.toJson(),
    "fixed_height": fixedHeight?.toJson(),
    "fixed_height_downsampled": fixedHeightDownsampled?.toJson(),
    "fixed_height_small": fixedHeightSmall?.toJson(),
    "fixed_width": fixedWidth?.toJson(),
    "fixed_width_downsampled": fixedWidthDownsampled?.toJson(),
    "fixed_width_small": fixedWidthSmall?.toJson(),
  };
}