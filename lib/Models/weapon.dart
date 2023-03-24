import 'dart:developer';

import 'package:chris_dnd_assistant/Resources/text_styles.dart';
import 'package:flutter/cupertino.dart';

import '../Resources/widgets.dart';
import 'Dice.dart';

class Weapon {
  String weaponName;
  List<int> damageDice;
  List<String> damageTypes;
  //List<Dice> diceList;

  Weapon({
    required this.weaponName,
    required this.damageDice,
    required this.damageTypes,
    //required this.diceList,
  });

  List<Widget> attack(bool raging, bool? advantage, int modifier) {
    List<Widget> diceList = [];
    //damageDice[i] needs to be used to create a dice and then roll it

    for (int i = 0; i < damageDice.length; i++) {
      diceList.add(
        Column(
          children: [
            tempDice(damageDice[i]),
            Text(
              damageTypes[i],
              style: contentText,
            )
          ],
        )
      );
    }

    return diceList;
  }
}