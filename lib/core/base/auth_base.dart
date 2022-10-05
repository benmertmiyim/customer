
import 'package:customer/core/model/customer_model.dart';

abstract class AuthBase {
  Future<Customer?> getCurrentCustomer();
}
