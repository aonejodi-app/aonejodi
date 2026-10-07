import 'package:app/Theme/theme-colors.dart';
import 'package:app/controllers/forgot-password-controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final ForgotPasswordController forgotPasswordController =
  Get.put(ForgotPasswordController());

  ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          // Background Gradient
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.centerRight,
                  colors: [pinkColor, Colors.white],
                ),
              ),
            ),
          ),

          // Main Content
          Center(
            child: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.90,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(0, 4)),
                  ],
                ),
                child: Obx(() {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Forgot Password",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),

                      // EMAIL FIELD
                      TextField(
                        controller: _emailController,
                        enabled: !forgotPasswordController.otpSent.value,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: "Email ID",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                      const SizedBox(height: 15),

                      // OTP FIELD (After OTP Sent)
                      if (forgotPasswordController.otpSent.value) ...[
                        TextField(
                          controller: _otpController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Enter OTP",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                        const SizedBox(height: 15),
                      ],

                      // PASSWORD FIELD (After OTP Verified)
                      if (forgotPasswordController.otpVerified.value) ...[
                        TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: "New Password",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],

                      // Action Button
                      GestureDetector(
                        onTap: () {
                          final email = _emailController.text.trim();
                          final otp = _otpController.text.trim();
                          final password = _passwordController.text.trim();

                          if (!forgotPasswordController.otpSent.value) {
                            forgotPasswordController.sendOtpEmail(email);
                          } else if (!forgotPasswordController.otpVerified.value) {
                            forgotPasswordController.enteredOtp.value = otp;
                            forgotPasswordController.verifyOtp();
                          } else {
                            forgotPasswordController.changePassword(password);
                          }
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: pinkColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: forgotPasswordController.isLoading.value
                                ? const CircularProgressIndicator(
                                color: Colors.white)
                                : Text(
                              !forgotPasswordController.otpSent.value
                                  ? "Send OTP"
                                  : !forgotPasswordController.otpVerified.value
                                  ? "Verify OTP"
                                  : "Change Password",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),
                    ],
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
