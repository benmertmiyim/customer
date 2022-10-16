import 'package:flutter/material.dart';

abstract class CardBase {
  Future<Object?> getCards(String cardUserKey);
}
