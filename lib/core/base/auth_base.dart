import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer/core/model/customer_model.dart';
import 'package:customer/core/model/iyzico/pay_result_model.dart';
import 'package:customer/core/model/park_history_model.dart';
import 'package:customer/core/model/request_model.dart';

abstract class AuthBase {
  Future<Customer?> getCurrentCustomer();
  Future<Object?> signInWithEmailAndPassword(String email,String password);
  Future<Object?> sendPasswordResetEmail(String email);
  Future<bool> pay(PayResult payResult, ParkHistory history);
  Future<Object?> createUserWithEmailAndPassword(String email,String password,String phone,String nameSurname);
  Future signOut();
  Stream<QuerySnapshot> getParkHistories();
  Stream<QuerySnapshot>? listenRequest();
  Future<bool> replyRequest(RequestModel requestModel, bool reply);
}
