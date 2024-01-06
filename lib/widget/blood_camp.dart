import 'package:flutter/material.dart';
import 'package:bloodbond/utils/constants.dart';
import 'package:get/get.dart';

class CampTile extends StatelessWidget {
  final BloodCamp campers;

  const CampTile({super.key, required this.campers});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 250,
        width: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 0.5, color: Colors.black),
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    border: Border.all(width: 0.5, color: Colors.black),
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                  ),
                  height: 80,
                  width: 100,
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
         const  Spacer(
      
           ),
            SizedBox(
              width: Get.width*0.45,
              child: ElevatedButton(
                onPressed: () => 'Null',
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green)),
                child: const Padding(
                  padding: const EdgeInsets.all(4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [Icon(Icons.touch_app), Text('Visit')],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
          ],
        ));
  }
}
