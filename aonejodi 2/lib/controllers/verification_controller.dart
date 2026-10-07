import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../views/screens/home-page.dart';

class VerificationController extends GetxController {
  var selectedCountryCode = Rxn<String>();
  var isVerificationInProgress = false.obs;

  // Helper method to handle the response
  void _handleResponse(http.Response response, String verificationType) {
    try {
      final Map<String, dynamic> responseData = json.decode(response.body);

      if (response.statusCode == 200 && responseData['success'] == true) {
        // Success case
        final data = responseData['data'];
        Get.snackbar(
          "Verification Successful",
          "$verificationType verification completed.\nClient ID: ${data['client_id'] ?? 'Unknown'}",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // Navigate to home page
        Future.delayed(const Duration(seconds: 1), () {
          Get.offAllNamed('/home');
        });
      } else {
        // Failure case
        Get.snackbar(
          "Verification Failed",
          "Reason: ${responseData['message'] ?? 'Unknown error occurred'}",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Verification Error",
        "An unexpected error occurred: ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
    isVerificationInProgress.value = false; // Reset the button state
  }

  Future<void> verifyUserAdhaar(String number, String email) async {
    isVerificationInProgress.value = true;
    final uri = Uri.parse('https://superjodi.in/API/verify.php');
    final body =
        jsonEncode({"number": number, "email": email, "type": "aadhaar"});
    try {
      final response = await http.post(
        uri,
        body: body,
        headers: {'Content-Type': 'application/json'},
      );
      _handleResponse(response, "Aadhaar Card");
    } catch (e) {
      isVerificationInProgress.value = false;
      Get.snackbar(
        "Verification Failed",
        "An error occurred during Aadhaar verification: ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> verifyUserDL(String number, String email, String dob) async {
    isVerificationInProgress.value = true;
    final uri = Uri.parse('https://superjodi.in/API/verify.php');
    final body = jsonEncode(
        {"number": number, "email": email, "type": "DL", "dob": dob});
    try {
      final response = await http.post(
        uri,
        body: body,
        headers: {'Content-Type': 'application/json'},
      );
      _handleResponse(response, "Driving License");
    } catch (e) {
      isVerificationInProgress.value = false;
      Get.snackbar(
        "Verification Failed",
        "An error occurred during Driving License verification: ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> verifyUserPanCard(String number, String email) async {
    isVerificationInProgress.value = true;
    final uri = Uri.parse('https://superjodi.in/API/verify.php');
    final body =
        jsonEncode({"number": number, "email": email, "type": "pancard"});
    try {
      final response = await http.post(
        uri,
        body: body,
        headers: {'Content-Type': 'application/json'},
      );
      _handleResponse(response, "Pan Card");
    } catch (e) {
      isVerificationInProgress.value = false;
      Get.snackbar(
        "Verification Failed",
        "An error occurred during Pan Card verification: ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
