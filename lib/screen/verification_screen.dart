import 'package:bloodbond/services/services.dart';
import 'package:bloodbond/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class VerificationScreen extends StatefulWidget {
  final email;
  VerificationScreen({super.key, required this.email});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  var email;
  bool isFetching = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    email = widget.email;
  }

  TextEditingController pinController = TextEditingController();
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
                    "Enter the 6 digit verification code that has been sent to: $email",
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
                Pinput(
                  length: 6,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  controller: pinController,
                ),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  width: Get.width * 0.9,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        isFetching = true;
                      });
                      await ApiService.verfiyotp(
                          email, pinController.value.text);
                      setState(() {
                        isFetching = false;
                      });
                    },
                    child: isFetching
                        ? const CircularProgressIndicator()
                        : Text(
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
