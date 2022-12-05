class PayModel {
  final double price;
  final String cardUserKey;
  final String cardToken;
  final String uid;
  final String name;
  final String surname;
  final String gsmNumber;
  final String email;
  final String identityNumber;
  final String address;
  final String ip;
  final String city;
  final String country;

  PayModel(
      {required this.price,
      required this.cardUserKey,
      required this.cardToken,
      required this.uid,
      required this.name,
      required this.surname,
      required this.gsmNumber,
      required this.email,
      required this.identityNumber,
      required this.address,
      required this.ip,
      required this.city,
      required this.country});

  Map<String, String> toJson() {
    return {
      "price": this.price.toString(),
      "cardUserKey": this.cardUserKey,
      "cardToken": this.cardToken,
      "uid": this.uid,
      "name": this.name,
      "surname": this.surname,
      "gsmNumber": this.gsmNumber,
      "email": this.email,
      "identityNumber": this.identityNumber,
      "address": this.address,
      "ip": this.ip,
      "city": this.city,
      "country": this.country,
    };
  }


}
