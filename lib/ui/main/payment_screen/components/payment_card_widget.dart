import 'package:customer/core/model/iyzico/card_result_model.dart';
import 'package:customer/core/view/card_view.dart';
import 'package:customer/ui/main/choose_payment_method_screen/choose_payment_method_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentCardWidget extends StatelessWidget {
  final CardResultModel cardResultModel;

  const PaymentCardWidget({Key? key, required this.cardResultModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        trailing: TextButton(
          child: const Text("Change"),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (c) => const ChoosePaymentMethodsScreen()));
          },
        ),
      ),
    );
  }
}