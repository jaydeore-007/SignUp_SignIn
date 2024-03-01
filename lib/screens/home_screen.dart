import 'package:deyus_internship/widgets/auth_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isSignUp = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              setState(
                () {
                  isSignUp = !isSignUp;
                },
              );
            },
            child: AnimatedContainer(
              duration: const Duration(seconds: 3),
              margin: const EdgeInsets.only(left: 30, bottom: 30),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(
                  20,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                        top: 10,
                        left: 10,
                        bottom: 10,
                        right: !isSignUp ? 20 : 3),
                    decoration: !isSignUp
                        ? BoxDecoration(
                            color: const Color(0xffbffa63),
                            // border: Border.all(
                            //   color: Colors.grey,
                            // ),
                            borderRadius: BorderRadius.circular(
                              15,
                            ),
                          )
                        : null,
                    child: const Text(
                      'Signin',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  // const SizedBox(width: 5),
                  Container(
                    padding: isSignUp
                        ? const EdgeInsets.only(
                            top: 10, left: 20, bottom: 10, right: 10)
                        : const EdgeInsets.only(left: 5, right: 5),
                    decoration: isSignUp
                        ? BoxDecoration(
                            color: const Color(0xffbffa63),
                            // border: Border.all(
                            //   color: Colors.grey,
                            // ),
                            borderRadius: BorderRadius.circular(
                              15,
                            ),
                          )
                        : null,
                    child: const Text(
                      'Signup',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          AuthWidget(
            isSignup: isSignUp,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isSignUp = true;
              });
            },
            child: Center(
              child: RichText(
                text: const TextSpan(
                  text: 'Don\'t have an account? ',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  children: [
                    TextSpan(
                      text: 'Signup',
                      style: TextStyle(
                        color: Color(0xffbffa63),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
