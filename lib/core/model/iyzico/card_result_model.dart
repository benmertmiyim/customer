class CardResultModel {
  CardResultModel({
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

  final String cardToken;
  final String cardAlias;
  final String binNumber;
  final String lastFourDigits;
  final String cardType;
  final String cardAssociation;
  final String cardFamily;
  final int cardBankCode;
  final String cardBankName;

  factory CardResultModel.fromJson(Map<String, dynamic> json) => CardResultModel(
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
    return 'CardResultModel{cardToken: $cardToken, cardAlias: $cardAlias, binNumber: $binNumber, lastFourDigits: $lastFourDigits, cardType: $cardType, cardAssociation: $cardAssociation, cardFamily: $cardFamily, cardBankCode: $cardBankCode, cardBankName: $cardBankName}';
  }
}
