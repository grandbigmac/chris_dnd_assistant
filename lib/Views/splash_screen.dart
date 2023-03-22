import 'package:chris_dnd_assistant/Views/select_action.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:page_transition/page_transition.dart';

import '../Resources/widgets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

//Features an animation of a barbarian in the center
//Barbarian animation is sent to the next main page via hero animation after 2 seconds

class _SplashScreenState extends State<SplashScreen> {

  void waitBeforeOpening() async {
    await Future.delayed(const Duration(seconds: 2));
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const ChooseAttack();
    }));
  }

  @override
  void initState() {
    waitBeforeOpening();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    //Importing flutter/scheduler.dart and setting this value higher causes the
    //hero animation to play slower and hence be visible
    timeDilation = 4;

    return Scaffold(
        body: Center(
          child: heroWidget(),
        ),
    );
  }
}
