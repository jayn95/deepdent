// import 'package:flutter/material.dart';

// class BBoxPainter extends CustomPainter {
//   final List<dynamic> detections;
//   BBoxPainter(this.detections);

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint =
//         Paint()
//           ..style = PaintingStyle.stroke
//           ..strokeWidth = 3.0;

//     for (var d in detections) {
//       // Expecting box normalized [x,y,w,h] in 0..1 OR absolute depending on backend.
//       // We'll try to handle normalized boxes (0..1).
//       try {
//         final box = d['box'] as List<dynamic>;
//         double x = (box[0] as num).toDouble();
//         double y = (box[1] as num).toDouble();
//         double w = (box[2] as num).toDouble();
//         double h = (box[3] as num).toDouble();

//         // If numbers look like normalized (<=1) scale to canvas
//         if (x <= 1 && y <= 1 && w <= 1 && h <= 1) {
//           x = x * size.width;
//           y = y * size.height;
//           w = w * size.width;
//           h = h * size.height;
//         }

//         final rect = Rect.fromLTWH(x, y, w, h);
//         paint.color = Colors.red;
//         canvas.drawRect(rect, paint);

//         // label
//         final textPainter = TextPainter(
//           text: TextSpan(
//             text:
//                 '${d['label']} ${(d['confidence'] * 100).toStringAsFixed(0)}%',
//             style: TextStyle(
//               color: Colors.white,
//               backgroundColor: Colors.red,
//               fontSize: 12,
//             ),
//           ),
//           textDirection: TextDirection.ltr,
//         );
//         textPainter.layout();
//         textPainter.paint(canvas, Offset(x, y - textPainter.height));
//       } catch (e) {
//         // ignore malformed boxes
//       }
//     }
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// }
