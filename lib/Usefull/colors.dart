import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:fluttertoast/fluttertoast.dart';

String mainFont = 'mon';

Color bgColor = Color(0xFF150714);
Color bglight = Color(0xFF200B1E);
Color mainColor = Color(0xFFFE69A9);
Color mainlight = Color(0xFFFF2181);
Color secColor = Color(0xFF896186);

Color errorColor = Color(0xFFFFFFFF);

Color transparent_overlay = Color(0xFFFFFF);

AutoSizeText mainText(String text, Color c, double size, FontWeight w,int lines) {
  return AutoSizeText(
    text,
    textAlign: TextAlign.center,
    maxLines: lines,
    style: TextStyle(
      color: c,
      letterSpacing: 0.5,
      fontSize: size,
      fontFamily: mainFont,
      fontWeight: w,

    ),
  );
}

AutoSizeText mainTextLines(String text, Color c, double size, FontWeight w,int lines) {
  return AutoSizeText(
    text,
    textAlign: TextAlign.start,
    maxLines: lines,
    style: TextStyle(
      color: c,
      letterSpacing: 0.5,
      fontSize: size,
      fontFamily: mainFont,
      fontWeight: w,

    ),
  );
}


class loader extends StatelessWidget {
  const loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
      alignment: Alignment.bottomCenter,
      child: new Container(
        height: 110.0,
        width: MediaQuery.of(context).size.width * 0.90,
        child: new Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          color: mainColor,
          elevation: 7.0,
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                mainText("This may take a while...Please Wait", Colors.white, 15.0, FontWeight.normal, 1),
                SizedBox(height: 3.0,),
                CircularProgressIndicator(
                  backgroundColor: mainColor,
                  color: Colors.white,
                  strokeWidth: 3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


Widget loaderss(bool a,BuildContext context){
  return Visibility(
      visible: a,
      child: Stack(
        children: [
          Visibility(
            visible: a,
            child: new Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: new Card(
                color: transparent_overlay,
                elevation: 4.0,
              ),
            ),
          ),
          Visibility(visible: a, child: loader())
        ],
      ));
}

void snacker(String s, BuildContext c){
  ScaffoldMessenger.of(c).showSnackBar(SnackBar(
      elevation: 0,
      duration: Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      backgroundColor: mainlight,
      content:
      Text(s)));
}

toaster(String msg){
  Fluttertoast.showToast(msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      textColor: Colors.white,
      backgroundColor: mainColor);

}

dialogLoader(BuildContext context,) async{
  await showDialog(
    context: context,
    builder: (context) => new AlertDialog(
      backgroundColor: mainColor,
      alignment: Alignment.bottomCenter,
      content: CircularProgressIndicator(
        backgroundColor: Colors.white,
        color: bgColor,
        strokeWidth: 5,
      ),
    ),
  );
}

Widget circles(BuildContext context){
  return Stack(
    clipBehavior: Clip.hardEdge, children: [
      Container(
        // margin: EdgeInsets.only(),

        child:
        Transform.translate(
            offset: Offset(
              -70.0,
              -120.0,
            ),
            child: CircleAvatar(
              backgroundColor: bglight,
              radius: 130.0,
            ),
        ),
      ),
    Container(
      // margin: EdgeInsets.only(),

      child:
      Transform.translate(
        offset: Offset(
          MediaQuery.of(context).size.width - 200.0,
          MediaQuery.of(context).size.height - 200.0,
        ),
        child: CircleAvatar(
          backgroundColor: bglight,
          radius: 130.0,
        ),
      ),
    ),

  ],
  );
}

Widget circlesleft(BuildContext context){
  return Stack(
    clipBehavior: Clip.hardEdge, children: [
    Container(
      // margin: EdgeInsets.only(),

      child:
      Transform.translate(
        offset: Offset(
          MediaQuery.of(context).size.width - 200.0,
          -120.0,
        ),
        child: CircleAvatar(
          backgroundColor: bglight,
          radius: 130.0,
        ),
      ),
    ),
    Container(
      child:
      Transform.translate(
        offset: Offset(
          -70,
          MediaQuery.of(context).size.height - 200.0,
        ),
        child: CircleAvatar(
          backgroundColor: bglight,
          radius: 130.0,
        ),
      ),
    ),

  ],
  );
}


Widget bottomIn(){
  return Container(
    alignment: Alignment.bottomCenter,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        mainText("interested", mainColor, 15.0, FontWeight.normal, 1),
        mainText("be one", secColor, 10.0, FontWeight.normal, 1),
        SizedBox(height: 20.0,)
      ],
    ),
  );
}

Widget textr(BuildContext context,String text){
  return Stack(
    fit: StackFit.expand,
    clipBehavior: Clip.hardEdge, children: [
    Container(
      // margin: EdgeInsets.only(),
      child:
      Transform.translate(
        offset: Offset(
          10.0,
          -100.0,
        ),
        child: Transform.rotate(
          angle: 0.2,
          child: Wrap(
            children: [
              mainText(text, bglight, 100.0, FontWeight.normal, 1),
              mainText(text, bglight, 100.0, FontWeight.normal, 1),
              mainText(text, bglight, 100.0, FontWeight.normal, 1),
              mainText(text, bglight, 100.0, FontWeight.normal, 1),
              mainText(text, bglight, 100.0, FontWeight.normal, 1),
              mainText(text, bglight, 100.0, FontWeight.normal, 1),
              mainText(text, bglight, 100.0, FontWeight.normal, 1),
              mainText(text, bglight, 100.0, FontWeight.normal, 1),
              mainText(text, bglight, 100.0, FontWeight.normal, 1),
              mainText(text, bglight, 100.0, FontWeight.normal, 1),

            ],
          ),
        )
      ),
    ),

  ],
  );
}


