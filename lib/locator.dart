import 'package:customer/core/service/auth_service.dart';
import 'package:customer/core/service/banner_service.dart';
import 'package:customer/core/service/card_service.dart';
import 'package:customer/core/service/location_service.dart';
import 'package:customer/core/service/notification_service.dart';
import 'package:customer/core/service/vendor_service.dart';
import 'package:customer/core/view/auth_view.dart';
import 'package:customer/core/view/banner_view.dart';
import 'package:customer/core/view/card_view.dart';
import 'package:customer/core/view/location_view.dart';
import 'package:customer/core/view/notification_view.dart';
import 'package:customer/core/view/vendor_view.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setUpLocator() {
  locator.registerLazySingleton(() => BannerService());
  locator.registerLazySingleton(() => BannerView());
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => AuthView());
  locator.registerLazySingleton(() => LocationService());
  locator.registerLazySingleton(() => LocationView());
  locator.registerLazySingleton(() => NotificationService());
  locator.registerLazySingleton(() => NotificationView());
  locator.registerLazySingleton(() => CardService());
  locator.registerLazySingleton(() => CardView());
  locator.registerLazySingleton(() => VendorService());
  locator.registerLazySingleton(() => VendorView());
}
