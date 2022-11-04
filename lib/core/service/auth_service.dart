import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer/core/base/auth_base.dart';
import 'package:customer/core/model/customer_model.dart';
import 'package:customer/core/model/park_history_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService implements AuthBase {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<Customer?> getCurrentCustomer() async {
    try {

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
            imageURL: map["image_url"],
            cardUserKey: map["cardUserKey"] ?? "",
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

  @override
  Future<Customer?> signInWithEmailAndPassword(String email, String password) async {
    await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    return getCurrentCustomer();
  }

  @override
  Future signOut() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<List<ParkHistory>?> getParkHistories() async {
    try{
      QuerySnapshot querySnapshot = await firebaseFirestore
          .collection("customers/${firebaseAuth.currentUser!.uid}/park_history").get();
      List<ParkHistory> list = [];
      for (int i = 0; i < querySnapshot.size; i++) {
        Map<String,dynamic> history = querySnapshot.docs[i].data() as Map<String, dynamic>;
        list.add(ParkHistory.fromMap(history));
      }
      return list;
    }catch(e){
      return null;
    }
  }
}
