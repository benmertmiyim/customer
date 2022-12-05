import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer/core/base/auth_base.dart';
import 'package:customer/core/model/customer_model.dart';
import 'package:customer/core/model/iyzico/pay_result_model.dart';
import 'package:customer/core/model/park_history_model.dart';
import 'package:customer/core/model/request_model.dart';
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
  List<ParkHistory> parkHistories = [];
  ParkHistory? _activePayment;

  ParkHistory? get activePayment => _activePayment;

  set activePayment(ParkHistory? value) {
    _activePayment = value;
    notifyListeners();
  }

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
    getParkHistories();
  }

  @override
  Stream<QuerySnapshot> getParkHistories() {
    var querySnapshot = authService.getParkHistories();
    querySnapshot.forEach((element) {
      List<QueryDocumentSnapshot> queryDocumentSnapshot = element.docs;
      queryDocumentSnapshot.forEach((element) {
        Map<String, dynamic> history = element.data() as Map<String, dynamic>;
        ParkHistory parkHistory = ParkHistory.fromJson(history);
        parkHistories.add(parkHistory);
        if (parkHistory.status == Status.payment) {
          activePayment = parkHistory;
        }
      });
    });
    return querySnapshot;
  }

  @override
  Future<Customer?> getCurrentCustomer() async {
    try {
      authProcess = AuthProcess.busy;
      customer = await authService.getCurrentCustomer();
      await Future.delayed(const Duration(seconds: 2)); //TODO
      if (customer != null) {
        authState = AuthState.authorized;
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
      authProcess = AuthProcess.busy;
      await authService.signOut();
      customer = null;
      authState = AuthState.intro;
      debugPrint(
        "AuthView - signOut : $customer",
      );
    } catch (e) {
      debugPrint(
        "AuthView - Exception - signOut : ${e.toString()}",
      );
    } finally {
      authProcess = AuthProcess.idle;
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
  Stream<QuerySnapshot>? listenRequest() {
    return authService.listenRequest();
  }

  @override
  Future<bool> replyRequest(RequestModel requestModel, bool reply) async {
    try {
      authProcess = AuthProcess.busy;
      return await authService.replyRequest(requestModel, reply);
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
        activePayment = null;
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
}
