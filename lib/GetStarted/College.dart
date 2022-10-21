import 'package:flutter/material.dart';
import 'package:interested/GetStarted/Passions.dart';
import 'package:interested/Usefull/Buttons.dart';
import 'package:interested/Usefull/Functions.dart';

import '../Usefull/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Map mainData = {};

class college extends StatefulWidget {
  Map data;
  college({Key? key,required this.data}) : super(key: key);

  @override
  State<college> createState() => _collegeState();
}

class _collegeState extends State<college> {
  bool isHide = false;
  final formKey = GlobalKey<FormState>();
  String name = "";

  List<Widget> citiesItems = [];
  List<dynamic> citiesNames = [];


  @override
  void initState() {
    getIns();
    mainData = widget.data;
  }

  getIns() async {
    setState((){
      isHide = true;
    });
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    QuerySnapshot querySnapshot =
    await firestore.collection('CCI').where("id", isEqualTo: widget.data['city'].toLowerCase()).get();

    final allData = querySnapshot.docs.map((e) => e.data()).toList();
    var b = allData[0] as Map<String, dynamic>;
    print(b['all']);
    setState(() {
      citiesNames = b['all'];
      for (var x in citiesNames) {
        var a = listItems(title: x,);
        setState(() {
          citiesItems.add(a);
          isHide = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: bgColor,
        body: SafeArea(
          child: Stack(
            children: [
              // circlesleft(context),
              dynamicCorners(context, Icons.school_outlined),
              SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 30.0,vertical: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 100.0,),

                    mainText("Select Your Institute", mainColor, 35.0, FontWeight.normal, 1),
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
                                    hintText: "Search",
                                    suffixIcon: Icon(Icons.school_outlined,color: mainColor,),
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

                                onChanged: (text) {
                                  String search = "";
                                  search = text;
                                  var a = citiesNames;
                                  citiesItems = [];
                                  for (var x in a) {
                                    if (x.toUpperCase().contains(text.toUpperCase())) {
                                      setState(() {
                                        var b = listItems(title: x);
                                        citiesItems.add(b);
                                      });
                                    }
                                  }
                                },
                              ),
                            ],
                          )
                      ),
                    ),
                    Container(
                      child: SingleChildScrollView(
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 2.0,
                          runSpacing: 2.0,
                          children: citiesItems,
                        ),
                      ),
                    ),




                    // SizedBox(height: 20.0,),
                  ],
                ),
              ),
              // Container(
              //   alignment: Alignment.bottomCenter,
              //   margin: EdgeInsets.only(bottom: 50.0),
              //   child: btnsss("NEXT", () { }, mainColor, Colors.white),
              // ),
              loaderss(isHide, context)
            ],
          ),
        ),
      ),
    );
  }
}

class listItems extends StatefulWidget {
  String title;
  listItems({Key? key,required this.title}) : super(key: key);

  @override
  State<listItems> createState() => _listItemsState();
}

class _listItemsState extends State<listItems> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
        child: mainText(
            widget.title, mainColor, 13.0, FontWeight.normal,1),
      ),
      style: ButtonStyle(
          foregroundColor:
          MaterialStateProperty.all<Color>(
              bgColor),
          backgroundColor:
          MaterialStateProperty.all<Color>(bgColor),
          shape: MaterialStateProperty.all<
              RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(15.0),
                  side: BorderSide(color: mainColor,width: 2.0)))),
      onPressed: (){
        mainData['college'] = widget.title;
        navScreen(passions(data: mainData) ,context, false);
      },
    );
  }
}