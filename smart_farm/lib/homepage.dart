import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Center(
              child: Text(
            "Smart farm app",
            style: TextStyle(color: Color.fromARGB(255, 102, 170, 134)),
          )),
          Text("Please wath a video here"),
          Icon(Icons.live_tv)
        ],
      ),
    );
  }
}
