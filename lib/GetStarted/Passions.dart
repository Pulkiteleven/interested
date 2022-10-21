import 'package:flutter/material.dart';
import 'package:interested/GetStarted/College.dart';
import 'package:interested/Usefull/Buttons.dart';
import 'package:interested/Usefull/Functions.dart';

import '../Usefull/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

late _passionsState stateOfPassions;

class passions extends StatefulWidget {
  Map data;
  passions({Key? key,required this.data}) : super(key: key);

  @override
  State<passions> createState() {
    stateOfPassions = _passionsState();
    return stateOfPassions;
  }
}

class _passionsState extends State<passions> {
  bool isHide = false;
  final formKey = GlobalKey<FormState>();
  String name = "";

  List<Widget> citiesItems = [];
  List<Widget> selectedPassions = [];
  List<String> sPassions = [];
  List<dynamic> citiesNames = [];


  @override
  void initState() {
    getCities();
  }

  getCities() async {
    setState((){
      isHide = true;
    });
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    QuerySnapshot querySnapshot =
    await firestore.collection('CCI').where("id", isEqualTo: "passion").get();

    final allData = querySnapshot.docs.map((e) => e.data()).toList();
    var b = allData[0] as Map<String, dynamic>;
    print(b['all']);
    setState(() {
      citiesNames = b['all'];
      for (var x in citiesNames) {
        var a = listItems(title:x,);
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
              dynamicCorners(context, Icons.star_border_outlined),
              SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 30.0,vertical: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 50.0,),

                    mainText("Passions", mainColor, 35.0, FontWeight.normal, 1),
                    SizedBox(height: 20.0,),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: selectedPassions,
                      ),
                    ),
                    SizedBox(height: 20.0,),
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
  Color bgs = bgColor;
  Color two = mainColor;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
        child: mainText(
            widget.title, two, 13.0, FontWeight.normal,1),
      ),
      style: ButtonStyle(
          foregroundColor:
          MaterialStateProperty.all<Color>(
              bgs),
          backgroundColor:
          MaterialStateProperty.all<Color>(bgs),
          shape: MaterialStateProperty.all<
              RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(15.0),
                  side: BorderSide(color: two,width: 2.0)))),
      onPressed: (){
        setState((){
          if(bgs == bgColor){
            bgs = mainColor;
            two = Colors.white;
            stateOfPassions.setState((){
              stateOfPassions.sPassions.add(widget.title);
              stateOfPassions.selectedPassions = [];
              for(var x in stateOfPassions.sPassions){
                var a = newListItem(title: x);
                stateOfPassions.selectedPassions.add(a);
              }
            });
          }
          else{
            bgs = bgColor;
            two = mainColor;
            stateOfPassions.setState((){
              stateOfPassions.sPassions.remove(widget.title);
              stateOfPassions.selectedPassions = [];
              for(var x in stateOfPassions.sPassions){
                var a = newListItem(title: x);
                stateOfPassions.selectedPassions.add(a);
              }
            });
          }
        });
        // navScreen(college(data: {'city':widget.title,'name':widget.name}), context, false);
      },
    );
  }
}


class newListItem extends StatefulWidget {
  String title;
  newListItem({Key? key,required this.title}) : super(key: key);

  @override
  State<newListItem> createState() => _newListItemState();
}

class _newListItemState extends State<newListItem> {
  Color bgs = mainColor;
  Color two = Colors.white;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(1, 0, 1, 0),
        child: mainText(
            widget.title, two, 10.0, FontWeight.normal,1),
      ),
      style: ButtonStyle(
          foregroundColor:
          MaterialStateProperty.all<Color>(
              bgs),
          backgroundColor:
          MaterialStateProperty.all<Color>(bgs),
          shape: MaterialStateProperty.all<
              RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(15.0),
                  side: BorderSide(color: two,width: 1.0)))),
      onPressed: (){
        // navScreen(college(data: {'city':widget.title,'name':widget.name}), context, false);
      },
    );
  }
}
