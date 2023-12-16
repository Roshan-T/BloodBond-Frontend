import 'package:bloodbond/utils/constants.dart';
import 'package:flutter/material.dart';

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
              height: 80,
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.elliptical(
                          MediaQuery.of(context).size.width, 100),
                    ),
                    color: Constants.kPrimaryColor),
                padding: const EdgeInsets.symmetric(
                    vertical: Constants.kHorizontalPadding),
                child: const Column(
                  children: [
                    Text(
                      "Donate Blood",
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
