import 'package:geolocator/geolocator.dart';

abstract class LocationBase {
  Future<Position?> getCurrentCustomerLocation();
  Future<Position?> getLastCustomerLocation();
  Future<bool> checkPermission();
}