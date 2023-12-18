import 'package:flutter/material.dart';

class Constants {
  // Colors
  static const kPrimaryColor = Color.fromARGB(255, 198, 13, 0);
  static const kAccentColor = Color(0XFFFF4701);
  static const kErrorColor = Color(0XFFE61F34);
  static const kSuccessColor = Colors.green;
  static const kBlackColor = Color(0XFF000000);
  static const kWhiteColor = Color(0XFFFFFFFF);
  static const kGrey = Colors.grey;
  static const kTextField = Color(0xFFF5F5F5);

  // padding
  static const kHorizontalPadding = 20.0;
}

class OnboardingData {
  final String imagePath;
  final String headline;
  final String description;

  OnboardingData(
      {required this.imagePath,
      required this.headline,
      required this.description});
}

final onBoardData = [
  OnboardingData(
      imagePath: "assets/images/onboarding1.png",
      headline: "Donate Blood",
      description: "Give Life , Donate Blood Today"),
  OnboardingData(
      imagePath: "assets/images/onboarding2.png",
      headline: "Search Blood Donor",
      description: "Give Life , Donate Blood Today"),
  OnboardingData(
      imagePath: "assets/images/onboarding3.png",
      headline: "Emergency Request",
      description: "Give Life , Donate Blood Today"),
  OnboardingData(
      imagePath: "assets/images/onboarding4.png",
      headline: "Save lives",
      description: " Be a hero in someone's story donate blood."),
];
