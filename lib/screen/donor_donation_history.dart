// import 'package:bloodbond/utils/constants.dart';
// import 'package:flutter/material.dart';

// import '../widget/donor_history_box.dart';

// class HistoryScreen extends StatelessWidget {
//   const HistoryScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text(
//           "History",
//           style: Theme.of(context)
//               .textTheme
//               .headlineSmall!
//               .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: Container(
//         padding: const EdgeInsets.symmetric(
//             horizontal: Constants.kHorizontalPadding, vertical: 20),
//         child: donorHistory.isEmpty
//             ? Center(
//                 child: Text("You have no history yet",
//                     style: Theme.of(context).textTheme.headlineSmall!.copyWith(
//                         color: Colors.red, fontWeight: FontWeight.bold)))
//             : ListView.separated(
//                 itemCount: donorHistory.length,
//                 separatorBuilder: (context, index) =>
//                     const SizedBox(height: 20),
//                 itemBuilder: (context, index) {
//                   return HistoryBox(
//                     donorHistory: donorHistory[index],
//                   );
//                 },
//               ),
//       ),
//     );
//   }
// }
