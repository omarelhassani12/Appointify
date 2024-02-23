import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'views/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Appointify',
      theme: ThemeData(
        primaryColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      home: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: AnimatedSplashScreen(
          splash: Image.asset(
            'assets/images/appointify.png',
            fit: BoxFit.fill,
          ),
          nextScreen: const WelcomeScreen(),
          splashTransition: SplashTransition.fadeTransition,
          duration: 3000,
        ),
      ),
    );
  }
}
