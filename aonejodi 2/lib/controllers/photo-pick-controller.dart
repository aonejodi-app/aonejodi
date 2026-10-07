import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PhotoUploadController extends GetxController {
  var imageBase64 = Rx<String?>(null);

  final ImagePicker _picker = ImagePicker();

 
  Future<String?> pickImage() async {
    try {
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
 
        File imageFile = File(pickedFile.path);
        List<int> imageBytes = await imageFile.readAsBytes();
        String base64Image = base64Encode(imageBytes);
        imageBase64.value = base64Image;
        return imageBase64.value;
      } else {
        print('No image selected.');
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  
  String? getImageBase64() {
    return imageBase64.value;
  }
}
