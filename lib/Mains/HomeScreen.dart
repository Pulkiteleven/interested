import 'package:flutter/material.dart';
import 'package:interested/Usefull/colors.dart';

class homeScreen extends StatefulWidget {
  Map data;
  homeScreen({Key? key,required this.data}) : super(key: key);

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: mainColor,
      ),
    );
  }
}
