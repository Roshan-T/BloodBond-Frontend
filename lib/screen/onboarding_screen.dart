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
                  height: 50,
                ),
                Center(
                  child: Image.asset(
                    onBoardData[i].imagePath,
                    height: 300,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Expanded(
                  child: ClipPath(
                    clipper: OvalTopBorderClipper(),
                    child: Container(
                      width: double.infinity,
                      decoration:
                          const BoxDecoration(color: Constants.kPrimaryColor),
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            textAlign: TextAlign.center,
                            onBoardData[i].headline,
                            style: Get.textTheme.displayLarge?.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Text(
                            textAlign: TextAlign.center,
                            onBoardData[i].description,
                            style: Get.textTheme.titleSmall
                                ?.copyWith(color: Colors.white),
                          ),
                          SizedBox(
                            height: 100,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 10,
                                width: page == 0 ? 25 : 10,
                                margin: EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                ),
                              ),
                              Container(
                                height: 10,
                                width: page == 1 ? 25 : 10,
                                margin: EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                ),
                              ),
                              Container(
                                height: 10,
                                width: page == 2 ? 25 : 10,
                                margin: EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                ),
                              ),
                              Container(
                                height: 10,
                                width: page == 3 ? 25 : 10,
                                margin: EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          page == 3
                              ? SizedBox(
                                  height: Get.height * 0.065,
                                  width: Get.width * 1.1,
                                  child: ElevatedButton(
                                      style: Get.theme.elevatedButtonTheme.style
                                          ?.copyWith(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Constants.kWhiteColor),
                                      ),
                                      onPressed: () {},
                                      child: Text(
                                        "Lets Go",
                                        style: Get.textTheme.labelLarge,
                                      )),
                                )
                              : Text("")
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
