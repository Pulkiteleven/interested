
import 'package:flutter/material.dart';
import 'package:interested/Usefull/Buttons.dart';
import 'package:interested/Usefull/colors.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Backend/backend.dart';



class enterOTP extends StatefulWidget {
  String number;
  String vID;
  enterOTP({Key? key,required this.number,required this.vID}) : super(key: key);

  @override
  State<enterOTP> createState() => _enterOTPState();
}

class _enterOTPState extends State<enterOTP> {
  final formKey = GlobalKey<FormState>();
  String OTP = "";
  bool isHide = false;
  FirebaseAuth _auth = FirebaseAuth.instance;
  late BuildContext mCtx;


  @override
  Widget build(BuildContext context) {
    mCtx = context;
    return MaterialApp(
      home: Scaffold(
        backgroundColor: bgColor,
        body: SafeArea(
          child: Stack(
            children: [

              circlesleft(context),

              SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 30.0,vertical: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 100.0,),
                    Row(
                      children: [
                        mainText("Enter OTP", mainColor, 35.0, FontWeight.normal, 1),
                        Spacer()
                      ],
                    ),
                    Row(
                      children: [
                        mainText("we have send OTP on your number", secColor, 13.0, FontWeight.normal, 1),
                        Spacer(),
                      ],
                    ),

                    SizedBox(height: 80.0,),
                    Form(
                      key: formKey,
                      child: (
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              OtpTextField(
                                numberOfFields: 6,
                                borderColor: mainColor,
                                cursorColor: mainColor,
                                enabledBorderColor: mainColor,
                                disabledBorderColor: mainColor,
                                borderRadius: BorderRadius.circular(5.0),
                                showFieldAsBox: false,
                                textStyle: TextStyle(
                                    color: mainColor
                                ),
                                onSubmit: (String value){
                                  OTP = value;
                                },


                              ),
                            ],
                          )
                      ),
                    ),



                    SizedBox(height: 20.0,),
                    btnsss("VERIFY", () { LoginwithOTP();}, mainColor, Colors.white),


                  ],
                ),
              ),
              // loaderss(isHide, context)
              bottomIn(),
              loaderss(isHide, context)
            ],
          ),
        ),
      ),
    );
  }

  Future LoginwithOTP() async {
    setState((){
      isHide = true;
    });
    var _cred = PhoneAuthProvider.credential(
        verificationId: widget.vID,
        smsCode: OTP);
    _auth.signInWithCredential(_cred).then((value) => {
      setState((){
        isHide = false;
      }),
      checker(context),
      print("ho gya")
    }).catchError((e){
      snacker("Something Went Wrong", mCtx);
      setState((){
        isHide = false;
      });
    });
  }


}
