import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer/core/base/auth_base.dart';
import 'package:customer/core/model/customer_model.dart';
import 'package:customer/core/model/iyzico/pay_result_model.dart';
import 'package:customer/core/model/park_history_model.dart';
import 'package:customer/core/model/rate_model.dart';
import 'package:customer/core/service/auth_service.dart';
import 'package:customer/locator.dart';
import 'package:flutter/material.dart';

enum AuthProcess {
  idle,
  busy,
}

enum AuthState {
  authorized,
  signIn,
  landing,
  intro,
  signUp,
  forgot,
}

class AuthView with ChangeNotifier implements AuthBase {
  AuthProcess _authProcess = AuthProcess.idle;
  AuthState _authState = AuthState.landing;
  AuthService authService = locator<AuthService>();
  Customer? customer;
  List<ParkHistory> parkHistory = [];
  List<ParkHistory> notRatedParkHistory = [];
  ParkHistory? activePark;
  ParkHistory? approvalPark;
  ParkHistory? paymentPark;
  StreamSubscription? parkListener;

  AuthProcess get authProcess => _authProcess;

  set authProcess(AuthProcess value) {
    _authProcess = value;
    notifyListeners();
  }

  AuthState get authState => _authState;

  set authState(AuthState value) {
    _authState = value;
    notifyListeners();
  }

  AuthView() {
    getCurrentCustomer();
  }

  @override
  Future<Customer?> getCurrentCustomer() async {
    try {
      authProcess = AuthProcess.busy;
      customer = await authService.getCurrentCustomer();
      if (customer != null) {
        authState = AuthState.authorized;
        getParks();
      } else {
        authState = AuthState.intro;
      }
      debugPrint(
        "AuthView - Current Customer : $customer",
      );
    } catch (e) {
      debugPrint(
        "AuthView - Exception - Get Current Customer : ${e.toString()}",
      );
    } finally {
      authProcess = AuthProcess.idle;
    }
    return customer;
  }

  @override
  Future<Object?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      authProcess = AuthProcess.busy;
      var res = await authService.signInWithEmailAndPassword(email, password);
      if (res is Customer) {
        customer = res;
        if (customer != null) {
          authState = AuthState.authorized;
          getParks();
        } else {
          authState = AuthState.signIn;
        }
        debugPrint(
          "AuthView - signInWithEmailAndPassword : $customer",
        );
      } else {
        return res;
      }
    } catch (e) {
      debugPrint(
        "AuthView - Exception - signInWithEmailAndPassword : ${e.toString()}",
      );
    } finally {
      authProcess = AuthProcess.idle;
    }
    return customer;
  }

  @override
  Future signOut() async {
    try {
      await authService.signOut();
      customer = null;
      parkListener!.cancel();
      debugPrint(
        "AuthView - signOut : $customer",
      );
    } catch (e) {
      debugPrint(
        "AuthView - Exception - signOut : ${e.toString()}",
      );
    }
    return customer;
  }

  @override
  Future<Object?> createUserWithEmailAndPassword(
      String email, String password, String phone, String nameSurname) async {
    try {
      authProcess = AuthProcess.busy;
      var result = await authService.createUserWithEmailAndPassword(
          email, password, phone, nameSurname);
      if (result is Customer) {
        customer = result;
        authState = AuthState.authorized;
        getParks();
      } else {
        return result;
      }
      debugPrint(
        "AuthView - createUserWithEmailAndPassword : $customer",
      );
      return null;
    } catch (e) {
      debugPrint(
        "AuthView - Exception - createUserWithEmailAndPassword : ${e.toString()}",
      );
      return null;
    } finally {
      authProcess = AuthProcess.idle;
    }
  }

  @override
  Future<Object?> sendPasswordResetEmail(String email) async {
    try {
      authProcess = AuthProcess.busy;
      var result = await authService.sendPasswordResetEmail(email);
      if (result is bool) {
        return true;
      } else {
        return result;
      }
    } catch (e) {
      debugPrint(
        "AuthView - Exception - createUserWithEmailAndPassword : ${e.toString()}",
      );
      return null;
    } finally {
      authProcess = AuthProcess.idle;
    }
  }

  @override
  Future<bool> replyRequest(ParkHistory parkHistory, bool reply) async {
    try {

      authProcess = AuthProcess.busy;
      return await authService.replyRequest(parkHistory, reply);
    } catch (e) {
      debugPrint(
        "AuthView - Exception - replyRequest : ${e.toString()}",
      );
      return false;
    } finally {
      authProcess = AuthProcess.idle;
    }
  }

  @override
  Future<bool> pay(PayResult payResult, ParkHistory history) async {
    try {
      authProcess = AuthProcess.busy;
      bool res = await authService.pay(payResult, history);
      if (res) {
        return true;
      }
      return false;
    } catch (e) {
      debugPrint(
        "AuthView - Exception - pay : ${e.toString()}",
      );
      return false;
    } finally {
      authProcess = AuthProcess.idle;
    }
  }


  @override
  Stream<QuerySnapshot<Object?>> getParks() {
    var querySnapshot = authService.getParks();
    debugPrint("Girdi Buraya");
    parkListener = querySnapshot.listen((event) {
      activePark = null;
      approvalPark = null;
      paymentPark = null;
      parkHistory = [];
      notRatedParkHistory = [];

      for (var doc in event.docs) {
        Map<String, dynamic> map = doc.data() as Map<String, dynamic>;
        ParkHistory park;
        if (map["status"] == "processing") {
          park = ParkHistory.fromJsonForProcessing(map);
          activePark = park;
        } else if (map["status"] == "payment") {
          park = ParkHistory.fromJsonForPay(map);
          paymentPark = park;
        } else if (map["status"] == "approval") {
          park = ParkHistory.fromJsonForRequest(map);
          approvalPark = park;
        } else if (map["status"] == "canceled") {
          park = ParkHistory.fromJsonForCanceled(map);
        } else {
          park = ParkHistory.fromJsonForHistory(map);
          if(!park.rated){
            notRatedParkHistory.add(park);
          }
        }
        parkHistory.add(park);

      }
      notifyListeners();

    });
    return querySnapshot;
  }

  @override
  Future<bool> ratePark(ParkHistory parkHistory, RateModel rateModel) async {
    try {
      authProcess = AuthProcess.busy;
      await authService.ratePark( parkHistory, rateModel);
      return true;
    } catch (e) {
      debugPrint(
        "AuthView - Exception - ratePark : ${e.toString()}",
      );
      return false;
    } finally {
      authProcess = AuthProcess.idle;
    }

  }
}
