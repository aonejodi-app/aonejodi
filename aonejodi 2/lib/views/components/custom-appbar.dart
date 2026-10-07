import 'dart:convert';

import 'package:app/Theme/theme-colors.dart';
import 'package:app/controllers/auth-controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (authController) {
        return AppBar(
          backgroundColor: pinkColor,
          leadingWidth: 70,
          leading: Builder(
            builder: (context) => GestureDetector(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, bottom: 10),
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    // CircleAvatar(
                    //     radius: 30, // Adjust the radius as needed
                    //     backgroundImage: NetworkImage(
                    //         authController.currentUser.value.image!)),
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: whiteColor,
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: pinkColor,
                        child: Icon(Icons.menu, size: 30, color: whiteColor),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                authController.currentUser.value.fullName,
                style: TextStyle(color: whiteColor, fontSize: 18),
              ),

            ],
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
