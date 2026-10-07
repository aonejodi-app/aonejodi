import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class PhotoUploadControllerEditPage extends GetxController {
  var imageBase64_1 = Rx<String?>(null);
  var imageBase64_2 = Rx<String?>(null);
  var imageBase64_3 = Rx<String?>(null);

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage(int index) async {
    try {
      final XFile? pickedFile =
      await _picker.pickImage(source: ImageSource.gallery);

      if (pickedFile == null) {
        print("No image selected");
        return;
      }

      // ✅ Crop image (image_cropper 7.x)
      final CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        compressQuality: 80,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: "Crop Image",
            toolbarColor: Get.theme.primaryColor,
            toolbarWidgetColor: Colors.white,
            hideBottomControls: true,
            lockAspectRatio: false,
            initAspectRatio: CropAspectRatioPreset.original, // ✅ NEW WAY
          ),
          IOSUiSettings(
            title: "Crop Image",
            aspectRatioLockEnabled: false,
          ),
        ],
      );

      if (croppedFile == null) {
        print("Cropping cancelled");
        return;
      }

      final File imageFile = File(croppedFile.path);
      final List<int> imageBytes = await imageFile.readAsBytes();
      final String base64Image = base64Encode(imageBytes);

      if (index == 1) {
        imageBase64_1.value = base64Image;
      } else if (index == 2) {
        imageBase64_2.value = base64Image;
      } else if (index == 3) {
        imageBase64_3.value = base64Image;
      }

      print("Image selected & cropped successfully!");
    } catch (e) {
      print("Error picking or cropping image: $e");
    }
  }
}
