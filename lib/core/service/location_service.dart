import 'package:customer/core/base/location_base.dart';
import 'package:geolocator/geolocator.dart';

class LocationService implements LocationBase {

  @override
  Future<Position?> getCurrentCustomerLocation() async {
    return await Geolocator.getCurrentPosition();
  }

  @override
  Future<bool> checkPermission() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied) {
        return false;
      }
      return true;
    }
    return true;
  }

  @override
  Future<Position?> getLastCustomerLocation() async {
    return await Geolocator.getLastKnownPosition();
  }
}