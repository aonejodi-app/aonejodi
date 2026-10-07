import 'package:app/controllers/search-controller.dart';
import 'package:app/models/combined-user-model.dart';
import 'package:app/views/components/custom-appbar.dart';
import 'package:app/views/components/custom-drawer.dart';
import 'package:app/views/components/profile-card.dart';
import 'package:app/views/screens/other-user-profile-page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchMatchPage extends StatefulWidget {
  const SearchMatchPage({super.key});

  @override
  State<SearchMatchPage> createState() => _MatchPageState();
}

class _MatchPageState extends State<SearchMatchPage> {
  final SearchUserController searchUserController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //searchUserController.searchedUserList=[];
    //print(searchUserController.searchedUserList[0].age.toString());
  }

  @override
  Widget build(BuildContext context) {
    var reversedList = searchUserController.searchedUserList.reversed.toList();
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: CustomDrawer(),
      body: (reversedList.isNotEmpty)
          ? ListView.builder(
              itemCount: reversedList.length,
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
            )
          : const Center(
              child: Text('No users found'),
            ),
    );
  }
}
