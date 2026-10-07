import 'dart:developer';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:app/controllers/auth-controller.dart';
import 'package:app/views/screens/auth_screens/login-page.dart';
import 'package:app/views/screens/home-page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AuthController authController = Get.put(AuthController());
  await authController.fetchCurrentUser();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoading = true;
  bool? isLoggedIn;

  Future<bool> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    log("THIS IS THE VALUE OF SHARED PREFERENCE");
    print(prefs.getBool('isLoggedIn'));

    return prefs.getBool('isLoggedIn') ?? false;
  }

  @override
  void initState() {
    super.initState();
    checkLoginStatus().then((value) {
      setState(() {
        isLoggedIn = value;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/home', page: () => const HomePage()),
        GetPage(name: '/login', page: () => LoginPage()),
      ],
      title: 'AOneJodi',
      home: isLoading
          ? const Scaffold(
        backgroundColor: Colors.white,
        body: Center(child: CircularProgressIndicator()),
      )
          : Stack(
        children: [
          // 1. Edge-to-Edge full screen wallpaper image
          Positioned.fill(
            child: Image.asset(
              'images/splash-screen-logo/appsplash.jpg',
              fit: BoxFit.cover, // Screen ke according auto-fit karega
            ),
          ),

          // 2. Navigation controller with transparent overlay
          AnimatedSplashScreen(
            splash: const SizedBox.shrink(),
            centered: true,
            nextScreen: isLoggedIn! ? const HomePage() : LoginPage(),
            backgroundColor: Colors.transparent,
            duration: 2500, // 2.5 seconds hold duration
            splashTransition: SplashTransition.fadeTransition,
          ),
        ],
      ),
    );
  }
}