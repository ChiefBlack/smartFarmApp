import 'package:flutter/material.dart';
import 'package:smart_farm/otp_sms.dart';
import 'package:smart_farm/startpage.dart';
import 'package:smart_farm/verify.dart';

//import 'package:smart_farm/videostream.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      
   
      home:  Scaffold(   
      body: Column(
        children: [
          LocalPagState(),
          //OTPPin(),
         // PhoneNumber()
        ],
      )),
      
      // routes:{
      //   "/": (context) => const HomePage(),
      // },
   

      
      
    );
  }
}
