import 'package:bloodbond/screen/bloodtype_selection.dart';
import 'package:bloodbond/screen/onboarding_screen.dart';
import 'dart:io';

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:bloodbond/widget/select_date.dart';
import 'package:bloodbond/widget/select_gender.dart';
import 'package:bloodbond/utils/constants.dart';
import 'package:bloodbond/widget/select_location.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  XFile? image;
  bool isFetchingLocation = false;

  Future<void> getImage() async {
    ImagePicker picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      image = pickedImage;
    });
  }

  String? latitude;
  String? longitude;
  String? city;

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
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
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
        return city as String?;
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
            child: Container(
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
                            hint_text: "First Name",
                            keyboard_type: TextInputType.name),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Textfield(
                            hint_text: "Last Name",
                            keyboard_type: TextInputType.name),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Textfield(
                      hint_text: "Email Address",
                      keyboard_type: TextInputType.emailAddress),
                  const SizedBox(
                    height: 15,
                  ),
                  Textfield(
                      hint_text: "Mobile Number",
                      keyboard_type: TextInputType.number),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: SelectGender(),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const SelectDate(),
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
                      latitude = position.latitude.toString();
                      longitude = position.longitude.toString();

                      city = await getNearestCity(
                          position.latitude, position.longitude);

                      setState(() {
                        isFetchingLocation = false;
                      });
                    },
                    readOnly: true,
                    decoration: InputDecoration(
                      suffixIcon: isFetchingLocation
                          ? const Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(),
                            )
                          : null,
                      isDense: true,
                      hintText: latitude == null ? "Select Location" : city,
                      hintStyle: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(color: Constants.kGrey),
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
                        Get.to(
                          () => BloodTypeSelectionScreen(),
                        );
                      },
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
      ),
    );
  }
}

class Textfield extends StatelessWidget {
  final String? hint_text;
  final TextInputType? keyboard_type;

  Textfield({
    required this.hint_text,
    required this.keyboard_type,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: false,
      keyboardType: keyboard_type,
      decoration: InputDecoration(
        isDense: true,
        hintText: hint_text,
        hintStyle: Theme.of(context)
            .textTheme
            .labelMedium!
            .copyWith(color: Constants.kGrey),
      ),
    );
  }
}
