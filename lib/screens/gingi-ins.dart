import 'package:flutter/material.dart';
import '../screens/image_selection_screen.dart';
import '../widgets/custom_button.dart';

class GingiInsScreen extends StatelessWidget {
  const GingiInsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Check for Gingivitis"),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
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
                  child: Text('Open your mouth to expose your teeth and gums.'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Image.asset(
                    'assets/images/right.png',
                    height: 120,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Image.asset(
                    'assets/images/wrong.png',
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
                    '* Expose top and bottom part of the mouth. Gently pull your lips back to expose the gums. Ask assistance if needed.',
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
                  child: Text('Ensure good lighting for accurate results.'),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Row(
              children: const [
                Icon(Icons.check_circle_outline, size: 40),
                SizedBox(width: 16),
                Expanded(
                  child: Text('Follow these instructions carefully.'),
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
                    builder:
                        (context) => const ImageSelectionScreen(
                          detectionType: "gingivitis",
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
