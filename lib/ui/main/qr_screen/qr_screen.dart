import 'package:customer/core/view/auth_view.dart';
import 'package:customer/ui/main/qr_screen/timer_widget.dart';
import 'package:customer/ui/main/request_screen/request_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRScreen extends StatelessWidget {
  const QRScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthView authView = Provider.of<AuthView>(context);

    if (authView.authProcess == AuthProcess.busy) {
      return const CircularProgressIndicator();
    } else {
      if (authView.approvalPark == null) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              QrImage(
                data: authView.customer!.uid,
                version: QrVersions.auto,
              ),
              Text(authView.customer!.uid),
              const SizedBox(
                height: 8,
              ),
              Text(
                authView.customer!.nameSurname,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 28),
              ),
              const SizedBox(
                height: 8,
              ),
              authView.activePark == null
                  ? Container()
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Active Park Details",
                          style: TextStyle(fontSize: 24),
                        ),
                        Text(
                          authView.activePark!.parkName,
                          style: const TextStyle(fontSize: 20),
                        ),
                        TimerWidget(
                          timestamp: authView.activePark!.requestTime,
                        ),
                      ],
                    ),
            ],
          ),
        );
      } else {
        return RequestScreen(parkHistory: authView.approvalPark!);
      }
    }
  }
}
