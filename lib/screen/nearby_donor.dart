import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bloodbond/utils/constants.dart';

class Nearby extends StatefulWidget {
  const Nearby({super.key});

  @override
  State<Nearby> createState() => _NearbyState();
}

class _NearbyState extends State<Nearby> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Nearby Donors",
            style: TextStyle(color: Colors.black, fontSize: 25),
          ),
          backgroundColor: Constants.kWhiteColor,
          elevation: 0,
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 8,
            ),

            //   SizedBox(height: 20,),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView.separated(
                  itemCount: DonorList.length,
                  itemBuilder: (context, index) {
                    return DonorTile(
                      donors: DonorList[index],
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height: 10,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DonorTile extends StatefulWidget {
  final NearbyDonor donors;

  const DonorTile({super.key, required this.donors});

  @override
  State<DonorTile> createState() => _DonorTileState();
}

class _DonorTileState extends State<DonorTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 0.5, color: Colors.black),
        borderRadius: const BorderRadius.all(Radius.circular(15)),
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 80,
          backgroundColor: Colors.grey,
          child: ClipOval(
            child: Image.asset(
              height: 180,
              width: 60,
              widget.donors.ImagePath,
              fit: BoxFit.cover,
            ),
          ),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("🩸",
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: Constants.kPrimaryColor,
                    fontWeight: FontWeight.bold)),
            Text(
              widget.donors.BloodGroup,
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ],
        ),
        title: Text(
          widget.donors.Name,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 18),
        ),
        subtitle: Text(
          "${widget.donors.phonenumber}",
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ),
    );
  }
}
