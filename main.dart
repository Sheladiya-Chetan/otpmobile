import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:otpsend/second_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(home: Myotp(), debugShowCheckedModeBanner: false,));
}

class Myotp extends StatefulWidget {
  //static String verificationid = "";

  @override
  State<Myotp> createState() => _MyotpState();
}

class _MyotpState extends State<Myotp> {
  TextEditingController number = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  otp() async {
   await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "+91${number.text}",
        verificationCompleted: (PhoneAuthCredential credential) async {
         await auth.signInWithCredential(credential).then((value) {
           if(value.user!= null){
             // Navigator.push(context, MaterialPageRoute(builder: (context) {
             //   return Second_Page();
             // },));
           }
         });
        },
        verificationFailed: (FirebaseAuthException error) {
          if(error.code == "invalid-Phone-Number")
            {
              print("Invalid Number");
            }
        },
        codeSent: (verificationId, forceResendingToken) {
          if(verificationId != null){
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Second_Page(verificationId);
            },));
          }
          log("Verification Id : $verificationId");
        },
        codeAutoRetrievalTimeout:(String verificationId) {},
        timeout: Duration(seconds: 120),
   );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(controller: number,

          ),
          ElevatedButton(onPressed: () {
            otp();
          }, child: Text("submit"))
        ],
      ),
    );
  }
}
