import 'dart:io';
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
  String? _result;

  Future<void> _detectImage() async {
    setState(() => _loading = true);

    // TODO: Replace with your endpoint (e.g., "gingi/redness")
    const endpoint = "gingi/redness";
    final result = await ApiService.uploadImage(widget.imageFile, endpoint);

    setState(() {
      _loading = false;
      _result = result ?? "Detection failed";
    });
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
            if (_result != null)
              Text("Result: $_result", style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
