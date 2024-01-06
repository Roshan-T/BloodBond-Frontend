import 'package:bloodbond/utils/constants.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 35,
                      child: Image.asset("assets/images/onboarding2.png"),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    children: [
                      Text(
                        "Hi Roshan,",
                        style: Get.textTheme.titleLarge?.copyWith(
                            color: Constants.kBlackColor,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Welcome Back",
                        style: Get.textTheme.labelMedium?.copyWith(
                          color: Constants.kBlackColor,
                        ),
                      )
                    ],
                  ),
                  const Spacer(),
                  const IconButton(
                    onPressed: null,
                    icon: Icon(
                      Icons.notifications_active_rounded,
                      color: Constants.kPrimaryColor,
                      size: 30,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
