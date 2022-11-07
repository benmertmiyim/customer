import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer/core/base/vendor_base.dart';
import 'package:customer/core/model/vendor_model.dart';
import 'package:flutter/cupertino.dart';

class VendorService implements VendorBase {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<List<VendorModel>?> getVendors() async {
    try {
      QuerySnapshot querySnapshot = await firebaseFirestore
          .collection(
          "vendors")
          .get();
      List<VendorModel> list = [];
      for (int i = 0; i < querySnapshot.size; i++) {
        Map<String, dynamic> vendor =
        querySnapshot.docs[i].data() as Map<String, dynamic>;
        debugPrint(vendor.toString());
        list.add(VendorModel.fromMap(vendor));
      }
      return list;
    } catch (e) {
      debugPrint(
        "VendorService - Exception - Get Vendors : ${e.toString()}",
      );
      return null;
    }
  }
}
