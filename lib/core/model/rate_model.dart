import 'package:cloud_firestore/cloud_firestore.dart';

class RateModel {
  double security;
  double serviceQuality;
  double accessibility;
  String message;
  String customerId;
  String vendorId;
  String processId;
  Timestamp commentDate;

  RateModel(
      {required this.security,
      required this.serviceQuality,
      required this.accessibility,
      required this.customerId,
      required this.vendorId,
      required this.commentDate,
      required this.processId,
      required this.message});

  factory RateModel.fromJson(Map<String, dynamic> json) {
    return RateModel(
      security: double.parse(json["security"]),
      serviceQuality: double.parse(json["serviceQuality"]),
      accessibility: double.parse(json["accessibility"]),
      message: json["message"],
      customerId: json["customerId"],
      commentDate:  json["commentDate"] as Timestamp,
      vendorId: json["vendorId"],
      processId: json["processId"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "security": this.security,
      "serviceQuality": this.serviceQuality,
      "accessibility": this.accessibility,
      "message": this.message,
      "customerId": this.customerId,
      "commentDate": this.commentDate,
      "vendorId": this.vendorId,
      "processId": this.processId,
    };
  }

}
