import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer/core/base/banner_base.dart';
import 'package:customer/core/model/banner_model.dart';
import 'package:flutter/material.dart';

class BannerService implements BannerBase {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<List<BannerModel>?> getBanners() async {
    try {
      QuerySnapshot querySnapshot = await firebaseFirestore
          .collection("banners").where("active",isEqualTo: true).get();
      List<BannerModel> list = [];
      for (int i = 0; i < querySnapshot.size; i++) {
        Map<String,dynamic> bannerMap = querySnapshot.docs[i].data() as Map<String, dynamic>;
        list.add(BannerModel.fromMap(bannerMap));
      }
      return list;
    } catch (e) {
      debugPrint(
        "BannerService - Exception - Get Banners : ${e.toString()}",
      );
      return null;
    }

  }

}
