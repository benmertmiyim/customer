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

            decoration: BoxDecoration(borderRadius: BorderRadius.circular(4),color: vendorModel.active ? Colors.green : Colors.red,),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "İzelman",
                  style: TextStyle(fontSize: 9),
                ),
                Text(
                  vendorModel.rating.toString(),
                  style: TextStyle(fontSize: 9),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
