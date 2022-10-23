import 'package:customer/core/base/card_base.dart';
import 'package:customer/core/model/iyzico/add_card_model.dart';
import 'package:customer/core/model/iyzico/add_card_result_model.dart';
import 'package:customer/core/model/iyzico/error_model.dart';
import 'package:customer/core/model/iyzico/get_cards_result_model.dart';
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
  GetCardsResultModel? getCardsResultModel;
  String? cardUserKey;

  CardProcess get cardProcess => _cardProcess;

  set cardProcess(CardProcess value) {
    _cardProcess = value;
    notifyListeners();
  }

  CardView(){
    getCards();

  }

  @override
  Future<Object?> getCards() async {
    try {
      cardProcess = CardProcess.busy;
      var result = await cardService.getCards();
      if(result is GetCardsResultModel){
        getCardsResultModel = result;
        return getCardsResultModel;
      }else{
        return result as ErrorModel;
      }
    } catch (e) {
      debugPrint(
        "CardView - Exception - getCards : ${e.toString()}",
      );
      return null;
    }
    finally{
      cardProcess = CardProcess.idle;
    }
  }

  @override
  Future<Object?> addCard(AddCardModel addCardModel) async {
    try {
      cardProcess = CardProcess.busy;
      var result = await cardService.addCard(addCardModel);
      if(result is AddCardResult){
        getCards();
        return result;
      }else{
        return result as ErrorModel;
      }
    } catch (e) {
      debugPrint(
        "CardView - Exception - addCard : ${e.toString()}",
      );
      return null;
    }finally{
      cardProcess = CardProcess.idle;
    }
  }

  @override
  Future<Object?> delCard(String cardToken, String cardUserKey) async {
    try {
      cardProcess = CardProcess.busy;
      var result = await cardService.delCard(cardToken,cardUserKey);
      if(result is bool){
        getCardsResultModel?.cardDetails?.removeWhere((item) => item.cardToken == cardToken);
        return result;
      }else{
        return result as ErrorModel;
      }
    } catch (e) {
      debugPrint(
        "CardView - Exception - delCard : ${e.toString()}",
      );
      return null;
    }finally{
      cardProcess = CardProcess.idle;
    }
  }

}