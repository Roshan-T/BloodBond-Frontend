import 'package:bloodbond/widget/custom_stepper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../utils/constants.dart';

class RequestDescrptionScreenHospital extends StatefulWidget {
  const RequestDescrptionScreenHospital({super.key});

  @override
  State<RequestDescrptionScreenHospital> createState() =>
      _RequestDescrptionScreenHospitalState();
}

class _RequestDescrptionScreenHospitalState
    extends State<RequestDescrptionScreenHospital> {
  bool isReceived = false;
  static const LatLng _pGooglePlex = LatLng(37.4223, -122.0848);
  static const LatLng _pApplePark = LatLng(37.3346, -122.0090);
  @override
  Widget build(BuildContext context) {
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
              initialCameraPosition: const CameraPosition(
                target: _pGooglePlex,
                zoom: 10,
              ),
              markers: {
                const Marker(
                    markerId: MarkerId("_sourceLocation"),
                    icon: BitmapDescriptor.defaultMarker,
                    position: _pGooglePlex),
                const Marker(
                    markerId: MarkerId("_destionationLocation"),
                    icon: BitmapDescriptor.defaultMarker,
                    position: _pApplePark)
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
                  "Patient Name: " + "Roshan Tiwari",
                  style: Get.textTheme.labelLarge,
                ),
                Row(
                  children: [
                    Text(
                      "Medical Problem: " + "Nothing AS SUCH",
                      style: Get.textTheme.labelLarge,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                ),
                Text(
                  "Location: " + "Pokhara",
                  style: Get.textTheme.labelLarge,
                ),
                Text(
                  "Requested Time: " + "2024/10/24 , 4:30 PM",
                  style: Get.textTheme.labelLarge,
                ),
                Text(
                  "Needed Within: " + "2024/10/24 , 4:30 PM",
                  style: Get.textTheme.labelLarge,
                ),
              ],
            ),
          ),
          const Spacer(),
          const CustomStepper(),
          const Spacer(),
          Center(
            child: SizedBox(
              height: 60,
              width: Get.width * 0.8,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    !isReceived;
                  });
                },
                child: Text(
                  "Received",
                  style: TextStyle(
                      fontWeight:
                          isReceived ? FontWeight.bold : FontWeight.normal),
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
