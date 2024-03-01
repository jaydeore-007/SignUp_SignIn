import 'package:deyus_internship/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: const MaterialColor(
          0xffbbfa63,
          <int, Color>{
            50: Color(0xfff4fee6),
            100: Color(0xffdffdb5),
            200: Color(0xffc9fb83),
            300: Color(0xffb4f952),
            400: Color(0xff9ef821),
            500: Color(0xff85de07),
            600: Color(0xff67ad06),
            700: Color(0xff4a7c04),
            800: Color(0xff2c4a02),
            900: Color(0xff0f1901),
          },
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
