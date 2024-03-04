import 'package:bloodbond/controller/Signup_controller.dart';
import 'package:bloodbond/screen/bloodtype_selection.dart';
import 'package:bloodbond/screen/login_screen.dart';
import 'package:bloodbond/utils/helper_function.dart';

//import 'package:bloodbond/screen/onboarding_screen.dart';
import 'dart:io';

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:bloodbond/widget/select_date.dart';
import 'package:bloodbond/widget/select_gender.dart';
import 'package:bloodbond/utils/constants.dart';
//import 'package:bloodbond/widget/select_location.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

SignUpController signupController = Get.put(SignUpController());

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  File? image;
  bool isFetchingLocation = false;
  @override
  dispose() {
    super.dispose();
    signupController.dispose();
  }
  // TextEditingController lastNameController = TextEditingController();
  // TextEditingController passwordController = TextEditingController();
  // TextEditingController emailController = TextEditingController();
  // TextEditingController mobileController = TextEditingController();

  final TextEditingController requestedDate = TextEditingController(
    text: DateFormat('yyyy-MM-dd').format(
      DateTime.now(),
    ),
  );

  dateSelect(BuildContext context, TextEditingController controller) async {
    final DateTime todayDate = DateTime.now();
    final DateTime? choosedDate = await showDatePicker(
      context: context,
      initialDate: todayDate,
      firstDate: todayDate,
      lastDate: DateTime(2025),
    );
    if (choosedDate != null) {
      controller.text = DateFormat('yyyy-MM-dd').format(choosedDate);
    }
    setState(() {});
  }

  Future<void> getImage() async {
    ImagePicker picker = ImagePicker();
    var pickedImage = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      image = File(pickedImage!.path);
    });
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<String?> getNearestCity(double latitude, double longitude) async {
    final apiUrl =
        'https://nominatim.openstreetmap.org/reverse?format=json&lat=$latitude&lon=$longitude';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body);
        final address = decodedData['address'] as Map<String, dynamic>;
        final city = address['city'];
        return city as String;
      }
    } catch (e) {
      print('Error: $e');
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  GestureDetector(
                    onTap: getImage,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.grey,
                      child: image == null
                          ? const Icon(
                              Icons.photo_camera,
                              size: 30,
                            )
                          : ClipOval(
                              child: Image.file(
                                File(image!.path),
                                fit: BoxFit.cover,
                                width: 100,
                                height: 100,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Textfield(
                            hinttext: "First Name",
                            control: signupController.firstnamecontroller.value,
                            keyboardtype: TextInputType.name),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Textfield(
                            hinttext: "Last Name",
                            control: signupController.lastnamecontroller.value,
                            keyboardtype: TextInputType.name),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Textfield(
                      hinttext: "Email Address",
                      control: signupController.emailcontroller.value,
                      keyboardtype: TextInputType.emailAddress),
                  const SizedBox(
                    height: 15,
                  ),
                  Textfield(
                    hinttext: "Password",
                    control: signupController.passwordcontroller.value,
                    keyboardtype: TextInputType.text,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Textfield(
                      hinttext: "Mobile Number",
                      maxilength: 10,
                      control: signupController.phonecontroller.value,
                      keyboardtype: TextInputType.number),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      const Expanded(
                        child: SelectGender(),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {},
                          child: const SelectDate(
                            datename: "Date Of Birth",
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextField(
                    onTap: () async {
                      setState(() {
                        isFetchingLocation = true;
                      });

                      //  Get.to(SelectLocation());

                      await _handleLocationPermission();
                      Position position = await Geolocator.getCurrentPosition(
                          desiredAccuracy: LocationAccuracy.high);
                      signupController.lat = position.latitude;
                      signupController.long = position.longitude;

                      signupController.city = await getNearestCity(
                          position.latitude, position.longitude);

                      setState(() {
                        isFetchingLocation = false;
                      });
                    },
                    readOnly: true,
                    decoration: InputDecoration(
                      errorMaxLines: 1,
                      errorStyle: const TextStyle(
                        fontSize: 16,
                        color: Colors.red,
                      ),
                      fillColor: Constants.kPrimaryColor.withOpacity(0.1),
                      filled: true,
                      enabledBorder: _getBorder(
                          Constants.kPrimaryColor.withOpacity(0.4), 1.5),
                      focusedBorder: _getBorder(
                          Constants.kPrimaryColor.withOpacity(0.6), 2.5),
                      errorBorder: _getBorder(Constants.kErrorColor, 1.5),
                      focusedErrorBorder:
                          _getBorder(Constants.kErrorColor, 2.5),
                      suffixIcon: isFetchingLocation
                          ? const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(),
                            )
                          : null,
                      isDense: true,
                      hintText: signupController.city ?? "Select Location",
                      hintStyle: TextStyle(
                        fontSize: 16,
                        color: Colors.black.withOpacity(0.7),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                    width: Get.width * 0.9,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        if (signupController
                                .firstnamecontroller.value.text.isEmpty ||
                            signupController
                                .lastnamecontroller.value.text.isEmpty ||
                            signupController
                                .passwordcontroller.value.text.isEmpty ||
                            signupController
                                .emailcontroller.value.text.isEmpty ||
                            signupController
                                .phonecontroller.value.text.isEmpty ||
                            requestedDate.text.isEmpty) {
                          // Display an error message or handle the case where not all fields are filled

                          Get.snackbar(
                            "Please fill all the fields ",
                            "",
                            colorText: Colors.white,
                            backgroundColor: Constants.kPrimaryColor,
                          );
                        } else if (!isEmailValid(signupController
                            .emailcontroller.value.text
                            .trim())) {
                          Get.snackbar(
                            "Error!",
                            "Enter a valid email",
                            colorText: Colors.white,
                            backgroundColor: Constants.kPrimaryColor,
                          );
                        } else if (signupController
                                .passwordcontroller.value.text
                                .trim()
                                .length <
                            6) {
                          Get.snackbar(
                            "Error!",
                            "Enter valid password",
                            colorText: Colors.white,
                            backgroundColor: Constants.kPrimaryColor,
                          );
                        } else {
                          Get.to(
                            () => BloodTypeSelectionScreen(images: image),
                          );
                        }
                      },
                      child: Text(
                        "Continue",
                        style: Get.textTheme.titleLarge
                            ?.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: Constants.kBlackColor,
                            ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.to(const LoginScreen());
                        },
                        child: Text("Login",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Constants.kPrimaryColor,
                                )),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputBorder _getBorder(Color color, double width) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color, width: width),
      borderRadius: const BorderRadius.all(
        Radius.circular(12),
      ),
    );
  }
}

class Textfield extends StatelessWidget {
  final String? hinttext;
  final TextInputType? keyboardtype;
  final TextEditingController? control;
  final int? maxilength;

  const Textfield({
    super.key,
    required this.hinttext,
    required this.keyboardtype,
    required this.control,
    this.maxilength,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLength: maxilength,
      readOnly: false,
      keyboardType: keyboardtype,
      controller: control,
      decoration: InputDecoration(
          counterText: "",
          hintText: hinttext,
          hintStyle: TextStyle(
            fontSize: 16,
            color: Colors.black.withOpacity(0.7),
          ),
          errorMaxLines: 1,
          errorStyle: const TextStyle(
            fontSize: 16,
            color: Colors.red,
          ),
          fillColor: Constants.kPrimaryColor.withOpacity(0.1),
          filled: true,
          enabledBorder:
              _getBorder(Constants.kPrimaryColor.withOpacity(0.4), 1.5),
          focusedBorder:
              _getBorder(Constants.kPrimaryColor.withOpacity(0.6), 2.5),
          errorBorder: _getBorder(Constants.kErrorColor, 1.5),
          focusedErrorBorder: _getBorder(Constants.kErrorColor, 2.5)),
    );
  }

  InputBorder _getBorder(Color color, double width) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color, width: width),
      borderRadius: const BorderRadius.all(
        Radius.circular(12),
      ),
    );
  }
}
