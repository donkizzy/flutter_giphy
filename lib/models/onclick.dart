class Onclick {
  Onclick({
    this.url,
  });

  factory Onclick.fromJson(Map<String, dynamic> json) => Onclick(
        url: json["url"] as String?,
      );
  final String? url;

  Map<String, dynamic> toJson() => {
        "url": url,
      };
}
