import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRScreen extends StatelessWidget {
  const QRScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String uid = "t7d72Cpo88bVK59YL4MM0xIY1cl1";
    const String nameSurname = "Mert Dönmez";

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          QrImage(
            data: uid,
            version: QrVersions.auto,
          ),
          const Text(uid),
          const SizedBox(
            height: 16,
          ),
          const Text(
            nameSurname,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
          ),
        ],
      ),
    );
  }
}
