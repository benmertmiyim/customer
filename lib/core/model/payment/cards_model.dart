import 'package:customer/core/model/payment/card_detail_model.dart';

class Cards {
  Cards({
    required this.status,
    required this.locale,
    required this.systemTime,
    required this.cardUserKey,
    required this.cardDetails,
  });

  final String status;
  final String locale;
  final int systemTime;
  final String cardUserKey;
  final List<CardDetail> cardDetails;

  factory Cards.fromJson(Map<String, dynamic> json) => Cards(
    status: json["status"],
    locale: json["locale"],
    systemTime: json["systemTime"],
    cardUserKey: json["cardUserKey"],
    cardDetails: List<CardDetail>.from(json["cardDetails"].map((x) => CardDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "locale": locale,
    "systemTime": systemTime,
    "cardUserKey": cardUserKey,
    "cardDetails": List<dynamic>.from(cardDetails.map((x) => x.toJson())),
  };

  factory Cards.fromMap(Map<String, dynamic> json) => Cards(
    status: json["status"],
    locale: json["locale"],
    systemTime: json["systemTime"],
    cardUserKey: json["cardUserKey"],
    cardDetails: List<CardDetail>.from(json["cardDetails"].map((x) => CardDetail.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "status": status,
    "locale": locale,
    "systemTime": systemTime,
    "cardUserKey": cardUserKey,
    "cardDetails": List<dynamic>.from(cardDetails.map((x) => x.toMap())),
  };

  @override
  String toString() {
    return 'Cards{status: $status, locale: $locale, systemTime: $systemTime, cardUserKey: $cardUserKey, cardDetails: $cardDetails}';
  }
}