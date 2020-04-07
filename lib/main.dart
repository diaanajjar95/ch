import 'package:ch/ui/home/home.dart';
import 'package:ch/ui/login/login.dart';
import 'package:ch/ui/signup/signup.dart';
import 'package:ch/ui/splash/splash_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => Splash(),
          '/login': (context) => Login(),
          '/signup': (context) => SignUp(),
          '/home': (context) => Home(),
        },
      ),
    );
