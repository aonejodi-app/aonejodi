import 'package:app/Theme/theme-colors.dart';
import 'package:app/controllers/auth-controller.dart';
import 'package:app/models/combined-user-model.dart';
import 'package:app/views/components/dialog-profile.dart';
import 'package:app/views/components/user-info-tile.dart';
import 'package:app/views/screens/edit-user-details.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';

import 'membership-plan-page.dart';

class UserProfile extends StatefulWidget {
  UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final AuthController authController = Get.find();

  // Helper function to handle empty values cleanly
  String getValidValue(String? value) {
    if (value == null || value.trim().isEmpty || value == 'null') {
      return 'Not Specified';
    }
    return value;
  }

  // Helper function to safely parse HTML content
  String getParsedHtml(String? htmlContent) {
    if (htmlContent == null || htmlContent.isEmpty || htmlContent == 'null') {
      return 'Not Specified';
    }
    try {
      final document = parse(htmlContent);
      final String parsedText = document.body?.text ?? '';
      return getValidValue(parsedText);
    } catch (_) {
      return 'Not Specified';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: pinkColor,
        centerTitle: true,
        title: Obx(() {
          final user = authController.currentUser.value;
          return Text(
            (user.fullName.isNotEmpty) ? user.fullName : 'Profile',
            style: const TextStyle(
              color: whiteColor,
              fontSize: 22,
            ),
          );
        }),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: GestureDetector(
              onTap: () async {
                // Ensure latest user state is passed during navigation
                final CombinedUser currentUser = authController.currentUser.value;

                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfilePage(userDetail: currentUser),
                  ),
                );
                setState(() {});
              },
              child: const Text(
                'Edit Profile',
                style: TextStyle(
                  color: whiteColor,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: authController.fetchCurrentUser(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Text('Please wait its loading...'));
          }
          if (snapshot.connectionState == ConnectionState.done) {
            final CombinedUser user = authController.currentUser.value;
            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                        height: MediaQuery.of(context).size.height * 0.55,
                        autoPlayAnimationDuration: const Duration(seconds: 1),
                        autoPlay: true,
                        viewportFraction: 1.0,
                        enlargeCenterPage: false,
                      ),
                      items: [
                        /// MAIN IMAGE
                        Stack(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height * 0.55,
                              child: Image.network(
                                user.image,
                                fit: BoxFit.fitWidth,
                                alignment: Alignment.topCenter,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                    'images/profile.png',
                                    fit: BoxFit.cover,
                                    alignment: Alignment.topCenter,
                                  );
                                },
                              ),
                            ),
                            Positioned(
                              bottom: 16,
                              left: 16,
                              child: Text(
                                '${user.fullName}\n${user.maritalStatus}',
                                style: const TextStyle(
                                  color: whiteColor,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1.7,
                                ),
                              ),
                            ),
                          ],
                        ),

                        /// IMAGE 2
                        SizedBox(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.55,
                          child: user.image2.isEmpty
                              ? Image.asset(
                            "images/splash-screen-logo/img.png",
                            fit: BoxFit.fitWidth,
                            alignment: Alignment.topCenter,
                          )
                              : Image.network(
                            user.image2,
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                          ),
                        ),

                        /// IMAGE 3
                        SizedBox(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.55,
                          child: user.image3.isEmpty
                              ? Image.asset(
                            "images/splash-screen-logo/img.png",
                            fit: BoxFit.fitWidth,
                            alignment: Alignment.topCenter,
                          )
                              : Image.network(
                            user.image3,
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16.0),
                          _buildSectionTitle('Basic Details'),
                          InfoTile(title: 'Profile Id', value: getValidValue(user.uid)),
                          InfoTile(title: 'Full Name', value: getValidValue(user.fullName)),
                          InfoTile(title: 'Gender', value: getValidValue(user.gender)),
                          InfoTile(
                              title: 'Date of Birth',
                              value: '${getValidValue(user.day)}/${getValidValue(user.month)}/${getValidValue(user.year)}'),
                          InfoTile(title: 'Mother Tongue', value: getValidValue(user.motherTongue)),
                          InfoTile(title: 'Religion', value: getValidValue(user.religion)),
                          InfoTile(title: 'Caste', value: getValidValue(user.caste)),
                          InfoTile(title: 'Country', value: getValidValue(user.country)),
                          InfoTile(title: 'State', value: getValidValue(user.state)),
                          InfoTile(title: 'City', value: getValidValue(user.city)),

                          const SizedBox(height: 16.0),
                          _buildSectionTitle('Personal Info'),
                          InfoTile(title: 'Place of Birth', value: getValidValue(user.birthPlace)),
                          InfoTile(title: 'Age', value: getValidValue(user.age)),
                          InfoTile(title: 'Time of Birth', value: getValidValue(user.birthTime)),
                          InfoTile(title: 'Height', value: getValidValue(user.height)),
                          InfoTile(title: 'Body Type', value: getValidValue(user.bodyType)),
                          InfoTile(title: 'Profile created by', value: getValidValue(user.profileCreatedBy)),
                          InfoTile(title: 'Marital Status', value: getValidValue(user.maritalStatus)),
                          InfoTile(
                              title: 'Eating Habit',
                              value: getParsedHtml(user.eating)),
                          InfoTile(title: 'Drinking Habit', value: getValidValue(user.drinking)),
                          InfoTile(title: 'Smoking Habit', value: getValidValue(user.smoking)),
                          InfoTile(title: 'Complexion', value: getValidValue(user.complexion)),
                          InfoTile(title: 'Annual Income', value: getValidValue(user.annualIncome)),

                          const SizedBox(height: 16.0),
                          _buildSectionTitle('Family Details'),
                          InfoTile(title: 'Family Type', value: getValidValue(user.familyType)),
                          InfoTile(title: 'Family Status', value: getValidValue(user.familyStatus)),
                          InfoTile(title: 'Father\'s Occupation', value: getValidValue(user.fathersOccupation)),
                          InfoTile(title: 'Mother\'s Occupation', value: getValidValue(user.mothersOccupation)),
                          InfoTile(title: 'Brother\'s', value: getValidValue(user.brothers)),
                          InfoTile(title: 'Sister\'s', value: getValidValue(user.sisters)),

                          const SizedBox(height: 16.0),
                          _buildSectionTitle('Education and Employment'),
                          InfoTile(title: 'Education', value: getValidValue(user.education)),
                          InfoTile(title: 'Occupation', value: getValidValue(user.profession)),

                          const SizedBox(height: 16.0),
                          _buildSectionTitle('Astrological Details'),
                          InfoTile(
                              title: 'Manglik',
                              value: getParsedHtml(user.manglik)),
                          const SizedBox(height: 25),

                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => MyDialog(
                                    user_id: user.uid,
                                    phoneNum: user.phoneNumber,
                                    email: user.email,
                                    profileDOB: '${user.day}/${user.month}/${user.year}',
                                    isverified: user.isverified ?? "0",
                                    emailId: user.email,
                                    isShortlist: "1"),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.only(top: 50, bottom: 50),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return const SizedBox();
            }
          }
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.black54,
        ),
      ),
    );
  }
}