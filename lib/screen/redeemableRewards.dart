import 'package:bloodbond/models/rewardsModel.dart';
import 'package:bloodbond/services/services.dart';
import 'package:bloodbond/utils/constants.dart';
import 'package:bloodbond/widget/rewardBox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class RedeemableReward extends StatefulWidget {
  RedeemableReward({super.key});

  @override
  State<RedeemableReward> createState() => _RedeemableRewardState();
}

class _RedeemableRewardState extends State<RedeemableReward> {
  var providedId = GetStorage().read('id');
  refresh() {
    setState(() {});
  }

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
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
                    return Text('Error Occur');
                  } else {
                    var filteredList = snapshot.data
                        ?.where((request) =>
                            (request.totalQuantity - request.redeemedQuantity) >
                            0)
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

                        return RewardBox(
                          reward: request,
                          redeem: true,
                          refresh: refresh,
                        );
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
          ],
        ),
      ),
    );
  }
}
