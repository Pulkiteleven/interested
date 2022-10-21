import 'package:flutter/material.dart';
import 'package:interested/Auth/OTPpage.dart';
import 'package:interested/Usefull/Buttons.dart';
import 'package:interested/Usefull/Functions.dart';
import 'package:interested/Usefull/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';


class enterMobile extends StatefulWidget {
  const enterMobile({Key? key}) : super(key: key);

  @override
  State<enterMobile> createState() => _enterMobileState();
}

class _enterMobileState extends State<enterMobile> {
  final formKey = GlobalKey<FormState>();
  String phone = "";
  bool isHide = false;
  FirebaseAuth _auth = FirebaseAuth.instance;
  late BuildContext mCtx;


  @override
  void initState() {
    dialogLoader(context);
  }

  @override
  Widget build(BuildContext context) {
    mCtx = context;
    return MaterialApp(
      home: Scaffold(
        backgroundColor: bgColor,
        body: SafeArea(
          child: Stack(
            children: [

              circles(context),

              SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 30.0,vertical: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 100.0,),
                    Row(
                      children: [
                        mainText("Login", mainColor, 35.0, FontWeight.normal, 1),
                        Spacer()
                      ],
                    ),
                    Row(
                      children: [
                        mainText("with mobile number", secColor, 13.0, FontWeight.normal, 1),
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
                              TextFormField(
                                maxLength: 10,
                                keyboardType:TextInputType.number,
                                cursorColor: mainColor,

                                style: TextStyle(
                                  fontFamily: 'mons',
                                  fontSize: 15.0,
                                  color: mainColor,
                                ),
                                decoration: InputDecoration(
                                    hintText: "Mobile Number",
                                    suffixIcon: Icon(Icons.call,color: mainColor,),
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
                                  phone = text;
                                },
                                validator: (value){
                                  if(value!.isEmpty){
                                    return("Please Enter a Number");
                                  }
                                  else if(value.length < 10){
                                    return("Number should be 10 digits long");
                                  }
                                  return null;
                                },
                              ),
                            ],
                          )
                      ),
                    ),



                    SizedBox(height: 20.0,),
                    btnsss("GET OTP", () { LoginwithMobile();}, mainColor, Colors.white),


                  ],
                ),
              ),
              bottomIn(),
              loaderss(isHide, context),



            ],
          ),
        ),
      ),
    );
  }
  Future LoginwithMobile() async{
    if(formKey.currentState!.validate()){
      setState((){
        isHide = true;
      });
      await _auth.verifyPhoneNumber(
          phoneNumber: "+91" + phone,
          verificationCompleted: _onVerificationCompleted,
          verificationFailed: _onVerificationFailed,
          codeSent: _onCodeSent,
          codeAutoRetrievalTimeout: _onCodeTimeout);
    }
  }

  _onVerificationCompleted(PhoneAuthCredential authCredential) async {
    print("verification completed ${authCredential.smsCode}");
    User? user = FirebaseAuth.instance.currentUser;
    setState(() {
      // this.otpCode.text = authCredential.smsCode!;
    });
    if (authCredential.smsCode != null) {
      try{
        UserCredential credential =
        await user!.linkWithCredential(authCredential);
      }on FirebaseAuthException catch(e){
        if(e.code == 'provider-already-linked'){
          await _auth.signInWithCredential(authCredential);
        }
      }
      setState(() {
        isHide = false;
      });
    }
  }

  _onVerificationFailed(FirebaseAuthException exception) {
    print(exception.code);
    if (exception.code == 'invalid-phone-number') {
      setState((){
        isHide = false;
      });
      snacker("Please Enter an Valid Phone Number", mCtx);
    }
  }

  _onCodeSent(String verificationId, int? forceResendingToken) {
    print("Bhij Gaya");
    verificationId = verificationId;
    print(forceResendingToken);
    snacker("OTP send Successfully", mCtx);
    navScreen(enterOTP(number: phone, vID: verificationId), context, false);
  }

  _onCodeTimeout(String timeout) {
    return null;
  }

}
