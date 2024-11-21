import 'package:credsafe/utils/constants/app_constants.dart';
import 'package:flutter/material.dart';


class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appName),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Login Screen'),
      )
    );
  }
}
