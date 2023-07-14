import 'package:flutter/material.dart';
import 'package:suitmedia_app/firstScreen/view/first_screen.dart';
import 'package:suitmedia_app/secondScreen/second_screen.dart';
import 'package:suitmedia_app/thirdScreen/view/third_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirstScreen(),
      routes: {
        '/first-screen': (context) => const FirstScreen(),
        '/second-screen': (context) => const SecondScreen(),
        '/third-screen': (context) => const ThirdScreen(),
      },
    );
  }
}
