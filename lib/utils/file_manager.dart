import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';

Future<File> saveImageLocally(XFile pickedFile) async {
  final directory = await getApplicationDocumentsDirectory();
  final fileName =
      "${DateTime.now().millisecondsSinceEpoch}_${basename(pickedFile.path)}";
  final savedImage = File('${directory.path}/$fileName');
  return File(pickedFile.path).copy(savedImage.path);
}
