// import 'dart:io';
// import 'package:http/http.dart' as http;

// class ApiService {
//   static const String baseUrl = "http://YOUR_BACKEND_IP:8000"; // Replace later

//   static Future<String?> uploadImage(File imageFile, String endpoint) async {
//     final uri = Uri.parse("$baseUrl/$endpoint");

//     final request = http.MultipartRequest('POST', uri)
//       ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

//     final response = await request.send();

//     if (response.statusCode == 200) {
//       final responseBody = await response.stream.bytesToString();
//       return responseBody;
//     } else {
//       return "Error: ${response.statusCode}";
//     }
//   }
// }

import 'dart:io';
import 'dart:async';

class ApiService {
  static Future<String?> uploadImage(File imageFile, String endpoint) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));
    // Return a mock result
    return "✅ Simulated detection successful for $endpoint!";
  }
}
