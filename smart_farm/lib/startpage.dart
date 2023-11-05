import 'package:flutter/material.dart';
import 'package:smart_farm/loginpage.dart';

class LocalPagState extends StatefulWidget {
  const LocalPagState({super.key});

  @override
  State<LocalPagState> createState() => _LocalPagStateState();
}

class _LocalPagStateState extends State<LocalPagState> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [Login()],
    );
  }
}
