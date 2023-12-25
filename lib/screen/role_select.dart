import 'package:bloodbond/screen/signup_screen.dart';
import 'package:bloodbond/utils/constants.dart';
import 'package:bloodbond/widget/role_choose.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RoleScreen extends StatefulWidget {
  const RoleScreen({super.key});

  @override
  State<RoleScreen> createState() => _RoleScreenState();
}

class _RoleScreenState extends State<RoleScreen> {
  bool isBeneficiary = true;
  bool isDonor = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: Constants.kHorizontalPadding, vertical: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: Image.asset('assets/images/onboarding4.png'),
              ),
              const SizedBox(
                height: 30,
              ),
              Column(
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Blood",
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                            text: "Bond🩸",
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(
                                    color: Constants.kPrimaryColor,
                                    fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Connecting Hearts - One Drop at a time",
                    style: TextStyle(
                      color: Constants.kGrey,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const SizedBox(
                height: 70,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Choose your role",
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // donor
              SizedBox(
                height: 80,
                child: GestureDetector(
                  onTap: () {
                    isBeneficiary = false;
                    if (!isDonor) {
                      isDonor = true;
                      setState(() {});
                    }
                  },
                  child: RoleChooseBox(
                    user: "Donor",
                    imageLocation: 'assets/images/onboarding1.png',
                    isSelected: isDonor,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // beneficiary
              SizedBox(
                height: 80,
                child: GestureDetector(
                  onTap: () {
                    isDonor = false;
                    if (!isBeneficiary) {
                      isBeneficiary = true;
                      setState(() {});
                    }
                  },
                  child: RoleChooseBox(
                    user: "Hospital",
                    imageLocation: 'assets/images/onboarding2.png',
                    isSelected: isBeneficiary,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                height: 60,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.to(
                    SignUpScreen(),
                  ),
                  child: const Text(
                    "Continue",
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
