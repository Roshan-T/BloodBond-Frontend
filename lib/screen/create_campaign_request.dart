import 'dart:io';

import 'package:bloodbond/controller/create_emergency_request_controller.dart';
import 'package:bloodbond/utils/constants.dart';
import 'package:bloodbond/widget/datetime_box.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../controller/create_campaign_controller.dart';

class CreateCampaginRequest extends StatefulWidget {
  const CreateCampaginRequest({super.key});

  @override
  State<CreateCampaginRequest> createState() => _CreateCampaginRequestState();
}

class _CreateCampaginRequestState extends State<CreateCampaginRequest> {
  bool _isAccepted = false;

  File? image;
  final _imagePicker = ImagePicker();
  selectImage() async {
    final choosedImage =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (choosedImage != null) {
      setState(() {
        image = File(choosedImage.path);
      });
    }
  }

  final TextEditingController campaignTitleController = TextEditingController();
  final TextEditingController campaginDescriptionController =
      TextEditingController();
  final TextEditingController campaignAddress = TextEditingController();
  final TextEditingController campaginCity = TextEditingController();
  final TextEditingController campaignDate = TextEditingController(
    text: DateFormat('yyyy-MM-dd').format(
      DateTime.now(),
    ),
  );

  final TextEditingController campaignTime = TextEditingController(
    text: DateFormat('h:mm a').format(
      DateTime.now(),
    ),
  );
  DateTime convertDateTime(String inputDate, String inputTime) {
    String dateText = inputDate;
    String timeText = inputTime;

    // Parse the date and time using the same formats
    DateTime date = DateFormat('yyyy-MM-dd').parse(dateText);
    DateTime time = DateFormat('h:mm a').parse(timeText);

    // Combine date and time to create a new DateTime
    DateTime combinedDateTime = date.add(Duration(
      hours: time.hour,
      minutes: time.minute,
    ));

    return combinedDateTime;
  }

  @override
  void dispose() {
    super.dispose();
    campaignTitleController.dispose();
    // _bloodUnit.dispose();
    campaignDate.dispose();
    campaignAddress.dispose();
    campaginDescriptionController.dispose();
    campaginCity.dispose();
    campaignTime.dispose();
    controller.dispose();
  }

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

  void showSnackBar(String title, String subtitle) {
    Get.closeAllSnackbars();
    Get.snackbar(
      title,
      subtitle,
      colorText: Colors.white,
      duration: const Duration(seconds: 1),
      backgroundColor: Constants.kPrimaryColor,
      icon: const Icon(
        Icons.error,
        color: Constants.kWhiteColor,
      ),
    );
  }

  timeSelect(BuildContext context, TextEditingController controller) async {
    final TimeOfDay presentTime = TimeOfDay.now();
    final TimeOfDay? choosedTime = await showTimePicker(
      context: context,
      initialTime: presentTime,
    );
    if (choosedTime != null) {
      final now = DateTime.now();
      final DateTime pickedDateTime = DateTime(
          now.year, now.month, now.day, choosedTime.hour, choosedTime.minute);
      controller.text = DateFormat('h:mm a').format(pickedDateTime);
    }
    setState(() {});
  }

  CreateCampaginController controller = Get.put(CreateCampaginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.kWhiteColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Constants.kBlackColor),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: false,
        title: Text(
          "Campagin Create",
          style: Get.textTheme.headlineSmall?.copyWith(
              color: Constants.kBlackColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: Constants.kHorizontalPadding),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(
                  height: 5,
                  color: Constants.kBlackColor,
                ),

                const SizedBox(
                  height: 15,
                ),
                Text(
                  "Campaign's Title",
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Constants.kGrey, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  keyboardType: TextInputType.name,
                  controller: campaignTitleController,
                  decoration: InputDecoration(
                    hintText: "Enter the campaigns title",
                    hintStyle: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: Constants.kGrey),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "Description",
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Constants.kGrey, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  keyboardType: TextInputType.name,
                  controller: campaginDescriptionController,
                  decoration: InputDecoration(
                    hintText: "Enter the campaign description",
                    hintStyle: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: Constants.kGrey),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                // *

                Text(
                  "City",
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Constants.kGrey, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  keyboardType: TextInputType.name,
                  controller: campaginCity,
                  decoration: InputDecoration(
                    hintText: "Enter the city",
                    hintStyle: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: Constants.kGrey),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Full Address",
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Constants.kGrey, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  keyboardType: TextInputType.name,
                  controller: campaignAddress,
                  decoration: InputDecoration(
                    hintText: "Enter the full address",
                    hintStyle: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: Constants.kGrey),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    DateTimeBox(
                      dateTime: campaignDate.text,
                      onPressed: () {
                        dateSelect(context, campaignDate);
                      },
                      type: "Campaign Date",
                      icon: const Icon(
                        Icons.calendar_month,
                        color: Constants.kPrimaryColor,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    DateTimeBox(
                      dateTime: campaignTime.text,
                      onPressed: () {
                        timeSelect(context, campaignTime);
                      },
                      type: "Campaign Time",
                      icon: const Icon(
                        Icons.access_time,
                        color: Constants.kPrimaryColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),

                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Banner",
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Constants.kGrey, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                // DottedBorder(
                // child:
                SizedBox(
                  height: 60,
                  width: 60,
                  child: image == null
                      ? IconButton(
                          onPressed: selectImage,
                          icon: const Icon(Icons.add_a_photo),
                        )
                      : kIsWeb
                          ? Image.network(image!.path)
                          : Image.file(
                              image!,
                              fit: BoxFit.fill,
                            ),
                ),
                // ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Checkbox(
                      activeColor: Constants.kPrimaryColor,
                      value: _isAccepted,
                      onChanged: (bool? value) {
                        setState(
                          () {
                            _isAccepted = value!;
                          },
                        );
                      },
                    ),
                    Expanded(
                      child: Text(
                        "I assure that all the details are valid.",
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            color: Constants.kGrey,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 60,
                  width: double.infinity,
                  child: Obx(
                    () => ElevatedButton(
                      onPressed: () {
                        if (campaignTitleController.text.isEmpty) {
                          return showSnackBar(
                              "Please Enter the campaign title", "");
                        }

                        if (campaginDescriptionController.text.isEmpty) {
                          return showSnackBar(
                              "Please enter the campagin description", "");
                          // } else if (_bloodUnit.text.isEmpty) {
                          //   return showSnackBar("Blood Unit can't be empty", "");
                        } else if (image == null) {
                          return showSnackBar("Please provide the banner", "");
                        } else if (campaignAddress.text.isEmpty) {
                          return showSnackBar(
                              "Please provide the full address", "");
                        } else if (campaginCity.text.isEmpty) {
                          return showSnackBar("Please provide the city", "");
                        } else if (_isAccepted == false) {
                          return showSnackBar(
                              "Please accept the terms and conditions", "");
                        }

                        controller.emergencyRequest(
                            campaignTitleController.text,
                            campaginDescriptionController.text,
                            campaginCity.text,
                            campaignAddress.text,
                            convertDateTime(
                              campaignDate.text,
                              campaignTime.text,
                            ),
                            image);
                      },
                      child: controller.loading.value
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text("Save"),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
