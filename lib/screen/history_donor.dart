import 'dart:async';
import 'dart:convert';

import 'package:bloodbond/controller/home_screen_controller.dart';
import 'package:bloodbond/routes/url.dart';
import 'package:bloodbond/services/services.dart';
import 'package:bloodbond/utils/constants.dart';
import 'package:bloodbond/widget/donor_history_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HistoryDonor extends StatefulWidget {
  const HistoryDonor({Key? key}) : super(key: key);

  @override
  _HistoryDonorState createState() => _HistoryDonorState();
}

class _HistoryDonorState extends State<HistoryDonor>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  late final HomeController requestController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    start();
  }

  void start() async {
    requestController = Get.put(HomeController());
    await requestController.fetchEmergencyRequest(a: true);

    Future.delayed(Duration(seconds: 2));
  }

  @override
  void dispose() {
    _tabController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int providedId = GetStorage().read('id');
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
        controller: _tabController,
        children: [
          Padding(
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
                    var filteredList = snapshot.data
                        ?.where((request) =>
                            (request.donor != null) &&
                            request.donor['id'] == providedId)
                        .toList();
                    if (filteredList!.isEmpty) {
                      return const Center(
                          child: Text(
                        'Not Donated',
                        textAlign: TextAlign.center,
                      ));
                    }
                    return ListView.separated(
                      physics: const ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        final request = filteredList[index];

                        return HistoryBox(
                          donorHistory: request,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 20);
                      },
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: filteredList!.length,
                    );
                  }
                },
              )),
          Padding(
              padding: const EdgeInsets.all(12.0),
              child: FutureBuilder<List<MyCampaigns>?>(
                future: ApiService.fetchDonorsCampaign(),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.black,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.data!.isEmpty) {
                    return const Center(
                        child: Text(
                      'Not Participated',
                      textAlign: TextAlign.center,
                    ));
                  } else {
                    return ListView.separated(
                      physics: const ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return CampaignBox(
                          donorsCampaign: snapshot.data![index],
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 20);
                      },
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data!.length,
                    );
                  }
                },
              ))
        ],
      ),
    );
  }
}

List<MyCampaigns> myCampaignsFromJson(String str) => List<MyCampaigns>.from(
    json.decode(str).map((x) => MyCampaigns.fromJson(x)));

String myCampaignsToJson(List<MyCampaigns> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MyCampaigns {
  int id;
  String name;
  String image;
  int hospitalId;
  String hospital;

  MyCampaigns({
    required this.id,
    required this.name,
    required this.image,
    required this.hospitalId,
    required this.hospital,
  });

  factory MyCampaigns.fromJson(Map<String, dynamic> json) => MyCampaigns(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        hospitalId: json["hospital_id"],
        hospital: json["hospital"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "hospital_id": hospitalId,
        "hospital": hospital,
      };
}

class CampaignBox extends StatelessWidget {
  final donorsCampaign;
  const CampaignBox({super.key, required this.donorsCampaign});
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width * 1;
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
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
                    child: Image.network(
                        Url.getImage + jsonDecode(donorsCampaign.image),
                        height: 60,
                        width: 100,
                        fit: BoxFit.cover),
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
                          donorsCampaign.name,
                          maxLines: 2,
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        width: width - 100 - 80,
                        child: RichText(
                          maxLines: 1,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: donorsCampaign.hospital,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(5),
            height: 28,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
                color: Colors.green),
            child: Text(
              "Participated",
              style: Theme.of(context)
                  .textTheme
                  .labelSmall!
                  .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
