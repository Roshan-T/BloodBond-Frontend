import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../utils/constants.dart';

class SelectDate extends StatefulWidget {
  const SelectDate({super.key});

  @override
  State<SelectDate> createState() => _SelectDateState();
}

class _SelectDateState extends State<SelectDate> {
  DateTime? dateSelected;

  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2030),
    );
    if (pickedDate != null) {
      setState(() {
        dateSelected = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        onTap: () {
          selectDate(context);
        },
        readOnly: true,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.calendar_today),
          isDense: true,
          hintText: dateSelected == null
              ? "Date of birth"
              : " ${DateFormat('yyyy-MM-dd').format(dateSelected!)}",
        ),
      ),
    );
  }
}
