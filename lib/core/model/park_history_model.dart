import 'package:cloud_firestore/cloud_firestore.dart';

class ParkHistory {
  final String parkId;
  final Timestamp dateTime;
  final double parkPrice;
  final double parkTime;
  final Map<String, dynamic>? rate;

  ParkHistory({
    required this.parkId,
    required this.dateTime,
    required this.parkPrice,
    required this.parkTime,
    this.rate,
  });

  factory ParkHistory.fromMap(Map<String, dynamic> map) {
    return ParkHistory(
      parkId: map['park_id'] as String,
      dateTime: map['date'] as Timestamp,
      parkPrice: map['park_price'].toDouble(),
      parkTime: map['park_time'].toDouble(),
      rate: map['rate'] as Map<String,dynamic>,
    );
  }




}
