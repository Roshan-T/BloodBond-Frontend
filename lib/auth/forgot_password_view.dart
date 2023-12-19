import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:bloodbond/auth/custom_text_form_field.dart';
import 'package:bloodbond/utils/utils.dart';

//import 'auth_controller.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController = TextEditingController();
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
                    controller: emailController,
                    hintText: "Enter your email",
                    errorText: errorText,
                    prefixIcon: Icons.email,
                  ),
                  const SizedBox(height: 50.0),
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                        onPressed: () {
                          if (!isEmailValid(emailController.text)) {
                            errorText = "Please enter a valid email";
                            setState(() {});
                            return;
                          }
                          setState(() {
                            errorText = null;
                          });

                          //context
                          // .read<AuthController>()
                          //.resetPassword(context, emailController.text);
                        },
                        child: const Text("Reset Password")),
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
