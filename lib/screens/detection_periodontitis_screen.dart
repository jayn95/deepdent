import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../widgets/custom_button.dart';

class DetectionPeriodontitisScreen extends StatefulWidget {
  final File imageFile;
  const DetectionPeriodontitisScreen({super.key, required this.imageFile});

  @override
  State<DetectionPeriodontitisScreen> createState() =>
      _DetectionPeriodontitisScreenState();
}

class _DetectionPeriodontitisScreenState
    extends State<DetectionPeriodontitisScreen> {
  bool _loading = false;
  Map<String, Uint8List?> _annotatedImages = {};
  String? _errorMessage;
  String? _toothAnalysis;

  Future<void> _detectImage() async {
    setState(() {
      _loading = true;
      _annotatedImages.clear();
      _errorMessage = null;
      _toothAnalysis = null;
    });

    const endpoint =
        "https://deepdent-backend.onrender.com/predict/periodontitis";

    final response = await ApiService.uploadImage(widget.imageFile, endpoint);

    setState(() => _loading = false);

    if (response == null) {
      setState(() => _errorMessage = "No response from server");
      return;
    }

    try {
      final json = jsonDecode(response);

      _annotatedImages.clear();
      _toothAnalysis = null;
      _errorMessage = null;

      // --- Handle annotated image from periodontitis API ---
      if (json.containsKey("annotated_image")) {
        final base64String = json["annotated_image"] as String;
        if (base64String.isNotEmpty) {
          try {
            _annotatedImages["annotated"] = base64Decode(base64String);
          } catch (e) {
            print("Failed to decode annotated image: $e");
            _annotatedImages["annotated"] = null;
          }
        }
      }

      // --- Extract tooth analysis ---
      if (json.containsKey("analysis")) {
        _toothAnalysis = json["analysis"] as String;
      }

      // --- Handle error field ---
      if (json.containsKey("error")) {
        _errorMessage = json["error"].toString();
      }

      setState(() {});
    } catch (e) {
      setState(() => _errorMessage = "Failed to parse response: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Periodontitis Detection")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
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
            if (_annotatedImages.isNotEmpty) ...[
              const SizedBox(height: 20),
              const Text(
                "Detection Results:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              for (final entry in _annotatedImages.entries)
                if (entry.value != null)
                  Column(
                    children: [
                      Image.memory(entry.value!, fit: BoxFit.contain),
                      const SizedBox(height: 20),
                    ],
                  ),
            ],
            if (_toothAnalysis != null) ...[
              const SizedBox(height: 20),
              const Text(
                "Tooth Analysis:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(_toothAnalysis!, style: const TextStyle(fontSize: 16)),
            ],
            if (_errorMessage != null)
              Text(_errorMessage!, style: const TextStyle(color: Colors.red)),

            const SizedBox(height: 30),

            // -------------------- DISCLAIMER --------------------
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: const Text(
                "Disclaimer: This tool can only estimate bone loss on dental X-rays. "
                "A clinical diagnosis is essential for confirming the condition and determining proper treatment.",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black87,
                  height: 1.3,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
