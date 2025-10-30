import 'dart:convert';
import 'dart:io';
// import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../widgets/custom_button.dart';

class DetectionScreen extends StatefulWidget {
  final File imageFile;
  const DetectionScreen({super.key, required this.imageFile});

  @override
  State<DetectionScreen> createState() => _DetectionScreenState();
}

class _DetectionScreenState extends State<DetectionScreen> {
  bool _loading = false;
  Uint8List? _annotatedImage;
  String? _errorMessage;

  Future<void> _detectImage() async {
    setState(() {
      _loading = true;
      _annotatedImage = null;
      _errorMessage = null;
    });

    // This should match your Space endpoint format
    const endpoint = "http://192.168.1.2:8000/predict";

    final response = await ApiService.uploadImage(widget.imageFile, endpoint);

    setState(() => _loading = false);

    if (response == null) {
      setState(() => _errorMessage = "No response from server");
      return;
    }

    try {
      final json = jsonDecode(response);

      // Expecting a key called "image" containing base64 data
      if (json.containsKey("image")) {
        final base64String = json["image"];
        final bytes = base64Decode(base64String);
        setState(() => _annotatedImage = bytes);
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
      appBar: AppBar(title: const Text("Detection")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Image.file(widget.imageFile, height: 250),
            const SizedBox(height: 20),
            CustomButton(
              text: "Run Detection",
              icon: Icons.science,
              onPressed: _detectImage,
            ),
            const SizedBox(height: 20),
            if (_loading) const CircularProgressIndicator(),
            if (_annotatedImage != null)
              Expanded(
                child: Column(
                  children: [
                    const Text(
                      "Detection Result:",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(child: Image.memory(_annotatedImage!)),
                  ],
                ),
              ),
            if (_errorMessage != null)
              Text(_errorMessage!, style: const TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }
}
