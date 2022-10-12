import 'package:customer/core/model/banner_model.dart';

abstract class BannerBase {
  Future<List<BannerModel>?> getBanners();
}
