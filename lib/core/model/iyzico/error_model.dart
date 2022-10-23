import 'dart:convert';

ErrorModel errorModelFromJson(String str) => ErrorModel.fromJson(json.decode(str));

String errorModelToJson(ErrorModel data) => json.encode(data.toJson());

class ErrorModel {
  ErrorModel({
    required this.status,
    required this.errorCode,
    required this.errorMessage,
    required this.locale,
    required this.systemTime,
    required this.email,
    required this.cardUserKey,
  });

  final String status;
  final String errorCode;
  final String errorMessage;
  final String locale;
  final int systemTime;
  final String? email;
  final String? cardUserKey;

  factory ErrorModel.fromJson(Map<String, dynamic> json) => ErrorModel(
    status: json["status"],
    errorCode: json["errorCode"],
    errorMessage: json["errorMessage"],
    locale: json["locale"],
    systemTime: json["systemTime"],
    email: json["email"] ?? "",
    cardUserKey: json["cardUserKey"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "errorCode": errorCode,
    "errorMessage": errorMessage,
    "locale": locale,
    "systemTime": systemTime,
    "email": email,
    "cardUserKey": cardUserKey,
  };

  @override
  String toString() {
    return 'ErrorModel{status: $status, errorCode: $errorCode, errorMessage: $errorMessage, locale: $locale, systemTime: $systemTime, email: $email}';
  }
}
