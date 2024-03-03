import 'dart:convert';

import 'package:bloodbond/controller/home_screen_controller.dart';
import 'package:bloodbond/routes/url.dart';
import 'package:bloodbond/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EmergencyRequestHistoryDescription extends StatefulWidget {
  EmergencyRequestHistoryDescription({super.key, required this.request});
  final EmergencyRequest request;
  @override
  State<EmergencyRequestHistoryDescription> createState() =>
      _EmergencyRequestHistoryDescriptionState();
}

class _EmergencyRequestHistoryDescriptionState
    extends State<EmergencyRequestHistoryDescription> {
  var request;
  @override
  void initState() {
    super.initState();
    request = widget.request;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Constants.kWhiteColor,
          elevation: 0,
          leading: IconButton(
            icon:
                const Icon(Icons.arrow_back_ios, color: Constants.kBlackColor),
            onPressed: () => Navigator.pop(context),
          ),
          centerTitle: false,
          title: Text(
            "Emergency Request ",
            style: Get.textTheme.headlineSmall?.copyWith(
                color: Constants.kBlackColor, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: Image.network(
                    Url.getImage + request.report,
                    fit: BoxFit.fill,
                    height: 200,
                    width: double.maxFinite,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Request Details",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    RequestDetailsContainer(request: request),
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomText extends StatelessWidget {
  final String topic;

  final String topicDetail;

  CustomText({super.key, required this.topic, required this.topicDetail});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            topic,
            style:
                Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 17),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            topicDetail,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Colors.grey, fontSize: 17),
          ),
        ),
      ],
    );
  }
}

class Details extends StatelessWidget {
  const Details({super.key, required this.request});
  final EmergencyRequest request;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CustomText(topic: "Patient Name  ", topicDetail: request.patientName),
        Divider(
          thickness: 1,
          color: Colors.grey.withOpacity(0.3),
        ),
        CustomText(topic: "Blood Group", topicDetail: request.bloodGroup),
        Divider(
          thickness: 1,
          color: Colors.grey.withOpacity(0.3),
        ),
        CustomText(
            topic: "Medical Condition", topicDetail: request.medicalCondition),
        Divider(
          thickness: 1,
          color: Colors.grey.withOpacity(0.3),
        ),
        CustomText(
            topic: "Donor Name",
            topicDetail: request.donor == null
                ? "_"
                : "${request.donor['first_name']} ${request.donor['last_name']}"),
        Divider(
          thickness: 1,
          color: Colors.grey.withOpacity(0.3),
        ),
        CustomText(
            topic: "Date",
            topicDetail: dateFormatter.format(request.requestedTime)),
        Divider(
          thickness: 1,
          color: Colors.grey.withOpacity(0.3),
        ),
        CustomText(
            topic: "Time ",
            topicDetail: timeFormatter.format(request.requestedTime)),
      ],
    );
  }
}

class RequestDetailsContainer extends StatelessWidget {
  const RequestDetailsContainer({super.key, required this.request});
  final EmergencyRequest request;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320,
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
        border: Border.all(
          color: Colors.grey.withOpacity(0.3),
          width: 1.0,
        ),
      ),
      child: Details(request: request),
    );
  }
}

DateFormat dateFormatter = DateFormat('yyyy-MM-dd');
DateFormat timeFormatter = DateFormat('HH:mm a');
