import 'package:bloodbond/controller/nearby_donor.controller.dart';
import 'package:flutter/material.dart';

import 'package:bloodbond/utils/constants.dart';
import 'package:get/get.dart';



class NearbyDonorScreen extends StatelessWidget {
  NearbyDonorScreen({super.key});
  final NearbyDonorController donorController =
      Get.put(NearbyDonorController());
  @override
  Widget build(BuildContext context) {
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
      body: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: Constants.kHorizontalPadding, vertical: 20),
        child: Obx(() {
          if (donorController.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(backgroundColor: Colors.black),
            );
          } else {
            return ListView.separated(
              itemCount: donorController.donorList.length,
              separatorBuilder: (context, index) => const SizedBox(height: 20),
              itemBuilder: (context, index) {
                return NearbyDonorBox(donor: donorController.donorList[index]);
              },
            );
          }
        }),
      ),
    );
  }
}

class NearbyDonorBox extends StatelessWidget {
  final donor;
  final width = Get.width;
  NearbyDonorBox({super.key, required this.donor});

  @override
  Widget build(BuildContext context) {
    return Stack(
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
              CircleAvatar(
                radius: 30,
                child: Image.network(donor.image,
                    height: 60, width: 100, fit: BoxFit.cover),
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
    );
  }
}
