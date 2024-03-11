import 'package:flutter/material.dart';
import 'package:smart_farm/videostream.dart';

class OTPVerificationScreen extends StatelessWidget {
  final TextEditingController otpController = TextEditingController();
  final String phoneNumber;
  final String otp;

  OTPVerificationScreen({required this.phoneNumber, required this.otp});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify OTP'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: otpController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter OTP',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String enteredOTP = otpController.text.trim();
                // Verify OTP
                verifyOTP(context, enteredOTP);
              },
              child: const Text('Verify OTP'),
            ),
          ],
        ),
      ),
    );
  }

  void verifyOTP(BuildContext context, String enteredOTP) {
    if (enteredOTP == otp) {
      // OTP is correct

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const VideoApp()),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('OTP is correct!'),
        ),
      );
    } else {
      // OTP is incorrect
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Incorrect OTP. Please try again.'),
        ),
      );
    }
  }
}
