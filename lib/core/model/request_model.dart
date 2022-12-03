import 'package:cloud_firestore/cloud_firestore.dart';

enum Status{
  completed,
  canceled,
  approval,
  processing,
}

statusConvert(String status){
  switch(status){
    case "completed":
      return Status.completed;
    case "canceled":
      return Status.canceled;
    case "approval":
      return Status.approval;
    case "processing":
      return Status.processing;
  }
}
statusConvert2(Status status){
  switch(status){
    case Status.completed:
      return "completed";
    case Status.canceled:
      return "canceled";
    case Status.approval:
      return "approval";
    case Status.processing:
      return "processing";
  }
}

class RequestModel {
  final String vendorId;
  String? requestId;
  final String uid;
  final String customerName;
  final String customerImage;
  final String parkName;
  final double hourlyPrice;
  final double startPrice;
  final Timestamp requestTime;
  Timestamp? responseTime;
  Status status;

  RequestModel({
    required this.vendorId,
    required this.uid,
    required this.customerName,
    required this.customerImage,
    required this.parkName,
    required this.hourlyPrice,
    required this.startPrice,
    required this.requestTime,required this.status,
  });

  factory RequestModel.fromMap(Map<String, dynamic> map) {
    return RequestModel(
      vendorId: map['vendor_id'] as String,
      uid: map['uid'] as String,
      parkName: map['park_name'] as String,
      customerName: map['customer_name'] as String,
      customerImage: map['customer_image'] as String,
      hourlyPrice: map['hourly_price'].toDouble(),
      startPrice: map['start_price'].toDouble(),
      requestTime: map['request_time'] as Timestamp,
      status: statusConvert(map["status"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "vendorId": this.vendorId,
      "requestId": this.requestId,
      "uid": this.uid,
      "customerName": this.customerName,
      "customerImage": this.customerImage,
      "parkName": this.parkName,
      "hourlyPrice": this.hourlyPrice,
      "startPrice": this.startPrice,
      "requestTime": this.requestTime,
      "responseTime": this.responseTime,
      "status": statusConvert2(this.status),
    };
  }
  Map<String, dynamic> toJsonForClosed() {
    return {
      "vendorId": this.vendorId,
      "requestId": this.requestId,
      "uid": this.uid,
      "customerName": this.customerName,
      "customerImage": this.customerImage,
      "parkName": this.parkName,
      "hourlyPrice": this.hourlyPrice,
      "startPrice": this.startPrice,
      "requestTime": this.requestTime,
      "responseTime": this.responseTime,
      "closedTime": this.responseTime,
      "status": statusConvert2(Status.canceled),
    };
  }
}
