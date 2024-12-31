import 'dart:async';
import 'package:flutter/material.dart';
import 'constant/images.dart';
import 'constant/screen_util.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenUtil = Dynamicscreenutil(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image Container
          Expanded(
            child: Container(
              width: screenUtil.fullWidth,
              height: screenUtil.fullHeight * 0.8,
              decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  image: AssetImage(ImagePaths.logo),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: Transform.rotate(
              angle: 1.0,
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}
