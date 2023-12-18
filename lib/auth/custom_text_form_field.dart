import 'package:flutter/material.dart';
import 'package:bloodbond/utils/constants.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.keyboardType,
    this.errorText,
    this.onChanged,
    this.isPassword = false,
  }) : super(key: key);

  final String hintText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool isPassword;
  final TextInputType? keyboardType;
  final String? errorText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
      onChanged: (value) {
        // * Check for custom onChanged function, and proceed accordingly
        if (widget.onChanged != null) {
          widget.onChanged!(value);
        }
      },
      validator: (value) {
        // * if custom validation is provided, proceed with it
        if (widget.validator != null) {
          return widget.validator!(value);
        }
        // * Default validation in-case of no custom validation
        else {
          if (value == null || value.isEmpty) {
            return "Field can't be empty";
          } else {
            return null;
          }
        }
      },
      obscureText: !widget.isPassword ? false : !showPassword,
      obscuringCharacter: '*',
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(
            fontSize: 16,
            color: Colors.black.withOpacity(0.7),
          ),
          errorMaxLines: 1,
          errorText: widget.errorText,
          errorStyle: const TextStyle(
            fontSize: 16,
            color: Colors.red,
          ),
          fillColor: Constants.kPrimaryColor.withOpacity(0.1),
          filled: true,
          prefixIcon: Icon(widget.prefixIcon, color: Constants.kPrimaryColor),
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    showPassword ? Icons.visibility : Icons.visibility_off,
                    color: Constants.kPrimaryColor.withOpacity(0.7),
                  ),
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                )
              : widget.suffixIcon,
          enabledBorder:
              _getBorder(Constants.kPrimaryColor.withOpacity(0.4), 1.5),
          focusedBorder:
              _getBorder(Constants.kPrimaryColor.withOpacity(0.6), 2.5),
          errorBorder: _getBorder(Constants.kErrorColor, 1.5),
          focusedErrorBorder: _getBorder(Constants.kErrorColor, 2.5)),
    );
  }
}

InputBorder _getBorder(Color color, double width) {
  return OutlineInputBorder(
    borderSide: BorderSide(color: color, width: width),
    borderRadius: const BorderRadius.all(
      Radius.circular(12),
    ),
  );
}
