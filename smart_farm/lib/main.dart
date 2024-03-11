import 'package:flutter/material.dart';
import 'package:smart_farm/newPages/Landingpage.dart';





void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: LandingPage());
  }
}


//  Scaffold(
//           body: Column(
//         children: [
//           //LocalPagState(),
//          // OTPPin(),
//           // PhoneNumber()
//           LandingPage()
//         ],
//       )),