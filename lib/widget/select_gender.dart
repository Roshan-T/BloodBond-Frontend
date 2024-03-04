import 'package:bloodbond/screen/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:bloodbond/utils/utils.dart';

class SelectGender extends StatefulWidget {
  const SelectGender({super.key});

  @override
  State<SelectGender> createState() => _SelectGenderState();
}

class _SelectGenderState extends State<SelectGender> {
  bool showHint = true;
  final controller = signupController;
  @override
  void initState() {
    super.initState();
  }

  final genderitems = ["Male", "Female"];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      child: InputDecorator(
        decoration: InputDecoration(
            counterText: "",
            hintText: "Select Gender",
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
        child: DropdownButton(
          items: genderitems.map((valueItem) {
            // to map each item in the genderitems list into a DropdownMenuItem widget
            return DropdownMenuItem(
              value: valueItem,
              child: Text(valueItem),
            );
          }).toList(),

          value: controller.gender.isEmpty
              ? null
              : controller.gender == "M"
                  ? genderitems[0]
                  : genderitems[1],

          onChanged: (newvalue) {
            setState(() {
              controller.gender = newvalue == "Male" ? "M" : "F";
            });
          },

          style: TextStyle(
            fontSize: 16,
            color: Colors.black.withOpacity(0.7),
          ),
          underline: const SizedBox(), //to remove underline
          isExpanded: true,
          hint: Text(
            "Select Gender",
            style: TextStyle(
              fontSize: 16,
              color: Colors.black.withOpacity(0.7),
            ),
          ),
          icon: Icon(
            Icons.arrow_drop_down,
            size: 20,
            color: Constants.kPrimaryColor.withOpacity(0.7),
          ),
          dropdownColor: Colors.white,

          //to transform mapped string into list
        ),
      ),
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
