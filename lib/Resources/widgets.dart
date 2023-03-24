import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'colours.dart';

Widget heroWidget() {
  return const Hero(
      tag: 'heroimage',
      child: Icon(Icons.add, color: Colors.white, size: 200)
  );
}

Widget buttonTemplate(Widget widget) {
  return Padding(
    padding: const EdgeInsets.all(12.0),
    child: Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: containerColour,
      ),
      child: widget,
    ),
  );
}

Widget tempDice(int rollResult) {
  return Container(
    height: 50,
    width: 50,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      border: Border.all(color: Colors.black, width: 2),
    ),
    child: Center(
      child: Text(
        rollResult.toString(),
      ),
    ),
  );
}