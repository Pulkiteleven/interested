import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:interested/GetStarted/GetStarted.dart';
import 'package:interested/Usefull/Functions.dart';

import '../Mains/HomeScreen.dart';

checker(BuildContext context) async{
  User? user = await FirebaseAuth.instance.currentUser;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  QuerySnapshot querySnapshot = await firestore.collection('user')
      .where("uid",isEqualTo: user!.uid).get();

  if (querySnapshot != null){
    final allData = querySnapshot.docs.map((e) => e.data()).toList();
    if(allData.length != 0) {
      var b = allData[0] as Map<String, dynamic>;
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) =>
              homeScreen(data: b,)), (Route<dynamic> route) => false);
    }
    else{
      navScreen(getStarted(), context, true);
    }
  }

}
