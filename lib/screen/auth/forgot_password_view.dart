import 'package:bloodbond/controller/forget_password_controller.dart';
import 'package:bloodbond/screen/verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'package:bloodbond/screen/auth/custom_text_form_field.dart';
import 'package:bloodbond/utils/utils.dart';

//import 'auth_controller.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  ForgetPasswordController controller = Get.put(ForgetPasswordController());
  String? errorText;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: <Widget>[
                  LottieBuilder.asset('assets/images/json/forgot-password.json',
                      height: 200),
                  const SizedBox(height: 20.0),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Forgot Password?",
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge!
                          .copyWith(fontSize: 20),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  CustomTextFormField(
                    controller: controller.emailController.value,
                    hintText: "Enter your email",
                    errorText: errorText,
                    prefixIcon: Icons.email,
                  ),
                  const SizedBox(height: 50.0),
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: Obx(
                      () => ElevatedButton(
                        onPressed: () {
                          if (!isEmailValid(
                              controller.emailController.value.text)) {
                            errorText = "Please enter a valid email";
                            setState(() {});
                            return;
                          }

                          setState(() {
                            errorText = null;
                          });
                          controller.forgetPassword();
                        },
                        child: controller.loading.value
                            ? const CircularProgressIndicator(
                                color: Colors.white)
                            : const Text("Reset Password"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
