import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../widgets/custom_button.dart';
import 'perio-ins.dart'; 

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

  // Helper to determine if the analysis is complete (successful or failed)
  bool get _hasCompletedAnalysis => _diagnosis != null || _errorMessage != null;

  @override
  void initState() {
    super.initState();
    // OPTIONAL: Auto-run detection immediately on screen load if desired,
    // otherwise, the user presses the button. Keeping the button press for now.
    // _detectImage(); 
  }


  Future<void> _detectImage() async {
    setState(() {
      _loading = true;
      _annotatedImages.clear();
      _errorMessage = null;
      _diagnosis = null;
    });

    if (!await widget.imageFile.exists()) {
      setState(() {
        _loading = false;
        _errorMessage = "Image file not found. Please try again.";
      });
      return;
    }

    const endpoint = "https://deepdent-backend.onrender.com/predict/gingivitis";

    try {
      final response = await ApiService.uploadImage(widget.imageFile, endpoint);

      setState(() => _loading = false);

      if (response == null) {
        setState(
          () =>
              _errorMessage =
                  "Cannot reach detection server. Please try again later.",
        );
        return;
      }

      late Map<String, dynamic> jsonData;
      try {
        jsonData = jsonDecode(response);
      } catch (e) {
        setState(() => _errorMessage = "Invalid response from server.");
        return;
      }

      if (jsonData.containsKey("error")) {
        setState(() {
          _errorMessage = jsonData["error"] ?? "Server error occurred.";
        });
        return;
      }

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

      _diagnosis = jsonData["diagnosis"]?.toString();

      setState(() {});
    } catch (e) {
      setState(() {
        _loading = false;
        _errorMessage = "Unexpected error occurred. Please try again.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF532B88); // Dark purple accent

    return Scaffold(
      appBar: AppBar(
        title: const Text("Gingivitis Detection"),
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
                      Text("Analyzing image... please wait.", style: TextStyle(fontSize: 16, color: primaryColor)),
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
                      Text("Image is ready!", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: primaryColor)),
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

                  // 2. Annotated Images
                  if (_annotatedImages.isNotEmpty) ...[
                    const SizedBox(height: 20),
                    const Text(
                      "Annotated Results:",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: primaryColor),
                    ),
                    const SizedBox(height: 15),
                    
                    // Display images returned by the AI
                    for (final entry in _annotatedImages.entries)
                      if (entry.value != null)
                        Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border.all(color: primaryColor.withOpacity(0.3)),
                              borderRadius: BorderRadius.circular(8)),
                          child: Column(
                            children: [
                              Text(
                                entry.key.toUpperCase(),
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: primaryColor),
                              ),
                              const SizedBox(height: 8),
                              Image.memory(entry.value!, fit: BoxFit.contain),
                            ],
                          ),
                        ),
                  ],

                  // 3. Diagnosis Text
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
                        style: const TextStyle(fontSize: 18, color: Colors.teal, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 30),

                    // 4. Conditional Next Step Button (if gingivitis is found)
                    if (_diagnosis!.toLowerCase().contains("gingivitis"))
                      SizedBox(
                        child: CustomButton( 
                          icon: Icons.arrow_forward,
                          text: "Further Analysis", // Used original text
                          backgroundColor: primaryColor,
                          textColor: Colors.white,
                          iconColor: Colors.white,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PerioInsScreen(),
                              ),
                            );
                          },
                        ),
                      ),
                      
                    const SizedBox(height: 20),

                    // 5. Back Button (if analysis is complete)
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Run New Scan", style: TextStyle(color: Colors.grey, fontFamily: 'InterTight',)),
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