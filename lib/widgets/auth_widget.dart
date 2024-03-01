import 'package:deyus_internship/screens/otp_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class AuthWidget extends StatefulWidget {
  const AuthWidget({Key? key, required this.isSignup}) : super(key: key);
  final bool isSignup;

  @override
  State<AuthWidget> createState() => _AuthWidgetState();
}

String veriId = '';

class _AuthWidgetState extends State<AuthWidget> {
  String? phoneNumber;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 30, bottom: 20, right: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.isSignup ? 'Welcome to App' : 'Welcome Back!!',
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 40),
          Text(
            widget.isSignup
                ? 'Please signup with your phone number to get registered'
                : 'Please login with your phone number.',
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 25),
          IntlPhoneField(
            decoration: const InputDecoration(
              labelText: 'Phone Number',
              border: OutlineInputBorder(
                borderSide: BorderSide(),
              ),
            ),
            initialCountryCode: 'IN',
            invalidNumberMessage: 'Please enter correct phone number.',
            onChanged: (phone) {
              if (phone.completeNumber.length == 13) {
                setState(() {
                  phoneNumber = phone.completeNumber;
                });
              }
            },
          ),
          const SizedBox(height: 25),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              minimumSize: const Size.fromHeight(50),
            ),
            onPressed: () async {
              if (phoneNumber?.length == 13) {
                await FirebaseAuth.instance
                    .verifyPhoneNumber(
                      phoneNumber: phoneNumber,
                      verificationCompleted: (phoneAuthCredential) async {},
                      verificationFailed: (error) {},
                      codeSent: (verificationId, resendingToken) {},
                      codeAutoRetrievalTimeout: (verificationId) {},
                    )
                    .then((value) => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => OtpScreen(
                              phoneNumber: phoneNumber!,
                              isSignup: widget.isSignup,
                            ),
                          ),
                        ));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Please enter correct phone number!',
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: const Text(
              'Continue',
              style: TextStyle(fontSize: 20),
            ),
          ),
          const SizedBox(height: 25),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Expanded(
                child: Divider(
                  color: Colors.grey,
                  thickness: 2,
                  height: 2,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: const Text('OR'),
              ),
              const Expanded(
                child: Divider(
                  color: Colors.grey,
                  thickness: 2,
                  height: 2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          const Buttons(
            icon: Icon(Icons.abc),
            title: 'Metamask',
          ),
          const SizedBox(height: 15),
          const Buttons(
            icon: Icon(Icons.abc),
            title: 'Google',
          ),
          const SizedBox(height: 15),
          const Buttons(
            icon: Icon(Icons.abc),
            title: 'Apple',
            ccolor: true,
          ),
        ],
      ),
    );
  }
}

class Buttons extends StatelessWidget {
  const Buttons({
    required this.title,
    required this.icon,
    this.ccolor = false,
    Key? key,
  }) : super(key: key);
  final String title;
  final Icon icon;
  final bool ccolor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: icon,
      style: ElevatedButton.styleFrom(
        primary:
            ccolor ? Colors.black : const Color.fromARGB(255, 221, 251, 215),
        side: const BorderSide(
          color: Colors.grey,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        minimumSize: const Size.fromHeight(50),
      ),
      onPressed: () {},
      label: RichText(
        text: TextSpan(
          text: 'Connect to ',
          style: TextStyle(
            fontSize: 20,
            color: ccolor ? Colors.white : Colors.black,
          ),
          children: [
            TextSpan(
              text: title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
