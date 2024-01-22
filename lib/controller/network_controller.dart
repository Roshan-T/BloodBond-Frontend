import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/constants.dart';

class NetworkController extends GetxController {
  var connectionStatus = 0.obs;
  late StreamSubscription<ConnectivityResult> connectivitySubscription;
  final Connectivity connectivity = Connectivity();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initConnectivity();
    connectivitySubscription =
        connectivity.onConnectivityChanged.listen(updateConnectionStatus);
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await connectivity.checkConnectivity();
    } catch (e) {
      print(e.toString());
    }
    return updateConnectionStatus(result);
  }

  updateConnectionStatus(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
        connectionStatus.value = 1;
        break;

      case ConnectivityResult.none:
        connectionStatus.value = 0;
        break;
      default:
        Get.closeAllSnackbars();
        Get.snackbar(
          "Network Error",
          "Failed to get network connection",
          colorText: Colors.white,
          backgroundColor: Constants.kPrimaryColor,
        );
        break;
    }
  }
}

class NetworkBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NetworkController>(
      () => NetworkController(),
    );
  }
}
