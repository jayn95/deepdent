import 'package:flutter/material.dart';
import '../screens/image_selection_screen.dart';
import '../widgets/custom_button.dart';

class DiseaseSelectionScreen extends StatelessWidget {
  const DiseaseSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Select Detection Type")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Choose the type of detection:",
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            CustomButton(
              text: "Gingivitis Detection",
              icon: Icons.medical_information,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => const ImageSelectionScreen(
                          detectionType: "gingivitis",
                        ),
                  ),
                );
              },
            ),
            const SizedBox(height: 15),
            CustomButton(
              text: "Periodontitis Detection",
              icon: Icons.science,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => const ImageSelectionScreen(
                          detectionType: "periodontitis",
                        ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
