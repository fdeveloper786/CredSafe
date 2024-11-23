import 'package:credsafe/screens/homepage/home_screen.dart';
import 'package:credsafe/screens/login/login.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //FirebaseAuth auth = FirebaseAuth.instance;
    //User? user = auth.currentUser;
    return Login();
    /*if (user != null) {
      return const HomeScreen(); // Show Home Screen if logged in
    } else {
      return const Login(); // Show Login Screen if not logged in
    }*/
  }
}