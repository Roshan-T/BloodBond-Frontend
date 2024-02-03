import 'package:bloodbond/controller/nearby_donor.controller.dart';
import 'package:bloodbond/routes/url.dart';
import 'package:bloodbond/screen/profile_screen.dart';
import 'package:flutter/material.dart';

import 'package:bloodbond/utils/constants.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widget/donor_history_box.dart';

class NearbyDonorScreen extends StatelessWidget {
  NearbyDonorScreen({super.key});
  static const LatLng _pGooglePlex = LatLng(37.4223, -122.0848);
  static const LatLng _pApplePark = LatLng(37.3346, -122.0090);

  @override
  Widget build(BuildContext context) {
    final NearbyDonorController donorController =
        Get.put(NearbyDonorController());

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "NearbyDonors",
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: Constants.kHorizontalPadding, vertical: 20),
          child: Obx(() {
            if (donorController.isLoading.value) {
              return const Center(
                child: CircularProgressIndicator(backgroundColor: Colors.black),
              );
            } else {
              return Column(
                children: [
                  ListView.separated(
                    itemCount: donorController.donorList.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 20),
                    itemBuilder: (context, index) {
                      return NearbyDonorBox(
                          donor: donorController.donorList[index]);
                    },
                  ),
                ],
              );
            }
          }),
        ),
      ),
    );
  }
}

class NearbyDonorBox extends StatelessWidget {
  final width = Get.width;

  var donor;
  NearbyDonorBox({super.key, required this.donor});

  @override
  Widget build(BuildContext context) {
    var imageUrl = Url.getImage + (donor.image).toString();
    return InkWell(
      onTap: () {},
      child: Stack(
        children: [
          Container(
            height: 85,
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 8),
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
                Text(
                  donor.firstName,
                  maxLines: 2,
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  " " + donor.lastName,
                  maxLines: 2,
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
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
              child: Text(
                donor.bloodGroup,
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DonorDetail extends StatelessWidget {
  @override
  var donor;
  DonorDetail({super.key, required this.donor});
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            ClipPath(
              clipper: OvalBottomBorderClipper(),
              child: Container(
                color: Constants.kPrimaryColor,
                height: 175,
                width: double.infinity,
              ),
            ),
            Positioned(
                bottom: -50,
                right: 0.5,
                left: 0.5,
                child: Container(
                  height: 130,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/images/onboarding2.png"),
                    ),
                  ),
                ))
          ],
        ),
        const SizedBox(height: 60),
        Text(
          "Roshan Tiwari",
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Constants.kBlackColor),
        ),
        const SizedBox(height: 10),
        Text(
          "roshantiwari9827@gmail.com",
          style: Theme.of(context).textTheme.labelSmall!.copyWith(fontSize: 14),
        ),
        IconButton(
          onPressed: () async {
            final Uri url = Uri(scheme: 'tel', path: "+977-9827114984");
            if (await canLaunchUrl(url)) {
              launchUrl(url);
            } else {
              throw 'Could not launch';
            }
          },
          iconSize: 30,
          icon: const Icon(
            Icons.call,
            color: Colors.blue,
          ),
        ),
        const ProfileDataBox(
          title: "Certified Donor ",
          icon: Icons.check_circle,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: DetailBox(
                    icon: Icons.bloodtype, title: "Blood Group", detail: "A+"),
              ),
              Expanded(
                child: DetailBox(
                    icon: Icons.monitor_heart_outlined,
                    title: "Life Saved",
                    detail: "5"),
              ),
              Expanded(
                child: DetailBox(
                    icon: Icons.calendar_month,
                    title: "Last Donation",
                    detail: "2080-10-12"),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Text(
          "Rewards",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Colors.black,
              ),
        ),
        const SizedBox(height: 10),
        const SizedBox(height: 15),
        const SizedBox(height: 20),
      ],
    );
  }
}
