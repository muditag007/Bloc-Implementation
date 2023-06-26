// ignore_for_file: prefer_const_constructors, unused_local_variable, unused_import, avoid_print

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_app/features/home/ui/home.dart';
import 'package:test_app/features/sign_in/ui/sign_in.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? email = prefs.getString("email");
  String? userType = prefs.getString("userType");
  print("hello");
  print(email);
  print(userType);

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      color: Colors.white,
      home: email == null ? SignIn() : Home(email: email),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      color: Colors.white,
      home: SignIn(),
    );
  }
}
