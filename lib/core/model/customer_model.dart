class Customer {
  final String uid;
  final String email;
  final String nameSurname;
  final String phone;
  String imageURL;
  double balance;
  bool verified;

  Customer({
    required this.phone,
    required this.uid,
    required this.email,
    required this.nameSurname,
    this.verified = false,
    this.balance = 0.0,
    this.imageURL = "", //TODO default image url add
  });

  @override
  String toString() {
    return 'Customer{uid: $uid, email: $email, nameSurname: $nameSurname, phone: $phone, imageURL: $imageURL, balance: $balance, verified: $verified}';
  }
}
