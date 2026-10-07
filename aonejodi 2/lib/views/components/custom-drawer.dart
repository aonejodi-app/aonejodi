import 'package:app/Theme/theme-colors.dart';
import 'package:app/controllers/auth-controller.dart';
import 'package:app/views/screens/about_us.dart';
import 'package:app/views/screens/advance-search-page.dart';
import 'package:app/views/screens/auth_screens/login-page.dart';
import 'package:app/views/screens/contact-us-page.dart';
import 'package:app/views/screens/home-page.dart';
import 'package:app/views/screens/match-by-userId/search-matches-by-id.dart';
import 'package:app/views/screens/membership-plan-page.dart';
import 'package:app/views/screens/privacy-policy-page.dart';
import 'package:app/views/screens/search-page.dart';
import 'package:app/views/screens/shortlisted-users-page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../screens/auth_screens/privacy_policy.dart';
import '../screens/auth_screens/terms_and_conditions.dart';

class CustomDrawer extends StatefulWidget {
  CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  final AuthController authController = Get.find();
  final String _url = 'https://superjodi.in/data_deletion.php';

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.9, // 90% of screen width

      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          // --- ADDED TOP CLEARANCE FOR STATUS BAR ---
          SizedBox(height: MediaQuery.of(context).padding.top + 20),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            height: 170,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  height: 120,
                  width: 110,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image:
                      NetworkImage(authController.currentUser.value.image!),
                      fit: BoxFit.fill,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        authController.currentUser.value.fullName!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 19,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(authController.currentUser.value.uid!),
                      const SizedBox(height: 3),
                      const Text('Subscribed to User Plan'),
                      const SizedBox(height: 10),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Get.to(const MembershipPage());
                          },
                          child: Container(
                            constraints: const BoxConstraints(
                              minHeight: 50,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: pinkColor,
                            ),
                            child: const Center(
                              child: Text(
                                'Upgrade Plan',
                                style: TextStyle(
                                  color: whiteColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
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
          _createDrawerItem(
              icon: Icons.info,
              text: 'About Us',
              onTap: () {
                Navigator.pop(context);
                Get.to(AboutUs());
              }),

          _createDrawerItem(
              icon: Icons.card_membership,
              text: 'Membership Plan',
              onTap: () {
                Navigator.pop(context);
                Get.to(const MembershipPage());
              }),
          _createDrawerItem(
              icon: Icons.home,
              text: 'Home',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
              }),
          _createDrawerItem(
              icon: Icons.document_scanner,
              text: 'Terms and Conditions',
              onTap: () {
                Navigator.pop(context);
                Get.to(const TermsAndConditions());
              }),
          _createDrawerItem(
              icon: Icons.privacy_tip,
              text: 'Privacy Policy',
              onTap: () {
                Navigator.pop(context);
                Get.to(PrivacyPolicy());
              }),
          _createDrawerItem(
              icon: Icons.person_search,
              text: 'Search By ID',
              onTap: () {
                Navigator.pop(context);
                Get.to(const SearchByIdPage());
              }),
          _createDrawerItem(
              icon: Icons.contact_page,
              text: 'Contact Us',
              onTap: () {
                Navigator.pop(context);
                Get.to(const ContactUsPage());
              }),
          _createDrawerItem(
              icon: Icons.logout,
              text: 'Logout',
              onTap: () async {
                await authController.logout();
              }),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Copyright © 2024. All rights reserved.',
              style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _createDrawerItem(
      {required IconData icon,
        required String text,
        required GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            size: 18,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
        ],
      ),
      onTap: onTap,
    );
  }

  void onDrawerItemTapped(int index) {
    print("index $index");
    setState(() {
      // currentIndex = index;
    });
    Navigator.pop(context);
  }
}