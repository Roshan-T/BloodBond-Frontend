import 'package:bloodbond/screen/request_description_screendonor.dart';
import 'package:bloodbond/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controller/home_screen_controller.dart';

class EmergencyRequestBox extends StatelessWidget {
  final EmergencyRequest emergencyRequest;
  final width = Get.width;
  EmergencyRequestBox({super.key, required this.emergencyRequest});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          // height: 150,
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 8),
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
                    backgroundColor: Constants.kPrimaryColor,
                    radius: 30,
                    child: Text(
                      emergencyRequest.bloodGroup,
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
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
                                text: emergencyRequest.hospital.city.toString(),
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
                      const SizedBox(height: 3),
                      SizedBox(
                        width: width - 100 - 80,
                        child: RichText(
                          maxLines: 2,
                          text: TextSpan(
                            children: [
                              const WidgetSpan(
                                child: Padding(
                                  padding: EdgeInsets.only(right: 5.0),
                                  child: Icon(
                                    FontAwesomeIcons.clock,
                                    size: 20,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                              TextSpan(
                                text: DateFormat.jm()
                                    .format(emergencyRequest.expiryTime),
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
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              SizedBox(
                width: Get.width,
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(RequestDetail(
                      emergencyRequest: emergencyRequest,
                    ));
                  },
                  child: const Text(
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
            child: const Icon(Icons.hourglass_empty,
                color: Constants.kWhiteColor, size: 20),
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