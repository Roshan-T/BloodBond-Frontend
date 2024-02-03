import 'package:bloodbond/controller/network_controller.dart';

import 'package:bloodbond/screen/splash_screen.dart';

import 'package:bloodbond/utils/theme.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: theme,
      home: const SplashScreen(),
      initialBinding: NetworkBinding(),
    );
  }
}
