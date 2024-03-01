import 'package:deyus_internship/widgets/otp_form.dart';
import 'package:flutter/material.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({
    Key? key,
    required this.isSignup,
    required this.phoneNumber,
  }) : super(key: key);
  final String phoneNumber;
  final bool isSignup;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        margin: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter OTP',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'A six digit has been code sent to $phoneNumber',
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 10),
            if (!isSignup)
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: RichText(
                  text: const TextSpan(
                    text: 'Incorrect Number? ',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: 'Change',
                        style: TextStyle(
                          color: Color(0xffbffa63),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            const SizedBox(
              height: 30,
            ),
            OtpForm(
              isSignUp: isSignup,
              phoneNumber: phoneNumber,
            ),
          ],
        ),
      ),
    );
  }
}
