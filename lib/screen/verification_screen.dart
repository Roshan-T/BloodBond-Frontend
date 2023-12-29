import 'package:bloodbond/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back();
          },
        ),
        backgroundColor: Constants.kWhiteColor,
        elevation: 0,
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            height: double.maxFinite,
            width: double.maxFinite,
            color: Constants.kWhiteColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 25,
                ),
                Text("Verification",
                    style: Theme.of(context).textTheme.displayLarge),
                const SizedBox(
                  height: 5,
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                    textAlign: TextAlign.left,
                    "Enter the 5 digit verification code that has been sent to your email address samire10@gmail.com",
                    style: Theme.of(context).textTheme.labelLarge),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                    height: 250,
                    width: 500,
                    child: Image.asset("assets/images/Confirmed-cuate.png")),
                const SizedBox(
                  height: 30,
                ),
                const Pinput(
                  length: 6,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                ),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  width: Get.width * 0.9,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "Continue",
                      style: Get.textTheme.titleLarge
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
