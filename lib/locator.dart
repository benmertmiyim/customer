import 'package:customer/core/service/auth_service.dart';
import 'package:customer/core/view/auth_view.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setUpLocator() {
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => AuthView());
}
