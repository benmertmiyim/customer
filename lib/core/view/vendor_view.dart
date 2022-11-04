import 'package:customer/core/base/vendor_base.dart';
import 'package:customer/core/model/vendor_model.dart';
import 'package:customer/core/service/vendor_service.dart';
import 'package:customer/locator.dart';
import 'package:flutter/material.dart';

enum VendorProcess {
  idle,
  busy,
}

class VendorView with ChangeNotifier implements VendorBase {
  VendorProcess _vendorProcess = VendorProcess.idle;
  VendorService vendorService = locator<VendorService>();
  List<VendorModel>? vendors;

  VendorProcess get vendorProcess => _vendorProcess;

  set vendorProcess(VendorProcess value) {
    _vendorProcess = value;
    notifyListeners();
  }

  VendorView() {
    getVendors();
  }

  @override
  Future<List<VendorModel>?> getVendors() async {
    try {
      vendorProcess = VendorProcess.busy;
      vendors = await vendorService.getVendors();
    } catch (e) {
      debugPrint(
        "VendorView - Exception - Get Vendors : ${e.toString()}",
      );
    } finally {
      vendorProcess = VendorProcess.idle;
    }
    return vendors;
  }
}