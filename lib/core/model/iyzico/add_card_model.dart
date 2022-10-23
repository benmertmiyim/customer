class AddCardModel {
  AddCardModel({
    required this.cardAlias,
    required this.cardNumber,
    required this.expireMonth,
    required this.expireYear,
    required this.cardHolderName,
  });

  final String cardHolderName;
  final String cardAlias;
  final String expireYear;
  final String expireMonth;
  final String cardNumber;

  factory AddCardModel.fromJson(Map<String, dynamic> json) => AddCardModel(
    cardAlias: json["cardAlias"],
    cardNumber: json["cardNumber"],
    expireMonth: json["expireMonth"],
    expireYear: json["expireYear"],
    cardHolderName: json["cardHolderName"],
  );

  Map<String, dynamic> toJson() => {
    "cardHolderName": cardHolderName,
    "expireYear": expireYear,
    "expireMonth": expireMonth,
    "cardNumber": cardNumber,
    "cardAlias": cardAlias,
  };

  @override
  String toString() {
    return 'AddCardModel{cardHolderName: $cardHolderName, cardAlias: $cardAlias, expireYear: $expireYear, expireMonth: $expireMonth, cardNumber: $cardNumber}';
  }
}
