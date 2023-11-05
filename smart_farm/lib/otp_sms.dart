

import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:smart_farm/homepage.dart';

class OTPPin extends StatefulWidget {
  const OTPPin({super.key});

  @override
  State<OTPPin> createState() => _OTPPinState();
}

class _OTPPinState extends State<OTPPin> with SingleTickerProviderStateMixin {
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
    return SizedBox(
      child:   Center(
        child:  Stack(children: [
 const Image(image: AssetImage('assets/images/image_logo.png')),
    const    Text("OTP",style: TextStyle(fontSize: 23,color: Colors.black),),

          Pinput(
          onCompleted: (pin) => {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            )
          },
          defaultPinTheme: PinTheme(
            width: 56,
            height: 56,
            textStyle: const TextStyle(
                fontSize: 20,
                color: Color.fromRGBO(30, 60, 87, 1),
                fontWeight: FontWeight.w600),
            decoration: BoxDecoration(
              border: Border.all(color: const Color.fromARGB(255, 14, 48, 77)),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        ]
          


        ,)
      ),
    );
  }
}

