import 'package:flutter/material.dart';
import 'package:smart_farm/newPages/phonenumber.dart';

class AppRoutes {
  static const String phoneScreen= '/phone_screen';
   static const String otpScreen= '/otp';


  

  static Map<String, WidgetBuilder> routes = {
     phoneScreen: (context) => const PhoneNumberWidget(),
  };
}
