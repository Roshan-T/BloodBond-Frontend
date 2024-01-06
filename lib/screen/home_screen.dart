import 'package:bloodbond/utils/constants.dart';
import 'package:bloodbond/widget/blood_camp.dart';
import 'package:bloodbond/widget/emergency_request_box.dart';
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Upcoming bootcamp",
                  style: Get.textTheme.displayLarge
                      ?.copyWith(color: Constants.kBlackColor, fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  
                  height: 250,
                  child: ListView.separated(
                      physics: const ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return CampTile(campers: bloodCamp[index]);
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          width: 10,
                        );
                      },
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: bloodCamp.length),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Emergency Request",
                  style: Get.textTheme.displayLarge
                      ?.copyWith(color: Constants.kBlackColor, fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return EmergencyRequestBox(
                          emergencyRequest: requests[index]);
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: requests.length)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
