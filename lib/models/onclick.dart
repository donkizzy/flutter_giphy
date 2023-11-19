

class Onclick {
  final String? url;

  Onclick({
    this.url,
  });

  factory Onclick.fromJson(Map<String, dynamic> json) => Onclick(
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
  };
}