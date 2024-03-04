import 'package:bloodbond/routes/url.dart';
import 'package:bloodbond/screen/hospitalRewardredeemedDonors.dart';
import 'package:bloodbond/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../utils/constants.dart';

class RewardBox extends StatelessWidget {
  final reward;
  bool redeem;
  final refresh;
  RewardBox(
      {super.key, required this.reward, this.redeem = false, this.refresh});

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
                  if (redeem == true)
                    CircleAvatar(
                      backgroundColor: Colors.green,
                      radius: 30,
                      child: Text(
                        "${reward.totalQuantity}",
                        maxLines: 2,
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
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
                          reward.name,
                          maxLines: 2,
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        width: width - 100 - 80,
                        child: RichText(
                          maxLines: 3,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: reward.description,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      if (redeem == true)
                        Text(
                          "Remaining : ${reward.totalQuantity - reward.redeemedQuantity}",
                          maxLines: 2,
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                        ),
                      if (redeem == true)
                        const SizedBox(
                          height: 20,
                        ),
                      if (redeem == false)
                        SizedBox(
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () {
                              Get.to(HospitalRewardRedeemedDonors(
                                  rewardid: reward.id));
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.green),
                            ),
                            child: Text("Redeemed Donors",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold)),
                          ),
                        ),
                      if (redeem == true)
                        SizedBox(
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () async {
                              await ApiService.redeemRewards(reward.id);
                              refresh();
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.yellow),
                            ),
                            child: Text("Redeem",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                          ),
                        )
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
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
                color: Colors.deepOrangeAccent),
            child: Column(
              children: [
                Text(
                  reward.points.toString(),
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                ),
                Text(
                  "Points",
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 8),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
