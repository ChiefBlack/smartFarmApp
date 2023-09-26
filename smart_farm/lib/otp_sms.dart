import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class OTPPin extends StatefulWidget {
  const OTPPin({super.key});

  @override
  State<OTPPin> createState() => _OTPPinState();
}

class _OTPPinState extends State<OTPPin>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        
        children: [
          Text("please put code u got from the sms"),
          Center(
            child: Pinput(
            onCompleted: (pin) => print(pin),
            defaultPinTheme: PinTheme(width: 56,
            height: 56,
            textStyle: const  TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
            decoration: BoxDecoration(
            border: Border.all(color:const Color.fromRGBO(234, 239, 243, 1)),
            borderRadius: BorderRadius.circular(20),
            ),),
            ),
          ),
        ],
      ),
    );
  }
}