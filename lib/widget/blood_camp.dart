import 'dart:convert';

import 'package:bloodbond/models/campaignModel.dart';
import 'package:bloodbond/routes/url.dart';
import 'package:bloodbond/screen/campaign_details.dart';
import 'package:flutter/material.dart';
import 'package:bloodbond/utils/constants.dart';
import 'package:get/get.dart';

class CampTile extends StatelessWidget {
  final CampaignDetails campers;

  const CampTile({super.key, required this.campers});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8),
        // height: 200,
        width: 300,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 240, 245, 245),
          // border: Border.all(width: 0.5, color: Colors.black),
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
                      // border: Border.all(width: 0.5, color: Colors.black),
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                    ),
                    height: 120,
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
                      child: Image.network(
                        Url.getImage + campers.banner,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    maxLines: 1,
                    campers.title,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Constants.kBlackColor,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    maxLines: 2,
                    campers.description,
                    style: Theme.of(context).textTheme.labelSmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                ],
              ),
            ),
            const Spacer(),
            Center(
              child: SizedBox(
                // height: 45,
                width: 280,
                child: ElevatedButton(
                  onPressed: () => Get.to(CampaignDetail(campers: campers)),
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
            SizedBox(
              height: 10,
            ),
          ],
        ));
  }
}
