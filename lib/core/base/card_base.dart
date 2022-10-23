
import 'package:customer/core/model/iyzico/add_card_model.dart';

abstract class CardBase {
  Future<Object?> getCards();
  Future<Object?> addCard(AddCardModel addCardModel);
  Future<Object?> delCard(String cardToken, String cardUserKey);
}
