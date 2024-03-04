import 'dart:convert';

import 'package:bloodbond/controller/campaign_controller.dart';
import 'package:bloodbond/models/campaignModel.dart';
import 'package:bloodbond/routes/url.dart';
import 'package:bloodbond/utils/constants.dart';
import 'package:bloodbond/widget/timer_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class CampaignDetail extends StatefulWidget {
  const CampaignDetail({super.key, required this.campers});
  final CampaignDetails campers;
  @override
  State<CampaignDetail> createState() => _CampaignDetailState();
}

class _CampaignDetailState extends State<CampaignDetail> {
  late CampaignDetails campers;

  final CountdownController countdownController = CountdownController();

  @override
  void initState() {
    super.initState();
    campers = widget.campers;
    countdownController.startCountdown(campers.date);
  }

  @override
  Widget build(BuildContext context) {
    final CampaignController controller = Get.put(CampaignController());

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Constants.kWhiteColor),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: false,
        title: Text(
          "Campaign Details",
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
                  Url.getImage + campers.banner,
                  fit: BoxFit.fill,
                  height: 300,
                  width: double.maxFinite,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Description",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    campers.description,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: 15, fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Campaign Details",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CampaignDetailsContainer(campers: campers),
                  const SizedBox(
                    height: 20,
                  ),
                  Text("Starts In:",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontSize: 20,
                            color: Colors.black,
                          )),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Obx(() => Expanded(
                            child: TimerBox(
                                time:
                                    "${countdownController.timeRemaining.value.inDays}",
                                timeDuration: "Days"),
                          )),
                      SizedBox(width: 10),
                      Obx(() => Expanded(
                            child: TimerBox(
                                time:
                                    "${countdownController.timeRemaining.value.inHours}",
                                timeDuration: "Hours"),
                          )),
                      SizedBox(width: 10),
                      Obx(() => Expanded(
                            child: TimerBox(
                                time:
                                    "${countdownController.timeRemaining.value.inMinutes % 60}",
                                timeDuration: "Mins"),
                          )),
                      SizedBox(width: 10),
                      Obx(() => Expanded(
                            child: TimerBox(
                                time:
                                    "${countdownController.timeRemaining.value.inSeconds % 60}",
                                timeDuration: "Sec"),
                          )),
                    ],
                  ),
                  SizedBox(height: 20),
                  GetStorage().read('role') == "donor"
                      ? Center(
                          child: SizedBox(
                            height: 60,
                            width: double.maxFinite,
                            child: ElevatedButton(
                              onPressed: () async {
                                await controller.register(campers.id);
                              },
                              child: const Text(
                                "Interested for donation",
                              ),
                            ),
                          ),
                        )
                      : SizedBox(),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ],
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
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Center(
            child: Text(
              topic,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontSize: 17),
            ),
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

class CampDetails extends StatelessWidget {
  const CampDetails({super.key, required this.campers});
  final CampaignDetails campers;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomText(topic: "Title ", topicDetail: campers.title),
          Divider(
            thickness: 1,
            color: Colors.grey.withOpacity(0.3),
          ),
          CustomText(
              topic: "Hospital Name", topicDetail: campers.hospital.name),
          Divider(
            thickness: 1,
            color: Colors.grey.withOpacity(0.3),
          ),
          CustomText(
              topic: "Campaign Date",
              topicDetail: dateFormatter.format(campers.date)),
          Divider(
            thickness: 1,
            color: Colors.grey.withOpacity(0.3),
          ),
          CustomText(
              topic: "Time ", topicDetail: timeFormatter.format(campers.date)),
          Divider(
            thickness: 1,
            color: Colors.grey.withOpacity(0.3),
          ),

          CustomText(topic: "Address", topicDetail: campers.city),

          // CustomText(topic: " Quantity", topicDetail: "4"),
        ],
      ),
    );
  }
}

class CampaignDetailsContainer extends StatelessWidget {
  const CampaignDetailsContainer({super.key, required this.campers});
  final CampaignDetails campers;
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
      child: CampDetails(campers: campers),
    );
  }
}

DateFormat dateFormatter = DateFormat('yyyy-MM-dd');
DateFormat timeFormatter = DateFormat('HH:mm a');
