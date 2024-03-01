import 'package:bloodbond/screen/create_campaign_request.dart';
import 'package:bloodbond/screen/create_emergency_request.dart';
import 'package:bloodbond/screen/create_form.dart';
import 'package:bloodbond/screen/donor_donation_history.dart';
import 'package:bloodbond/screen/history_donor.dart';
import 'package:bloodbond/screen/home_screen.dart';
import 'package:bloodbond/screen/hospital_ind_reqandcamp.dart';
import 'package:bloodbond/screen/profile_screen.dart';
import 'package:bloodbond/screen/viral_disease_alert.dart';

import 'package:bloodbond/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({this.currentIndex = 0, super.key});
  final int currentIndex;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int _currentIndex;
  late String role;
  // list of screens in bottom nav bar
  List<Widget> _screens = [];

  @override
  void initState() {
    super.initState();
    // getCurrentUser(); // get current user
    _currentIndex = widget.currentIndex;
    var storage = GetStorage();
    role = storage.read('role');
    _screens = [
      HomeScreen(),
      if (role == 'hospital') SelectForm(),
      if (role == 'hospital') HospitalIndRequest(),
      if (role == 'hospital') const HistoryScreen(),
      if (role == 'donor') const HistoryDonor(),
      if (role == 'donor') ProfileScreen(),
      if (role == 'hospital') ProfileScreen(),
      if (role == 'donor') ViralDiseaseAlert(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],

      //bottom navbar
      bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedIconTheme: const IconThemeData(
            color: Constants.kPrimaryColor,
            size: 24,
          ),
          unselectedIconTheme: const IconThemeData(
            color: Constants.kGrey,
            size: 24,
          ),
          selectedItemColor: Constants.kPrimaryColor,
          items: [
            const BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.all(5.0),
                child: Icon(
                  FontAwesomeIcons.house,
                ),
              ),
              label: "Home",
            ),
            if (role == 'hospital')
              const BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Icon(
                    FontAwesomeIcons.handHoldingHeart,
                  ),
                ),
                label: "Donate",
              ),
            if (role == 'hospital')
              const BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Icon(FontAwesomeIcons.info),
                ),
                label: "Info",
              ),
            const BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.all(5.0),
                child: Icon(FontAwesomeIcons.clockRotateLeft),
              ),
              label: "History",
            ),
            const BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.all(5.0),
                child: Icon(FontAwesomeIcons.user),
              ),
              label: "Profile",
            ),
            if (role == 'donor')
              const BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Icon(FontAwesomeIcons.disease),
                ),
                label: "Disease",
              ),
          ],
          currentIndex: _currentIndex,
          onTap: (index) => setState(
                () {
                  Get.deleteAll();
                  _currentIndex = index;
                },
              )),
    );
  }
}
