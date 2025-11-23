import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../screens/detection_gingivitis_screen.dart';
import '../screens/detection_periodontitis_screen.dart';
import '../utils/file_manager.dart';
import '../utils/permissions.dart';
import '../widgets/custom_button.dart';

class ImageSelectionScreen extends StatefulWidget {
  final String detectionType; // "gingivitis" or "periodontitis"

  const ImageSelectionScreen({super.key, required this.detectionType});

  @override
  State<ImageSelectionScreen> createState() => _ImageSelectionScreenState();
}

class _ImageSelectionScreenState extends State<ImageSelectionScreen> {
  File? _selectedImage;

  Future<void> _pickImage(ImageSource source) async {
    await requestPermissions();

    final picker = ImagePicker();
    final pickedFile =
        await picker.pickImage(source: source, imageQuality: 85);

    if (pickedFile != null) {
      final savedImage = await saveImageLocally(pickedFile);
      setState(() => _selectedImage = savedImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Upload Image – ${widget.detectionType}")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 50), // space from app bar

            Center(
              child: Column(
                children: [
                  _selectedImage == null
                      ? const Text(
                          "No image selected.",
                          style: TextStyle(fontSize: 16),
                        )
                      : Image.file(_selectedImage!, height: 250, fit: BoxFit.contain),

                  const SizedBox(height: 20),

                  /// Hide Capture Image button when PERIODONTITIS is selected
                  if (widget.detectionType == "gingivitis")
                    SizedBox(
                      width: 280,
                      child: CustomButton(
                        text: "Capture Image",
                        backgroundColor: const Color(0xFF9B72CF),
                        onPressed: () => _pickImage(ImageSource.camera),
                      ),
                    ),

                  const SizedBox(height: 10),

                  SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      text: "Select from Gallery",
                      backgroundColor: const Color(0xFF9B72CF),
                      onPressed: () => _pickImage(ImageSource.gallery),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 50),

            if (_selectedImage != null)
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  text: "Choose Image",
                  icon: Icons.analytics,
                  onPressed: () {
                    if (widget.detectionType == "gingivitis") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetectionGingivitisScreen(imageFile: _selectedImage!),
                        ),
                      );
                    } else if (widget.detectionType == "periodontitis") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetectionPeriodontitisScreen(imageFile: _selectedImage!),
                        ),
                      );
                    }
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
