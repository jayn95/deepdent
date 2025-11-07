import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://192.168.1.3:8000";

  static Future<String?> uploadImage(File imageFile, [String? endpoint]) async {
    try {
      // Use provided endpoint, default to "/predict" if null
      final uri = Uri.parse(endpoint ?? "$baseUrl/predict");

      var request = http.MultipartRequest('POST', uri)
        ..files.add(await http.MultipartFile.fromPath('image', imageFile.path));

      final streamedResponse = await request.send().timeout(
        const Duration(seconds: 60),
      );
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        print("✅ Upload success");
        return response.body;
      } else {
        print("❌ Server returned ${response.statusCode}: ${response.body}");
        return "Error ${response.statusCode}";
      }
    } on TimeoutException catch (_) {
      return "Timeout: No response from server.";
    } on SocketException catch (_) {
      return "Network error: Unable to reach server.";
    } catch (e) {
      return "Unexpected error: $e";
    }
  }
}
