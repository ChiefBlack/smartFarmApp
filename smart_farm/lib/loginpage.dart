import 'package:flutter/material.dart';
import 'package:smart_farm/otp_sms.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

   final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Container(
    
      child: logging(context),
    );
  }

  Form logging(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "Enter Your Number"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter ur number';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 16.0),
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Navigate the user to the Home page
                       Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const OTPPin()),
  );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please fill input')),
                      );
                    }
                  },
                  child:const  Padding(padding:   EdgeInsets.symmetric(horizontal: 8, vertical: 16),  child:  Text('Comnfirm SMS')),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}