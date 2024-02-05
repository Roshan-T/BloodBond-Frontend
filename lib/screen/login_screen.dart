import 'package:bloodbond/controller/login_controller.dart';
import 'package:bloodbond/screen/auth/forgot_password_view.dart';
import 'package:bloodbond/screen/role_select.dart';
import 'package:flutter/material.dart';
import 'package:bloodbond/utils/constants.dart';
import 'package:bloodbond/screen/auth/custom_text_form_field.dart';
import 'package:bloodbond/utils/helper_function.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginController controller = Get.put(LoginController());
  String? emailErrorText;
  String? passwordErrorText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      //prevention of bottom pixel overflow when keyboard pop up
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            color: Constants.kWhiteColor,
            width: double.maxFinite,
            height: double.maxFinite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 70,
                ),
                Text("Welcome",
                    style: Theme.of(context).textTheme.displayLarge),
                const SizedBox(
                  height: 5,
                ),
                Text("Back!",
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          color: Constants.kPrimaryColor,
                        )),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Sign into your account",
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.8),
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
                const Text(
                  "Email",
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
                  controller: controller.emailController.value,
                  hintText: "Enter your email",
                  prefixIcon: Icons.email,
                  errorText: emailErrorText,
                ),
                const SizedBox(
                  height: 25,
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
                  controller: controller.passwordController.value,
                  hintText: "Create a strong password",
                  prefixIcon: Icons.lock,
                  errorText: passwordErrorText,
                ),
                const SizedBox(
                  height: 5,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: () {
                      Get.to(const ForgotPasswordScreen());
                    },
                    child: Text(
                      "Forgot Password?",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Constants.kPrimaryColor,
                          ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 60,
                  width: double.infinity,
                  child: Obx(
                    () => ElevatedButton(
                      onPressed: () async {
                        print(controller.passwordController.value.text);
                        //* check validation
                        // check email
                        if (!isEmailValid(
                            controller.emailController.value.text.trim())) {
                          emailErrorText = 'Please enter a valid email';
                        } else {
                          emailErrorText = null;
                          setState(() {});
                        }
                        // check password
                        if (controller.passwordController.value.text
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
                        // here all fields are validated
                        setState(() {
                          emailErrorText = null;
                          passwordErrorText = null;
                        });
                        controller.loginApi();
                        // login user
                      },
                      child: controller.loading.value
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text("Login"),
                    ),
                  ),
                ),
                const OptionalSignUpWidget()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OptionalSignUpWidget extends StatelessWidget {
  const OptionalSignUpWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account yet?",
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Constants.kBlackColor,
              ),
        ),
        TextButton(
          onPressed: () {
            Get.offAll(
              const RoleScreen(),
            );
          },
          child: Text(
            "Sign Up",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Constants.kPrimaryColor,
                ),
          ),
        ),
      ],
    );
  }
}
