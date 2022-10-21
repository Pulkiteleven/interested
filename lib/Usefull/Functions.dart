

import 'package:flutter/material.dart';

navScreen(Widget a,BuildContext context,bool replace){
  if(replace){
    Navigator.pushReplacement(context,MaterialPageRoute(builder:
        (context){
      return a;
    }));
  }
  else {
    Navigator.push(context, MaterialPageRoute(builder:
        (context) {
      return a;
    }));
  }
}