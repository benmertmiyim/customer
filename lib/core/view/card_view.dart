import 'package:customer/core/base/card_base.dart';
import 'package:customer/core/model/payment/cards_model.dart';
import 'package:customer/core/model/payment/error_model.dart';
import 'package:customer/core/service/card_service.dart';
import 'package:customer/locator.dart';
import 'package:flutter/material.dart';

enum CardProcess {
  idle,
  busy,
}

class CardView with ChangeNotifier implements CardBase {
  CardProcess _cardProcess = CardProcess.idle;
  CardService cardService = locator<CardService>();
  Cards? cards;

  CardProcess get cardProcess => _cardProcess;

  set cardProcess(CardProcess value) {
    _cardProcess = value;
    notifyListeners();
  }

  @override
  Future<Object?> getCards(String cardUserKey) async {
    try {
      var result = await cardService.getCards(cardUserKey);
      if(result is Cards){
        cards = result;
        return cards;
      }else{
        return result as Error;
      }
    } catch (e) {
      debugPrint(
        "CardView - Exception - getCards : ${e.toString()}",
      );
      return null;
    }
  }

}