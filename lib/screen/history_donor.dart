import 'package:bloodbond/controller/home_screen_controller.dart';
import 'package:bloodbond/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HistoryDonor extends StatefulWidget {
  const HistoryDonor({Key? key}) : super(key: key);

  @override
  _HistoryDonorState createState() => _HistoryDonorState();
}

class _HistoryDonorState extends State<HistoryDonor>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final HomeController requestController = Get.put(HomeController());
    final int providedId = GetStorage().read('id');
    print(providedId);
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
          "My Details",
          style: Get.textTheme.headlineSmall?.copyWith(
              color: Constants.kBlackColor, fontWeight: FontWeight.bold),
        ),
        bottom: TabBar(
          controller: _tabController, // Assigning the TabController
          isScrollable: true,
          labelColor: Constants.kPrimaryColor,
          indicatorColor: Constants.kPrimaryColor,
          unselectedLabelColor: Constants.kGrey,
          tabs: const [
            Padding(
              padding: EdgeInsets.all(8),
              child: Text("Request"),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text("Campaigns"),
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController, // Assigning the TabController
        children: [],
      ),
    );
  }
}
