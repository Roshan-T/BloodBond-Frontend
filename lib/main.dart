import 'package:bloodbond/controller/get_donor_detail.dart';
import 'package:bloodbond/controller/network_controller.dart';

import 'package:bloodbond/screen/splash_screen.dart';

import 'package:bloodbond/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  OneSignal.initialize("6e156e67-f308-49c1-a830-2ad88c8de8d3");

  OneSignal.Notifications.requestPermission(true);
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
