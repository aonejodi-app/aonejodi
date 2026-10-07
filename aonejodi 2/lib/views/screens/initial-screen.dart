import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app/controllers/auth-controller.dart';
import 'package:app/views/screens/auth_screens/login-page.dart';
import 'package:app/views/screens/home-page.dart';

class InitialScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _checkLoginStatus(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final bool isLoggedIn = snapshot.data ?? false;
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            if (isLoggedIn) {
              Get.offAll(HomePage()); // Navigate to HomePage if logged in
            } else {
              Get.offAll(LoginPage()); // Navigate to LoginPage if not logged in
            }
          });
          return Container(); // Return empty container while navigating
        }
      },
    );
  }

  Future<bool> _checkLoginStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }
}
