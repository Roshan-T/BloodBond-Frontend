import 'package:bloodbond/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class OnboardingScreen extends StatefulWidget {
  OnboardingScreen({super.key});

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
                const SizedBox(
                  height: 100,
                ),
                Center(
                  child: Image.asset(
                    onBoardData[i].imagePath,
                    height: 300,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Expanded(
                  child: ClipPath(
                    clipper: OvalTopBorderClipper(),
                    child: Container(
                      width: double.infinity,
                      decoration:
                          const BoxDecoration(color: Constants.kPrimaryColor),
                      padding: const EdgeInsets.all(50),
                      child: Column(
                        children: [
                          Text(
                            textAlign: TextAlign.center,
                            onBoardData[i].headline,
                            style: Get.textTheme.displayLarge?.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Text(
                            onBoardData[i].description,
                            style: Get.textTheme.titleSmall
                                ?.copyWith(color: Colors.white),
                          ),
                          const SizedBox(
                            height: 200,
                          ),
                          Text(
                            page.toString(),
                            style: Get.textTheme.titleSmall
                                ?.copyWith(color: Colors.white),
                          ),
                          Row(
                            children: [],
                          )
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
