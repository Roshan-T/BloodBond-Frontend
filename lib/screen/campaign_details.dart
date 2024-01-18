import 'package:bloodbond/utils/constants.dart';
import 'package:flutter/material.dart';

class CampaignDetail extends StatefulWidget {
  const CampaignDetail({super.key});

  @override
  State<CampaignDetail> createState() => _CampaignDetailState();
}

class _CampaignDetailState extends State<CampaignDetail> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(" Details"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            width: double.maxFinite,
            height: 1100,
            color: Constants.kWhiteColor,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Expanded(
                    flex: 1,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      child: Image.asset(
                        "assets/images/onboarding4.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ), //image
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Constants.kWhiteColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      width: double.maxFinite,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 15, right: 8, left: 8),
                            child: Text(
                              "Description",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    fontSize: 17,
                                    color: Colors.grey,
                                  ),
                            ),
                          ), //String "description"

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(fontSize: 17),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              "Campaign Details",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    fontSize: 17,
                                    color: Colors.grey,
                                  ),
                            ),
                          ), //String"Food Details"

                          const FoodDetailsContainer(),

                          const SizedBox(
                            height: 20,
                          ),
                          Flexible(
                            child: FractionallySizedBox(
                              heightFactor: 0.5,
                              widthFactor: 1,
                              child: ElevatedButton(
                                onPressed: () {},
                                child: const Text(
                                  "Interested for donation",
                                ),
                              ),
                            ),
                          ), //elevatedbutton
                        ],
                      ),
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

class CustomText extends StatelessWidget {
  final String topic;

  final String topicDetail;

  CustomText({super.key, required this.topic, required this.topicDetail});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            topic,
            style:
                Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 17),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            topicDetail,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Colors.grey, fontSize: 17),
          ),
        ),
      ],
    );
  }
}

class FoodDetails extends StatelessWidget {
  const FoodDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CustomText(
            topic: "Title ", topicDetail: "Bank Blood (Campaign's Title)"),
        Divider(
          thickness: 1,
          color: Colors.grey.withOpacity(0.3),
        ),
        CustomText(topic: "Organization Name", topicDetail: " Red Cross "),
        Divider(
          thickness: 1,
          color: Colors.grey.withOpacity(0.3),
        ),
        CustomText(topic: "Campaign Date", topicDetail: "2023-08-19"),
        Divider(
          thickness: 1,
          color: Colors.grey.withOpacity(0.3),
        ),
        CustomText(topic: "Time ", topicDetail: "7 AM "),
        Divider(
          thickness: 1,
          color: Colors.grey.withOpacity(0.3),
        ),

        CustomText(topic: "Address", topicDetail: "Pokhara"),

        // CustomText(topic: " Quantity", topicDetail: "4"),
      ],
    );
  }
}

class FoodDetailsContainer extends StatelessWidget {
  const FoodDetailsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320,
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
        border: Border.all(
          color: Colors.grey.withOpacity(0.3),
          width: 1.0,
        ),
      ),
      child: const FoodDetails(),
    );
  }
}
