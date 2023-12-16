import 'package:bloodbond/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final theme = ThemeData(
    primaryColor: const Color(0XFF5A59D6),
    primarySwatch: Colors.blue,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: Constants.kWhiteColor,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFFFFFFFF),
      selectedItemColor: Colors.black,
      selectedIconTheme: IconThemeData(
        size: 30,
        color: Colors.black,
      ),
      selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
    ),
    fontFamily: GoogleFonts.poppins().fontFamily,
    appBarTheme: AppBarTheme(
      color: Constants.kPrimaryColor,
      elevation: 3,
      titleTextStyle: GoogleFonts.lato(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Constants.kWhiteColor,
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: Color.fromARGB(255, 247, 247, 251),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
        borderSide: BorderSide(color: Constants.kBlackColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
        borderSide: BorderSide(color: Constants.kPrimaryColor),
      ),
    ),
    // text styles
    textTheme: TextTheme(
      bodyMedium: GoogleFonts.montserrat(
          fontSize: 36,
          fontWeight: FontWeight.w500,
          height: 1,
          color: Constants.kBlackColor),

      //headline
      displayLarge: const TextStyle(
        fontWeight: FontWeight.w900,
        height: 1,
        fontSize: 36,
        color: Constants.kBlackColor,
      ),
      // title
      titleLarge: const TextStyle(
        color: Constants.kBlackColor,
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
    ),

    // elevated button
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(vertical: 10, horizontal: 20)),
        backgroundColor:
            MaterialStateProperty.all<Color>(Constants.kPrimaryColor),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        textStyle: MaterialStateProperty.all<TextStyle>(
          GoogleFonts.lato(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Constants.kWhiteColor),
        ),
        alignment: Alignment.center,
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      ),
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: const Color(0XFF5A59D6), secondary: const Color(0XFFFF4701)));
