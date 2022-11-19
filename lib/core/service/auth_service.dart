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
  Future<Object?> signInWithEmailAndPassword(
      String email, String password) async {
    try{
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return getCurrentCustomer();
    }on FirebaseAuthException catch (e) {
      return e.message;
    }

  }

  @override
  Future signOut() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<List<ParkHistory>?> getParkHistories() async {
    try {
      QuerySnapshot querySnapshot = await firebaseFirestore
          .collection("customers/${firebaseAuth.currentUser!.uid}/park_history")
          .get();
      List<ParkHistory> list = [];
      for (int i = 0; i < querySnapshot.size; i++) {
        Map<String, dynamic> history =
            querySnapshot.docs[i].data() as Map<String, dynamic>;
        list.add(ParkHistory.fromMap(history));
      }
      return list;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<Object?> createUserWithEmailAndPassword(
      String email, String password, String phone, String nameSurname) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      CollectionReference customers = firebaseFirestore.collection("customers");
      await customers.doc(firebaseAuth.currentUser!.uid).set({
        "cardUserKey": "",
        "email": email,
        "image_url": "",
        "name_surname": nameSurname,
        "phone": phone,
        "verified": false,
        "registered_date": Timestamp.now(),
      });
      return getCurrentCustomer();
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
    return null;
  }

  @override
  Future<Object?> sendPasswordResetEmail(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      return true;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
    return false;
  }
}
