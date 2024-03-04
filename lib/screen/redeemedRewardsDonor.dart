import 'package:bloodbond/models/rewardsModel.dart';
import 'package:bloodbond/services/services.dart';
import 'package:bloodbond/utils/constants.dart';
import 'package:bloodbond/widget/rewardBox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/redeemedRewardsModel.dart';

class RedeemedReward extends StatefulWidget {
  RedeemedReward({super.key});

  @override
  State<RedeemedReward> createState() => _RedeemedRewardState();
}

class _RedeemedRewardState extends State<RedeemedReward> {
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
          "Redeemed Rewards",
          style: Get.textTheme.headlineSmall?.copyWith(
              color: Constants.kBlackColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: FutureBuilder<List<RedeemedRewards>?>(
                future: ApiService.fetchRedeemedRewards(),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.black,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return const Text('Error occured');
                  } else {
                    if (snapshot.data!.isEmpty) {
                      return const Center(
                          child: Text(
                        'Not Redeemed',
                        textAlign: TextAlign.center,
                      ));
                    }
                    return ListView.separated(
                      physics: const ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        final request = snapshot.data;

                        return RewardBox(
                          reward: snapshot.data![index].reward,
                          redeem: true,
                          redeemHistory: true,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 20);
                      },
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data!.length,
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
