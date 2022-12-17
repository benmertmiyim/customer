import 'package:customer/core/model/park_history_model.dart';
import 'package:customer/core/view/auth_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class RequestScreen extends StatelessWidget {
  final ParkHistory parkHistory;

  const RequestScreen({Key? key, required this.parkHistory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthView authView = Provider.of<AuthView>(context);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            parkHistory.customerName,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          Text(
            "Park name: ${parkHistory.parkName}",
            style: const TextStyle(fontSize: 20),
          ),
          Text(
            "Start time: ${DateFormat('dd-MM-yyyy kk:mm').format((parkHistory.requestTime).toDate())}",
            style: const TextStyle(fontSize: 18),
          ),
          Text(
            "Start price: ${parkHistory.startPrice}₺",
            style: const TextStyle(fontSize: 18),
          ),
          Text(
            "Hourly price: ${parkHistory.hourlyPrice}₺",
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            width: double.maxFinite,
            child: ElevatedButton(
              onPressed: () {
                authView.replyRequest(parkHistory, true);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text("Accept"),
            ),
          ),
          SizedBox(
            width: double.maxFinite,
            child: ElevatedButton(
              onPressed: () {
                authView.replyRequest(parkHistory, false);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text("Rejection"),
            ),
          ),
        ],
      ),
    );
  }
}
