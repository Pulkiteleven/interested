import 'package:flutter/material.dart';
import 'package:interested/GetStarted/City.dart';
import 'package:interested/Usefull/Buttons.dart';
import 'package:interested/Usefull/Functions.dart';

import '../Usefull/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';


class userName extends StatefulWidget {
  const userName({Key? key}) : super(key: key);

  @override
  State<userName> createState() => _userNameState();
}

class _userNameState extends State<userName> {
  bool isHide = false;
  final formKey = GlobalKey<FormState>();
  String name = "";
  late BuildContext mCtx;
  bool oneUser = false;

  @override
  Widget build(BuildContext context) {
    mCtx = context;

    return MaterialApp(
      home: Scaffold(
        backgroundColor: bgColor,
        body: SafeArea(
          child: Stack(
            children: [
              // circlesleft(context),
              dynamicCorners(context, Icons.account_circle_outlined),
              SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 30.0,vertical: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 100.0,),

                    mainText("Enter Username", mainColor, 35.0, FontWeight.normal, 1),
                    SizedBox(height: 80.0,),
                    Form(
                      key: formKey,
                      child: (
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextFormField(
                                maxLength: 18,
                                keyboardType:TextInputType.text,
                                cursorColor: mainColor,

                                style: TextStyle(
                                  fontFamily: 'mons',
                                  fontSize: 15.0,
                                  color: mainColor,
                                ),
                                decoration: InputDecoration(
                                    hintText: "username",
                                    suffixIcon: Icon(Icons.account_circle_outlined,color: mainColor,),
                                    hintStyle: TextStyle(
                                        fontFamily: 'mons',
                                        color:secColor
                                    ),
                                    labelStyle: TextStyle(
                                        fontFamily: 'mons',
                                        color:secColor
                                    ),
                                    errorStyle: TextStyle(
                                        fontFamily: 'mons',
                                        color: errorColor
                                    ),
                                    errorBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: errorColor
                                        )
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: mainColor
                                        )
                                    )
                                ),

                                onChanged: (text){
                                  name = text;
                                },
                                validator: (value){
                                  if(value!.isEmpty){
                                    return("Please Enter a Your Name");
                                  }
                                },
                              ),
                              Visibility(
                              visible: oneUser,
                                  child: mainText("Username already Exists", secColor, 13.0, FontWeight.normal, 1)),
                            ],
                          )
                      ),
                    ),



                    SizedBox(height: 20.0,),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.only(bottom: 50.0),
                child: btnsss("NEXT", () {
                  snacker("hello", context);
                  checkUsername();}, mainColor, Colors.white),
              ),
              loaderss(isHide, context)
            ],
          ),
        ),
      ),
    );
  }

  checkUsername() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isHide = true;
      });
      var ref = await FirebaseDatabase.instance.reference().child('allUsers');
      final index = await ref.child(name).once();


      if (index.snapshot.value != null) {
        setState(() {
          isHide = false;
          oneUser = true;
        });

      }
      else {
        setState(() {
          isHide = false;
          oneUser = false;
        });
        navScreen(city(data: {'name': name}), context, false);
      }
    }
  }

}
