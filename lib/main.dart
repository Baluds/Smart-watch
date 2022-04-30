import 'package:flutter/material.dart';
import 'package:smart_watch/ui/pages/forgetpass.dart';
import 'package:smart_watch/ui/pages/home.dart';
import 'package:smart_watch/ui/pages/login.dart';
import 'package:smart_watch/ui/pages/profile.dart';
import 'package:smart_watch/ui/pages/signup.dart';
import 'package:smart_watch/ui/pages/heartrate.dart';
import 'package:smart_watch/ui/pages/spo2.dart';
import 'package:smart_watch/ui/pages/welcome.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WelcomePage(),
      // routes: {
      // },
    );
  }
}
