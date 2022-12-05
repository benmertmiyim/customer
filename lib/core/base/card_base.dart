
import 'package:customer/core/model/iyzico/add_card_model.dart';
import 'package:customer/core/model/iyzico/pay_model.dart';

abstract class CardBase {
  Future<Object?> getCards();
  Future<Object?> pay(PayModel payModel);
  Future<Object?> addCard(AddCardModel addCardModel);
  Future<Object?> delCard(String cardToken, String cardUserKey);
}
