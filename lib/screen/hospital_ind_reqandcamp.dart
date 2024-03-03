import 'dart:convert';

import 'package:bloodbond/controller/home_screen_controller.dart';
import 'package:bloodbond/models/campaignModel.dart';
import 'package:bloodbond/routes/url.dart';
import 'package:bloodbond/screen/hospitalCampaign.dart';
import 'package:bloodbond/screen/request_description_screen_hospital.dart';
import 'package:bloodbond/screen/request_description_screendonor.dart';
import 'package:bloodbond/utils/constants.dart';
import 'package:bloodbond/widget/blood_camp.dart';
import 'package:bloodbond/widget/emergency_request_box.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class HospitalIndRequest extends StatefulWidget {
  const HospitalIndRequest({Key? key}) : super(key: key);

  @override
  _HospitalIndRequestState createState() => _HospitalIndRequestState();
}

class _HospitalIndRequestState extends State<HospitalIndRequest>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final HomeController requestController = Get.put(HomeController());
    final int providedId = GetStorage().read('id');
    print(providedId);
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
          "My Details",
          style: Get.textTheme.headlineSmall?.copyWith(
              color: Constants.kBlackColor, fontWeight: FontWeight.bold),
        ),
        bottom: TabBar(
          controller: _tabController, // Assigning the TabController
          isScrollable: true,
          labelColor: Constants.kPrimaryColor,
          indicatorColor: Constants.kPrimaryColor,
          unselectedLabelColor: Constants.kGrey,
          tabs: const [
            Padding(
              padding: EdgeInsets.all(8),
              child: Text("Request"),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text("Campaigns"),
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController, // Assigning the TabController
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Obx(
              () {
                if (requestController.isRequestLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(
                        backgroundColor: Colors.black),
                  );
                } else {
                  final filteredList = requestController.requestList
                      .where((request) => request.hospital.id == providedId)
                      .toList();

                  if (filteredList.isEmpty) {
                    return const Center(
                        child: Text(
                      'No request Pending',
                      textAlign: TextAlign.center,
                    ));
                  }

                  return ListView.separated(
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final request = filteredList[index];
                      return Dismissible(
                        key: Key(request.id.toString()),
                        onDismissed: (direction) {
                          filteredList.removeAt(index);
                          setState(() async {
                            await requestController.removeRequest(request.id);

                            await requestController.fetchEmergencyRequest();
                          });

                          Get.snackbar("Request Deleted", "");
                        },
                        background: Container(
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                          ),
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20.0),
                          child: const Icon(Icons.delete),
                        ),
                        child: RequestBox(
                          title:
                              request.accepted ? "Accepted" : 'Pending Request',
                          emergencyRequest: request,
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 20);
                    },
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: filteredList.length,
                  );

                  // ListView.separated(
                  //   physics: NeverScrollableScrollPhysics(),
                  //   itemBuilder: (context, index) {
                  //     return RequestBox(
                  //         title: 'Pending',
                  //         emergencyRequest: filteredList[index]);
                  //   },
                  //   separatorBuilder: (context, index) {
                  //     return const SizedBox(height: 20);
                  //   },
                  //   shrinkWrap: true,
                  //   scrollDirection: Axis.vertical,
                  //   itemCount: filteredList.length,
                  // );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Obx(
              () {
                if (requestController.isCampaignLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(
                        backgroundColor: Colors.black),
                  );
                } else {
                  final filteredCList = requestController.campaignList
                      .where((request) => request.hospital.id == providedId)
                      .toList();

                  if (filteredCList.isEmpty) {
                    return const Center(
                        child: Text(
                      'No campaign Pending',
                      textAlign: TextAlign.center,
                    ));
                  }

                  return ListView.separated(
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final request = filteredCList[
                          index]; // Retrieve the campaign from filteredCList
                      return Dismissible(
                        key: Key(request.id.toString()),
                        onDismissed: (direction) {
                          filteredCList.removeAt(index);
                          setState(() async {
                            await requestController.removeCampaign(request.id);

                            await requestController.fetchCampaigns();
                          });

                          Get.snackbar("Campaign Deleted", "");
                        },
                        background: Container(
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                          ),
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20.0),
                          child: const Icon(Icons.delete),
                        ),
                        child: CampaTile(campers: request),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 20);
                    },
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: filteredCList.length,
                  );

                  // ListView.separated(
                  //   physics: NeverScrollableScrollPhysics(),
                  //   itemBuilder: (context, index) {
                  //     return CampaTile(campers: filteredList[index]);
                  //   },
                  //   separatorBuilder: (context, index) {
                  //     return const SizedBox(height: 20);
                  //   },
                  //   shrinkWrap: true,
                  //   scrollDirection: Axis.vertical,
                  //   itemCount: filteredList.length,
                  // );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class RequestBox extends StatelessWidget {
  final emergencyRequest;
  final title;
  final width = Get.width;
  RequestBox({super.key, this.title, required this.emergencyRequest});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 150,
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: const Color.fromARGB(255, 240, 245, 245),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Constants.kPrimaryColor,
                    radius: 30,
                    child: Text(
                      emergencyRequest.bloodGroup,
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: width - 100 - 80,
                        child: Text(
                          emergencyRequest.patientName,
                          maxLines: 2,
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        width: width - 100 - 80,
                        child: RichText(
                          maxLines: 2,
                          text: TextSpan(
                            children: [
                              const WidgetSpan(
                                child: Icon(
                                  Icons.place,
                                  size: 24,
                                  color: Colors.red,
                                ),
                              ),
                              TextSpan(
                                text: emergencyRequest.hospital.city.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(
                                      fontSize: 15,
                                      color: Colors.black,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 3),
                      SizedBox(
                        width: width - 100 - 80,
                        child: RichText(
                          maxLines: 2,
                          text: TextSpan(
                            children: [
                              const WidgetSpan(
                                child: Padding(
                                  padding: EdgeInsets.only(right: 5.0),
                                  child: Icon(
                                    FontAwesomeIcons.clock,
                                    size: 20,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                              TextSpan(
                                text: DateFormat.jm()
                                    .format(emergencyRequest.expiryTime),
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(
                                      fontSize: 15,
                                      color: Colors.black,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              SizedBox(
                width: Get.width,
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(RequestDescrptionScreenHospital(
                      emergencyRequest: emergencyRequest,
                    ));
                  },
                  child: Text(
                    title,
                  ),
                ),
              )
            ],
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(5),
            height: 33,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
                color: Constants.kPrimaryColor),
            child: const Icon(Icons.hourglass_empty,
                color: Constants.kWhiteColor, size: 20),
          ),
        ),
      ],
    );
  }
}

class CampaTile extends StatelessWidget {
  final CampaignDetails campers;

  const CampaTile({super.key, required this.campers});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8),
        height: 250,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 239, 236, 236),
          border: Border.all(width: 0.5, color: Colors.black),
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      border: Border.all(width: 0.5, color: Colors.black),
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                    ),
                    height: 120,
                    width: 250,
                    child: Image.network(
                      Url.getImage + campers.banner,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Text(
                    maxLines: 1,
                    campers.title,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Constants.kBlackColor,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    maxLines: 2,
                    campers.description,
                    style: Theme.of(context).textTheme.labelSmall,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ),
            const Spacer(),
            Center(
              child: SizedBox(
                height: 45,
                width: 280,
                child: ElevatedButton(
                  onPressed: () {
                    print("id: ${campers.id}");
                    Get.to(HospitalCampaign(
                      id: campers.id,
                    ));
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Constants.kPrimaryColor),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.touch_app),
                        Text(
                          'View Details',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(fontSize: 16),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ));
  }
}
