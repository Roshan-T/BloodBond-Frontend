import 'package:bloodbond/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            Center(
              child: Image.asset(
                'assets/images/onboarding1.png',
                height: 300,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Expanded(
              child: ClipPath(
                clipper: WaveClipperOne(reverse: true, flip: true),
                child: Container(
                  width: double.infinity,
                  decoration:
                      const BoxDecoration(color: Constants.kPrimaryColor),
                  padding: const EdgeInsets.all(50),
                  child: const Column(
                    children: [
                      Text(
                        "Donate Blood",
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
