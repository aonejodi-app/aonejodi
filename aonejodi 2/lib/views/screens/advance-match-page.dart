import 'dart:ffi';

import 'package:app/controllers/adv-search-controller.dart';
import 'package:app/models/combined-user-model.dart';
import 'package:app/views/components/custom-appbar.dart';
import 'package:app/views/components/custom-drawer.dart';
import 'package:app/views/components/profile-card.dart';
import 'package:app/views/screens/other-user-profile-page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdvantageMatchPage extends StatefulWidget {
  const AdvantageMatchPage({super.key});

  @override
  State<AdvantageMatchPage> createState() => _AdvantageMatchPageState();
}

class _AdvantageMatchPageState extends State<AdvantageMatchPage> {
  final AdvantageSearchUserController advantageSearchUserController =
      Get.find();

  @override
  void initState() {
    super.initState();
    if (advantageSearchUserController.advsearchedUserList.isNotEmpty) {
      print(
          advantageSearchUserController.advsearchedUserList[0].age.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    var reversedList = advantageSearchUserController.advsearchedUserList.reversed.toList();
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: CustomDrawer(),
      body: reversedList.isEmpty
          ? Center(child: Text('No user found'))
          : ListView.builder(
              itemCount:
                  reversedList.length,
              itemBuilder: (context, index) {
                CombinedUser user =
                    reversedList[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 14.0, horizontal: 16.0),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(OtherUserProfile(user: user));
                    },
                    child: MatchProfileCard(
                      height: user.height,
                      imagePath: user.image,
                      name: user.fullName,
                      age: user.age,

                      occupation: user.profession,
                      // education: user.education,
                      location: '${user.state} ${user.country}',
                      isVerified: user.isverified ?? "0",
                      // userId: user.uid,
                    ),
                  ),
                );
              },
            ),
    );
  }
}
