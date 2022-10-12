class BannerModel {
  final String bannerId;
  final String bannerURL;

  BannerModel({
    required this.bannerId,
    required this.bannerURL,
  });

  factory BannerModel.fromMap(Map<String, dynamic> map) {
    return BannerModel(
      bannerId: map['banner_id'] as String,
      bannerURL: map['banner_url'] as String,
    );
  }
}
