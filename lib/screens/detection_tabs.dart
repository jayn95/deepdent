// import 'package:flutter/material.dart';
// import 'detection_gingivitis_screen.dart';
// import 'detection_periodontitis_screen.dart';
// import 'dart:io';

// class DetectionTabs extends StatelessWidget {
//   final File? initialImage;

//   const DetectionTabs({super.key, this.initialImage});

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2, // Gingivitis + Periodontitis
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text("DeepDent AI"),
//           bottom: const TabBar(
//             tabs: [
//               Tab(icon: Icon(Icons.health_and_safety), text: "Gingivitis"),
//               Tab(icon: Icon(Icons.medical_services), text: "Periodontitis"),
//             ],
//           ),
//         ),
//         body: TabBarView(
//           children: [
//             // Pass the selected image if available
//             DetectionGingivitisScreen(imageFile: initialImage ?? File('')),
//             DetectionPeriodontitisScreen(imageFile: null),
//           ],
//         ),
//       ),
//     );
//   }
// }
