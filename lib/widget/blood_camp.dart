import 'package:flutter/material.dart';
import 'package:bloodbond/utils/constants.dart';
import 'package:get/get.dart';

class CampTile extends StatelessWidget {
  final BloodCamp campers;

  const CampTile({super.key, required this.campers});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8),
        height: 200,
        width: 300,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 239, 236, 236),
          border: Border.all(width: 0.5, color: Colors.black),
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    border: Border.all(width: 0.5, color: Colors.black),
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                  ),
                  height: 120,
                  width: 250,
                  child: Image.asset(campers.image)),
            ),
            Text(
              campers.title,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontSize: 20),
            ),
            Text(
              maxLines: 2,
              campers.description,
              style: Theme.of(context).textTheme.labelLarge,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            Center(
              child: SizedBox(
                width: 280,
                child: ElevatedButton(
                  onPressed: () => 'Null',
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Constants.kPrimaryColor),
                  ),
                  child: const Padding(
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.touch_app),
                        Text('View Details')
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ));
  }
}
