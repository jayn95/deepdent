import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../widgets/custom_button.dart';

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

  Future<void> _detectImage() async {
    setState(() {
      _loading = true;
      _annotatedImages.clear();
      _errorMessage = null;
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
            Image.file(widget.imageFile, height: 250, fit: BoxFit.contain),
            const SizedBox(height: 20),
            CustomButton(
              text: "Run Gingivitis Detection",
              icon: Icons.science,
              onPressed: _detectImage,
            ),
            const SizedBox(height: 20),
            if (_loading) const CircularProgressIndicator(),
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
            if (_errorMessage != null)
              Text(_errorMessage!, style: const TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }
}
