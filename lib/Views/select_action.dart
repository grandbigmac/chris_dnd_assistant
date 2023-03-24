import 'dart:developer';
import 'dart:math' as m;
import 'package:chris_dnd_assistant/Models/weapon.dart';
import 'package:chris_dnd_assistant/Resources/colours.dart';
import 'package:chris_dnd_assistant/Resources/text_styles.dart';
import 'package:chris_dnd_assistant/Resources/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';

import '../Models/dice.dart';

class ChooseAttack extends StatefulWidget {
  const ChooseAttack({super.key,});

  @override
  State<ChooseAttack> createState() => _ChooseAttackState();
}

/// Page Functionality
///
/// This will be the main page for the application
/// Allows 2 primary functions:
///   - View table of recent dice rolls and results
///   - Select an action from a menu to perform
///       (eg. Attack, Reckless Attack, Attack with disadvantage etc...)
///
/// DICE ROLL VIEW
///   The dice roll view must display in a satisfying way the following:
///     - String defining what the roll is for and its conditions
///     - Individual dice roll results should be displayed in sequence
///       - Depending on dice type, show a silhouette of the dice with the result in the center
///         eg. He makes a Reckless weapon attack:
///           D20 attack dice A pops up with result in center, followed by D20 attack dice B,
///           the lower result dice animates back down while the taken result animates into position.
///
///           Weapon damage dice pops up on screen with result.
///
///           Final display is the attack description string at the top, with the attack roll dice
///           showing below on the left, and the damage roll dice showing below on the right
///
///   Modifiers menu appears below the dice roll view
///     - Lists out any modifiers that will affect the dice roll result
///       - Need to display:
///         - Advantage/ Disadvantage (could be shown as a dropdown menu with none as 3rd option)
///         - Rage (shown as a checkbox, which will add on rage damage if true)
///
///   Equipment loadout should display as a dropdown menu
///     - Check his character sheet for what weapons he owns
///       - Each weapon should be its own class defined in the library (to get damage dice etc)
///
///   Each type of combat action should be displayed aesthetically in a list without overflowing off the page
///     - Clicking an action triggers the dice roll view to display that dice roll
///
///   POTENTIALLY:
///     Potentially make a small skills/ saving throws roller for him too

class _ChooseAttackState extends State<ChooseAttack> with SingleTickerProviderStateMixin {
  //This set of variables could be moved into their own dart file eventually
  //List to hold the dice that should be rolled
  List<Widget> diceList = [];
  //List of weapons his character has
  List<Weapon> weaponList = [
    Weapon(weaponName: 'Battle Tax', damageDice: [8, 8], damageTypes: ['Slashing', 'Slashing']),
    Weapon(weaponName: 'Greataxe', damageDice: [8, 8], damageTypes: ['Slashing', 'Slashing']),
  ];
  //The list for the drop down weapon selector, list is populated at runtime
  List<DropdownMenuItem<Weapon>> weaponDropdownList = [];
  //Default selected weapon is first weapon in the dropdownmenuitem list
  late Weapon selectedWeapon;

  @override
  void initState() {
    weaponDropdownList = populateWeaponDropdown(weaponList);
    selectedWeapon = weaponList[0];
    super.initState();
  }

  Widget recentRollWindow() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
          width: double.infinity, height: MediaQuery.of(context).size.height * 0.25,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: diceList
          )
      ),
    );
  }

  Widget testDiceRoll() {
    return InkWell(
      onTap: () {
        setState(() {
          Dice dice = Dice(sides: 20);
          diceList.add(dice.showDice());
        });
      },
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text('Press Me', style: contentText),
        ),
      ),
    );
  }

  Widget makeWeaponAttack() {
    return InkWell(
      onTap: () {
        //Call attack method on weapon
        setState(() {
          diceList = selectedWeapon.attack(false, false, 0);
        });
      },
      child: buttonTemplate(
        const Center(
          child: Text(
            'Make Weapon Attack',
          ),
        ),
      ),
    );
  }

  Widget weaponSelectDropDown() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: DropdownButtonFormField<Weapon>(
        items: weaponDropdownList,
        value: selectedWeapon,
        onChanged: (value) {
          setState(() {
            selectedWeapon = value!;
          });
        },
        style: contentText,
        dropdownColor: bgColour,
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    //We reset the timeDilation back to default
    timeDilation = 1;


    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          shrinkWrap: true,
          children: [
            heroWidget(),
            recentRollWindow(),
            makeWeaponAttack(),
            weaponSelectDropDown()
          ],
        ),
      ),
    );
  }
}

List<DropdownMenuItem<Weapon>> populateWeaponDropdown(List<Weapon> list) {
  List<DropdownMenuItem<Weapon>> result = [];

  for (Weapon i in list) {
    result.add(DropdownMenuItem(value: i, child: Text(i.weaponName)));
  }

  return result;
}