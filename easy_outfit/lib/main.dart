import 'package:easy_outfit/src/frontend/pages/home_screen.dart';
import 'package:easy_outfit/src/frontend/pages/splash_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "splash",
      routes: {
        "splash":(context) => const SplashScreen(),
        "home":(context) => const HomeScreen(),
      }
    );
  }
}