import 'package:customer/core/model/park_history_model.dart';
import 'package:customer/ui/main/home_screen/components/calculator_widget.dart';
import 'package:customer/ui/main/qr_screen/timer_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ActivePark extends StatelessWidget {
  const ActivePark({Key? key, required this.parkHistory}) : super(key: key);
  final ParkHistory parkHistory;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Active Park",
            style: TextStyle(fontSize: 22, color: Colors.black54),
          ),
          Card(
            child: Container(
              width: double.maxFinite,
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    parkHistory.parkName,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Text(
                      "Start Time: ${DateFormat('dd-MM-yyyy – kk:mm').format(parkHistory.requestTime.toDate())}"),
                  CalculatorWidget(
                    parkHistory: parkHistory,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
