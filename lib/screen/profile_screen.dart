import 'package:bloodbond/controller/get_donor_detail.dart';
import 'package:bloodbond/controller/profile_controller.dart';
import 'package:bloodbond/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {

    DonorDetailsController donorDetailsController = Get.find();
    bool isDonor = true;
    return Scaffold(
        body: SingleChildScrollView(
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
            style:
                Theme.of(context).textTheme.labelSmall!.copyWith(fontSize: 14),
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
                      icon: Icons.bloodtype,
                      title: "Blood Group",
                      detail: "A+"),
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
          CircularPercentIndicator(
            radius: 60.0,
            lineWidth: 5.0,
            percent: 0.75,
            center: Text("${0.75 * 100}%"),
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
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
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
    ));
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
      height: 75,
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
