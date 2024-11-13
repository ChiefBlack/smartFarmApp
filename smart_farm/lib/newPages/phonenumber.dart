import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:smart_farm/otpverification.dart';

class OTPScreen extends StatefulWidget {
  final String otp;
  final Key? key;
  OTPScreen({
    required this.otp,
    this.key,
  }) : super(key: key);

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final TextEditingController phoneNumberController = TextEditingController();
  String? selectedCountryCode = '+1';  // Default to USA

  final List<String> countryCodes = ['+1', '+44', '+91', '+27'];

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
            DropdownButton<String>(
              value: selectedCountryCode,
              onChanged: (String? newValue) {
                setState(() {
                  selectedCountryCode = newValue!;
                });
              },
              items: countryCodes.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: phoneNumberController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 102, 170, 134),
                      width: 2.0,
                    )),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 102, 170, 134),
                      width: 2.0,
                    )),
                labelText: 'Enter your phone number',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  const Color.fromARGB(255, 102, 170, 134),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
              ),
              onPressed: () async {
                String phoneNumber = phoneNumberController.text.trim();
                if (phoneNumber.isNotEmpty) {
                  // Await the Future result of sendOTP
                  bool success = await sendOTP(phoneNumber);
                  print(success);
                  if (success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('OTP sent successfully')),
                    );
                    onTapVerify(context, selectedCountryCode! + phoneNumber);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Failed to send OTP. Please try again.')),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter a phone number'),
                    ),
                  );
                }
              },
              child: const Text(
                'Send OTP',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Updated sendOTP function using Future<bool> to return success status
  Future<bool> sendOTP(String phoneNumber) async {
  String fullPhoneNumber = selectedCountryCode! + phoneNumber;
  print(fullPhoneNumber);

  try {
    // Send phone number as form data, not as JSON
    var response = await http.post(
      Uri.parse('http://192.168.15.225:8000/api/users/send-otp/'),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded', // Use form URL encoding
      },
      body: {
        'phone_number': fullPhoneNumber, // Send phone number as a form field
      },
    );

    print("Request Sent: ${response.request?.url}");
    print("Response Status: ${response.statusCode}");
    print("Response Body: ${response.body}");

    if (response.statusCode == 200) {
      print('OTP sent successfully');
      return true;
    } else {
      var responseBody = jsonDecode(response.body);
      print('Error: ${responseBody['status']}');
      return false;
    }
  } catch (error) {
    print("Error sending OTP: $error");
    return false;
  }
}


  void onTapVerify(BuildContext context, String phoneNumber) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OTPVerificationScreen(
          otp: widget.otp,
          phoneNumber: phoneNumber,
        ),
      ),
    );
  }
}
