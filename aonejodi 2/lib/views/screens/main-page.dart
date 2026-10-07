import 'package:app/Theme/theme-colors.dart';
import 'package:app/controllers/auth-controller.dart';
import 'package:app/models/combined-user-model.dart';
import 'package:app/views/components/custom-appbar.dart';
import 'package:app/views/components/custom-drawer.dart';
import 'package:app/views/screens/edit-user-details.dart';
import 'package:app/views/screens/membership-plan-page.dart';
import 'package:app/views/screens/profile-verification-page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class MainPage extends StatelessWidget {
  final AuthController authController = Get.find();
  final String _url = 'https://superjodi.in/';
  final String _instagramUrl = 'https://www.instagram.com/aonejodimatrimony/';

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  List<Map<String, dynamic>> buttonData = [
    {
      'color': const Color.fromRGBO(255, 166, 0, 1),
      'text': 'MEMBERSHIP PLANS',
      'page': MembershipPage(),
    },
    {
      'color': const Color.fromARGB(255, 196, 143, 57),
      'text': 'VERIFY YOUR PROFILE',
      'page': const ProfileVerificationPage(),
    },
    {
      'color': const Color(0xFFE1306C), // Instagram color
      'text': 'FOLLOW US ON INSTAGRAM',
      'url': 'https://www.instagram.com/aonejodimatrimony/',
    },
  ];

  MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: CustomDrawer(),
      body: FutureBuilder(
        future: authController.fetchCurrentUser(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Text('Please wait, loading...'));
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            saveUid(
                authController.currentUser.value.phoneNumber,
                authController.currentUser.value.uid,
                authController.currentUser.value.email);

            final CombinedUser? user = authController.currentUser.value;

            if (user == null ||
                user.image == null ||
                user.fullName == null ||
                user.uid == null) {
              return const Center(child: Text('User data is incomplete'));
            }

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                height: 86,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                  color: pinkColor,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Get.to(EditProfilePage(userDetail: user));
                                      },
                                      child: const Padding(
                                        padding:
                                            EdgeInsets.only(top: 10.0, right: 14),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.person,
                                                color: whiteColor),
                                            Text(
                                              'Edit profile',
                                              style: TextStyle(
                                                  color: whiteColor,
                                                  fontSize: 11),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                bottom: -50,
                                left: MediaQuery.of(context).size.width / 2 - 70,
                                right: MediaQuery.of(context).size.width / 2 - 70,
                                child: Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.2),
                                            spreadRadius: 3,
                                            blurRadius: 10,
                                            offset: const Offset(0, 5),
                                          ),
                                        ],
                                      ),
                                      child: CircleAvatar(
                                        radius: 54,
                                        backgroundColor: whiteColor,
                                        backgroundImage:
                                            NetworkImage(user.image!),
                                      ),
                                    ),
                                    const Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: CircleAvatar(
                                        radius: 16,
                                        backgroundColor: greyColorAddIcon,
                                        child: CircleAvatar(
                                          radius: 15,
                                          backgroundColor: whiteColor,
                                          child: Icon(
                                            Icons.camera_alt,
                                            color: Colors.black,
                                            size: 15,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 60),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              user.isverified == "1"
                                  ? const Icon(
                                      Icons.verified,
                                      color: Colors.blue,
                                      size: 24,
                                    )
                                  : Container(),
                              const SizedBox(width: 8),
                              Text(
                                user.fullName!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: blackColor),
                              ),
                            ],
                          ),
                          Text('Profile ID ${user.uid}'),
                          const SizedBox(height: 10),
                          const Divider(
                            color: greyColorAddIcon,
                            endIndent: 10,
                          ),
                          user.isverified == "0"
                              ? const SizedBox.shrink()
                              : const Text(
                                  'Verified',
                                  style: TextStyle(fontSize: 20),
                                ),
                          const Divider(
                            color: greyColorAddIcon,
                            endIndent: 10,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 12.0),
                            child: Text(
                              '',
                              style: TextStyle(
                                  color: pinkColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Column(
                            children: [
                              // MEMBERSHIP PLANS button -> ALWAYS SHOW
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                margin:
                                    const EdgeInsets.only(bottom: 10, top: 20),
                                height: 60,
                                width: MediaQuery.of(context).size.width -
                                    (MediaQuery.of(context).size.width / 8),
                                decoration: BoxDecoration(
                                  color: buttonData[0]['color'],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: InkWell(
                                  onTap: () => Get.to(MembershipPage()),
                                  child: Center(
                                    child: Text(
                                      buttonData[0]['text'],
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              // VERIFY PROFILE button -> ONLY SHOW when NOT VERIFIED
                              if (user.isverified == "0")
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  margin: const EdgeInsets.only(
                                      bottom: 10, top: 20),
                                  height: 60,
                                  width: MediaQuery.of(context).size.width -
                                      (MediaQuery.of(context).size.width / 8),
                                  decoration: BoxDecoration(
                                    color: buttonData[1]['color'],
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: InkWell(
                                    onTap: () => Get.to(
                                        const ProfileVerificationPage()),
                                    child: Center(
                                      child: Text(
                                        buttonData[1]['text'],
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                              // FOLLOW US ON INSTAGRAM button -> ALWAYS SHOW
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                margin:
                                    const EdgeInsets.only(bottom: 10, top: 20),
                                height: 60,
                                width: MediaQuery.of(context).size.width -
                                    (MediaQuery.of(context).size.width / 8),
                                decoration: BoxDecoration(
                                  color: buttonData[2]['color'],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: InkWell(
                                  onTap: () => _launchURL(_instagramUrl),
                                  child: Center(
                                    child: Text(
                                      buttonData[2]['text'],
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: Text('Something went wrong!'));
          }
        },
      ),
    );
  }

  Future<void> saveUid(String uid, String myuid, String emailid) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_uid', uid);
    await prefs.setString('my_uid', myuid);
    await prefs.setString('email_id', emailid);
  }
}
