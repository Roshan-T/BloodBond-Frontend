import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bloodbond/utils/constants.dart';

class CaBlood extends StatefulWidget {
  const CaBlood({super.key});

  @override
  State<CaBlood> createState() => _CaBloodState();
}

class _CaBloodState extends State<CaBlood> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "CA Donors",
            style: TextStyle(color: Colors.black, fontSize: 25),
          ),
          backgroundColor: Constants.kWhiteColor,
          elevation: 0,
        ),
        body: Card(
          elevation: 50,
          child: Container(
            height:400 ,
            width: Get.width ,
            child: Column(
              children: [
                const SizedBox(
                  height: 8,
                ),
            
                //   SizedBox(height: 20,),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: DonorList.length,
                      itemBuilder: (context, index) {
                        return CampTile(
                          campers: bloodCamp[index],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(
                          width: 10,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

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
                  height: 200,
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
         const  Spacer(
      
           ),
            SizedBox(
              width: Get.width*0.65,
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
