class FixedHeight {
  FixedHeight({
    this.height,
    this.width,
    this.size,
    this.url,
    this.mp4Size,
    this.mp4,
    this.webpSize,
    this.webp,
    this.frames,
    this.hash,
  });

  factory FixedHeight.fromJson(Map<String, dynamic> json) => FixedHeight(
        height: json['height'] as String?,
        width: json['width'] as String?,
        size: json['size'] as String?,
        url: json['url'] as String?,
        mp4Size: json['mp4_size'] as String?,
        mp4: json['mp4'] as String?,
        webpSize: json['webp_size'] as String?,
        webp: json['webp'] as String?,
        frames: json['frames'] as String?,
        hash: json['hash'] as String?,
      );
  final String? height;
  final String? width;
  final String? size;
  final String? url;
  final String? mp4Size;
  final String? mp4;
  final String? webpSize;
  final String? webp;
  final String? frames;
  final String? hash;

  Map<String, dynamic> toJson() => {
        'height': height,
        'width': width,
        'size': size,
        'url': url,
        'mp4_size': mp4Size,
        'mp4': mp4,
        'webp_size': webpSize,
        'webp': webp,
        'frames': frames,
        'hash': hash,
      };
}
