import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../widgets/custom_button.dart';
import 'disease_selection_screen.dart';
import 'perio-ins.dart'; // <-- ADD THIS

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

  Future<void> _detectImage() async {
    setState(() {
      _loading = true;
      _annotatedImages.clear();
      _errorMessage = null;
      _diagnosis = null;
    });

    // 🟣 **Check if the image exists before uploading**
    if (!await widget.imageFile.exists()) {
      setState(() {
        _loading = false;
        _errorMessage = "Image file not found. Please try again.";
      });
      return;
    }

    const endpoint = "https://deepdent-backend.onrender.com/predict/gingivitis";

    try {
      // 🟣 **Attempt upload**
      final response = await ApiService.uploadImage(widget.imageFile, endpoint);

      setState(() => _loading = false);

      // 🟣 If backend is down or unreachable
      if (response == null) {
        setState(
          () =>
              _errorMessage =
                  "Cannot reach detection server. Please try again later.",
        );
        return;
      }

      // 🟣 Try to parse JSON safely
      late Map<String, dynamic> jsonData;
      try {
        jsonData = jsonDecode(response);
      } catch (e) {
        setState(() => _errorMessage = "Invalid response from server.");
        return;
      }

      // 🟣 Backend returned an error message
      if (jsonData.containsKey("error")) {
        setState(() {
          _errorMessage = jsonData["error"] ?? "Server error occurred.";
        });
        return;
      }

      // 🟣 Decode annotated images safely
      if (jsonData.containsKey("images")) {
        final images = jsonData["images"] as Map<String, dynamic>;
        _annotatedImages.clear();

        for (final entry in images.entries) {
          final label = entry.key;
          final base64String = entry.value;

          if (base64String == null || base64String.isEmpty) {
            _annotatedImages[label] = null;
            continue;
          }

          try {
            _annotatedImages[label] = base64Decode(base64String);
          } catch (e) {
            print("Failed to decode image for $label: $e");
            _annotatedImages[label] = null;
          }
        }
      }

      // 🟣 Diagnosis message handling
      _diagnosis = jsonData["diagnosis"]?.toString();

      setState(() {});
    } catch (e) {
      // 🟣 For unexpected exceptions
      setState(() {
        _loading = false;
        _errorMessage = "Unexpected error occurred. Please try again.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gingivitis Detection"),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),

            /// Header - Image ready
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

            /// Detection button
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

            /// Annotated images
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

            /// Diagnosis box
            if (_diagnosis != null) ...[
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.teal.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.teal),
                ),
                child: Text(
                  _diagnosis!,
                  style: const TextStyle(fontSize: 16, color: Colors.teal),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),

              /// If gingivitis detected → show button
              if (_diagnosis!.toLowerCase().contains("you have gingivitis"))
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF532B88),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PerioInsScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "Proceed to Periodontitis Detection",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
            ],

            /// Error message
            if (_errorMessage != null)
              Text(_errorMessage!, style: const TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }
}
