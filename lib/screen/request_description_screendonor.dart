import 'package:bloodbond/utils/utils.dart';
import 'package:bloodbond/widget/timer_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  static const LatLng _pGooglePlex = LatLng(37.4223, -122.0848);
  static const LatLng _pApplePark = LatLng(37.3346, -122.0090);

  Map<PolylineId, Polyline> polylines = {};

  Duration remainingTime =
      DateTime(2024, 1, 5, 24, 00, 0).difference(DateTime.now());

  @override
  void initState() {
    super.initState();
    countdownController.startCountdown(DateTime(2024, 12, 30, 24, 00, 0));
  }

  bool isAccepted = false;
  final CountdownController countdownController = CountdownController();

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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Constants.kBlackColor, width: 0.5),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Get.to(
                              FullScreen(
                                photoUrl: "assets/images/onboarding4.png",
                              ),
                            );
                          },
                          child: Image.asset(
                            "assets/images/onboarding4.png",
                            fit: BoxFit.cover,
                            width: 50,
                            height: 50,
                          ),
                        ),
                      )
                    ],
                  ),
                  Text(
                    "Location: " + "Pokhara",
                    style: Get.textTheme.labelLarge,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Requested Time: " + "2024/10/24 , 4:30 PM",
                    style: Get.textTheme.labelLarge,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Needed Within: " + "2024/10/24 , 4:30 PM",
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
                              "${countdownController.timeRemaining.value.inHours % 24}",
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
                child: ElevatedButton(
                  onPressed: null,
                  child: Text(
                    isAccepted ? "Accepted" : "Accept Request",
                  ),
                ),
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
          child: Image.asset(
            photoUrl,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
