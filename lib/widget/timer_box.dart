import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/constants.dart';

class TimerBox extends StatelessWidget {
  String timeDuration;
  String time;

  TimerBox({super.key, required this.time, required this.timeDuration});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Constants.kPrimaryColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            time,
            style: Get.textTheme.displayLarge?.copyWith(
              color: Colors.white,
            ),
          ),
          Text(
            timeDuration,
            style: Get.textTheme.labelMedium?.copyWith(
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}

class CountdownController extends GetxController {
  Rx<Duration> timeRemaining = Duration.zero.obs;
  late Timer timer;

  void startCountdown(DateTime futureTime) {
    Duration duration = futureTime.difference(DateTime.now());
    timeRemaining.value = duration;

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      timeRemaining.value = timeRemaining.value - Duration(seconds: 1);

      if (timeRemaining.value.isNegative) {
        timer.cancel();
        timeRemaining.value = Duration.zero;
      }
    });
  }
}
