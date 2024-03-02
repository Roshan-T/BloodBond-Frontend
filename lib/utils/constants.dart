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

// class BloodCamp {
//   final String image;
//   final String datentime;
//   final String title;
//   final String description;
//   final String location;
//   final String phonenumber;
//   BloodCamp(this.description, this.location,
//       {required this.image,
//       required this.datentime,
//       required this.title,
//       required this.phonenumber});
// }

// List<BloodCamp> bloodCamp = [
//   BloodCamp(" This is fish", "Pokhara",
//       image: "assets/images/onboarding1.png",
//       datentime: "22.23 Monday",
//       title: "Basic blood bank",
//       phonenumber: "9844545488"),
//   BloodCamp(" This is fish", "Pokhara",
//       image: "assets/images/onboarding2.png",
//       datentime: "22.23 Monday",
//       title: "Basic  bank",
//       phonenumber: "9844545488"),
//   BloodCamp(" This is fish", "Pokhara",
//       image: "assets/images/onboarding3.png",
//       datentime: "22.23 Monday",
//       title: " Blood bank",
//       phonenumber: "9844545488"),
//   BloodCamp(
//       " Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
//       "Pokhara",
//       image: "assets/images/onboarding4.png",
//       datentime: "22.23 Monday",
//       title: " Bank Blood",
//       phonenumber: "9844545488"),
// ];

// class NearbyDonor {
//   final String Name;
//   final String ImagePath;
//   final String BloodGroup;
//   final int? phonenumber;

//   NearbyDonor(
//       {required this.Name,
//       required this.ImagePath,
//       required this.BloodGroup,
//       required this.phonenumber});
// }

// final DonorList = [
//   NearbyDonor(
//       Name: "Roshan vai",
//       ImagePath: "assets/images/onboarding1.png",
//       BloodGroup: "A+",
//       phonenumber: 980738388),
//   NearbyDonor(
//       Name: "Samir vai",
//       ImagePath: "assets/images/onboarding2.png",
//       BloodGroup: "O+",
//       phonenumber: 985738390),
//   NearbyDonor(
//       Name: "Shishir vai",
//       ImagePath: "assets/images/onboarding3.png",
//       BloodGroup: "AB+",
//       phonenumber: 980737373),
//   NearbyDonor(
//       Name: "Solti vai",
//       ImagePath: "assets/images/onboarding3.png",
//       BloodGroup: "AB+",
//       phonenumber: 980737373),
// ];

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

// class DonorHistory {
//   String imageUrl;
//   DateTime time;
//   String hospital;
//   String location;
//   String donatedto;
//   DonorHistory(
//       {required this.imageUrl,
//       required this.time,
//       required this.hospital,
//       required this.location,
//       required this.donatedto});
// }

// List<DonorHistory> donorHistory = [
//   DonorHistory(
//       imageUrl: "assets/images/onboarding1.png",
//       time: DateTime.now(),
//       hospital: "Manipal",
//       location: "Pokhara",
//       donatedto: "Rathore"),
//   DonorHistory(
//       imageUrl: "assets/images/onboarding2.png",
//       time: DateTime.now(),
//       hospital: "GMC",
//       location: "Pokhara",
//       donatedto: "GMC"),
//   DonorHistory(
//       imageUrl: "assets/images/onboarding1.png",
//       time: DateTime.now(),
//       hospital: "FewaCity",
//       location: "Pokhara",
//       donatedto: "Kalu Pandey"),
// ];

// class EmergencyRequest {
//   EmergencyRequest(
//       {required this.bloodGroup,
//       required this.patientName,
//       required this.medicalProblem,
//       required this.bloodUnit,
//       required this.address,
//       required this.time,
//       required this.imageUrl,
//       required this.gender,
//       required this.phoneNumber});

//   String bloodGroup;
//   String patientName;
//   String medicalProblem;
//   int bloodUnit;
//   String address;
//   DateTime time;
//   String imageUrl;
//   String gender;
//   int phoneNumber;
// }

// // List<EmergencyRequest> requests = [
//   EmergencyRequest(
//       phoneNumber: 9898989898,
//       bloodGroup: "A+",
//       patientName: "Munna Bhai",
//       medicalProblem: "Cancer",
//       bloodUnit: 2,
//       address: "Mars",
//       time: DateTime.now(),
//       imageUrl: "assets/images/onboarding2.png",
//       gender: "Male"),
//   EmergencyRequest(
//       phoneNumber: 9898989898,
//       bloodGroup: "A+",
//       patientName: "Munna Bhai",
//       medicalProblem: "Cancer",
//       bloodUnit: 2,
//       address: "Mars",
//       time: DateTime.now(),
//       imageUrl: "assets/images/onboarding2.png",
//       gender: "Male"),
//   EmergencyRequest(
//       phoneNumber: 9898989898,
//       bloodGroup: "A+",
//       patientName: "Munna Bhai",
//       medicalProblem: "Cancer",
//       bloodUnit: 2,
//       address: "Mars",
//       time: DateTime.now(),
//       imageUrl: "assets/images/onboarding2.png",
//       gender: "Male"),
//   EmergencyRequest(
//       phoneNumber: 9898989898,
//       bloodGroup: "A+",
//       patientName: "Munna Bhai",
//       medicalProblem: "Cancer",
//       bloodUnit: 2,
//       address: "Mars",
//       time: DateTime.now(),
//       imageUrl: "assets/images/onboarding2.png",
//       gender: "Male"),
// ];
