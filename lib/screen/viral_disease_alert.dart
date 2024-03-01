import 'package:bloodbond/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ViralDiseaseAlert extends StatefulWidget {
  const ViralDiseaseAlert({Key? key}) : super(key: key);

  @override
  ViralDiseaseAlertState createState() => ViralDiseaseAlertState();
}

class ViralDiseaseAlertState extends State<ViralDiseaseAlert>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.kWhiteColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Constants.kBlackColor),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: false,
        title: Text(
          "COVID-19",
          style: Get.textTheme.headlineSmall?.copyWith(
              color: Constants.kBlackColor, fontWeight: FontWeight.bold),
        ),
        bottom: TabBar(
          controller: _tabController, // Assigning the TabController
          isScrollable: true,
          labelColor: Constants.kPrimaryColor,
          indicatorColor: Constants.kPrimaryColor,
          unselectedLabelColor: Constants.kGrey,
          tabs: const [
            Padding(
              padding: EdgeInsets.all(8),
              child: Text("Symptoms"),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text("Precautions"),
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController, // Assigning the TabController
        children: [
          Column(
            children: [
              Image(
                  image: const AssetImage("images/symptoms.jpg"),
                  fit: BoxFit.contain,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.2),
              Text(
                "Symptoms",
                style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                        color: Colors.blue,
                        fontSize: 30,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold)),
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: 3 / 2,
                            mainAxisSpacing: 20),
                    itemCount: 10,
                    itemBuilder: (BuildContext ctx, index) {
                      return Container(
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        padding: const EdgeInsets.all(10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 5,
                                  spreadRadius: 1)
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          children: [
                            Image(
                                image: AssetImage(images[index]),
                                fit: BoxFit.contain,
                                width: 90,
                                height: 90),
                            Text(
                              symptom[index],
                              style: Get.textTheme.labelLarge!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      );
                    }),
              )
            ],
          ),
          Column(
            children: [
              Image(
                  image: const AssetImage("images/precautions.jpg"),
                  fit: BoxFit.contain,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.2),
              Text(
                "Precautions",
                style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                        color: Colors.blue,
                        fontSize: 30,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold)),
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: 3 / 2,
                            mainAxisSpacing: 20),
                    itemCount: 8,
                    itemBuilder: (BuildContext ctx, index) {
                      return Container(
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        padding: const EdgeInsets.all(10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 5,
                                  spreadRadius: 1)
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          children: [
                            Image(
                                image: AssetImage(pimages[index]),
                                fit: BoxFit.contain,
                                width: 90,
                                height: 90),
                            Text(precaution[index],
                                style: Get.textTheme.labelLarge!
                                    .copyWith(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      );
                    }),
              )
            ],
          )
        ],
      ),
    );
  }
}

List<String> symptom = [
  "Fever",
  "Chest Pain",
  "Loss of Speech",
  "Difficulty Breathing",
  "Headache",
  "Diarrhoea",
  "Loss of taste",
  "Sore throat",
  "Conjunctivitis",
  "Tiredness"
];
List<String> images = [
  "images/Fever.jpg",
  "images/chestpain.png",
  "images/lossofspeech.png",
  "images/difficultybreathing.png",
  "images/headache.jpg",
  "images/diarrhoea.jpg",
  "images/lossoftaste.jpg",
  "images/sore.jpg",
  "images/conjunctivitis.jpg",
  "images/tiredness.jpg"
];

List<String> precaution = [
  "Social Distancing",
  "Wash Hands",
  "Wear a mask",
  "Restrict Travel",
  "Stop Handshake",
  "Do not Gather",
  "Self-quarantine if sick",
  "Mentor Health",
];
List<String> pimages = [
  "images/socialdistancing.jpg",
  "images/washhand.jpg",
  "images/wearmask.jpg",
  "images/travel.jpg",
  "images/nohandshake.jpg",
  "images/gather.jpg",
  "images/quaritine.jpg",
  "images/mentor.jpg",
];
