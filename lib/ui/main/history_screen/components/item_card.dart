import 'package:customer/ui/main/rate_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:customer/core/model/enums.dart';
import 'package:customer/core/model/park_history_model.dart';

class ItemCard extends StatelessWidget {
  final ParkHistory parkHistory;

  ItemCard({Key? key, required this.parkHistory}) : super(key: key);

  DateTime? closedTime;
  late DateTime requestTime;

  @override
  Widget build(BuildContext context) {
    closedTime = parkHistory.closedTime != null
        ? parkHistory.closedTime!.toDate()
        : null;
    requestTime = parkHistory.requestTime.toDate();

    return Card(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Park name: ${parkHistory.parkName}"),
                  Text(
                    "Status: ${statusConvert2(parkHistory.status)}",
                  ),
                  Text(
                    "Start date: ${DateFormat('dd-MM-yyyy – kk:mm').format(requestTime)}",
                  ),
                  closedTime != null
                      ? Text(
                          "Closed date: ${DateFormat('dd-MM-yyyy – kk:mm').format(closedTime!)}",
                        )
                      : Container(),
                  parkHistory.status == Status.completed
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Total Time: ${parkHistory.totalTime!.toInt()} min",
                            ),
                            Text(
                              "Total Price: ${parkHistory.totalPrice!.toStringAsFixed(2)} ₺",
                            ),
                          ],
                        )
                      : Container(),
                ],
              ),
            ),
            !parkHistory.rated
                ? Expanded(
                    flex: 1,
                    child: TextButton(
                      child: const Text(
                        "Rate Now"
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (c)=>RateScreen(parkHistory: parkHistory)));
                      },
                    ))
                : Container()
          ],
        ),
      ),
    );
  }
}
