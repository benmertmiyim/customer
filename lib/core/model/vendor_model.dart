import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class VendorModel {
  final String vendorId;
  final String description;
  final String name;
  final double rating;
  final bool active;
  final LatLng location;
  final List<String> imgList;

  VendorModel({
    required this.vendorId,
    required this.description,
    required this.name,
    required this.rating,
    required this.active,
    required this.location,
    required this.imgList,
  });

  factory VendorModel.fromMap(Map<String, dynamic> map) {
    GeoPoint geoPoint = map["location"] as GeoPoint;
    LatLng latLng = LatLng(geoPoint.latitude, geoPoint.longitude);
    return VendorModel(
      vendorId: map['vendor_id'] as String,
      description: map['park_description'] as String,
      name: map['park_name'] as String,
      rating: map['rating'].toDouble(),
      active: map['active'] as bool,
      location: latLng,
      imgList: List.from(map['img_list']),
    );
  }
}
