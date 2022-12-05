import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer/core/model/request_model.dart';

class ParkHistory {
  final Timestamp closedTime;
  final Timestamp requestTime;
  final Timestamp responseTime;
  final String vendorId;
  final String requestId;
  final String uid;
  final String customerName;
  final String customerImage;
  final String parkName;
  final double hourlyPrice;
  final double startPrice;
  final double? totalPrice;
  final double? totalTime;
  Status status;

  ParkHistory(
      {required this.closedTime,
      required this.requestTime,
      required this.responseTime,
      required this.vendorId,
      required this.requestId,
      required this.uid,
      required this.customerName,
      required this.customerImage,
      required this.parkName,
      required this.hourlyPrice,
      required this.startPrice,
      this.totalPrice,
      this.totalTime,
      required this.status});

  factory ParkHistory.fromJson(Map<String, dynamic> json) {
    try{
      return ParkHistory(
        closedTime: json["closedTime"] as Timestamp,
        requestTime: json["requestTime"] as Timestamp,
        responseTime: json["responseTime"] as Timestamp,
        vendorId: json["vendorId"],
        requestId: json["requestId"],
        uid: json["uid"],
        customerName: json["customerName"],
        customerImage: json["customerImage"],
        parkName: json["parkName"],
        hourlyPrice: json["hourlyPrice"].toDouble(),
        startPrice: json["startPrice"].toDouble(),
        totalPrice: json["totalPrice"].toDouble(),
        totalTime: json["totalTime"].toDouble(),
        status: statusConvert(json["status"]),
      );

    }catch(e){
      return ParkHistory(
        closedTime: json["closedTime"] as Timestamp,
        requestTime: json["requestTime"] as Timestamp,
        responseTime: json["responseTime"] as Timestamp,
        vendorId: json["vendorId"],
        requestId: json["requestId"],
        uid: json["uid"],
        customerName: json["customerName"],
        customerImage: json["customerImage"],
        parkName: json["parkName"],
        hourlyPrice: json["hourlyPrice"].toDouble(),
        startPrice: json["startPrice"].toDouble(),
        status: statusConvert(json["status"]),
      );

    }
  }
//

}
