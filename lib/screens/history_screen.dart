// import 'dart:io';
// import 'package:flutter/material.dart';
// import '../utils/storage.dart';
// import 'result_screen.dart';

// class HistoryScreen extends StatefulWidget {
//   @override
//   State<HistoryScreen> createState() => _HistoryScreenState();
// }

// class _HistoryScreenState extends State<HistoryScreen> {
//   List<Map<String, dynamic>> _items = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadHistory();
//   }

//   Future<void> _loadHistory() async {
//     final list = await Storage.loadHistory();
//     setState(() => _items = list);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('History')),
//       body:
//           _items.isEmpty
//               ? Center(child: Text('No history yet'))
//               : ListView.builder(
//                 itemCount: _items.length,
//                 itemBuilder: (context, i) {
//                   final item = _items[i];
//                   return ListTile(
//                     leading: Image.file(
//                       File(item['imagePath']),
//                       width: 56,
//                       height: 56,
//                       fit: BoxFit.cover,
//                     ),
//                     title: Text(item['timestamp'] ?? ''),
//                     subtitle: Text(
//                       'Detections: ${item['detections']?.length ?? 0}',
//                     ),
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder:
//                               (_) => ResultScreen(
//                                 imageFile: File(item['imagePath']),
//                                 resultJson: item['result'],
//                               ),
//                         ),
//                       );
//                     },
//                   );
//                 },
//               ),
//     );
//   }
// }
