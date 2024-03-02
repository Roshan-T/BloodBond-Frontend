import 'package:bloodbond/controller/Signup_controller.dart';
import 'package:bloodbond/screen/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../utils/constants.dart';

class SelectDate extends StatefulWidget {
  const SelectDate({super.key, required this.datename});

  final String datename;

  @override
  State<SelectDate> createState() => _SelectDateState();
}

class _SelectDateState extends State<SelectDate> {
  DateTime? dateSelected;
  final contoller = signupController;

  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2030),
    );
    if (pickedDate != null) {
      print("pickedDate: ${pickedDate}");
      setState(() {
        dateSelected = pickedDate;
        contoller.dateofbirthcontroller.value.text =
            "${dateSelected!.year}-${dateSelected!.month}-${dateSelected!.day}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: () {
        selectDate(context);
      },
      readOnly: true,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.calendar_today),
          isDense: true,
          hintText: dateSelected == null
              ? widget.datename
              : " ${DateFormat('yyyy-MM-dd').format(dateSelected!)}",
          hintStyle: TextStyle(
            fontSize: 16,
            color: Colors.black.withOpacity(0.7),
          ),
          errorMaxLines: 1,
          errorStyle: const TextStyle(
            fontSize: 16,
            color: Colors.red,
          ),
          fillColor: Constants.kPrimaryColor.withOpacity(0.1),
          filled: true,
          enabledBorder:
              _getBorder(Constants.kPrimaryColor.withOpacity(0.4), 1.5),
          focusedBorder:
              _getBorder(Constants.kPrimaryColor.withOpacity(0.6), 2.5),
          errorBorder: _getBorder(Constants.kErrorColor, 1.5),
          focusedErrorBorder: _getBorder(Constants.kErrorColor, 2.5)),
    );
  }

  InputBorder _getBorder(Color color, double width) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color, width: width),
      borderRadius: const BorderRadius.all(
        Radius.circular(12),
      ),
    );
  }
}
