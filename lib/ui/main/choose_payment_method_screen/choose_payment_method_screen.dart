import 'package:customer/core/view/card_view.dart';
import 'package:customer/ui/main/add_credit_card/add_credit_card_screen.dart';
import 'package:customer/ui/main/payment_methods_screen/components/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChoosePaymentMethodsScreen extends StatelessWidget {
  const ChoosePaymentMethodsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        body: cardView.cardProcess == CardProcess.idle
            ? (cardView.getCardsResultModel?.cardDetails != null
                ? Column(
                    children: [
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount:
                              cardView.getCardsResultModel?.cardDetails?.length,
                          itemBuilder: (BuildContext context, int i) {
                            return InkWell(
                              onTap: () {
                                cardView.selectedCard = cardView
                                    .getCardsResultModel!.cardDetails![i];
                                Navigator.pop(context);
                              },
                              child: CardWidget(
                                  cardResultModel: cardView
                                      .getCardsResultModel!.cardDetails![i]),
                            );
                          }),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Image.asset(
                          "assets/images/iyzico_colored.png",
                          height: 48,
                        ),
                      ),
                    ],
                  )
                : const Center(
                    child: Text("You dont have registered card"),
                  ))
            : const Center(
                child: CircularProgressIndicator(),
              ));
  }
}
