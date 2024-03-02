import 'package:bloodbond/screen/viral_disease_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiseaseAlertModel {
  final String title;
  final String description;
  final String image;
  final void onPressed;

  DiseaseAlertModel({
    required this.title,
    required this.description,
    required this.onPressed,
    required this.image,
  });
}

final List<DiseaseAlertModel> diseaseAlerts = [
  DiseaseAlertModel(
    title: 'Corona Virus',
    image: 'assets/corona.png',
    description:
        'Corona Virus is a deadly virus. It spreads through air and contact.',
    onPressed: () {
      Get.to(ViralDiseaseAlert());
    },
  ),
  DiseaseAlertModel(
    title: 'Dengue',
    image: 'assets/dengue.png',
    description:
        'Dengue is a deadly disease. It spreads through mosquito bites.',
    onPressed: () {},
  ),
  DiseaseAlertModel(
    title: 'Typhoid',
    image: 'assets/typhoid.png',
    description:
        'Typhoid is high fever . It spreads through contaminated food and water.',
    onPressed: () {},
  ),
  DiseaseAlertModel(
    title: 'Cholera',
    image: 'assets/cholera.png',
    description:
        'Cholera is very known deadly disease in countries like Nepal. It spreads through contaminated food and water.',
    onPressed: () {},
  ),
];

class DiseaseScreen extends StatelessWidget {
  const DiseaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Disease'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Expanded(
          child: ListView.separated(
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => index == 0
                      ? Get.to(() => const ViralDiseaseAlert())
                      : null,
                  child: ListTile(
                    minVerticalPadding: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    tileColor: Colors.grey[200],
                    leading: Image.asset(
                      diseaseAlerts[index].image,
                      width: 50,
                      height: 50,
                    ),
                    title: Text(diseaseAlerts[index].title,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    subtitle: Text(diseaseAlerts[index].description,
                        style: TextStyle(fontSize: 15)),
                  ),
                );
              },
              separatorBuilder: (context, _) => SizedBox(height: 10),
              itemCount: diseaseAlerts.length),
        ),
      ),
    );
  }
}
