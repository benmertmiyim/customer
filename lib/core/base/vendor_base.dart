import 'package:customer/core/model/vendor_model.dart';

abstract class VendorBase {
  Future<List<VendorModel>?> getVendors();
}
