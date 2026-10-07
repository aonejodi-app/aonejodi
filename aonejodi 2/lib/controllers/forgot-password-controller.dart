import 'dart:convert';
import 'dart:math';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ForgotPasswordController extends GetxController {
  var isLoading = false.obs;

  var otpSent = false.obs; // Step 1 done
  var otpVerified = false.obs; // Step 2 done

  var generatedOtp = ''.obs;
  var enteredOtp = ''.obs;
  var emailStored = ''.obs;

  // Generate 4-digit OTP
  void generateOtp() {
    final rnd = Random();
    generatedOtp.value = (1000 + rnd.nextInt(9000)).toString();
    print('Generated OTP: ${generatedOtp.value}');
  }

  // Step 1: Send OTP
  Future<void> sendOtpEmail(String email) async {
    if (email.isEmpty) {
      Get.snackbar("Error", "Enter email");
      return;
    }

    isLoading(true);
    emailStored.value = email;
    generateOtp();

    try {
      final response = await http.post(
        Uri.parse('https://superjodi.in/API/sendOtpEmail.php'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "otp": generatedOtp.value,
        }),
      );

      if (response.statusCode == 200) {
        otpSent(true);
        Get.snackbar("Success", "OTP sent to your email");
      } else {
        Get.snackbar("Error", "Failed to send OTP");
      }
    } catch (e) {
      Get.snackbar("Error", "Error sending OTP: $e");
    } finally {
      isLoading(false);
    }
  }

  // Step 2: Verify OTP
  void verifyOtp() {
    if (enteredOtp.value != generatedOtp.value) {
      Get.snackbar("Error", "Invalid OTP");
      return;
    }
    otpVerified(true);
    Get.snackbar("Success", "OTP Verified");
  }

  // Step 3: Change Password
  Future<void> changePassword(String newPass) async {
    if (!otpVerified.value) {
      Get.snackbar("Error", "Verify OTP first");
      return;
    }
    if (newPass.isEmpty) {
      Get.snackbar("Error", "Enter new password");
      return;
    }

    isLoading(true);
    try {
      final response = await http.post(
        Uri.parse('https://superjodi.in/API/index.php?p=onforgotpassword'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          'email': emailStored.value,
          'password': newPass,
        }),
      );

      if (response.statusCode == 200) {
        Get.snackbar("Success", "Password changed successfully");
        resetProcess();
      } else {
        Get.snackbar("Error", "Failed to change password");
      }
    } catch (e) {
      Get.snackbar("Error", "Error: $e");
    } finally {
      isLoading(false);
    }
  }

  // Reset UI state after success
  void resetProcess() {
    otpSent(false);
    otpVerified(false);
    enteredOtp('');
    generatedOtp('');
    emailStored('');
  }
}
