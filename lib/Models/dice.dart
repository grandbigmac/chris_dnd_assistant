import 'dart:math';

import 'package:flutter/cupertino.dart';

import '../Resources/widgets.dart';

class Dice {
  int sides;

  Dice ({
    required this.sides,
  });

  int rollDice() {
    var rand = Random();
    return rand.nextInt(sides + 1);
  }

  Widget showDice() {
    return tempDice(rollDice());
  }
}