import 'package:customer/core/base/auth_base.dart';
import 'package:customer/core/model/customer_model.dart';
import 'package:customer/core/service/auth_service.dart';
import 'package:customer/locator.dart';
import 'package:flutter/material.dart';

enum AuthProcess {
  idle,
  busy,
}

class AuthView with ChangeNotifier implements AuthBase {
  AuthProcess _authProcess = AuthProcess.idle;
  AuthService authService = locator<AuthService>();
  Customer? customer;

  AuthProcess get authProcess => _authProcess;

  set authProcess(AuthProcess value) {
    _authProcess = value;
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
  Future<Customer?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      authProcess = AuthProcess.busy;
      customer = await authService.signInWithEmailAndPassword(email, password);
      debugPrint(
        "AuthView - signInWithEmailAndPassword : $customer",
      );
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
}
