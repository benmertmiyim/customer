import 'package:customer/core/view/park_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ParkView parkView = Provider.of<ParkView>(context);

    if(parkView.parkProcess == ParkProcess.idle){
      if(parkView.parkHistories != null){
        return const Text("Data Var");
      }else{
        return const Text("Data yok");
      }
    }else{
      return const Center(child: CircularProgressIndicator(),);
    }

  }
}
