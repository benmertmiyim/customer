import 'package:customer/const.dart';
import 'package:customer/core/model/iyzico/error_model.dart';
import 'package:customer/core/model/iyzico/pay_model.dart';
import 'package:customer/core/model/iyzico/pay_result_model.dart';
import 'package:customer/core/view/auth_view.dart';
import 'package:customer/core/view/card_view.dart';
import 'package:customer/ui/main/choose_payment_method_screen/choose_payment_method_screen.dart';
import 'package:customer/ui/main/payment_screen/components/payment_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthView authView = Provider.of<AuthView>(context);
    CardView cardView = Provider.of<CardView>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(title),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(authView.paymentPark!.customerName),
              Text(authView.paymentPark!.parkName),
              Text(
                  "Start Time: ${DateFormat('dd-MM-yyyy – kk:mm').format(authView.paymentPark!.requestTime.toDate())}"),
              Text(
                  "Closed Time: ${DateFormat('dd-MM-yyyy – kk:mm').format(authView.paymentPark!.closedTime!.toDate())}"),
              Text("Start Price: ${authView.paymentPark!.startPrice}"),
              Text("Hourly Price: ${authView.paymentPark!.hourlyPrice}"),
              Text("Total Time: ${authView.paymentPark!.totalTime}"),
              Text("Total Price: ${authView.paymentPark!.totalPrice}"),
              const Divider(),
              const Divider(),
              const Text(
                "PAYMENT METHOD",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              cardView.selectedCard != null
                  ? PaymentCardWidget(cardResultModel: cardView.selectedCard!)
                  : TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (c) =>
                                const ChoosePaymentMethodsScreen()));
                      },
                      child: const Text("Choose payment method"),
                    ),
              const SizedBox(
                height: 32,
              ),
              cardView.cardProcess == CardProcess.idle
                  ? ElevatedButton(
                      onPressed: () async {
                        if (cardView.selectedCard != null) {
                          PayModel payModel = PayModel(
                              price: authView.paymentPark!.totalPrice!,
                              cardUserKey: authView.customer!.cardUserKey,
                              cardToken: cardView.selectedCard!.cardToken,
                              uid: authView.customer!.uid,
                              name: authView.customer!.nameSurname,
                              surname: authView.customer!.nameSurname,
                              gsmNumber: authView.customer!.phone,
                              email: authView.customer!.email,
                              identityNumber: "11111111111",
                              address: "Adress",
                              ip: "85.34.78.112",
                              city: "Izmir",
                              country: "Turkey");
                          var res = await cardView.pay(payModel);

                          if (res is PayResult) {
                            bool result =
                                await authView.pay(res, authView.paymentPark!);
                            if (!result) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Something Went Wrong"),
                                ),
                              );
                            }
                          } else if (res is ErrorModel) {
                            ErrorModel error = res as ErrorModel;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(error.errorMessage),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Something Went Wrong"),
                              ),
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Choose payment method."),
                            ),
                          );
                        }
                      },
                      child: const Text("Pay Now"),
                    )
                  : const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
