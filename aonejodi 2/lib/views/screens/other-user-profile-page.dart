import 'package:app/views/components/dialog-profile.dart';
import 'package:app/views/components/user-info-tile.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:app/Theme/theme-colors.dart';
import 'package:app/models/combined-user-model.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controllers/shortlist-controller.dart';
import 'membership-plan-page.dart';

class OtherUserProfile extends StatelessWidget {
  final CombinedUser user;

  OtherUserProfile({Key? key, required this.user}) : super(key: key);

  final ShortProfilelistController shortProfilelistController =
  Get.put(ShortProfilelistController());

  // Helper function to handle null, empty, or 'null' string values properly
  String getSafeValue(String? value, {String fallback = 'N/A'}) {
    if (value == null ||
        value.trim().isEmpty ||
        value.trim().toLowerCase() == 'null' ||
        value.contains('null:null')) {
      return fallback;
    }
    return value.trim();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: pinkColor,
        centerTitle: true,
        title: Text(
          getSafeValue(user.fullName, fallback: 'Profile Details'),
          style: const TextStyle(
            color: whiteColor,
            fontSize: 22,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  autoPlayAnimationDuration: const Duration(seconds: 1),
                  autoPlay: true,
                  height: 370,
                  viewportFraction: 1.0,
                  enlargeCenterPage: true,
                ),
                items: [
                  Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 370,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: (user.image != null && user.image!.isNotEmpty)
                                ? NetworkImage(user.image!)
                                : const AssetImage('images/profile.png')
                            as ImageProvider,
                            fit: BoxFit.contain,
                            alignment: Alignment.topCenter,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 16,
                        left: 16,
                        child: Row(
                          children: [
                            user.isverified == "1"
                                ? const Icon(
                              Icons.verified,
                              color: Colors.blue,
                              size: 27,
                            )
                                : Container(),
                            const SizedBox(width: 8),
                            Text(
                              '${getSafeValue(user.fullName)}\n${getSafeValue(user.maritalStatus)}',
                              style: const TextStyle(
                                color: whiteColor,
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.7,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    height: 370,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: (user.image2 == null || user.image2 == "")
                            ? const AssetImage("images/splash-screen-logo/img.png")
                            : NetworkImage(user.image2!) as ImageProvider,
                        fit: BoxFit.contain,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 370,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: (user.image3 == null || user.image3 == "")
                            ? const AssetImage("images/splash-screen-logo/img.png")
                            : NetworkImage(user.image3!) as ImageProvider,
                        fit: BoxFit.contain,
                        alignment: Alignment.topCenter,
                      ),
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
                    InfoTile(title: 'Profile Id', value: getSafeValue(user.uid)),
                    InfoTile(title: 'Full Name', value: getSafeValue(user.fullName)),
                    InfoTile(title: 'Gender', value: getSafeValue(user.gender)),
                    InfoTile(
                      title: 'Date of Birth',
                      value: (user.day != null &&
                          user.month != null &&
                          user.year != null &&
                          user.day!.isNotEmpty &&
                          user.month!.isNotEmpty &&
                          user.year!.isNotEmpty)
                          ? '${user.day}/${user.month}/${user.year}'
                          : 'N/A',
                    ),
                    InfoTile(
                        title: 'Mother Tongue',
                        value: getSafeValue(user.motherTongue)),
                    InfoTile(title: 'Religion', value: getSafeValue(user.religion)),
                    InfoTile(title: 'Caste', value: getSafeValue(user.caste)),
                    InfoTile(title: 'Country', value: getSafeValue(user.country)),
                    InfoTile(title: 'State', value: getSafeValue(user.state)),
                    InfoTile(title: 'City', value: getSafeValue(user.city)),

                    const SizedBox(height: 16.0),
                    _buildSectionTitle('Personal Info'),
                    InfoTile(title: 'Place of Birth', value: getSafeValue(user.city)),
                    InfoTile(title: 'Age', value: getSafeValue(user.age)),
                    InfoTile(
                        title: 'Time of Birth',
                        value: getSafeValue(user.birthTime)),
                    InfoTile(title: 'Height', value: getSafeValue(user.height)),
                    InfoTile(title: 'Body Type', value: getSafeValue(user.bodyType)),
                    InfoTile(
                        title: 'Profile created by',
                        value: getSafeValue(user.profileCreatedBy)),
                    InfoTile(
                        title: 'Marital Status',
                        value: getSafeValue(user.maritalStatus)),
                    InfoTile(title: 'Eating Habit', value: getSafeValue(user.eating)),
                    InfoTile(
                        title: 'Drinking Habit',
                        value: getSafeValue(user.drinking)),
                    InfoTile(
                        title: 'Smoking Habit',
                        value: getSafeValue(user.smoking)),
                    InfoTile(
                        title: 'Complexion',
                        value: getSafeValue(user.complexion)),
                    InfoTile(
                        title: 'Annual Income',
                        value: getSafeValue(user.annualIncome)),

                    const SizedBox(height: 16.0),
                    _buildSectionTitle('Family Details'),
                    InfoTile(
                        title: 'Family Type',
                        value: getSafeValue(user.familyType)),
                    InfoTile(
                        title: 'Family Status',
                        value: getSafeValue(user.familyStatus)),
                    InfoTile(
                        title: 'Father\'s Occupation',
                        value: getSafeValue(user.fathersOccupation)),
                    InfoTile(
                        title: 'Mother\'s Occupation',
                        value: getSafeValue(user.mothersOccupation)),
                    InfoTile(
                        title: 'Brother\'s',
                        value: getSafeValue(user.brothers)),
                    InfoTile(
                        title: 'Sister\'s',
                        value: getSafeValue(user.sisters)),

                    const SizedBox(height: 16.0),
                    _buildSectionTitle('Education and Employment'),
                    InfoTile(
                        title: 'Education',
                        value: getSafeValue(user.education)),
                    InfoTile(
                        title: 'Occupation',
                        value: getSafeValue(user.profession)),

                    const SizedBox(height: 16.0),
                    _buildSectionTitle('Astrological Details'),
                    InfoTile(
                      title: 'Manglik',
                      value: (user.manglik != null && user.manglik!.isNotEmpty)
                          ? (parse(user.manglik!).body?.text ?? 'N/A')
                          : 'N/A',
                    ),
                    const SizedBox(height: 25),

                    GestureDetector(
                      onTap: () async {
                        final prefs = await SharedPreferences.getInstance();
                        String? userUid = prefs.getString('my_uid');

                        if (userUid != null) {
                          await shortProfilelistController.onCheckShortlisted(
                              userUid, user.uid);
                          await Future.delayed(const Duration(milliseconds: 300));

                          String emailId =
                              shortProfilelistController.email_id ?? '';
                          String phoneNum =
                              shortProfilelistController.number ?? '';

                          showDialog(
                            context: context,
                            builder: (context) => MyDialog(
                                user_id: user.uid,
                                phoneNum: emailId.isNotEmpty
                                    ? phoneNum
                                    : (user.phoneNumber ?? ''),
                                email: emailId.isNotEmpty
                                    ? emailId
                                    : (user.email ?? ''),
                                profileDOB:
                                '${user.day ?? ''}/${user.month ?? ''}/${user.year ?? ''}',
                                isverified: user.isverified ?? "0",
                                emailId: emailId.isNotEmpty
                                    ? emailId
                                    : (user.email ?? ''),
                                isShortlist: emailId.isNotEmpty ? "1" : "0"),
                          );
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.only(
                          top: 20,
                          bottom: 120,
                        ),
                        alignment: Alignment.center,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: pinkColor,
                        ),
                        child: const Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.phone,
                                color: whiteColor,
                                size: 34,
                              ),
                              SizedBox(width: 15),
                              Text(
                                'View Phone Number',
                                style: TextStyle(
                                  color: whiteColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
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