import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer/core/base/auth_base.dart';
import 'package:customer/core/model/customer_model.dart';
import 'package:customer/core/model/iyzico/pay_result_model.dart';
import 'package:customer/core/model/park_history_model.dart';
import 'package:customer/core/model/request_model.dart';
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
  Stream<QuerySnapshot> getParkHistories() {
    return firebaseFirestore
        .collection("customers/${firebaseAuth.currentUser!.uid}/history")
        .snapshots();
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

  @override
  Stream<QuerySnapshot>? listenRequest() {
    try {
      return firebaseFirestore
          .collection(
              "customers/${firebaseAuth.currentUser!.uid}/awaiting_approval")
          .snapshots();
    } on FirebaseException catch (e) {
      debugPrint(
        "AuthService - Exception - listenRequest : ${e.message}",
      );
      return null;
    }
  }

  @override
  Future<bool> replyRequest(RequestModel requestModel, bool reply) async {
    try {
      DocumentReference customerApproval = firebaseFirestore
          .collection("customers/${requestModel.uid}/awaiting_approval")
          .doc(requestModel.requestId);
      DocumentReference vendorApproval = firebaseFirestore
          .collection("vendors/${requestModel.vendorId}/awaiting_approval")
          .doc(requestModel.requestId);
      await customerApproval.delete();
      await vendorApproval.delete();
      RequestModel requestModelFinal = requestModel;
      requestModelFinal.responseTime = Timestamp.now();

      if (reply) {
        requestModelFinal.status = Status.processing;
        CollectionReference customerCollectionReference = firebaseFirestore
            .collection("customers/${requestModel.uid}/active_park");
        await customerCollectionReference
            .doc(requestModel.requestId)
            .set(requestModel.toJson());
        CollectionReference vendorCollectionReference = firebaseFirestore
            .collection("vendors/${requestModel.vendorId}/active_park");
        await vendorCollectionReference
            .doc(requestModel.requestId)
            .set(requestModel.toJson());
      } else {
        requestModelFinal.status = Status.canceled;
        CollectionReference customerCollectionReference = firebaseFirestore
            .collection("customers/${requestModel.uid}/history");
        await customerCollectionReference
            .doc(requestModel.requestId)
            .set(requestModel.toJsonForClosed());
        CollectionReference vendorCollectionReference = firebaseFirestore
            .collection("vendors/${requestModel.vendorId}/history");
        await vendorCollectionReference
            .doc(requestModel.requestId)
            .set(requestModel.toJsonForClosed());
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> pay(PayResult payResult, ParkHistory history) async {
    try {
      DocumentReference customer = firebaseFirestore
          .collection("customers/${history.uid}/history")
          .doc(history.requestId);
      await customer
          .update({"status": "completed", "paymentId": payResult.paymentId});
      return true;
    }  catch (e) {
      return false;
    }
  }
}
