import 'package:bloodbond/utils/constants.dart';
import 'package:flutter/material.dart';

class RoleChooseBox extends StatelessWidget {
  const RoleChooseBox(
      {required this.isSelected,
      required this.imageLocation,
      required this.user,
      super.key});
  final bool isSelected;
  final String imageLocation;
  final String user;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          border: isSelected
              ? Border.all(color: Constants.kPrimaryColor, width: 2)
              : Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(12)),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Align(
              alignment: Alignment.center,
              child: Row(
                children: [
                  Image.asset(imageLocation, height: 40),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    user,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: Colors.black, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
          isSelected
              ? Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      color: Constants.kPrimaryColor,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10)),
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Constants.kWhiteColor,
                    ),
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
