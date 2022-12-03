import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class VendorModel {
  final String vendorId;
  final String description;
  final String name;
  final double rating;
  final bool active;
  final double latitude;
  final double longitude;
  final List<String> imgList;

  VendorModel({
    required this.vendorId,
    required this.description,
    required this.name,
    required this.rating,
    required this.active,
    required this.latitude,
    required this.longitude,
    required this.imgList,
  });

  factory VendorModel.fromMap(Map<String, dynamic> map) {
    return VendorModel(
      vendorId: map['vendor_id'] as String,
      description: map['park_description'] as String,
      name: map['park_name'] as String,
      rating: map['rating'].toDouble(),
      active: map['active'] as bool,
      latitude: map['latitude'].toDouble(),
      longitude: map['longitude'].toDouble(),
      imgList: List.from(map['img_list']),
    );
  }
}
