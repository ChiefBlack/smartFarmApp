import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:phonenumbers/phonenumbers.dart';
class PhoneNumber extends StatefulWidget {
  const PhoneNumber({super.key});

  @override
  State<PhoneNumber> createState() => _PhoneNumberState();
}

class _PhoneNumberState extends State<PhoneNumber> {
   final phoneNumberController = PhoneNumberEditingController();
   
   String phonenumber= "0639133555";
//List <String> recipients =["0639133555"];

String message = "This is a test message!";
List<String> recipents = ["1234567890"];



   //String message = "0764";
 
  @override

  
  Widget build(BuildContext context) {
    return  Center(
      child: Form( 
            child : Column(children: [
               PhoneNumberField(
               controller: PhoneNumberEditingController.fromCountryCode('SA'),
                      decoration:const  InputDecoration(border: OutlineInputBorder()),
              ),
           Container(padding: const EdgeInsets.all(9),
           
           
          //  color: Colors.black,
            child:    ElevatedButton(onPressed:(){
//_sendSMS(message, recipents);
print("data");

            }, child:const Text("please verify your number",style: TextStyle(color: Color.fromARGB(255, 242, 245, 242)),))),
              
            ],
           
           
             
            
          ),
        ),
    );
    
  }
}
void _sendSMS(String message, List<String> recipents) async {
 String _result = await sendSMS(message: message, recipients: recipents);
    //     .catchError((onError) {
    //   print(onError);
    // });
print(_result);
}