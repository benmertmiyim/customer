class CreditCard {
  final String cardID;
  final String cardName;
  final String cardNumber;
  String? month;
  String? year;
  String? cvv;

  CreditCard(
      {required this.cardID,
      required this.cardName,
      required this.cardNumber,
      this.month,
      this.year,
      this.cvv,});
}
