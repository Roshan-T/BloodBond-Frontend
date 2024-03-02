import 'package:bloodbond/routes/url.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryBox extends StatelessWidget {
  final donorHistory;
  HistoryBox({super.key, required this.donorHistory});
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width * 1;
    return Stack(
      children: [
        Container(
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
                    child: Image.network(
                        Url.getImage + donorHistory.hospital.image,
                        height: 60,
                        width: 100,
                        fit: BoxFit.cover),
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
                          donorHistory.hospital.name,
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
                                  size: 18,
                                  color: Colors.red,
                                ),
                              ),
                              TextSpan(
                                text: donorHistory.hospital.city,
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
              const SizedBox(height: 10),
              const Divider(
                color: Colors.black,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Donate To: ${donorHistory.patientName}",
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${DateFormat('yyyy MMMM dd').format(donorHistory.requestedTime)} | ${DateFormat('HH:mm:a').format(donorHistory.requestedTime)}",
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: Colors.black,
                        ),
                  ),
                ],
              )
            ],
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(5),
            height: 28,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
                color: Colors.green),
            child: Text(
              "Donated",
              style: Theme.of(context)
                  .textTheme
                  .labelSmall!
                  .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
