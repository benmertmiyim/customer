import 'package:customer/core/base/auth_base.dart';
import 'package:flutter/material.dart';

enum AuthProcess {
  idle,
  busy,
}

class AuthView with ChangeNotifier implements AuthBase {}
