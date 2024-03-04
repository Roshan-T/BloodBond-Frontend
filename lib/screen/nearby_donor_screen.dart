import 'dart:convert';

import 'package:bloodbond/controller/nearby_donor.controller.dart';
import 'package:bloodbond/routes/url.dart';
import 'package:bloodbond/screen/profile_screen_donor.dart';
import 'package:flutter/material.dart';

import 'package:bloodbond/utils/constants.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class NearbyDonorScreen extends StatelessWidget {
  NearbyDonorScreen({super.key});
  var storage = GetStorage();
  addMarkers(donorList) {
    List<Marker> markers = [];
    var marker;
    for (var donor in donorList) {
      marker = Marker(
          markerId: const MarkerId(""),
          icon: BitmapDescriptor.defaultMarker,
          position: LatLng(donor.latitude, donor.longitude),
          infoWindow: InfoWindow(title: donor.firstName));
      markers.add(marker);
    }
    return markers;
  }

  @override
  Widget build(BuildContext context) {
    var latitude = storage.read('latitude');
    var longitude = storage.read('longitude');
    final NearbyDonorController donorController =
        Get.put(NearbyDonorController());
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Nearby Donors",
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
              Get.back();
            },
          )),
      body: Obx(() {
        if (donorController.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(backgroundColor: Colors.black),
          );
        } else {
          return Column(
            children: [
              SizedBox(
                height: Get.height * 0.25,
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(latitude, longitude),
                    zoom: 10,
                  ),
                  markers: addMarkers(donorController.donorList).toSet()

                  // Marker(
                  //     markerId: const MarkerId("2"),
                  //     icon: BitmapDescriptor.defaultMarker,
                  //     position: LatLng(latitude, longitude),
                  //     infoWindow: InfoWindow(title: name))
                  ,
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Constants.kHorizontalPadding, vertical: 20),
                  child: ListView.separated(
                    itemCount: donorController.donorList.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 20),
                    itemBuilder: (context, index) {
                      return NearbyDonorBox(
                          donor: donorController.donorList[index]);
                    },
                  ),
                ),
              )
            ],
          );
        }
      }),
    );
  }
}

class NearbyDonorBox extends StatelessWidget {
  final width = Get.width;

  var donor;
  NearbyDonorBox({super.key, required this.donor});

  @override
  Widget build(BuildContext context) {
    var imageUrl = Url.getImage + donor.image;
    print("image $imageUrl");
    return InkWell(
      onTap: () {
        Get.to(DonorDetail(donor: donor));
      },
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color.fromARGB(255, 240, 245, 245),
            ),
            child: Row(
              children: [
                ClipOval(
                  child: Image.network(
                    (imageUrl),
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
                      "${donor.firstName} ${donor.lastName}",
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      donor.city,
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                    )
                  ],
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
    var imageUrl = Url.getImage + donor.image;
    return Scaffold(
      body: Column(
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
                      image: DecorationImage(image: NetworkImage(imageUrl)),
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
            style:
                Theme.of(context).textTheme.labelSmall!.copyWith(fontSize: 14),
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
            padding: const EdgeInsets.all(8.0),
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
                      title: "Life Saved",
                      detail: " "),
                ),
                Expanded(
                  child: DetailBox(
                      icon: Icons.calendar_month,
                      title: "Last Donation",
                      detail: donor.lastDonationDate ?? "Not yet"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
