import 'dart:convert';

AddCardResult addCardResultFromJson(String str) => AddCardResult.fromJson(json.decode(str));

String addCardResultToJson(AddCardResult data) => json.encode(data.toJson());

class AddCardResult {
  AddCardResult({
    required this.status,
    required this.locale,
    required this.systemTime,
    required this.email,
    required this.cardUserKey,
    required this.cardToken,
    required this.cardAlias,
    required this.binNumber,
    required this.lastFourDigits,
    required this.cardType,
    required this.cardAssociation,
    required this.cardFamily,
    required this.cardBankCode,
    required this.cardBankName,
  });

  final String status;
  final String locale;
  final int systemTime;
  final String email;
  final String cardUserKey;
  final String cardToken;
  final String cardAlias;
  final String binNumber;
  final String lastFourDigits;
  final String cardType;
  final String cardAssociation;
  final String cardFamily;
  final int cardBankCode;
  final String cardBankName;

  factory AddCardResult.fromJson(Map<String, dynamic> json) => AddCardResult(
    status: json["status"],
    locale: json["locale"],
    systemTime: json["systemTime"],
    email: json["email"],
    cardUserKey: json["cardUserKey"],
    cardToken: json["cardToken"],
    cardAlias: json["cardAlias"],
    binNumber: json["binNumber"],
    lastFourDigits: json["lastFourDigits"],
    cardType: json["cardType"],
    cardAssociation: json["cardAssociation"],
    cardFamily: json["cardFamily"],
    cardBankCode: json["cardBankCode"],
    cardBankName: json["cardBankName"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "locale": locale,
    "systemTime": systemTime,
    "email": email,
    "cardUserKey": cardUserKey,
    "cardToken": cardToken,
    "cardAlias": cardAlias,
    "binNumber": binNumber,
    "lastFourDigits": lastFourDigits,
    "cardType": cardType,
    "cardAssociation": cardAssociation,
    "cardFamily": cardFamily,
    "cardBankCode": cardBankCode,
    "cardBankName": cardBankName,
  };

  @override
  String toString() {
    return 'AddCardResult{status: $status, locale: $locale, systemTime: $systemTime, email: $email, cardUserKey: $cardUserKey, cardToken: $cardToken, cardAlias: $cardAlias, binNumber: $binNumber, lastFourDigits: $lastFourDigits, cardType: $cardType, cardAssociation: $cardAssociation, cardFamily: $cardFamily, cardBankCode: $cardBankCode, cardBankName: $cardBankName}';
  }
}
