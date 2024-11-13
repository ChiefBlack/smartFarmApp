import 'package:flutter/material.dart';
import 'package:smart_farm/newPages/VideoDetect.dart';

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
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(
                    color: const Color.fromARGB(255, 102, 170, 134), width: 2.0),
                    
                ),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(
                    color: const Color.fromARGB(255, 102, 170, 134), width: 2.0),
                    
                ),
                
                labelText: 'Enter OTP',
                

              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  const Color.fromARGB(255, 102, 170, 134), // Same color as before
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0), // Rounded corners
                  ),
                ),
              ),
              onPressed: () {
                String enteredOTP = otpController.text.trim();
                // Verify OTP
                verifyOTP(context, enteredOTP);
              },
              child: const Text(
                'Verify OTP',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
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
        MaterialPageRoute(builder: (context) => const VideoDetect()),
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
