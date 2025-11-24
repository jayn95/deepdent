// import 'dart:convert';
// import 'dart:io';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import '../services/api_service.dart';
// import '../widgets/custom_button.dart';
// import 'disease_selection_screen.dart';

// class DetectionGingivitisScreen extends StatefulWidget {
//   final File imageFile;
//   const DetectionGingivitisScreen({super.key, required this.imageFile});

//   @override
//   State<DetectionGingivitisScreen> createState() =>
//       _DetectionGingivitisScreenState();
// }

// class _DetectionGingivitisScreenState extends State<DetectionGingivitisScreen> {
//   bool _loading = false;
//   Map<String, Uint8List?> _annotatedImages = {};
//   String? _errorMessage;
//   String? _diagnosis;
//   String? _userMessage;

//   Future<void> _detectImage() async {
//     setState(() {
//       _loading = true;
//       _annotatedImages.clear();
//       _errorMessage = null;
//       _diagnosis = null;
//       _userMessage = null;
//     });

//     const endpoint = "https://deepdent-backend.onrender.com/predict/gingivitis";
//     final response = await ApiService.uploadImage(widget.imageFile, endpoint);

//     setState(() => _loading = false);

//     if (response == null) {
//       setState(() => _errorMessage = "No response from server");
//       return;
//     }

//     try {
//       final json = jsonDecode(response);
//       print("Gingivitis response: $json");

//       if (json.containsKey("images")) {
//         final images = json["images"] as Map<String, dynamic>;
//         _annotatedImages.clear();

//         images.forEach((label, base64String) {
//           if (base64String != null && base64String.isNotEmpty) {
//             try {
//               _annotatedImages[label] = base64Decode(base64String);
//             } catch (e) {
//               print("Failed to decode $label: $e");
//               _annotatedImages[label] = null;
//             }
//           } else {
//             _annotatedImages[label] = null;
//           }
//         });

//         _diagnosis = json["diagnosis"]?.toString();

//         // ⭐ Generate user-friendly message below images
//         if (_diagnosis != null) {
//           if (_diagnosis!.toLowerCase().contains("gingivitis")) {
//             _userMessage =
//                 "Signs of gingivitis were detected in the image. Look for redness, swelling, or bleeding. "
//                 "We recommend maintaining oral hygiene and visiting your dentist for further evaluation.";
//           } else {
//             _userMessage =
//                 "Gingivitis is unlikely based on this image. Keep up good oral hygiene!";
//           }
//         }

//         setState(() {});
//       } else if (json.containsKey("error")) {
//         setState(() => _errorMessage = json["error"].toString());
//       } else {
//         throw Exception("Unexpected response format: $json");
//       }
//     } catch (e) {
//       setState(() => _errorMessage = "Failed to parse image: $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Gingivitis Detection")),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Image.file(widget.imageFile, height: 250, fit: BoxFit.contain),
//             const SizedBox(height: 20),
//             CustomButton(
//               text: "Run Gingivitis Detection",
//               icon: Icons.science,
//               onPressed: _detectImage,
//             ),
//             const SizedBox(height: 20),
//             if (_loading) const CircularProgressIndicator(),
//             if (_annotatedImages.isNotEmpty) ...[
//               const Text(
//                 "Detection Results:",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 10),
//               for (final entry in _annotatedImages.entries)
//                 if (entry.value != null)
//                   Column(
//                     children: [
//                       Text(
//                         entry.key.toUpperCase(),
//                         style: const TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       Image.memory(entry.value!, fit: BoxFit.contain),
//                       const SizedBox(height: 20),
//                     ],
//                   ),
//             ],
//             // ⭐ Show diagnosis message below images
//             if (_userMessage != null) ...[
//               const SizedBox(height: 10),
//               Container(
//                 padding: const EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   color: Colors.teal.shade50,
//                   borderRadius: BorderRadius.circular(8),
//                   border: Border.all(color: Colors.teal),
//                 ),
//                 child: Text(
//                   _userMessage!,
//                   style: const TextStyle(fontSize: 16, color: Colors.teal),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               const SizedBox(height: 10),
//               // Optional: add button to proceed to perio detection
//               if (_diagnosis!.toLowerCase().contains("gingivitis"))
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => DiseaseSelectionScreen(),
//                       ),
//                     );
//                   },
//                   child: const Text("Proceed to Periodontitis Detection"),
//                 ),
//             ],
//             if (_errorMessage != null)
//               Text(_errorMessage!, style: const TextStyle(color: Colors.red)),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../widgets/custom_button.dart';
import 'disease_selection_screen.dart';

class DetectionGingivitisScreen extends StatefulWidget {
  final File imageFile;
  const DetectionGingivitisScreen({super.key, required this.imageFile});

  @override
  State<DetectionGingivitisScreen> createState() =>
      _DetectionGingivitisScreenState();
}

class _DetectionGingivitisScreenState extends State<DetectionGingivitisScreen> {
  bool _loading = false;
  Map<String, Uint8List?> _annotatedImages = {};
  String? _errorMessage;
  String? _diagnosis;
  String? _userMessage;

  Future<void> _detectImage() async {
    setState(() {
      _loading = true;
      _annotatedImages.clear();
      _errorMessage = null;
      _diagnosis = null;
      _userMessage = null;
    });

    const endpoint = "https://deepdent-backend.onrender.com/predict/gingivitis";
    final response = await ApiService.uploadImage(widget.imageFile, endpoint);

    setState(() => _loading = false);

    if (response == null) {
      setState(() => _errorMessage = "No response from server");
      return;
    }

    try {
      final json = jsonDecode(response);
      print("Gingivitis response: $json");

      if (json.containsKey("images")) {
        final images = json["images"] as Map<String, dynamic>;
        _annotatedImages.clear();

        images.forEach((label, base64String) {
          if (base64String != null && base64String.isNotEmpty) {
            try {
              _annotatedImages[label] = base64Decode(base64String);
            } catch (e) {
              print("Failed to decode $label: $e");
              _annotatedImages[label] = null;
            }
          } else {
            _annotatedImages[label] = null;
          }
        });

        _diagnosis = json["diagnosis"]?.toString();

        // User-friendly message
        if (_diagnosis != null) {
          if (_diagnosis!.toLowerCase().contains("gingivitis")) {
            _userMessage =
                "Signs of gingivitis were detected. Look for redness, swelling, or bleeding. "
                "We recommend maintaining oral hygiene and visiting your dentist.";
          } else {
            _userMessage =
                "Gingivitis is unlikely based on this image. Keep up good oral hygiene!";
          }
        }

        setState(() {});
      } else if (json.containsKey("error")) {
        setState(() => _errorMessage = json["error"].toString());
      } else {
        throw Exception("Unexpected response format: $json");
      }
    } catch (e) {
      setState(() => _errorMessage = "Failed to parse image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Gingivitis Detection")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),

            // Centered "Image ready for detection" text with icon
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.task_alt_outlined,
                  color: Color(0xFF532B88),
                  size: 40,
                ),
                SizedBox(width: 15),
                Text(
                  "Image ready for detection",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF532B88),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
            Image.file(widget.imageFile, height: 250, fit: BoxFit.contain),
            const SizedBox(height: 50),

            // Detection button
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                text: "Run Detection",
                icon: Icons.science,
                onPressed: _detectImage,
                backgroundColor: const Color(0xFF532B88),
              ),
            ),
            const SizedBox(height: 20),

            if (_loading) const CircularProgressIndicator(),

            // Annotated images
            if (_annotatedImages.isNotEmpty) ...[
              const Text(
                "Detection Results:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              for (final entry in _annotatedImages.entries)
                if (entry.value != null)
                  Column(
                    children: [
                      Text(
                        entry.key.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Image.memory(entry.value!, fit: BoxFit.contain),
                      const SizedBox(height: 20),
                    ],
                  ),
            ],

            // Diagnosis message below images
            if (_userMessage != null) ...[
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.teal.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.teal),
                ),
                child: Text(
                  _userMessage!,
                  style: const TextStyle(fontSize: 16, color: Colors.teal),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 10),
              if (_diagnosis!.toLowerCase().contains("gingivitis"))
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DiseaseSelectionScreen(),
                      ),
                    );
                  },
                  child: const Text("Proceed to Periodontitis Detection"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF532B88),
                  ),
                ),
            ],

            // Error message
            if (_errorMessage != null)
              Text(_errorMessage!, style: const TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }
}
