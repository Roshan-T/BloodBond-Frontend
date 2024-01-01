import 'package:bloodbond/screen/map.dart';
import 'package:bloodbond/screen/onboarding_screen.dart';
import 'package:bloodbond/screen/verification_screen.dart';
import 'package:bloodbond/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: theme,
<<<<<<< HEAD
      home: MapPage(),
=======
      home: const VerificationScreen(),
>>>>>>> e678cfd2bca0b896e63b81dc0b892d3e45f7a5fa
    );
  }
}
