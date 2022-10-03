import 'package:customer/core/view/auth_view.dart';
import 'package:customer/ui/components/went_wrong_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRScreen extends StatelessWidget {
  const QRScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthView authView = Provider.of<AuthView>(context);

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
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
              ),
            ],
          ),
        );
      } else {
        return const WentWrongWidget();
      }
    }
  }
}
