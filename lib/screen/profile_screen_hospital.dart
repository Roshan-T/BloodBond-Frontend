import 'package:bloodbond/controller/get_donor_detail.dart';
import 'package:bloodbond/controller/get_hospital_detail.dart';
import 'package:bloodbond/controller/profile_controller.dart';
import 'package:bloodbond/models/rewardsModel.dart';
import 'package:bloodbond/routes/url.dart';
import 'package:bloodbond/screen/create_reward.dart';
import 'package:bloodbond/services/services.dart';
import 'package:bloodbond/utils/constants.dart';
import 'package:bloodbond/widget/rewardBox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProfileScreenHospital extends StatelessWidget {
  ProfileScreenHospital({super.key});
  ProfileController controller = Get.put(ProfileController());
  final HospitalController hospitalController = Get.put(HospitalController());

  @override
  Widget build(BuildContext context) {
    hospitalController.fetchDonor(GetStorage().read('id'));
    var providedId = GetStorage().read('id');
    return Scaffold(body: Obx(() {
      if (hospitalController.hospital.value == null) {
        return const Center(
            child:
                CircularProgressIndicator()); // Show loading indicator while data is being fetched
      } else {
        var hospital = hospitalController.hospital.value!;

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
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            Url.getImage + (hospital.image),
                          ),
                        ),
                      ),
                    ))
              ],
            ),
            const SizedBox(height: 60),
            Text(
              hospital.name,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  color: Constants.kBlackColor),
            ),
            const SizedBox(height: 10),
            Text(
              hospital.email,
              style: Theme.of(context)
                  .textTheme
                  .labelSmall!
                  .copyWith(fontSize: 14),
            ),

            IconButton(
              onPressed: () async {
                final Uri url = Uri(scheme: 'tel', path: hospital.phone);
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
              title: "Certified Hospital ",
              icon: Icons.check_circle,
            ),
            // Padding(
            //   padding: const EdgeInsets.all(6.0),
            //   child: Row(
            //     children: [
            //       Expanded(
            //         child: DetailBox(
            //             icon: Icons.bloodtype,
            //             title: "My Rewards",
            //             detail: "12345"),
            //       ),
            //       Expanded(
            //         child: DetailBox(
            //             icon: Icons.monitor_heart_outlined,
            //             title: "Create Rewards",
            //             detail: "5"),
            //       ),
            //     //   Expanded(
            //     //     child: DetailBox(
            //     //         icon: Icons.calendar_month,
            //     //         title: "Last Donation",
            //     //         detail: DateFormat('yyyy-MM-dd').format(
            //     //             DateTime.parse(
            //     //                 donor.lastDonationDate.toString()))),
            //     //   ),
            //     ],
            //   ),
            // ),
            // const SizedBox(height: 10),
            // Text(
            //   "Rewards",
            //   style: Theme.of(context).textTheme.titleLarge!.copyWith(
            //         color: Colors.black,
            //       ),
            // ),
            // const SizedBox(height: 10),
            // CircularPercentIndicator(
            //   radius: 60.0,
            //   lineWidth: 5.0,
            //   percent: 0.75,
            //   center: Text("150"),
            //   linearGradient: const LinearGradient(
            //     colors: [
            //       Constants.kPrimaryColor,
            //       Constants.kAccentColor,
            //       Constants.kLightRed,
            //       Colors.blue,
            //       Colors.green,
            //       Colors.yellowAccent
            //     ],
            //   ),
            // ),
            // const SizedBox(height: 15),
            // SizedBox(
            //   width: Get.width * 0.4,
            //   height: 40,
            //   child: ElevatedButton(
            //     style: ButtonStyle(
            //       backgroundColor:
            //           MaterialStateProperty.all<Color>(Colors.green),
            //     ),
            //     onPressed: null,
            //     child: const Text("Redeem"),
            //   ),
            // ),
            const SizedBox(height: 20),
            SizedBox(
              height: 60,
              width: Get.width * 0.9,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Constants.kSuccessColor)),
                onPressed: () => Get.to(() => MyRewards()),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text("Rewards"), Icon(Icons.arrow_forward_ios)],
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),

            Spacer(),

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
            const SizedBox(height: 20),
          ],
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
      width: Get.width * 0.9,
      // margin: const EdgeInsets.all(8),
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

class MyRewards extends StatelessWidget {
  MyRewards({super.key});
  var providedId = GetStorage().read('id');
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
          "Rewards",
          style: Get.textTheme.headlineSmall?.copyWith(
              color: Constants.kBlackColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: FutureBuilder<List<Rewards>?>(
                future: ApiService.fetchRewards(),
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
                        ?.where((request) => request.ownerId == providedId)
                        .toList();

                    if (filteredList!.isEmpty) {
                      return const Center(
                          child: Text(
                        'Not Created',
                        textAlign: TextAlign.center,
                      ));
                    }
                    return ListView.separated(
                      physics: const ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        final request = filteredList[index];

                        return RewardBox(reward: request);
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
          SizedBox(
            height: 60,
            width: Get.width * 0.8,
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Constants.kSuccessColor)),
              onPressed: () => Get.off(CreateReward()),
              child: const Text("Create Rewards"),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
