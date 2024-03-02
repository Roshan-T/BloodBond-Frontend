import 'dart:async';
import 'dart:convert';

import 'package:bloodbond/controller/campaign_controller.dart';
import 'package:bloodbond/controller/home_screen_controller.dart';
import 'package:bloodbond/models/campaignDonorsModel.dart';
import 'package:bloodbond/routes/url.dart';
import 'package:bloodbond/services/services.dart';
import 'package:bloodbond/utils/constants.dart';
import 'package:bloodbond/widget/donor_history_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HospitalCampaign extends StatefulWidget {
  HospitalCampaign({super.key, required this.id});
  var id;

  @override
  _HospitalCampaignState createState() => _HospitalCampaignState();
}

class _HospitalCampaignState extends State<HospitalCampaign>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  var id;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    id = widget.id;
  }

  void refresh() {
    setState(() {});
  }

  @override
  void dispose() {
    _tabController.dispose();

    super.dispose();
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
        bottom: TabBar(
          controller: _tabController, // Assigning the TabController
          isScrollable: true,
          labelColor: Constants.kPrimaryColor,
          indicatorColor: Constants.kPrimaryColor,
          unselectedLabelColor: Constants.kGrey,
          tabs: const [
            Padding(
              padding: EdgeInsets.all(8),
              child: Text("Interested"),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text("Donated"),
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
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
                      'No one Registered Yet',
                      textAlign: TextAlign.center,
                    ),
                  );
                } else {
                  var filteredList = snapshot.data!.donors;
                  // .where((request) => (request.donated == false))
                  // .toList();
                  return ListView.separated(
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final request = filteredList[index];

                      return DonorBox(
                        donor: request,
                        campaignId: id,
                        refresh: refresh,
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
                } else if (snapshot.data!.donatedCount == 0) {
                  return const Center(
                    child: Text(
                      'No one Donated Yet',
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
                        refresh: refresh,
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
  var refresh;
  var donor;
  var campaignId;
  DonorBox(
      {super.key,
      required this.donor,
      required this.campaignId,
      required this.refresh});

  @override
  Widget build(BuildContext context) {
    var requestController = Get.put(CampaignController());
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
                : InkWell(
                    onTap: () async {
                      await requestController.donated(campaignId, donor.id);
                      refresh();
                    },
                    child: const Icon(Icons.check_box_outline_blank),
                  ),
          )
        ],
      ),
    );
  }
}
