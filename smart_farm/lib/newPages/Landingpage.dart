import 'package:flutter/material.dart';
import 'package:smart_farm/newPages/phonenumber.dart';

import 'package:smart_farm/utils/custom_image.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.grey[5001],
            appBar: _buildAppBar(context),
            body: Container(
                width: double.maxFinite,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 25),
                child: Column(children: [
                  _buildPageHeader(context),
                  const SizedBox(height: 31),
                const  CustomImage(),
                  const SizedBox(height: 33),
                  const Text("SmartFarm App", style: TextStyle(fontSize: 22)),
                  const SizedBox(height: 33),
                  SizedBox(
                    height: 40,
                    width: MediaQuery.of(context).size.width - 50,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color.fromARGB(255, 102, 170, 134)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ))),
                        child: const Text(
                          "Get Started",
                          style: TextStyle(
                              
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          onTapGetStarted(context);
                        }),
                  ),
                  const SizedBox(height: 14),
                ]))));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
        backgroundColor: const Color.fromARGB(255, 102, 170, 134),
        leadingWidth: double.maxFinite,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            padding: const EdgeInsets.fromLTRB(49, 16, 302, 16),
            onPressed: () {
              onTapArrowLeft(context);
            }));
  }

  /// Section Widget
  Widget _buildPageHeader(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width - 20,
              child: const Text("Welcome to the communinity of smartFarmApp ",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "sans-serif",
                    fontSize: 40,
                  ))),
          const SizedBox(height: 2),
        ]);
  }

  /// Navigates back to the previous screen.
  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }

  /// Navigates to the signupScreen when the action is triggered.
  onTapGetStarted(BuildContext context) {
    Navigator.push(context,  MaterialPageRoute(builder: (context) => const PhoneNumberWidget()),);
  }

  /// Navigates to the loginScreen when the action is triggered.
  // onTapLogin(BuildContext context) {
  //   Navigator.pushNamed(context, "/login");
  // }
}


