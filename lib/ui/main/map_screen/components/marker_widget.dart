import 'package:customer/core/model/vendor_model.dart';
import 'package:customer/ui/auth/login_screen/login_screen.dart';
import 'package:flutter/material.dart';

class MarkerWidget extends StatelessWidget {
  final VendorModel vendorModel;

  const MarkerWidget({Key? key, required this.vendorModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Icon(
          Icons.location_pin,
          color: vendorModel.active ? Colors.green : Colors.red,
          size: 48,
        ),
        Positioned(
          top: 0,
          right: 0,
          left: 0,
          child: Container(
            height: 32,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: vendorModel.active ? Colors.green : Colors.red,
            ),
            child: Text(
              vendorModel.name,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 10,
                color: Colors.white
              ),
            ),
          ),
        ),
      ],
    );
  }
}
