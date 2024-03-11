import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:smart_farm/otpverification.dart';

class OTPScreen extends StatelessWidget {
  final TextEditingController phoneNumberController = TextEditingController();
  final String otp;
  final Key? key;
  OTPScreen({
    required this.otp,
    this.key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Phone Number'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: phoneNumberController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Enter your phone number',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String phoneNumber = phoneNumberController.text.trim();
                // Validate phone number (if needed)
                if (phoneNumber.isNotEmpty) {
                  // Send OTP
                  sendOTP(context, phoneNumber);
                } else {
                  // Handle empty phone number
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter a phone number'),
                    ),
                  );
                }
              },
              child: const Text('Send OTP'),
            ),
          ],
        ),
      ),
    );
  }

  void sendOTP(BuildContext context, String phoneNumber) {
    // Create SMS message body
    String message = 'Your OTP for verification is: $otp';

    // Use flutter_sms package to send SMS
    _sendSMS(phoneNumber, message);
    onTapVerify(context, phoneNumber);
    //Navigate to OTP verification screen
  }

  void _sendSMS(String phoneNumber, String message) async {
    try {
      // Use FlutterSms class to send SMS
      await sendSMS(message: message, recipients: [phoneNumber]);
    } catch (error) {
      print("Error sending SMS: $error");
      // Handle error here
    }
  }

  void onTapVerify(BuildContext context, String phoneNumber) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => OTPVerificationScreen(
                otp: otp,
                phoneNumber: phoneNumber,
              )),
    );
  }
}
