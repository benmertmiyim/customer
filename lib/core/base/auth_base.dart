import 'package:customer/core/model/customer_model.dart';

abstract class AuthBase {
  Future<Customer?> getCurrentCustomer();
  Future<Customer?> signInWithEmailAndPassword(String email,String password);
  Future signOut();
}
