import 'package:bloodbond/controller/login_controller.dart';
import 'package:bloodbond/screen/auth/custom_text_form_field.dart';
import 'package:bloodbond/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePassword extends StatefulWidget {
  final email;
  const ChangePassword({super.key, required this.email});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  LoginController controller = Get.put(LoginController());
  var email;
  String? passwordErrorText;
  @override
  void initState() {
    super.initState();
    email = widget.email;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Container(
              color: Constants.kWhiteColor,
              width: double.maxFinite,
              //height: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 70,
                  ),
                  Text("Reset",
                      style: Theme.of(context).textTheme.displayLarge),
                  const SizedBox(
                    height: 5,
                  ),
                  Text("Password!",
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                            color: Constants.kPrimaryColor,
                          )),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Password",
                    style: TextStyle(
                      color: Constants.kBlackColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                    isPassword: true,
                    controller: controller.forgetPasswordController.value,
                    hintText: "Enter a new password",
                    prefixIcon: Icons.lock,
                    errorText: passwordErrorText,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 60,
                    width: double.infinity,
                    child: Obx(
                      () => ElevatedButton(
                        onPressed: () async {
                          if (controller.forgetPasswordController.value.text
                                  .trim()
                                  .length <
                              6) {
                            passwordErrorText =
                                'Password must have 6 characters or more';
                            setState(() {});
                            return;
                          } else {
                            passwordErrorText = null;
                            setState(() {});
                          }

                          setState(() {
                            passwordErrorText = null;
                          });
                          controller.resetPassword(email);
                          // login user
                        },
                        child: controller.loading.value
                            ? const CircularProgressIndicator(
                                color: Colors.white)
                            : const Text("Reset"),
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
