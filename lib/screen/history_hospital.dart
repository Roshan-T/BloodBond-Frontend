import 'dart:convert';

import 'package:bloodbond/controller/home_screen_controller.dart';
import 'package:bloodbond/models/campaignDonorsModel.dart';
import 'package:bloodbond/models/campaignModel.dart';
import 'package:bloodbond/routes/url.dart';
import 'package:bloodbond/screen/hos_req_his_desc.dart';
import 'package:bloodbond/screen/request_description_screen_hospital.dart';
import 'package:bloodbond/screen/request_description_screendonor.dart';
import 'package:bloodbond/services/services.dart';
import 'package:bloodbond/utils/constants.dart';
import 'package:bloodbond/widget/blood_camp.dart';
import 'package:bloodbond/widget/emergency_request_box.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class HistoryHospital extends StatefulWidget {
  const HistoryHospital({Key? key}) : super(key: key);

  @override
  _HistoryHospitalState createState() => _HistoryHospitalState();
}

class _HistoryHospitalState extends State<HistoryHospital>
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
    var currentTime = DateTime.now();
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
          "My History",
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
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: FutureBuilder<List<EmergencyRequest>?>(
                future: ApiService.fetchEmergencyRequest(All: true),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.black,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    var filteredList = snapshot.data!
                        .where((request) =>
                            ((request.hospital.id == providedId) &&
                                (request.donated == true ||
                                    currentTime.isAfter(request.expiryTime))))
                        .toList();
                    if (filteredList.isEmpty) {
                      return const Center(
                        child: Text(
                          'Not Requested Yet',
                          textAlign: TextAlign.center,
                        ),
                      );
                    }
                    return ListView.separated(
                      physics: const ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        final request = filteredList[index];

                        return RequestBox(
                          emergencyRequest: request,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 20);
                      },
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: filteredList.length,
                    );
                  }
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: FutureBuilder<List<CampaignDetails>?>(
                future: ApiService.fetchCampaigns(All: true),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.black,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    var filteredList = snapshot.data!
                        .where((request) =>
                            (request.hospital.id == providedId &&
                                currentTime.isAfter(request.date)))
                        .toList();
                    if (filteredList.isEmpty) {
                      return const Center(
                        child: Text(
                          'Not Organized Yet',
                          textAlign: TextAlign.center,
                        ),
                      );
                    }
                    return ListView.separated(
                      physics: const ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        final request = filteredList[index];

                        return CampaTile(
                          campers: request,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 20);
                      },
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: filteredList.length,
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RequestBox extends StatelessWidget {
  final emergencyRequest;

  final width = Get.width;
  RequestBox({super.key, required this.emergencyRequest});

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
                    Get.to(EmergencyRequestHistoryDescription(
                      request: emergencyRequest,
                    ));
                  },
                  child: Text(
                    emergencyRequest.donated == true
                        ? "Received"
                        : "Not Received",
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
                    Get.to(HistoryCampaign(id: campers.id));
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

// **

class HistoryCampaign extends StatefulWidget {
  HistoryCampaign({super.key, required this.id});
  var id;

  @override
  _HistoryCampaignState createState() => _HistoryCampaignState();
}

class _HistoryCampaignState extends State<HistoryCampaign> {
  var id;
  @override
  void initState() {
    super.initState();

    id = widget.id;
  }

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
          "Campagin Details",
          style: Get.textTheme.headlineSmall?.copyWith(
              color: Constants.kBlackColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Text(
            "Donors",
            style: Get.textTheme.headlineSmall?.copyWith(
                color: Constants.kBlackColor, fontWeight: FontWeight.normal),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: FutureBuilder<CampaignDonorsDetails?>(
              future: ApiService.fetchCampaignDonors(id),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.black,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.data!.registeredCount == 0) {
                  return const Center(
                    child: Text(
                      'No one Registered ',
                      textAlign: TextAlign.center,
                    ),
                  );
                } else {
                  var filteredList = snapshot.data!.donors
                      .where((request) => (request.donated == true))
                      .toList();
                  return ListView.separated(
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final request = filteredList[index];

                      return DonorBox(
                        donor: request,
                        campaignId: id,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 20);
                    },
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: filteredList.length,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DonorBox extends StatelessWidget {
  final width = Get.width;

  var donor;
  var campaignId;
  DonorBox({
    super.key,
    required this.donor,
    required this.campaignId,
  });

  @override
  Widget build(BuildContext context) {
    var imageUrl = Url.getImage + donor.image;

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color.fromARGB(255, 240, 245, 245),
      ),
      child: Row(
        children: [
          ClipOval(
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              height: 60,
              width: 60,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${donor.name}",
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(5),
            height: 33,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
                color: Constants.kWhiteColor),
            child: donor.donated == true
                ? const Icon(Icons.check_box)
                : const Icon(Icons.check_box_outline_blank),
          )
        ],
      ),
    );
  }
}
