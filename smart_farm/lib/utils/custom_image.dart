import 'package:flutter/material.dart';
class CustomImage extends StatelessWidget {
  const CustomImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Image(
        image: AssetImage("assets/images/image_logo.png"),
        height: 105,
        width: 117);
  }
}