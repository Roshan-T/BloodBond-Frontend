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
        hintStyle: Theme.of(context)
            .textTheme
            .labelMedium!
            .copyWith(color: Constants.kGrey),
        hintText: dateSelected == null
            ? widget.datename
            : " ${DateFormat('yyyy-MM-dd').format(dateSelected!)}",
      ),
    );
  }
}
