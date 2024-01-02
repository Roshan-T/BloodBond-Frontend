import 'package:flutter/material.dart';

class Constants {
  // Colors
  static const kPrimaryColor = Color.fromARGB(255, 198, 13, 0);
  static const kLightRed = Color.fromARGB(255, 252, 226, 226);
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

class Questions {
  final String question;
  bool? result;
  Questions({required this.question, this.result});
}

final ListQuestion = [
  Questions(
    question: "Do you have diabetes?",
  ),
  Questions(
    question: "Have you ever had problems in your heart?",
  ),
  Questions(
    question: "In the last 28 days, have you tested positive for COVID-19?",
  ),
  Questions(
    question: "Have you ever had a positive test for HIV/AIDS virus?",
  ),
  Questions(
    question: "Have you ever had a cancer?",
  ),
  Questions(
    question: "In last 3 months, have you had a vaccination?",
  ),
];

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

class DonorHistory {
  String imageUrl;
  DateTime time;
  String hospital;
  String location;
  String donatedto;
  DonorHistory(
      {required this.imageUrl,
      required this.time,
      required this.hospital,
      required this.location,
      required this.donatedto});
}

List<DonorHistory> donorHistory = [
  DonorHistory(
      imageUrl: "assets/images/onboarding1.png",
      time: DateTime.now(),
      hospital: "Manipal",
      location: "Pokhara",
      donatedto: "Rathore"),
  DonorHistory(
      imageUrl: "assets/images/onboarding2.png",
      time: DateTime.now(),
      hospital: "GMC",
      location: "Pokhara",
      donatedto: "GMC"),
  DonorHistory(
      imageUrl: "assets/images/onboarding1.png",
      time: DateTime.now(),
      hospital: "FewaCity",
      location: "Pokhara",
      donatedto: "Kalu Pandey"),
];
