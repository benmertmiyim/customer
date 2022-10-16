class Customer {
  final String uid;
  final String email;
  final String nameSurname;
  final String phone;
  String cardUserKey;
  String imageURL;
  bool verified;

  Customer({
    required this.phone,
    required this.uid,
    required this.email,
    required this.nameSurname,
    this.verified = false,
    this.imageURL = "", //TODO default image url add
    this.cardUserKey = "",
  });

  @override
  String toString() {
    return 'Customer{uid: $uid, email: $email, nameSurname: $nameSurname, phone: $phone, imageURL: $imageURL, verified: $verified, cardUserKey: $cardUserKey}';
  }
}
