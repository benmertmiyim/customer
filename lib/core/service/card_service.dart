import 'dart:convert';
import 'package:customer/core/base/card_base.dart';
import 'package:customer/core/model/payment/cards_model.dart';
import 'package:customer/core/model/payment/error_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../const.dart';

class CardService implements CardBase {
  @override
  Future<Object?> getCards(String cardUserKey) async {
    try {
      var response = await http.post(
        Uri.parse("${functionsURL}getCards"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'cardUserKey': cardUserKey,
        }),
      );
      var result = json.decode(response.body);
      if (result["status"] == "success") {
        return Cards.fromJson(result);
      } else {
        Error error = Error.fromJson(result);
        debugPrint(error.toString());
        return error;
      }
    } catch (e) {
      debugPrint(
        "CardService - Exception - getCards : ${e.toString()}",
      );
      return null;
    }
  }
}
