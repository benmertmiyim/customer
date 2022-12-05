import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer/core/model/request_model.dart';
import 'package:customer/core/view/auth_view.dart';
import 'package:customer/ui/components/went_wrong_widget.dart';
import 'package:customer/ui/main/notification_screen/notification_screen.dart';
import 'package:customer/ui/main/request_screen/request_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRScreen extends StatelessWidget {
  const QRScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthView authView = Provider.of<AuthView>(context);

    return StreamBuilder<QuerySnapshot>(
      stream: authView.listenRequest(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (snapshot.data!.size != 0) {
          Map<String, dynamic> map = snapshot.data!.docs[0].data() as Map<String, dynamic> ;
          RequestModel requestModel = RequestModel.fromMap(map);
          requestModel.requestId = snapshot.data!.docs[0].id;
          return RequestScreen(requestModel: requestModel);
        } else {
          if (authView.authProcess == AuthProcess.busy) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (authView.customer != null) {
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
                      height: 16,
                    ),
                    Text(
                      authView.customer!.nameSurname,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 28),
                    ),
                  ],
                ),
              );
            } else {
              return const WentWrongWidget();
            }
          }
        }
      },
    );
  }
}
