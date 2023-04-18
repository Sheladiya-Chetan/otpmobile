import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:otpsend/Homepage.dart';
import 'package:otpsend/main.dart';
import 'package:pinput/pinput.dart';

class Second_Page extends StatefulWidget {
  String verificationId;

  Second_Page(String this.verificationId);


  @override
  State<Second_Page> createState() => _Second_PageState();
}

class _Second_PageState extends State<Second_Page> {
  TextEditingController Otp = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;


  verification() async {
    try{
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId:widget.verificationId ,
          smsCode:Otp.text);
      auth.signInWithCredential(credential).then((value)  {
        if(value.user!=null){
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Success full")));
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return HOmePage();
          },));
        }
      });
    }catch (e) {ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Wrong otp")));}
    // Create a PhoneAuthCredential with the code

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  height: 250,
                  width: 250,
                  child:
                  Lottie.asset('images/22581-otp-mobile-notification.json')),
              SizedBox(
                height: 20,
              ),
              Text(
                "Verification",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                "Enter the Code sent to the Number",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                "Mobile number",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                height: 20,
              ),
              Pinput(
                controller:Otp ,
                androidSmsAutofillMethod:
                AndroidSmsAutofillMethod.smsUserConsentApi,
                length: 6,
                showCursor: true,
                defaultPinTheme: PinTheme(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.green,
                        ),
                        borderRadius: BorderRadius.circular(15)),
                    textStyle:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: 35,
              ),
              Text(
                "Didn't receive code..?",
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(height: 10),
              Text(
                "Resend",
                style:
                TextStyle(fontSize: 15, decoration: TextDecoration.underline),
              ),
              SizedBox(
                height: 65,
              ),
              InkWell(
                onTap: () {
                  verification();
                },
                child: Container(
                  height: 50,
                  width: 140,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(width: 2, color: Colors.green),
                      color: Colors.green),
                  child: Center(
                      child: Text(
                        "Submit",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      )),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
