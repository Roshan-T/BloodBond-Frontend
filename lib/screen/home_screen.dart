
import 'package:bloodbond/controller/home_screen_controller.dart';
import 'package:bloodbond/routes/url.dart';
import 'package:bloodbond/screen/nearby_donor_screen.dart';
import 'package:bloodbond/utils/constants.dart';
import 'package:bloodbond/widget/blood_camp.dart';
import 'package:bloodbond/widget/emergency_request_box.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class HomeScreen extends StatelessWidget {
  var storage;
  var first_name;
  var image;

  HomeScreen({super.key}) {
    storage = GetStorage();
    first_name = storage.read('first_name');
    image = storage.read('image');
  }

//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     //Remove this method to stop OneSignal Debugging
//     OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

//     OneSignal.initialize("6e156e67-f308-49c1-a830-2ad88c8de8d3");

// // The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
//     OneSignal.Notifications.requestPermission(true);
//   }
  @override
  Widget build(BuildContext context) {
    // storage = GetStorage();
    // first_name = storage.read('first_name');
    // image = storage.read('image');
    final HomeController requestController = Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Constants.kWhiteColor,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipOval(
            child: Image.network(
              Url.getImage + image,
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(
          "Hi $first_name ,",
          textAlign: TextAlign.start,
          style: Get.textTheme.titleLarge?.copyWith(
              color: Constants.kBlackColor, fontWeight: FontWeight.bold),
        ),
        actions: const [
          IconButton(
            onPressed: null,
            icon: Icon(
              Icons.notifications_active_rounded,
              color: Constants.kPrimaryColor,
              size: 30,
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Row(
                //   children: [
                //     Padding(
                //       padding: const EdgeInsets.all(8.0),
                //       child: CircleAvatar(
                //         radius: 22,
                //         child: ClipOval(
                //           child: Image.network(
                //             Url.getImage + image,
                //             height: 45,
                //             width: 44,
                //             fit: BoxFit.fill,
                //           ),
                //         ),
                //       ),
                //     ),
                //     const SizedBox(
                //       width: 8,
                //     ),
                //     Column(
                //       children: [
                //         Text(
                //           // ignore: prefer_interpolation_to_compose_strings
                //           "Hi $first_name ,",
                //           textAlign: TextAlign.start,
                //           style: Get.textTheme.titleLarge?.copyWith(
                //               color: Constants.kBlackColor,
                //               fontWeight: FontWeight.bold),
                //         ),
                //         const SizedBox(
                //           height: 8,
                //         ),
                //         Text(
                //           "Welcome Back",
                //           style: Get.textTheme.labelMedium?.copyWith(
                //             color: Constants.kBlackColor,
                //           ),
                //         )
                //       ],
                //     ),
                //     const Spacer(),
                //     const IconButton(
                //       onPressed: null,
                //       icon: Icon(
                //         Icons.notifications_active_rounded,
                //         color: Constants.kPrimaryColor,
                //         size: 30,
                //       ),
                //     )
                //   ],
                // ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Upcoming bootcamp",
                  style: Get.textTheme.displayLarge
                      ?.copyWith(color: Constants.kBlackColor, fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 250,
                  child: ListView.separated(
                      physics: const ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return CampTile(campers: bloodCamp[index]);
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          width: 10,
                        );
                      },
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: bloodCamp.length),
                ),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    Get.to(
                      NearbyDonorScreen(),
                    );
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.green),
                    ),
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        children: [
                          const Icon(Icons.search_rounded),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                            "Nearby Donors",
                            style: Get.textTheme.labelLarge,
                          )
                        ],
                      ),
                    ),

                    // decoration: InputDecoration(
                    //   prefixIcon: const Icon(
                    //     Icons.search_rounded,
                    //   ),
                    //   hintText: "Nearby Donors",
                    //   border: OutlineInputBorder(
                    //     borderRadius: BorderRadius.circular(12),
                    //   ),
                    // ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "Emergency Request",
                  style: Get.textTheme.displayLarge
                      ?.copyWith(color: Constants.kBlackColor, fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                GetBuilder<HomeController>(
                  init: HomeController(),
                  builder: (requestController) {
                    if (requestController.isRequestLoading.value) {
                      return const Center(
                        child: CircularProgressIndicator(
                            backgroundColor: Colors.black),
                      );
                    } else {
                      return ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return EmergencyRequestBox(
                                emergencyRequest:
                                    requestController.requestList[index]);
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 20,
                            );
                          },
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: requestController.requestList.length);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
