import 'dart:async';
import 'package:app/controllers/auth-controller.dart';
import 'package:app/controllers/matched-user-controller.dart';
import 'package:app/models/combined-user-model.dart';
import 'package:app/views/components/custom-appbar.dart';
import 'package:app/views/components/custom-drawer.dart';
import 'package:app/views/components/profile-card.dart';
import 'package:app/views/screens/other-user-profile-page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MatchPage extends StatefulWidget {
  const MatchPage({super.key});

  @override
  State<MatchPage> createState() => _MatchPageState();
}

class _MatchPageState extends State<MatchPage> {
  final MatchedUserController matchedUserController =
      Get.put(MatchedUserController());
    final AuthController authController = Get.put(AuthController());
  
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _fetchMatchedUsers();
    _startPeriodicFetch();
  }

  void _fetchMatchedUsers() {

    matchedUserController.matchedUserFind(
        authController.currentUser.value.gender=="Male"?"Female":"Male", authController.currentUser.value.country, authController.currentUser.value.ageBetween);
  }

  void _startPeriodicFetch() {
    _timer = Timer.periodic(const Duration(minutes: 20), (timer) {
      _fetchMatchedUsers();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: CustomDrawer(),
      body: Obx(() {
        if (matchedUserController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (matchedUserController.matchedUsersList.isEmpty) {
          return const Center(child: Text('No users found'));
        // } else {
        //   return ListView.builder(
        //     padding:
        //         const EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
        //     itemCount: matchedUserController.matchedUsersList.length,
        //     itemBuilder: (context, index) {
        //       CombinedUser user = matchedUserController.matchedUsersList[index];
        //       return Padding(
        //         padding: const EdgeInsets.all(8.0),
        //         child: GestureDetector(
        //           onTap: () {
        //             Get.to(OtherUserProfile(user: user,));
        //           },
        //           child: MatchProfileCard(
        //             height: user.height,
        //             imagePath: user.image,
        //             name: user.fullName,
        //             age: user.age,
        //
        //             occupation: user.profession,
        //             // education: user.education,
        //             location: user.state,
        //             isVerified: user.isverified ?? "0",
        //             // userId: user.uid,
        //           ),
        //         ),
        //       );
        //     },
        //   );
        // }
        } else {
          var reversedList =
          matchedUserController.matchedUsersList.reversed.toList();

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
            itemCount: reversedList.length,
            itemBuilder: (context, index) {
              CombinedUser user = reversedList[index];

              return Padding(
                padding: const EdgeInsets.all(8.0),
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
                    location: user.state,
                    isVerified: user.isverified ?? "0",
                  ),
                ),
              );
            },
          );
        }

      }),
    );
  }


}
