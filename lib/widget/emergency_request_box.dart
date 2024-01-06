import 'package:bloodbond/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EmergencyRequestBox extends StatelessWidget {
  final EmergencyRequest emergencyRequest;
  final width = Get.width;
  EmergencyRequestBox({super.key, required this.emergencyRequest});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 175,
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: const Color.fromARGB(255, 240, 245, 245),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    child: Image.asset(emergencyRequest.imageUrl,
                        height: 60, width: 100, fit: BoxFit.cover),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: width - 100 - 80,
                        child: Text(
                          emergencyRequest.patientName,
                          maxLines: 2,
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        width: width - 100 - 80,
                        child: RichText(
                          maxLines: 2,
                          text: TextSpan(
                            children: [
                              const WidgetSpan(
                                child: Icon(
                                  Icons.place,
                                  size: 24,
                                  color: Colors.red,
                                ),
                              ),
                              TextSpan(
                                text: emergencyRequest.address,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(
                                      fontSize: 15,
                                      color: Colors.black,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        width: width - 100 - 80,
                        child: RichText(
                          maxLines: 2,
                          text: TextSpan(
                            children: [
                              const WidgetSpan(
                                child: Icon(
                                  FontAwesomeIcons.clock,
                                  size: 24,
                                  color: Colors.red,
                                ),
                              ),
                              TextSpan(
                                text: DateFormat.jm()
                                    .format(emergencyRequest.time),
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(
                                      fontSize: 15,
                                      color: Colors.black,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: Get.width,
                child: const ElevatedButton(
                  onPressed: null,
                  child: Text(
                    "Donate Now",
                  ),
                ),
              )
            ],
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(5),
            height: 33,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
                color: Constants.kPrimaryColor),
            child: Text(
              emergencyRequest.bloodGroup,
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}


//  Stack(
//         children: [
//           Row(
//             children: [
//               // Text("🩸",
//               //     style: Theme.of(context).textTheme.headlineLarge!.copyWith(
//               //         color: Constants.kPrimaryColor,
//               //         fontWeight: FontWeight.bold)),
//               // Text(
//               //   emergencyRequest.bloodGroup,
//               //   style: Theme.of(context).textTheme.labelMedium,
//               // ),
//               CircleAvatar(
//                 radius: 40,
//                 backgroundColor: Colors.grey,
//                 child: Image.asset(
//                   fit: BoxFit.cover,
//                   emergencyRequest.imageUrl,
//                 ),
//               ),
//               const SizedBox(
//                 width: 10,
//               ),
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Text(
//                     emergencyRequest.patientName,
//                     style: Theme.of(context)
//                         .textTheme
//                         .titleLarge!
//                         .copyWith(fontSize: 18),
//                   ),
//                   Text(
//                     emergencyRequest.address,
//                     style: Theme.of(context)
//                         .textTheme
//                         .titleMedium!
//                         .copyWith(color: Constants.kGrey),
//                   )
//                 ],
//               )
//             ],
//           )
//         ],
//       ),