import 'package:flutter/material.dart';
import 'package:smart_farm/otp_sms.dart';
import 'package:smart_farm/utils/custom_image.dart';

class SendToWidget extends StatelessWidget {
  const SendToWidget({super.key});

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
                  const CustomImage(),
                  const SizedBox(height: 33),
                  const Text("The sms is send to this number :06391XXXXX ",
                      style: TextStyle(fontSize: 22)),
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
                          "Confirm",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          onTapConfirm(context);
                        }),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  SizedBox(
                    height: 40,
                    width: MediaQuery.of(context).size.width - 50,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color.fromARGB(255, 13, 15, 14)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ))),
                        child: const Text(
                          "Back",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          onTapBack(context);
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
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(
          width: MediaQuery.of(context).size.width - 20,
          child: const Text("Please confirm if the number entered Correct",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.black,
                fontFamily: "sans-serif",
                fontSize: 30,
              ))),
      const SizedBox(height: 2),
    ]);
  }

  /// Navigates back to the previous screen.
  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }

  /// Navigates to the signupScreen when the action is triggered.
  onTapConfirm(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const OTPPin()),
    );
  }

  //back to edit number
  onTapBack(BuildContext context) {
    Navigator.pop(context);
  }
}
