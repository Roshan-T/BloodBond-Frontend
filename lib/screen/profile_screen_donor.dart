import 'dart:convert';

import 'package:bloodbond/controller/get_donor_detail.dart';
import 'package:bloodbond/controller/profile_controller.dart';
import 'package:bloodbond/routes/url.dart';
import 'package:bloodbond/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProfileScreenDonor extends StatelessWidget {
  ProfileScreenDonor({super.key});
  ProfileController controller = Get.put(ProfileController());
  final DonorController donorController = Get.put(DonorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Obx(() {
      if (donorController.donor.value == null) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else {
        var donor = donorController.donor.value!;

        return SingleChildScrollView(
          child: Column(
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
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(
                            Url.getImage + (donor.image),
                          )),
                        ),
                      ))
                ],
              ),
              const SizedBox(height: 60),
              Text(
                "${donor.firstName} ${donor.lastName}",
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Constants.kBlackColor),
              ),
              const SizedBox(height: 10),
              Text(
                donor.email,
                style: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(fontSize: 14),
              ),
              IconButton(
                onPressed: () async {
                  final Uri url = Uri(scheme: 'tel', path: donor.phone);
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
                padding: const EdgeInsets.all(6.0),
                child: Row(
                  children: [
                    Expanded(
                      child: DetailBox(
                          icon: Icons.bloodtype,
                          title: "Blood Group",
                          detail: donor.bloodGroup),
                    ),
                    Expanded(
                      child: DetailBox(
                          icon: Icons.monitor_heart_outlined,
                          title: "Date of Birth",
                          detail: DateFormat('yyyy-MM-dd').format(
                              DateTime.parse(donor.dateOfBirth.toString()))),
                    ),
                    Expanded(
                      child: DetailBox(
                        icon: Icons.calendar_month,
                        title: "Last Donation",
                        detail: DateFormat('yyyy-MM-dd').format(
                          DateTime.parse(
                            donor.lastDonationDate.toString(),
                          ),
                        ),
                      ),
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
              CircularPercentIndicator(
                radius: 60.0,
                lineWidth: 5.0,
                percent: 0.75,
                center: Text(donor.points.toString()),
                linearGradient: const LinearGradient(
                  colors: [
                    Constants.kPrimaryColor,
                    Constants.kAccentColor,
                    Constants.kLightRed,
                    Colors.blue,
                    Colors.green,
                    Colors.yellowAccent
                  ],
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: Get.width * 0.4,
                height: 40,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green),
                  ),
                  onPressed: null,
                  child: const Text("Redeem"),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: Get.width * 0.9,
                height: 60,
                child: Obx(
                  () => ElevatedButton(
                    onPressed: controller.logout,
                    child: controller.isLoading.value
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('Logout'),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    }));
  }
}

class ProfileDataBox extends StatelessWidget {
  final String title;
  final IconData icon;

  const ProfileDataBox({super.key, required this.title, required this.icon});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(20),
      height: 75,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color.fromARGB(255, 240, 245, 245),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const Spacer(),
              Icon(
                icon,
                color: Colors.green,
                size: 30,
              )
            ],
          ),
        ],
      ),
    );
  }
}

class DetailBox extends StatelessWidget {
  final IconData icon;
  final String title;
  final String detail;

  DetailBox({required this.icon, required this.title, required this.detail});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      height: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color.fromARGB(255, 240, 245, 245),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            icon,
            color: Constants.kPrimaryColor,
          ),
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Colors.black, fontSize: 13),
          ),
          Text(
            detail,
            style: Theme.of(context)
                .textTheme
                .labelSmall!
                .copyWith(color: Colors.black, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
