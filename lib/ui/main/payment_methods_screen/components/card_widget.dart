import 'package:customer/core/model/iyzico/card_result_model.dart';
import 'package:customer/core/view/card_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardWidget extends StatelessWidget {
  final CardResultModel cardResultModel;

  const CardWidget({Key? key, required this.cardResultModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CardView cardView = Provider.of<CardView>(context);
    return Card(
      shape: const BeveledRectangleBorder(borderRadius: BorderRadius.zero),
      margin: EdgeInsets.zero,
      elevation: 2,
      child: ListTile(
        leading: Image.asset(cardResultModel.cardAssociation == "MASTER_CARD"
            ? "assets/images/mastercard.png"
            : "assets/images/visacard.png",height: 32,),
        title: Text(cardResultModel.cardAlias),
        subtitle: Text("${cardResultModel.binNumber}****${cardResultModel.lastFourDigits}"),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            cardView.delCard(cardResultModel.cardToken, cardView.getCardsResultModel!.cardUserKey);
          },
        ),
      ),
    );
  }
}