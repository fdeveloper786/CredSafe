import 'package:credsafe/domain/app_binding/common_binding.dart';
import 'package:credsafe/screens/auth_wrapper/auth_wrapper.dart';
import 'package:credsafe/screens/onboard/onboard_screen.dart';
import 'package:credsafe/utils/constants/app_constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: apiKey,
        appId: appId,
        messagingSenderId: messageSenderId,
        projectId: projectId
    )
  );
  FlutterNativeSplash.remove();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

  runApp(MyApp(isFirstTime: isFirstTime));
}

class MyApp extends StatelessWidget {
  final bool isFirstTime;
  const MyApp({required this.isFirstTime,super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      initialBinding: AppBinding(),
      home: isFirstTime ? const OnboardingScreen() : AuthWrapper(),
    );
  }
}