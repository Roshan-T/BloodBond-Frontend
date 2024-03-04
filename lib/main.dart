import 'package:bloodbond/controller/get_donor_detail.dart';
import 'package:bloodbond/controller/network_controller.dart';
import 'package:bloodbond/firebase_options.dart';

import 'package:bloodbond/screen/splash_screen.dart';

import 'package:bloodbond/utils/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

  OneSignal.initialize("bdc6c13e-6cc3-457f-b009-e34972e9e3bf");

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
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: theme,
      home: const SplashScreen(),
      initialBinding: NetworkBinding(),
    );
  }
}
