import 'package:flutter/material.dart';

import 'package:smart_farm/videostream.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final String url = "https://www.youtube.com/watch?v=b63H7spQ-R4&t=1833s";
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
   
      home:  VideoPlayerWidget(videoUrl: url),
    );
  }
}
