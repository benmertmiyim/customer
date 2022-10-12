import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer/core/base/auth_base.dart';
import 'package:customer/core/model/customer_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService implements AuthBase {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<Customer?> getCurrentCustomer() async {
    try {
      firebaseAuth.signInWithEmailAndPassword(email: "benmertmiyim35@gmail.com", password: "159263.Mert");//TODO
      User? user = firebaseAuth.currentUser;

      if (user != null) {
        CollectionReference customer =
            firebaseFirestore.collection("customers");
        DocumentSnapshot documentSnapshot = await customer.doc(user.uid).get();

        if (documentSnapshot.exists) {
          Map map = documentSnapshot.data() as Map;
          return Customer(
            uid: user.uid,
            email: user.email!,
            phone: map["phone"],
            nameSurname: map["name_surname"],
            verified: map["verified"] as bool,
            balance: map["balance"].toDouble(),
            imageURL: map["image_url"],
          );
        }
      }
      return null;
    } catch (e) {
      debugPrint(
        "AuthService - Exception - Get Current Customer : ${e.toString()}",
      );
      return null;
    }
  }
}
