import 'package:customer/core/view/auth_view.dart';
import 'package:customer/core/view/card_view.dart';
import 'package:customer/ui/components/went_wrong_widget.dart';
import 'package:customer/ui/main/add_credit_card/add_credit_card_screen.dart';
import 'package:customer/ui/main/payment_methods_screen/components/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/model/payment/cards_model.dart';
import '../../../core/model/payment/error_model.dart';

class PaymentMethodsScreen extends StatelessWidget {
  const PaymentMethodsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthView authView = Provider.of<AuthView>(context);
    CardView cardView = Provider.of<CardView>(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text("Payment Methods"),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddCreditCardScreen(),
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
        body: FutureBuilder(
          future: cardView.getCards(authView.customer!.cardUserKey),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data is Cards) {
                Cards cards = snapshot.data;
                return ListView.builder(
                    itemCount: cards.cardDetails.length,
                    itemBuilder: (BuildContext context, int i) {
                      return CardWidget(cardDetail: cards.cardDetails[i]);
                    });
              } else {
                Error error = snapshot.data;
                String message = error.errorCode == "3001" ? "You don't have a registered card": "${error.errorMessage}.\n Please contact to us";
                return Center(
                  child: Text(message,textAlign: TextAlign.center,),
                );
              }
            } else {
              if (snapshot.hasError) {
                return const WentWrongWidget();
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }
          },
        ));
  }
}
