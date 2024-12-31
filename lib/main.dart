import 'package:flutter/material.dart';
import 'package:todo_list/home_screen.dart';
import 'splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context)=> SplashScreen(),
        '/home': (context) =>HomeScreen()
      },
    );
  }
}


