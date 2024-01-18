import 'package:bloodbond/screen/create_emergency_request.dart';
import 'package:bloodbond/screen/donor_donation_history.dart';
import 'package:bloodbond/screen/home_screen.dart';
import 'package:bloodbond/screen/profile_screen.dart';
import 'package:bloodbond/screen/role_select.dart';
import 'package:bloodbond/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({this.currentIndex = 0, super.key});
  final int currentIndex;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int _currentIndex;
  // list of screens in bottom nav bar
  final List<Widget> _screens = [
    const HomeScreen(),
    const CreateEmergencyRequest(),
    const HistoryScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    // getCurrentUser(); // get current user
    _currentIndex = widget.currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    // context.read<AuthController>().logout(context);
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
          items: const [
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.all(5.0),
                child: Icon(
                  FontAwesomeIcons.house,
                ),
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.all(5.0),
                child: Icon(
                  FontAwesomeIcons.handHoldingHeart,
                ),
              ),
              label: "Donate",
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.all(5.0),
                child: Icon(FontAwesomeIcons.clockRotateLeft),
              ),
              label: "History",
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.all(5.0),
                child: Icon(FontAwesomeIcons.user),
              ),
              label: "Profile",
            ),
          ],
          currentIndex: _currentIndex,
          onTap: (index) => setState(
                () {
                  _currentIndex = index;
                },
              )),
    );
  }
}
