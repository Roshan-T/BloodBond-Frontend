import 'dart:io';

import 'package:bloodbond/controller/create_emergency_request_controller.dart';
import 'package:bloodbond/utils/constants.dart';
import 'package:bloodbond/widget/datetime_box.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class CreateEmergencyRequest extends StatefulWidget {
  const CreateEmergencyRequest({super.key});

  @override
  State<CreateEmergencyRequest> createState() => _CreateEmergencyRequestState();
}

class _CreateEmergencyRequestState extends State<CreateEmergencyRequest> {
  String selectedBloodType = '';

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

  final TextEditingController patientNameController = TextEditingController();
  final TextEditingController medicalProblemController =
      TextEditingController();
  // final TextEditingController _bloodUnit = TextEditingController();
  final TextEditingController requestedDate = TextEditingController(
    text: DateFormat('yyyy-MM-dd').format(
      DateTime.now(),
    ),
  );
  final TextEditingController requestedTime = TextEditingController(
    text: DateFormat('h:mm a').format(
      DateTime.now(),
    ),
  );
  final TextEditingController expirationDate = TextEditingController(
    text: DateFormat('yyyy-MM-dd').format(
      DateTime.now(),
    ),
  );
  final TextEditingController expirationTime = TextEditingController(
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
    patientNameController.dispose();
    // _bloodUnit.dispose();
    requestedDate.dispose();
    requestedTime.dispose();
    expirationDate.dispose();
    expirationTime.dispose();
    medicalProblemController.dispose();
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

  void updateSelection(String bloodType) {
    setState(() {
      selectedBloodType = bloodType;
    });
  }

  CreateEmergencyRequestController controller =
      Get.put(CreateEmergencyRequestController());
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
          "Emergency Request",
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
                  "Select Blood Group",
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Constants.kGrey, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 75,
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildBloodTypeButton("A+", Constants.kLightRed),
                      ),
                      Expanded(
                        child: _buildBloodTypeButton("B+", Constants.kLightRed),
                      ),
                      Expanded(
                        child:
                            _buildBloodTypeButton("AB+", Constants.kLightRed),
                      ),
                      Expanded(
                        child: _buildBloodTypeButton("O+", Constants.kLightRed),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 75,
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildBloodTypeButton("A-", Constants.kLightRed),
                      ),
                      Expanded(
                        child: _buildBloodTypeButton("B-", Constants.kLightRed),
                      ),
                      Expanded(
                        child:
                            _buildBloodTypeButton("AB-", Constants.kLightRed),
                      ),
                      Expanded(
                        child: _buildBloodTypeButton("O-", Constants.kLightRed),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "Patient Name",
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Constants.kGrey, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  keyboardType: TextInputType.name,
                  controller: patientNameController,
                  decoration: InputDecoration(
                    hintText: "Enter the patient name",
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
                  "Medical Problem",
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Constants.kGrey, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  keyboardType: TextInputType.name,
                  controller: medicalProblemController,
                  decoration: InputDecoration(
                    hintText: "Enter the medical problem",
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
                      dateTime: requestedDate.text,
                      onPressed: () {
                        dateSelect(context, requestedDate);
                      },
                      type: "Requested Date",
                      icon: const Icon(
                        Icons.calendar_month,
                        color: Constants.kPrimaryColor,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    DateTimeBox(
                      dateTime: requestedTime.text,
                      onPressed: () {
                        timeSelect(context, requestedTime);
                      },
                      type: "Requested Time",
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
                Row(
                  children: [
                    DateTimeBox(
                      dateTime: expirationDate.text,
                      onPressed: () {
                        dateSelect(context, expirationDate);
                      },
                      type: "Expiration Date",
                      icon: const Icon(
                        Icons.calendar_month,
                        color: Constants.kPrimaryColor,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    DateTimeBox(
                      dateTime: expirationTime.text,
                      onPressed: () {
                        timeSelect(context, expirationTime);
                      },
                      type: "Expiration Time",
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
                Text(
                  "Medical Document",
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
                        if (selectedBloodType.isEmpty) {
                          return showSnackBar(
                              "Please Select Your Blood Group", "");
                        }

                        if (patientNameController.text.isEmpty) {
                          return showSnackBar(
                              "Please enter the patient name", "");
                          // } else if (_bloodUnit.text.isEmpty) {
                          //   return showSnackBar("Blood Unit can't be empty", "");
                        } else if (image == null) {
                          return showSnackBar(
                              "Please provide the medical document", "");
                        } else if (medicalProblemController.text.isEmpty) {
                          return showSnackBar(
                              "Please provide the medical problem", "");
                        } else if (_isAccepted == false) {
                          return showSnackBar(
                              "Please accept the terms and conditions", "");
                        }

                        controller.emergencyRequest(
                            selectedBloodType,
                            patientNameController.text,
                            medicalProblemController.text,
                            convertDateTime(
                              requestedDate.text,
                              requestedTime.text,
                            ),
                            convertDateTime(
                              expirationDate.text,
                              expirationTime.text,
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

  Widget _buildBloodTypeButton(String bloodType, Color color) {
    bool isSelected = selectedBloodType == bloodType;

    return GestureDetector(
      onTap: () => updateSelection(bloodType),
      child: Container(
        margin: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? Constants.kPrimaryColor : color,
          borderRadius: BorderRadius.circular(8),
          border: isSelected
              ? Border.all(color: Colors.black, width: 1)
              : Border.all(color: Colors.transparent),
        ),
        child: Center(
          child: Text(
            bloodType,
            style: TextStyle(
              fontSize: 25,
              color:
                  isSelected ? Constants.kWhiteColor : Constants.kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
