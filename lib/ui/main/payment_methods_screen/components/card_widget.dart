import 'package:customer/core/model/payment/card_detail_model.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final CardDetail cardDetail;

  const CardWidget({Key? key, required this.cardDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const BeveledRectangleBorder(borderRadius: BorderRadius.zero),
      margin: EdgeInsets.zero,
      elevation: 2,
      child: ListTile(
        leading: Image.asset(cardDetail.cardAssociation == "MASTER_CARD"
            ? "assets/images/mastercard.png"
            : "assets/images/visacard.png",height: 32,),
        title: Text(cardDetail.cardAlias),
        subtitle: Text("${cardDetail.binNumber}****${cardDetail.lastFourDigits}"),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {

          },
        ),
      ),
    );
  }
}
