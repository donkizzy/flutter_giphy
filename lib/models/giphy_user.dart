class User {
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
        avatarUrl: json['avatar_url'] as String?,
        bannerImage: json['banner_image'] as String?,
        bannerUrl: json['banner_url'] as String?,
        profileUrl: json['profile_url'] as String?,
        username: json['username'] as String?,
        displayName: json['display_name'] as String?,
        description: json['description'] as String?,
        instagramUrl: json['instagram_url'] as String?,
        websiteUrl: json['website_url'] as String?,
        isVerified: json['is_verified'] as bool?,
      );
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

  Map<String, dynamic> toJson() => {
        'avatar_url': avatarUrl,
        'banner_image': bannerImage,
        'banner_url': bannerUrl,
        'profile_url': profileUrl,
        'username': username,
        'display_name': displayName,
        'description': description,
        'instagram_url': instagramUrl,
        'website_url': websiteUrl,
        'is_verified': isVerified,
      };
}
