import 'package:bloodbond/screen/bloodtype_selection.dart';
import 'dart:io';

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

  Future<void> getImage() async {
    ImagePicker picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      image = pickedImage;
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

//Position position =  Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
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
                      //Get.to(SelectLoc
                      //ation());
                      await _handleLocationPermission();
                      Position position = await Geolocator.getCurrentPosition(
                          desiredAccuracy: LocationAccuracy.high);
                      print(position.latitude);
                      print(position.longitude);
                    },
                    readOnly: true,
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: "Select Location",
                      hintStyle: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(color: Constants.kGrey),
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
  Textfield({required this.hint_text, required this.keyboard_type});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
