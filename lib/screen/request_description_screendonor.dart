import 'dart:convert';

import 'package:bloodbond/controller/emerequest_description.dart';
import 'package:bloodbond/controller/home_screen_controller.dart';
import 'package:bloodbond/routes/url.dart';
import 'package:bloodbond/services/services.dart';
import 'package:bloodbond/utils/utils.dart';
import 'package:bloodbond/widget/timer_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class RequestDetail extends StatefulWidget {
  final EmergencyRequest emergencyRequest;
  const RequestDetail({super.key, required this.emergencyRequest});

  @override
  State<RequestDetail> createState() => _MapPageState();
}

class _MapPageState extends State<RequestDetail> {
  late EmergencyRequest request;
  late double latitude;
  late double longitude;
  var expiryTime;
  var name;
  Map<PolylineId, Polyline> polylines = {};

  @override
  void initState() {
    super.initState();
    request = widget.emergencyRequest;

    var storage = GetStorage();
    latitude = storage.read('latitude');
    longitude = storage.read('longitude');
    name = storage.read('first_name');
    expiryTime = request.expiryTime;

    // LatLng donorLat =
    //     LatLng(request.donor['latitude'], request.donor['longitude']);
    countdownController.startCountdown(request.expiryTime);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    countdownController.dispose();
  }

  final CountdownController countdownController = CountdownController();
  @override
  Widget build(BuildContext context) {
    RequestController controller = Get.put(RequestController());
    HomeController homeController = Get.put(HomeController());
    print("Accept:$request.accepted");
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                      markerId: const MarkerId("1"),
                      icon: BitmapDescriptor.defaultMarker,
                      position: LatLng(request.hospital.latitude.toDouble(),
                          request.hospital.latitude.toDouble()),
                      infoWindow: InfoWindow(title: request.hospital.name)),
                  Marker(
                      markerId: const MarkerId("2"),
                      icon: BitmapDescriptor.defaultMarker,
                      position: LatLng(latitude, longitude),
                      infoWindow: InfoWindow(title: name))
                },
                polylines: Set<Polyline>.of(polylines.values),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              padding: const EdgeInsets.only(right: 10, left: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Donation Details",
                    style: Get.textTheme.titleLarge,
                  ),
                  const Divider(
                    thickness: 0.5,
                    color: Constants.kBlackColor,
                  ),
                  const SizedBox(
                    height: 15,
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
                      const Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Constants.kBlackColor, width: 0.5),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Get.to(
                              FullScreen(
                                photoUrl: Url.getImage + request.report,
                              ),
                            );
                          },
                          child: Image.network(
                            Url.getImage + request.report,
                            fit: BoxFit.fill,
                            width: 50,
                            height: 50,
                          ),
                        ),
                      )
                    ],
                  ),
                  Text(
                    "Location: ${request.hospital.city}",
                    style: Get.textTheme.labelLarge,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Requested Time: ${DateFormat('MMM d yyyy, HH:mm a').format(request.requestedTime)}",
                    style: Get.textTheme.labelLarge,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Needed Within: ${DateFormat('MMM d yyyy, HH:mm a').format(request.expiryTime)}",
                    style: Get.textTheme.labelLarge,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Time Left",
                    style: Get.textTheme.headlineMedium,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Obx(() => TimerBox(
                          time:
                              "${countdownController.timeRemaining.value.inHours}",
                          timeDuration: "Hour")),
                      Obx(() => TimerBox(
                          time:
                              "${countdownController.timeRemaining.value.inMinutes % 60}",
                          timeDuration: "Min")),
                      Obx(() => TimerBox(
                          time:
                              "${countdownController.timeRemaining.value.inSeconds % 60}",
                          timeDuration: "Sec"))
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Center(
              child: SizedBox(
                  height: 60,
                  width: Get.width * 0.8,
                  child: Obx(
                    () => ElevatedButton(
                      onPressed: () {
                        setState(() {
                          controller.acceptRequest(request.id);
                          homeController.fetchEmergencyRequest();
                        });
                        // login user
                      },
                      child: controller.loading.value
                          ? const CircularProgressIndicator(color: Colors.white)
                          : (request.accepted
                              ? const Text("Accepted")
                              : const Text('Accept Request')),
                    ),
                  )
                  // ElevatedButton(
                  //   onPressed: null,
                  //   child: Text(
                  //     request.accepted ? "Accepted" : "Accept Request",
                  //   ),
                  // ),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class FullScreen extends StatelessWidget {
  FullScreen({super.key, required this.photoUrl});
  String photoUrl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Constants.kGrey,
      body: Center(
        child: InteractiveViewer(
          child: Image.network(
            photoUrl,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
