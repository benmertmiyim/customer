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
    _authProcess = AuthProcess.busy;
    customer = await authService.getCurrentCustomer();
    authProcess = AuthProcess.idle;

    debugPrint(
      "AuthView - Current Customer : $customer",
    );

    return customer;
  }
}
