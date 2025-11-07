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
    final pickedFile = await picker.pickImage(source: source, imageQuality: 85);

    if (pickedFile != null) {
      final savedImage = await saveImageLocally(pickedFile);
      setState(() => _selectedImage = savedImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Upload Image – ${widget.detectionType}")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _selectedImage == null
                ? const Text("No image selected.")
                : Image.file(_selectedImage!, height: 250),
            const SizedBox(height: 20),
            CustomButton(
              text: "Capture Image",
              icon: Icons.camera_alt,
              onPressed: () => _pickImage(ImageSource.camera),
            ),
            const SizedBox(height: 10),
            CustomButton(
              text: "Select from Gallery",
              icon: Icons.photo_library,
              onPressed: () => _pickImage(ImageSource.gallery),
            ),
            const SizedBox(height: 20),
            if (_selectedImage != null)
              CustomButton(
                text: "Run Detection",
                icon: Icons.analytics,
                onPressed: () {
                  if (widget.detectionType == "gingivitis") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => DetectionGingivitisScreen(
                              imageFile: _selectedImage!,
                            ),
                      ),
                    );
                  } else if (widget.detectionType == "periodontitis") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => DetectionPeriodontitisScreen(
                              imageFile: _selectedImage!,
                            ),
                      ),
                    );
                  }
                },
              ),
          ],
        ),
      ),
    );
  }
}
