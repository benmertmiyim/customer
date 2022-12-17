import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer/core/base/auth_base.dart';
import 'package:customer/core/model/customer_model.dart';
import 'package:customer/core/model/enums.dart';
import 'package:customer/core/model/iyzico/pay_result_model.dart';
import 'package:customer/core/model/park_history_model.dart';
import 'package:customer/core/model/rate_model.dart';
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
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return getCurrentCustomer();
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  @override
  Future signOut() async {
    await firebaseAuth.signOut();
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
  }

  @override
  Future<Object?> sendPasswordResetEmail(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      return true;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  @override
  Future<bool> replyRequest(ParkHistory parkHistory, bool reply) async {
    try {
      ParkHistory parkHistoryFinal = parkHistory;
      parkHistoryFinal.responseTime = Timestamp.now();
      if (reply) {
        parkHistoryFinal.status = Status.processing;
      } else {
        parkHistoryFinal.status = Status.canceled;
        parkHistoryFinal.closedTime = parkHistoryFinal.responseTime;
      }

      CollectionReference customerCollectionReference = firebaseFirestore
          .collection("customers/${parkHistoryFinal.uid}/history");
      await customerCollectionReference
          .doc(parkHistoryFinal.requestId)
          .update(parkHistoryFinal.toJson());
      CollectionReference vendorCollectionReference = firebaseFirestore
          .collection("vendors/${parkHistoryFinal.vendorId}/history");
      await vendorCollectionReference
          .doc(parkHistoryFinal.requestId)
          .update(parkHistoryFinal.toJson());
      return true;
    } catch (e) {
      debugPrint("hata" + e.toString());
      return false;
    }
  }

  @override
  Future<bool> pay(PayResult payResult, ParkHistory history) async {
    try {
      DocumentReference customer = firebaseFirestore
          .collection("customers/${history.uid}/history")
          .doc(history.requestId);
      await customer.update({
        "status": "completed",
        "paymentId": payResult.paymentId,
        "rated": false
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Stream<QuerySnapshot<Object?>> getParks() {
    return firebaseFirestore
        .collection("customers/${firebaseAuth.currentUser!.uid}/history").orderBy("requestTime",descending: true)
        .snapshots();
  }

  @override
  Future<bool> ratePark(ParkHistory parkHistory, RateModel rateModel)async {
    try{
      DocumentReference customerDocumentReference = firebaseFirestore
          .collection("customers/${parkHistory.uid}/history").doc(parkHistory.requestId);
      customerDocumentReference.update({"rated":true});
      CollectionReference vendorCollectionReference = firebaseFirestore
          .collection("vendors/${parkHistory.vendorId}/ratings");
      vendorCollectionReference.add(rateModel.toJson());
      return true;
    }catch(e){
      debugPrint(
        "AuthService - Exception - ratePark : ${e.toString()}",
      );
      return false;
    }
  }
}
