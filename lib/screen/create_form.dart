import 'package:bloodbond/screen/create_campaign_request.dart';
import 'package:bloodbond/screen/create_emergency_request.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return BottomSheetSelection();
        },
      );
    });

    return Center(
      child: ElevatedButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return BottomSheetSelection();
            },
          );
        },
        child: Text("Show the bottomsheet"),
      ),
    );
  }
}

class BottomSheetSelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('Create Emergency Request'),
            onTap: () {
              // Close the bottom sheet
              Get.to(const CreateEmergencyRequest());
            },
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('Create Campagin'),
            onTap: () {
              // Close the bottom sheet
              Get.to(const CreateCampaginRequest());
            },
          ),
        ],
      ),
    );
  }
}




// class SelectForm extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             showModalBottomSheet(
//               context: context,
//               builder: (BuildContext context) {
//                 return Container(
//                   child: Wrap(
//                     children: <Widget>[
//                       ListTile(
//                         leading: Icon(Icons.home),
//                         title: Text('Create Emergency Request'),
//                         onTap: () {
//                           Navigator.pop(context); // Close the bottom sheet
//                           Get.to(const CreateEmergencyRequest());
//                         },
//                       ),
//                       ListTile(
//                         leading: Icon(Icons.work),
//                         title: Text('Create Campaign'),
//                         onTap: () {
//                           Navigator.pop(context); // Close the bottom sheet
//                           Get.to(
//                             CreateCampaginRequest(),
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             );
//           },
//           child: Text('Show Bottom Sheet'),
//         ),
//       ),
//     );
//   }
// }
