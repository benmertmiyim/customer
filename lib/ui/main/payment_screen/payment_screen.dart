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
              Text(authView.activePayment!.customerName),
              Text(authView.activePayment!.parkName),
              Text(
                  "Start Time: ${DateFormat('dd-MM-yyyy – kk:mm').format(authView.activePayment!.requestTime.toDate())}"),
              Text(
                  "Closed Time: ${DateFormat('dd-MM-yyyy – kk:mm').format(authView.activePayment!.closedTime.toDate())}"),
              Text("Start Price: ${authView.activePayment!.startPrice}"),
              Text("Hourly Price: ${authView.activePayment!.hourlyPrice}"),
              Text("Total Time: ${authView.activePayment!.totalTime}"),
              Text("Total Price: ${authView.activePayment!.totalPrice}"),
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
              cardView.cardProcess == CardProcess.idle ? ElevatedButton(
                onPressed: () async {
                  PayModel payModel = PayModel(
                      price: authView.activePayment!.totalPrice!,
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

                  if(res is PayResult){
                    bool result = await authView.pay(res, authView.activePayment!);
                    if(!result){
                      ScaffoldMessenger.of(context)
                          .showSnackBar(
                        SnackBar(
                          content: Text("Something Went Wrong"),
                        ),
                      );
                    }
                  }else if( res is ErrorModel) {
                    ErrorModel error = res as ErrorModel;
                    ScaffoldMessenger.of(context)
                        .showSnackBar(
                      SnackBar(
                        content: Text(error.errorMessage),
                      ),
                    );
                  }else{
                    ScaffoldMessenger.of(context)
                        .showSnackBar(
                      const SnackBar(
                        content: Text("Something Went Wrong"),
                      ),
                    );
                  }
                },
                child: const Text("Pay Now"),
              ): const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
