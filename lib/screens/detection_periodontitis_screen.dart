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

  // Helper to determine if the analysis is complete (successful or failed)
  bool get _hasCompletedAnalysis => _toothAnalysis != null || _errorMessage != null;

  Future<void> _detectImage() async {
    setState(() {
      _loading = true;
      _annotatedImages.clear();
      _errorMessage = null;
      _toothAnalysis = null;
    });

    // Check file existence for robustness, consistent with Gingivitis screen
    if (!await widget.imageFile.exists()) {
      setState(() {
        _loading = false;
        _errorMessage = "Image file not found. Please try again.";
      });
      return;
    }

    const endpoint =
        "https://deepdent-backend.onrender.com/predict/periodontitis";

    final response = await ApiService.uploadImage(widget.imageFile, endpoint);

    setState(() => _loading = false);

    if (response == null) {
      setState(
          () => _errorMessage = "Cannot reach detection server. Please try again later.");
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
            // Store the single annotated X-Ray image
            _annotatedImages["Annotated X-Ray"] = base64Decode(base64String); 
          } catch (e) {
            print("Failed to decode annotated image: $e");
            _annotatedImages["Annotated X-Ray"] = null;
          }
        }
      }

      // --- Extract tooth analysis ---
      if (json.containsKey("analysis")) {
        _toothAnalysis = json["analysis"] as String;
      }

      // --- Handle error field ---
      if (json.containsKey("error")) {
         setState(() {
             _errorMessage = json["error"].toString();
         });
      }

      setState(() {});
    } catch (e) {
      setState(() => _errorMessage = "Failed to parse response: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF532B88); // Dark purple accent

    return Scaffold(
      appBar: AppBar(
        title: const Text("Periodontitis Detection"),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: primaryColor, 
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // --- Loading State ---
            if (_loading) 
              const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 80.0),
                  child: Column(
                    children: [
                      CircularProgressIndicator(color: primaryColor),
                      SizedBox(height: 20),
                      Text("Analyzing X-Ray image... please wait.", style: TextStyle(fontSize: 16, color: primaryColor)),
                    ],
                  ),
                ),
              ),

            // --- Pre-Run State: Show Image and Button to Start Analysis ---
            if (!_hasCompletedAnalysis && !_loading)
              Column(
                children: [
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.task_alt_outlined, color: primaryColor, size: 40),
                      SizedBox(width: 15),
                      Text("X-Ray is ready!", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: primaryColor)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Image.file(widget.imageFile, height: 250, fit: BoxFit.contain),
                  const SizedBox(height: 50),
                  SizedBox(
                    width: double.infinity,
                    child: CustomButton( // Consistent CustomButton usage
                      text: "Run Detection",
                      icon: Icons.science,
                      onPressed: _detectImage,
                      backgroundColor: primaryColor,
                      textColor: Colors.white,
                      iconColor: Colors.white,
                    ),
                  ),
                ],
              ),
              
            // --- Post-Run State: Show Results or Error ---
            if (_hasCompletedAnalysis)
              Column(
                children: [
                  // 1. Error Message
                  if (_errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      child: Text(_errorMessage!, style: const TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold)),
                    ),

                  // 2. Annotated X-Ray Image
                  if (_annotatedImages.isNotEmpty) ...[
                    const SizedBox(height: 20),
                    const Text(
                      "Annotated X-Ray:",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: primaryColor),
                    ),
                    const SizedBox(height: 15),
                    
                    // Display the single annotated X-Ray image
                    for (final entry in _annotatedImages.entries)
                      if (entry.value != null)
                        Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border.all(color: primaryColor.withOpacity(0.3)),
                              borderRadius: BorderRadius.circular(8)),
                          child: Image.memory(entry.value!, fit: BoxFit.contain),
                        ),
                  ],

                  // 3. Tooth Analysis Text (Styled box)
                  if (_toothAnalysis != null) ...[
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        // Teal styling consistent with Gingivitis diagnosis box
                        color: Colors.teal.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.teal),
                      ),
                      child: Text(
                        _toothAnalysis!,
                        style: const TextStyle(fontSize: 18, color: Colors.teal, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 30),

                    // 4. Back Button (Run New Scan)
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Run New Scan", style: TextStyle(color: Colors.grey)),
                    ),
                  ],
                ],
              ),
          ],
        ),
      ),
    );
  }
}