import 'package:bloodbond/controller/emerequest_description.dart';
import 'package:bloodbond/controller/home_screen_controller.dart';
import 'package:bloodbond/widget/custom_stepper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

import '../utils/constants.dart';

class RequestDescrptionScreenHospital extends StatefulWidget {
  final EmergencyRequest emergencyRequest;
  const RequestDescrptionScreenHospital(
      {super.key, required this.emergencyRequest});

  @override
  State<RequestDescrptionScreenHospital> createState() =>
      _RequestDescrptionScreenHospitalState();
}

class _RequestDescrptionScreenHospitalState
    extends State<RequestDescrptionScreenHospital> {
  late EmergencyRequest request;
  late double latitude;
  late double longitude;

  var name;
  void initState() {
    super.initState();
    request = widget.emergencyRequest;

    var storage = GetStorage();
    latitude = storage.read('latitude');
    longitude = storage.read('longitude');
    name = storage.read('first_name');
  }

  @override
  Widget build(BuildContext context) {
    RequestController controller = Get.put(RequestController());
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Detail of Request",
          style: Get.textTheme.headlineSmall?.copyWith(
              color: Constants.kWhiteColor, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Constants.kWhiteColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: Get.height * 0.25,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(latitude, longitude),
                zoom: 10,
              ),
              markers: {
                Marker(
                    markerId: MarkerId("_sourceLocation"),
                    icon: BitmapDescriptor.defaultMarker,
                    position: LatLng(latitude, longitude)),
                //  Marker(
                //     markerId: MarkerId("_destionationLocation"),
                //     icon: BitmapDescriptor.defaultMarker,
                //     position: LatLng(latitude, longitude))
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.only(right: 10, left: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "Donation Details",
                  style: Get.textTheme.titleLarge,
                ),
                const Divider(
                  thickness: 0.5,
                  color: Constants.kBlackColor,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Patient Name: ${request.patientName}",
                  style: Get.textTheme.labelLarge,
                ),
                Row(
                  children: [
                    Text(
                      "Medical Problem: ${request.medicalCondition}",
                      style: Get.textTheme.labelLarge,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                ),
                Text(
                  "Location: ${request.hospital.city}",
                  style: Get.textTheme.labelLarge,
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "Requested Time: ${DateFormat('MMM d yyyy, HH:mm a').format(request.requestedTime)}",
                  style: Get.textTheme.labelLarge,
                ),
                Text(
                  "Needed Within: ${DateFormat('MMM d yyyy, HH:mm a').format(request.expiryTime)}",
                  style: Get.textTheme.labelLarge,
                ),
              ],
            ),
          ),
          const Spacer(),
          CustomStepper(
            accept: request.accepted,
            donated: request.donated,
          ),
          const Spacer(),
          Center(
            child: SizedBox(
              height: 60,
              width: Get.width * 0.8,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    controller.confirmDonate(request.id);
                  });
                },
                child: Text(
                  request.accepted == true ? "Received" : "Not Accepted",
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
