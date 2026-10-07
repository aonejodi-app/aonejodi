  import 'package:app/Theme/theme-colors.dart';
import 'package:app/controllers/match-by-id-controller.dart';
import 'package:app/models/combined-user-model.dart';
import 'package:app/views/components/profile-card.dart';
import 'package:app/views/screens/other-user-profile-page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class UserProfileResultPage extends StatelessWidget {
  final String userId;
  final MatchedIdUserController matchedIdUserController =
      Get.put(MatchedIdUserController());

  UserProfileResultPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    matchedIdUserController.matchedUserFind(userId);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: pinkColor,
        title: const Text('User Profile', style: TextStyle(color: whiteColor),),
        
      ),
      body: Obx(() {
        if (matchedIdUserController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (matchedIdUserController.matchedUserListById.isEmpty) {
          return const Center(child: Text('No user found for this ID'));
        } else {
          CombinedUser user = matchedIdUserController.matchedUserListById.first;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                InkWell(
                  onTap: (){
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
              ],
            ),
          );
        }
      }),
    );
  }
}
