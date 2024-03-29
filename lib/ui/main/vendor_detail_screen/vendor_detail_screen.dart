// ============================
// Filename.cpp
// Creator Name:
// Date of Creation:
// Purpose:
//
// --------------------------------------
// Modification Log
// 26 Jan 2004
//      Specify the changes have been made
// 4 Feb 2004
//      Specify the changes have been made
/*



 */
import 'package:customer/core/model/vendor_model.dart';
import 'package:customer/ui/main/vendor_detail_screen/components/vendor_slider.dart';
import 'package:flutter/material.dart';

class VendorDetailScreen extends StatelessWidget {
  final VendorModel vendorModel;

  const VendorDetailScreen({Key? key, required this.vendorModel})
      : super(key: key);












  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(vendorModel.name),),
      body: Column(
        children: [
          VendorSliderWidget(imgList: vendorModel.imgList),
        ],
      ),
    );
  }
}
