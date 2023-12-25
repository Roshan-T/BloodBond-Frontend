import 'package:bloodbond/screen/onboarding_screen.dart';
import 'package:bloodbond/screen/signup_screen.dart';
import 'package:bloodbond/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BloodTypeSelectionScreen extends StatefulWidget {
  @override
  _BloodTypeSelectionScreenState createState() =>
      _BloodTypeSelectionScreenState();
}

class _BloodTypeSelectionScreenState extends State<BloodTypeSelectionScreen> {
  String selectedBloodType = "";
  String selectedBloodRh = "";

  void updateSelection(String bloodType) {
    setState(() {
      selectedBloodType = bloodType;
    });
  }

  void togglePositiveSelection(String text) {
    setState(() {
      selectedBloodRh = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.kWhiteColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.to(
              () => const SignUpScreen(),
            );
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        centerTitle: true,
        title: Text(
          "Pick Your Blood Group",
          style: Get.textTheme.headlineSmall?.copyWith(
              color: Constants.kBlackColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildBloodTypeButton("A", Constants.kLightRed),
                _buildBloodTypeButton("B", Constants.kLightRed),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildBloodTypeButton("AB", Constants.kLightRed),
                _buildBloodTypeButton("O", Constants.kLightRed),
              ],
            ),
            _buildBloodTypeButton("HH", Constants.kLightRed),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildRhButton("+", Constants.kLightRed),
                _buildRhButton("-", Constants.kLightRed),
              ],
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: Get.width * 0.8,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  if (selectedBloodType.isEmpty || selectedBloodRh.isEmpty) {
                    Get.snackbar(
                      "Please Select Your Blood Group!",
                      "",
                      colorText: Colors.white,
                      duration: const Duration(seconds: 1),
                      backgroundColor: Constants.kPrimaryColor,
                      icon: const Icon(
                        Icons.error,
                        color: Constants.kWhiteColor,
                      ),
                    );
                  } else {
                    Get.to(
                      () => OnboardingScreen(),
                    );
                  }
                },
                child: Text(
                  "Continue",
                  style:
                      Get.textTheme.titleLarge?.copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBloodTypeButton(String bloodType, Color color) {
    bool isSelected = selectedBloodType == bloodType;

    return GestureDetector(
      onTap: () => updateSelection(bloodType),
      child: Container(
        margin: const EdgeInsets.all(12),
        width: Get.width * 0.40,
        height: Get.height * 0.15,
        decoration: BoxDecoration(
          color: isSelected ? Constants.kPrimaryColor : color,
          borderRadius: BorderRadius.circular(8),
          border: isSelected
              ? Border.all(color: Colors.black, width: 1)
              : Border.all(color: Colors.transparent),
        ),
        child: Center(
          child: Text(
            bloodType,
            style: TextStyle(
              color:
                  isSelected ? Constants.kWhiteColor : Constants.kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRhButton(String text, Color color) {
    bool isSelected = selectedBloodRh == text;
    return GestureDetector(
      onTap: () {
        togglePositiveSelection(text);
      },
      child: Container(
        margin: const EdgeInsets.all(12),
        width: 75,
        height: 75,
        decoration: BoxDecoration(
          color: isSelected ? Constants.kPrimaryColor : Constants.kLightRed,
          borderRadius: BorderRadius.circular(8),
          border: isSelected
              ? Border.all(color: Colors.black, width: 1)
              : Border.all(color: Colors.transparent),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color:
                  isSelected ? Constants.kWhiteColor : Constants.kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
