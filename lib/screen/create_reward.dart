import 'package:bloodbond/controller/create_reward.dart';
import 'package:bloodbond/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateReward extends StatefulWidget {
  const CreateReward({super.key});

  @override
  State<CreateReward> createState() => _CreateRewardState();
}

class _CreateRewardState extends State<CreateReward> {
  bool _isAccepted = false;

  final TextEditingController rewardName = TextEditingController();
  final TextEditingController rewardDescription = TextEditingController();
  final TextEditingController rewardPoint = TextEditingController();
  final TextEditingController totalQuantity = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    rewardName.dispose();

    rewardDescription.dispose();
    rewardPoint.dispose();
    totalQuantity.dispose();
  }

  void showSnackBar(String title, String subtitle) {
    Get.closeAllSnackbars();
    Get.snackbar(
      title,
      subtitle,
      colorText: Colors.white,
      duration: const Duration(seconds: 1),
      backgroundColor: Constants.kPrimaryColor,
      icon: const Icon(
        Icons.error,
        color: Constants.kWhiteColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final CreateRewardController rewardController =
        Get.put(CreateRewardController());
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
          "Reward Create",
          style: Get.textTheme.headlineSmall?.copyWith(
              color: Constants.kBlackColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: Constants.kHorizontalPadding),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(
                  height: 5,
                  color: Constants.kBlackColor,
                ),

                const SizedBox(
                  height: 15,
                ),
                Text(
                  "Reward Name",
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Constants.kGrey, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  keyboardType: TextInputType.name,
                  controller: rewardName,
                  decoration: InputDecoration(
                    hintText: "Enter the reward name",
                    hintStyle: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: Constants.kGrey),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "Description",
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Constants.kGrey, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  keyboardType: TextInputType.name,
                  controller: rewardDescription,
                  decoration: InputDecoration(
                    hintText: "Enter the reward description",
                    hintStyle: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: Constants.kGrey),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                // *

                Text(
                  "Points",
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Constants.kGrey, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  keyboardType: TextInputType.name,
                  controller: rewardPoint,
                  decoration: InputDecoration(
                    hintText: "Enter the points required",
                    hintStyle: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: Constants.kGrey),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Total Quantity",
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Constants.kGrey, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  keyboardType: TextInputType.name,
                  controller: totalQuantity,
                  decoration: InputDecoration(
                    hintText: "Enter the total quantity",
                    hintStyle: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: Constants.kGrey),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),

                Row(
                  children: [
                    Checkbox(
                      activeColor: Constants.kPrimaryColor,
                      value: _isAccepted,
                      onChanged: (bool? value) {
                        setState(
                          () {
                            _isAccepted = value!;
                          },
                        );
                      },
                    ),
                    Expanded(
                      child: Text(
                        "I assure that all the details are valid.",
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            color: Constants.kGrey,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 60,
                  width: double.infinity,
                  child: Obx(
                    () => ElevatedButton(
                      onPressed: () {
                        if (rewardName.text.isEmpty) {
                          return showSnackBar(
                              "Please Enter the reward title", "");
                        }

                        if (rewardDescription.text.isEmpty) {
                          return showSnackBar(
                              "Please enter the reward description", "");
                        } else if (rewardPoint.text.isEmpty) {
                          return showSnackBar(
                              "Please provide the reward point", "");
                        } else if (totalQuantity.text.isEmpty) {
                          return showSnackBar(
                              "Please provide the total quantity", "");
                        } else if (_isAccepted == false) {
                          return showSnackBar(
                              "Please accept the terms and conditions", "");
                        }
                        rewardController.createReward(
                            rewardName.text,
                            rewardDescription.text,
                            rewardPoint.text,
                            totalQuantity.text);
                      },
                      child: rewardController.loading.value == true
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text("Save"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
