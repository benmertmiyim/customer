import 'package:customer/core/model/vendor_model.dart';
import 'package:customer/ui/auth/login_screen/login_screen.dart';
import 'package:flutter/material.dart';

class MarkerWidget extends StatelessWidget {
  final VendorModel vendorModel;
  const MarkerWidget({Key? key, required this.vendorModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.local_parking,
      color: vendorModel.active ? Colors.green : Colors.red,
      size: 48,
    );
  }
}
