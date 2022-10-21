import 'package:flutter/material.dart';
import 'package:interested/GetStarted/UserDetails.dart';
import 'package:interested/Usefull/Buttons.dart';
import 'package:interested/Usefull/Functions.dart';

import '../Usefull/colors.dart';


class getStarted extends StatefulWidget {
  const getStarted({Key? key}) : super(key: key);

  @override
  State<getStarted> createState() => _getStartedState();
}

class _getStartedState extends State<getStarted> {
  bool isHide = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: bgColor,
        body: SafeArea(
          child: Stack(
            children: [
              circles(context),
              Center(child: mainText("interested", mainColor, 30.0, FontWeight.normal, 1)),
              Container(
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.only(bottom: 50.0),
                child: bigBtnss("GET STARTED", () {navScreen(userName(), context, false); }, mainColor, Colors.white),
              ),
              loaderss(isHide, context)
            ],
          ),
        ),
      ),
    );
  }
}
