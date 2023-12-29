//import 'package:bloodbond/screen/bloodtype_selection.dart';
//import 'package:bloodbond/screen/login_screen.dart';
//import 'package:bloodbond/screen/signup_screen.dart';
import 'package:bloodbond/screen/login_screen.dart';
import 'package:bloodbond/screen/verification_screen.dart';
import 'package:bloodbond/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int page = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView.builder(
          onPageChanged: (int index) {
            setState(() {
              page = index;
            });
          },
          itemCount: onBoardData.length,
          itemBuilder: (_, i) {
            return Column(
              children: [
                SizedBox(
                  height: Get.height * 0.05,
                ),
                Center(
                  child: Image.asset(
                    onBoardData[i].imagePath,
                    height: Get.height * 0.3,
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.15,
                ),
                Expanded(
                  child: ClipPath(
                    clipper: OvalTopBorderClipper(),
                    child: Container(
                      width: double.infinity,
                      decoration:
                          const BoxDecoration(color: Constants.kPrimaryColor),
                      padding: EdgeInsets.all(Get.width * 0.1),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            onBoardData[i].headline,
                            style: Get.textTheme.displayLarge?.copyWith(
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: Get.height * 0.04,
                          ),
                          Text(
                            onBoardData[i].description,
                            style: Get.textTheme.titleSmall
                                ?.copyWith(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: Get.height * 0.10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              for (int index = 0; index < 4; index++)
                                Container(
                                  height: 10,
                                  width: page == index ? 25 : 10,
                                  margin: const EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                  ),
                                ),
                            ],
                          ),
                          page == 3
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: SizedBox(
                                    height: Get.height * 0.065,
                                    width: Get.width * 0.8,
                                    child: ElevatedButton(
                                      style: Get.theme.elevatedButtonTheme.style
                                          ?.copyWith(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Constants.kWhiteColor),
                                      ),
                                      onPressed: () {
                                        Get.offAll(
                                          const LoginScreen(),
                                        );
                                      },
                                      child: Text(
                                        "Let's Go",
                                        style: Get.textTheme.labelLarge,
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
