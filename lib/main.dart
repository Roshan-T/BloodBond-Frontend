import 'package:bloodbond/screen/campaign_details.dart';
import 'package:bloodbond/screen/main_screen.dart';
import 'package:bloodbond/screen/signup_hospital.dart';
import 'package:bloodbond/screen/signup_screen.dart';

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
      home: SignUpScreenHospital(),
    );
  }
}
