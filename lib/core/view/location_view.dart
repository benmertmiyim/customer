import 'package:customer/core/base/location_base.dart';
import 'package:customer/core/service/location_service.dart';
import 'package:customer/locator.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

enum LocationProcess {
  idle,
  busy,
}

class LocationView with ChangeNotifier implements LocationBase {
  LocationProcess _locationProcess = LocationProcess.idle;
  LocationService locationService = locator<LocationService>();
  Position? position;
  bool permission = false;

  LocationProcess get locationProcess => _locationProcess;

  set locationProcess(LocationProcess value) {
    _locationProcess = value;
    notifyListeners();
  }

  LocationView(){
    getLastCustomerLocation();
    getCurrentCustomerLocation();
  }

  @override
  Future<bool> checkPermission() async {
    try {
      locationProcess = LocationProcess.busy;
      permission = await locationService.checkPermission();
    } catch (e) {
      debugPrint(
        "LocationView - Exception - Check Permission : ${e.toString()}",
      );
    }finally{
      locationProcess = LocationProcess.idle;
    }
    return permission;
  }

  @override
  Future<Position?> getCurrentCustomerLocation() async {
    try {
      await checkPermission();
      position =  await locationService.getCurrentCustomerLocation();
      return position;
    } catch (e) {
      debugPrint(
        "LocationView - Exception - Get Current Customer Location : ${e.toString()}",
      );
    }
    return position;
  }

  @override
  Future<Position?> getLastCustomerLocation() async {
    try {
      position =  await locationService.getLastCustomerLocation();
      return position;
    } catch (e) {
      debugPrint(
        "LocationView - Exception - Get Last Customer Location : ${e.toString()}",
      );
    }
    return position;
  }

}