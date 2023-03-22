import 'dart:developer';
import 'dart:math' as m;
import 'package:chris_dnd_assistant/Resources/text_styles.dart';
import 'package:chris_dnd_assistant/Resources/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';

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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    //We reset the timeDilation back to default
    timeDilation = 1;

    Widget recentRollWindow() {
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          width: double.infinity, height: MediaQuery.of(context).size.height * 0.3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Center(
            child: Text('Box'),
          ),
        ),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          shrinkWrap: true,
          children: [
            heroWidget(),
            recentRollWindow(),
          ],
        ),
      ),
    );
  }
}