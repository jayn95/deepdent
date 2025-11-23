import 'package:flutter/material.dart';
import '../screens/image_selection_screen.dart';
import '../widgets/custom_button.dart';


class PerioInsScreen extends StatelessWidget {
  const PerioInsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text("Check for Periodontitis")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: const [
                Icon(Icons.camera_alt, size: 40),
                SizedBox(width: 16),
                Expanded(
                  child: Text('Upload a clear panoramic dental X-ray showing the full jaw, including all teeth and surrounding bone.'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Image.asset(
                    'assets/images/p-right.png',
                    height: 120,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Image.asset(
                    'assets/images/p-wrong.png',
                    height: 120,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: const [
                SizedBox(width: 16),
                Expanded(
                  child: Text(
                    '* Make sure the image includes the entire gum line and jawbone.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Row(
              children: const [
                Icon(Icons.info_outline, size: 40),
                SizedBox(width: 16),
                Expanded(
                  child: Text('Ensure the X-ray is not blurry or distorted and free from glare or reflections.'),
                ),
              ],
            ),
            const SizedBox(height: 42),
            // Add Proceed button
            CustomButton(
              text: "Proceed",
              backgroundColor: const Color(0xFF9B72CF),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const ImageSelectionScreen(detectionType: "periodontitis"),
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
