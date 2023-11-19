
class User {
  final String? avatarUrl;
  final String? bannerImage;
  final String? bannerUrl;
  final String? profileUrl;
  final String? username;
  final String? displayName;
  final String? description;
  final String? instagramUrl;
  final String? websiteUrl;
  final bool? isVerified;

  User({
    this.avatarUrl,
    this.bannerImage,
    this.bannerUrl,
    this.profileUrl,
    this.username,
    this.displayName,
    this.description,
    this.instagramUrl,
    this.websiteUrl,
    this.isVerified,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    avatarUrl: json["avatar_url"],
    bannerImage: json["banner_image"],
    bannerUrl: json["banner_url"],
    profileUrl: json["profile_url"],
    username: json["username"],
    displayName: json["display_name"],
    description: json["description"],
    instagramUrl: json["instagram_url"],
    websiteUrl: json["website_url"],
    isVerified: json["is_verified"],
  );

  Map<String, dynamic> toJson() => {
    "avatar_url": avatarUrl,
    "banner_image": bannerImage,
    "banner_url": bannerUrl,
    "profile_url": profileUrl,
    "username": username,
    "display_name": displayName,
    "description": description,
    "instagram_url": instagramUrl,
    "website_url": websiteUrl,
    "is_verified": isVerified,
  };
}