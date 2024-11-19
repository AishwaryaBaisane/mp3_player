import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:mx_player/Screen/HomeScreen/homeScreen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: AnimatedSplashScreen(
          duration: 4000,
          splash: Container(
            height: double.infinity,
            width: screenWidth * 0.85,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/img/sp3.gif'),
              ),
            ),
          ),
          nextScreen: const HomeScreen(),
          splashTransition: SplashTransition.fadeTransition,
          splashIconSize: screenHeight * double.infinity,
          backgroundColor:const  Color(0xff201646),
        ),
      ),
    );
  }
}

