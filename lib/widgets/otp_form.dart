import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:timer_count_down/timer_count_down.dart';

class OtpForm extends StatefulWidget {
  const OtpForm({
    Key? key,
    required this.isSignUp,
    required this.phoneNumber,
  }) : super(key: key);
  final bool isSignUp;
  final String phoneNumber;
  @override
  State<OtpForm> createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  FocusNode? pin2FocusNode;
  FocusNode? pin3FocusNode;
  FocusNode? pin4FocusNode;
  FocusNode? pin5FocusNode;
  FocusNode? pin6FocusNode;
  String finalOtp = '';

  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
    pin5FocusNode = FocusNode();
    pin6FocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    pin2FocusNode!.dispose();
    pin3FocusNode!.dispose();
    pin4FocusNode!.dispose();
    pin5FocusNode!.dispose();
    pin6FocusNode!.dispose();
  }

  void nextField(String value, FocusNode? focusNode) {
    if (value.length == 1) {
      finalOtp += value;
      focusNode!.requestFocus();
    }
  }

  bool resendOtp = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 50,
                child: TextFormField(
                  autofocus: true,
                  obscureText: true,
                  style: const TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  // decoration: otpInputDecoration,
                  onChanged: (value) {
                    nextField(value, pin2FocusNode);
                  },
                ),
              ),
              SizedBox(
                width: 50,
                child: TextFormField(
                  focusNode: pin2FocusNode,
                  obscureText: true,
                  style: const TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  // decoration: otpInputDecoration,
                  onChanged: (value) => nextField(value, pin3FocusNode),
                ),
              ),
              SizedBox(
                width: 50,
                child: TextFormField(
                  focusNode: pin3FocusNode,
                  obscureText: true,
                  style: const TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  // decoration: otpInputDecoration,
                  onChanged: (value) => nextField(value, pin4FocusNode),
                ),
              ),
              SizedBox(
                width: 50,
                child: TextFormField(
                  focusNode: pin4FocusNode,
                  obscureText: true,
                  style: const TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  // decoration: otpInputDecoration,
                  onChanged: (value) => nextField(value, pin5FocusNode),
                ),
              ),
              SizedBox(
                width: 50,
                child: TextFormField(
                  focusNode: pin5FocusNode,
                  obscureText: true,
                  style: const TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  // decoration: otpInputDecoration,
                  onChanged: (value) => nextField(value, pin6FocusNode),
                ),
              ),
              SizedBox(
                width: 50,
                child: TextFormField(
                  focusNode: pin6FocusNode,
                  obscureText: true,
                  style: const TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  // decoration: otpInputDecoration,
                  onChanged: (value) {
                    if (value.length == 1) {
                      pin6FocusNode!.unfocus();
                      // Then you need to check is the code is correct or not
                      finalOtp += value;
                    }
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 80),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: const Color(0xffbffa63),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              minimumSize: const Size.fromHeight(50),
            ),
            onPressed: widget.isSignUp
                ? () {}
                : resendOtp
                    ? () async {
                        await FirebaseAuth.instance.verifyPhoneNumber(
                          phoneNumber: widget.phoneNumber,
                          verificationCompleted: (phoneAuthCredential) async {},
                          verificationFailed: (error) {},
                          codeSent: (verificationId, resendingToken) {},
                          codeAutoRetrievalTimeout: (verificationId) {},
                        );
                      }
                    : null,
            child: Text(widget.isSignUp ? 'Done' : 'Resend OTP'),
          ),
          const SizedBox(height: 20),
          // if (!widget.isSignUp) const Text('Resend OTP in '),
          if (!widget.isSignUp && !resendOtp)
            Countdown(
              seconds: 30,
              build: (BuildContext context, double time) => RichText(
                text: TextSpan(
                  text: 'Resend OTP in ',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                  children: [
                    TextSpan(
                      text: time.toString(),
                    ),
                  ],
                ),
              ),
              interval: const Duration(seconds: 1),
              onFinished: () {
                setState(() {
                  resendOtp = true;
                });
              },
            ),
          if (widget.isSignUp) const Text('Don\'t you recieve any code?'),
          const SizedBox(height: 10),
          if (widget.isSignUp)
            GestureDetector(
              onTap: () async {
                await FirebaseAuth.instance.verifyPhoneNumber(
                  phoneNumber: widget.phoneNumber,
                  verificationCompleted: (phoneAuthCredential) async {},
                  verificationFailed: (error) {},
                  codeSent: (verificationId, resendingToken) {},
                  codeAutoRetrievalTimeout: (verificationId) {},
                );
              },
              child: const Text(
                'Re-send Code',
                style: TextStyle(
                  color: Color(0xffbffa63),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
