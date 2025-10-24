// import 'dart:io';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import '../widgets/bbox_painter.dart';

// // expected resultJson structure (example)
// // {
// //   "detections": [
// //     {"label":"redness","confidence":0.92,"box":[x,y,w,h]}, ...
// //   ]
// // }

// class ResultScreen extends StatelessWidget {
//   final File imageFile;
//   final Map<String, dynamic> resultJson;

//   ResultScreen({required this.imageFile, required this.resultJson});

//   @override
//   Widget build(BuildContext context) {
//     final detections = (resultJson['detections'] ?? []) as List<dynamic>;

//     return Scaffold(
//       appBar: AppBar(title: Text('Result')),
//       body: Column(
//         children: [
//           Expanded(
//             child: FutureBuilder(
//               future: imageFile.readAsBytes(),
//               builder: (context, snapshot) {
//                 if (!snapshot.hasData)
//                   return Center(child: CircularProgressIndicator());
//                 final bytes = snapshot.data as Uint8List;
//                 return LayoutBuilder(
//                   builder: (context, constraints) {
//                     // We show image in a FittedBox and overlay BBoxes with CustomPaint
//                     return FittedBox(
//                       fit: BoxFit.contain,
//                       child: SizedBox(
//                         width: constraints.maxWidth,
//                         height: constraints.maxHeight,
//                         child: Stack(
//                           children: [
//                             Image.memory(bytes),
//                             CustomPaint(
//                               painter: BBoxPainter(detections),
//                               child: Container(),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//           SizedBox(height: 8),
//           Text('Detections: ${detections.length}'),
//           SizedBox(height: 12),
//         ],
//       ),
//     );
//   }
// }
