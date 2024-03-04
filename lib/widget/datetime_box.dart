import 'package:bloodbond/utils/constants.dart';
import 'package:flutter/material.dart';

class DateTimeBox extends StatelessWidget {
  const DateTimeBox(
      {required this.dateTime,
      required this.onPressed,
      required this.type,
      required this.icon,
      super.key});
  final Icon icon;
  final String type;
  final String dateTime;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onPressed,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              type,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Constants.kGrey, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black26),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    dateTime,
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: Constants.kBlackColor,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 24,
                    width: 24,
                    child: IconButton(
                      onPressed: onPressed,
                      icon: icon,
                      padding: EdgeInsets.zero,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
