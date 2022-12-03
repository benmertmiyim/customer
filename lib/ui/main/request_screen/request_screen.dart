import 'package:customer/core/model/request_model.dart';
import 'package:customer/core/view/auth_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class RequestScreen extends StatelessWidget {
  final RequestModel requestModel;

  const RequestScreen({Key? key, required this.requestModel}) : super(key: key);

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
            requestModel.customerName,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          Text(
            "Park name: ${requestModel.parkName}",
            style: const TextStyle(fontSize: 20),
          ),
          Text(
            "Start time: ${DateFormat('dd-MM-yyyy kk:mm').format((requestModel.requestTime).toDate())}",
            style: const TextStyle(fontSize: 18),
          ),
          Text(
            "Start price: ${requestModel.startPrice}₺",
            style: const TextStyle(fontSize: 18),
          ),
          Text(
            "Hourly price: ${requestModel.hourlyPrice}₺",
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            width: double.maxFinite,
            child: ElevatedButton(
              onPressed: () {
                authView.replyRequest(requestModel, true);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text("Accept"),
            ),
          ),
          SizedBox(
            width: double.maxFinite,
            child: ElevatedButton(
              onPressed: () {
                authView.replyRequest(requestModel, false);
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
