import 'package:customer/core/base/auth_base.dart';
import 'package:customer/core/model/customer_model.dart';
import 'package:flutter/material.dart';

enum AuthProcess {
  idle,
  busy,
}

class AuthView with ChangeNotifier implements AuthBase {
  Customer? customer = Customer(uid: "t7d72Cpo88bVK59YL4MM0xIY1cl1", email: "benmertmiyim35", nameSurname: "Mert Dönmez");
}
