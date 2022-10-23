import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer/const.dart';
import 'package:customer/core/base/card_base.dart';
import 'package:customer/core/model/customer_model.dart';
import 'package:customer/core/model/iyzico/add_card_model.dart';
import 'package:customer/core/model/iyzico/add_card_result_model.dart';
import 'package:customer/core/model/iyzico/error_model.dart';
import 'package:customer/core/model/iyzico/get_cards_result_model.dart';
import 'package:customer/core/service/auth_service.dart';
import 'package:customer/locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class CardService implements CardBase {
  AuthService authService = locator<AuthService>();

  @override
  Future<Object?> getCards() async {
    try {
      Customer? customer = await authService.getCurrentCustomer();
      if (customer != null) {
        var response = await http.post(
          Uri.parse("${functionsURL}getCards"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'cardUserKey': customer.cardUserKey,
          }),
        );
        var result = json.decode(response.body);
        if (result["status"] == "success") {
          GetCardsResultModel getCardsResultModel =
              GetCardsResultModel.fromJson(result);
          debugPrint(getCardsResultModel.toString());
          return getCardsResultModel;
        } else {
          ErrorModel error = ErrorModel.fromJson(result);
          debugPrint(error.toString());
          return error;
        }
      } else {
        return null;
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  @override
  Future<Object?> addCard(AddCardModel addCardModel) async {
    try {
      Customer? customer = await authService.getCurrentCustomer();
      if (customer != null) {
        var response = await http.post(
          Uri.parse("${functionsURL}regCard"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'cardUserKey': customer.cardUserKey,
            'email': customer.email,
            'cardAlias': addCardModel.cardAlias,
            'cardHolderName': addCardModel.cardHolderName,
            'cardNumber': addCardModel.cardNumber,
            'expireMonth': addCardModel.expireMonth,
            'expireYear': addCardModel.expireYear,
          }),
        );
        var result = json.decode(response.body);
        if (result["status"] == "success") {
          AddCardResult addCardResult = AddCardResult.fromJson(result);
          if (customer.cardUserKey == "") {
            CollectionReference collectionReference =
                FirebaseFirestore.instance.collection('customers');
            await collectionReference
                .doc(customer.uid)
                .update({"cardUserKey": addCardResult.cardUserKey});
          }
          return addCardResult;
        } else {
          ErrorModel error = ErrorModel.fromJson(result);
          debugPrint(error.toString());
          return error;
        }
      } else {
        return null;
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  @override
  Future<Object?> delCard(String cardToken,String cardUserKey) async {
    var response = await http.post(
      Uri.parse("${functionsURL}delCard"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'cardToken': cardToken,
        'cardUserKey': cardUserKey,
      }),
    );
    var result = json.decode(response.body);
    if (result["status"] == "success") {
      return true;
    } else {
      ErrorModel error = ErrorModel.fromJson(result);
      debugPrint(error.toString());
      return error;
    }
  }
}
