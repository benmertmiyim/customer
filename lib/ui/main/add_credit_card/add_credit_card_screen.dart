import 'package:customer/core/model/iyzico/add_card_model.dart';
import 'package:customer/core/model/iyzico/add_card_result_model.dart';
import 'package:customer/core/model/iyzico/error_model.dart';
import 'package:customer/core/view/card_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:provider/provider.dart';

class AddCreditCardScreen extends StatefulWidget {
  const AddCreditCardScreen({Key? key}) : super(key: key);

  @override
  State<AddCreditCardScreen> createState() => _AddCreditCardScreenState();
}

class _AddCreditCardScreenState extends State<AddCreditCardScreen> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  OutlineInputBorder? border;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();


  @override
  void initState() {
    border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.withOpacity(0.7),
        width: 2.0,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CardView cardView = Provider.of<CardView>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Credit Card"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            CreditCardWidget(
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
              showBackView: isCvvFocused,
              obscureCardNumber: true,
              obscureCardCvv: true,
              isHolderNameVisible: true,
              isSwipeGestureEnabled: true,
              onCreditCardWidgetChange: (CreditCardBrand creditCardBrand) {},
              customCardTypeIcons: <CustomCardTypeIcon>[
                CustomCardTypeIcon(
                  cardType: CardType.mastercard,
                  cardImage: Image.asset(
                    'assets/images/mastercard.png',
                    height: 48,
                    width: 48,
                  ),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    CreditCardForm(
                      formKey: formKey,
                      obscureCvv: true,
                      obscureNumber: true,
                      cardNumber: cardNumber,
                      cvvCode: cvvCode,
                      isHolderNameVisible: true,
                      isCardNumberVisible: true,
                      isExpiryDateVisible: true,
                      cardHolderName: cardHolderName,
                      expiryDate: expiryDate,
                      themeColor: Colors.blue,
                      cardNumberDecoration: InputDecoration(
                        labelText: 'Number',
                        hintText: 'XXXX XXXX XXXX XXXX',
                        focusedBorder: border,
                        enabledBorder: border,
                      ),
                      expiryDateDecoration: InputDecoration(
                        focusedBorder: border,
                        enabledBorder: border,
                        labelText: 'Expired Date',
                        hintText: 'XX/XX',
                      ),
                      cvvCodeDecoration: InputDecoration(
                        focusedBorder: border,
                        enabledBorder: border,
                        labelText: 'CVV',
                        hintText: 'XXX',
                      ),
                      cardHolderDecoration: InputDecoration(
                        focusedBorder: border,
                        enabledBorder: border,
                        labelText: 'Card Holder',
                      ),
                      onCreditCardModelChange: onCreditCardModelChange,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    cardView.cardProcess != CardProcess.busy
                        ? ElevatedButton(
                            child: const Text(
                              'Validate',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            onPressed: () async {
                              //cardView.addCard(AddCardModel(cardAlias: "bişi", cardNumber: "5528790000000008", expireMonth: "12", expireYear: "2030", cardHolderName: "Mert Dönmez"));
                              if (formKey.currentState!.validate()) {
                                cardNumber = cardNumber.replaceAll(' ', '');
                                String expireMonth = expiryDate.split("/")[0];
                                String expireYear =
                                    '20${expiryDate.split("/")[1]}';
                                var result = await cardView.addCard(AddCardModel(
                                    cardAlias: "test",
                                    cardNumber: cardNumber,
                                    expireMonth: expireMonth,
                                    expireYear: expireYear,
                                    cardHolderName: cardHolderName));
                                if(result is AddCardResult) {
                                  Navigator.of(context).pop();
                                } else if (result is ErrorModel){
                                  ErrorModel error = result;
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.errorMessage)));
                                }else{
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Something went wrong")));
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("invalid")));
                              }
                            },
                          )
                        : const Center(child: CircularProgressIndicator()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
