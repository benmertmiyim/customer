import 'dart:convert';

import 'package:customer/core/model/iyzico/card_result_model.dart';

GetCardsResultModel getCardsResultModelFromJson(String str) => GetCardsResultModel.fromJson(json.decode(str));

class GetCardsResultModel {
  GetCardsResultModel({
    required this.status ,
    required this.locale ,
    required this.systemTime,
    required this.cardUserKey,
     required this.cardDetails,
  });

  final String status;
  final String locale;
  final int systemTime;
  final String cardUserKey;
  final List<CardResultModel>? cardDetails;

  factory GetCardsResultModel.fromJson(Map<String, dynamic> json) => GetCardsResultModel(
    status: json["status"],
    locale: json["locale"],
    systemTime: json["systemTime"],
    cardUserKey: json["cardUserKey"],
    cardDetails: List<CardResultModel>.from(json["cardDetails"].map((x) => CardResultModel.fromJson(x))),
  );


  @override
  String toString() {
    return 'GetCardsResultModel{status: $status, locale: $locale, systemTime: $systemTime, cardUserKey: $cardUserKey, cardDetails: $cardDetails}';
  }
}

