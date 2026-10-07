// import 'package:app/controllers/auth-controller.dart';
// import 'package:app/views/screens/auth_screens/login-page.dart';
// import 'package:app/views/screens/home-page.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class AuthGate extends StatelessWidget {
//   AuthController authController = Get.put(AuthController());
//    AuthGate({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Obx((){
//       if(authController.currentUser.value != null){
//         return HomePage();
//       } 
//       else{
//         return LoginPage();
//       }

//     });
//   }
// }