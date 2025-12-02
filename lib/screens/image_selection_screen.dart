import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../screens/detection_gingivitis_screen.dart';
import '../screens/detection_periodontitis_screen.dart';
import '../utils/file_manager.dart';
import '../utils/permissions.dart';
import '../widgets/custom_button.dart';


class ImageSelectionScreen extends StatefulWidget {
  final String detectionType; 

  const ImageSelectionScreen({super.key, required this.detectionType});

  @override
  State<ImageSelectionScreen> createState() => _ImageSelectionScreenState();
}

class _ImageSelectionScreenState extends State<ImageSelectionScreen> {
  File? _selectedImage;
  bool _isProcessing = false; // Added state to prevent double-taps

  Future<void> _pickImage(ImageSource source) async {
    if (_isProcessing) return;
    setState(() {
      _isProcessing = true;
    });

    await requestPermissions();

    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source, imageQuality: 85);

    setState(() {
      _isProcessing = false;
      if (pickedFile != null) {
        _selectedImage = null; 
      }
    });

    if (pickedFile != null) {
      final savedImage = await saveImageLocally(pickedFile);
      setState(() => _selectedImage = savedImage);
    }
  }

  void _analyzeImage() {
    if (_selectedImage == null) return;
    
    // Determine the navigation route based on detectionType
    final Widget destinationScreen = widget.detectionType == "gingivitis"
        ? DetectionGingivitisScreen(imageFile: _selectedImage!)
        : DetectionPeriodontitisScreen(imageFile: _selectedImage!);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => destinationScreen,
      ),
    );
  }

  void _clearImage() {
    setState(() {
      _selectedImage = null;
    });
    // Optionally delete the file locally here if needed, 
  }


  @override
  Widget build(BuildContext context) {
    const Color accentColor = Color(0xFF9B72CF); 

    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Image"),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                color: accentColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: accentColor.withOpacity(0.5)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: _selectedImage == null
                    ? const Center(
                        child: Text(
                          "Tap below to select or capture an image.",
                          style: TextStyle(fontSize: 16, color: accentColor),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : Image.file(
                        _selectedImage!,
                        fit: BoxFit.cover,
                      ),
              ),
            ),

            const SizedBox(height: 20),

            if (_selectedImage == null)
              // State 1: No Image Selected - Show acquisition buttons
              Column(
                children: [
                  // Hide Capture Image button when PERIODONTITIS is selected
                  if (widget.detectionType == "gingivitis")
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: CustomButton(
                        text: "Capture New Image",
                        icon: Icons.camera_alt,
                        backgroundColor: accentColor,
                        onPressed: () => _pickImage(ImageSource.camera),
                        textColor: Colors.white,
                        iconColor: Colors.white,
                      ),
                    ),
                  CustomButton(
                    text: "Select from Gallery",
                    icon: Icons.photo_library,
                    backgroundColor: accentColor.withOpacity(0.8),
                    onPressed: () => _pickImage(ImageSource.gallery),
                    textColor: Colors.white,
                    iconColor: Colors.white,
                  ),
                ],
              )
            else
              Column(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: TextButton.icon(
                      onPressed: _clearImage,
                      icon: const Icon(Icons.edit, size: 18, color: Color.fromARGB(255, 88, 88, 88)),
                      label: const Text(
                        "Change Image",
                        style: TextStyle(color: Color.fromARGB(255, 88, 88, 88), fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero, 
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  CustomButton(
                    text: "Check Image",
                    icon: Icons.analytics,
                    backgroundColor: accentColor,
                    onPressed: _analyzeImage,
                    textColor: Colors.white,
                    iconColor: Colors.white,
                  ),
                ],
              ),
            
            const SizedBox(height: 40),
            Text(
              "DISCLAIMER: This app is NOT a substitute for professional medical diagnosis. Always consult a qualified dentist for final confirmation and treatment.",
              style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: const Color.fromARGB(255, 246, 1, 1)),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}