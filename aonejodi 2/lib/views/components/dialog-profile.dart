import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Theme/theme-colors.dart';
import '../../controllers/shortlist-controller.dart';
import '../screens/membership-plan-page.dart';

class MyDialog extends StatefulWidget {
  final String phoneNum;
  final String email;
  final String profileDOB;
  final String isverified;
  final String emailId;
  final String user_id;
  final String isShortlist;

  const MyDialog({
    super.key,
    required this.phoneNum,
    required this.email,
    required this.profileDOB,
    required this.isverified,
    required this.emailId,
    required this.user_id,
    required this.isShortlist,
  });

  @override
  State<MyDialog> createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  final ShortProfilelistController shortProfilelistController = Get.put(ShortProfilelistController());

  String emailId = "";
  String phoneNum = "";
  String isShortlist = "0";

  @override
  void initState() {
    super.initState();
    emailId = widget.emailId;
    phoneNum = widget.phoneNum;
    isShortlist = widget.isShortlist;
  }

  @override
  void didUpdateWidget(covariant MyDialog oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isShortlist != widget.isShortlist ||
        oldWidget.emailId != widget.emailId ||
        oldWidget.phoneNum != widget.phoneNum) {
      setState(() {
        emailId = widget.emailId;
        phoneNum = widget.phoneNum;
        isShortlist = widget.isShortlist;
      });
    }
  }

  // --- Formatting Helpers ---
  String formatPartialPhone(String rawPhone) {
    if (rawPhone.isEmpty) return "";
    String cleanPhone = rawPhone.replaceAll(RegExp(r'[\s\-\(\)]'), '');
    if (cleanPhone.length < 10) return rawPhone;
    return "+91*******${cleanPhone.substring(cleanPhone.length - 4)}";
  }

  String formatPartialEmail(String rawEmail) {
    if (rawEmail.isEmpty || !rawEmail.contains('@')) return rawEmail;
    final parts = rawEmail.split('@');
    final localPart = parts[0];
    final domainPart = parts[1];
    if (localPart.length <= 3) {
      return "${localPart}***@$domainPart";
    }
    return "${localPart.substring(0, 2)}*****@$domainPart";
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      content: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header Section
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.pink,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 24.0),
              child: const Text(
                'Contact Details',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ),

            // Details Section
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailTile(
                    label: 'Primary Contact Number',
                    value: isShortlist == "1" ? phoneNum : formatPartialPhone(phoneNum),
                    trailing: widget.isverified == "1" && isShortlist == "1"
                        ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.verified, color: Colors.green[600], size: 16),
                        const SizedBox(width: 4),
                        Text('Verified', style: TextStyle(color: Colors.green[600], fontSize: 12, fontWeight: FontWeight.bold)),
                      ],
                    )
                        : null,
                  ),
                  const SizedBox(height: 16),
                  _buildDetailTile(
                    label: 'Email ID',
                    value: isShortlist == "1" ? emailId : formatPartialEmail(emailId),
                  ),
                  const SizedBox(height: 16),
                  _buildDetailTile(
                    label: 'Profile Date of Birth',
                    value: widget.profileDOB,
                  ),

                  // Action Button
                  if (isShortlist == "0") ...[
                    const SizedBox(height: 24),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: pinkColor,
                        minimumSize: const Size(double.infinity, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      onPressed: () async {
                        final prefs = await SharedPreferences.getInstance();
                        String? userUid = prefs.getString('my_uid');

                        if (userUid != null) {
                          // Rely entirely on your backend api to permit/reject the action
                          await shortProfilelistController.onShortlisted(userUid, widget.user_id);
                          await Future.delayed(const Duration(milliseconds: 300));

                          if (shortProfilelistController.email_id.isNotEmpty) {
                            setState(() {
                              emailId = shortProfilelistController.email_id;
                              phoneNum = shortProfilelistController.number;
                              isShortlist = "1";
                            });
                          } else {
                            // If backend leaves data empty (no valid plan), redirect them smoothly
                            Navigator.pop(context);
                            Get.to(() => const MembershipPage());
                          }
                        }
                      },
                      child: const Text(
                        'View Phone Number',
                        style: TextStyle(
                          color: whiteColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ] else ...[
                    const SizedBox(height: 12),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailTile({required String label, required String value, Widget? trailing}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 11,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
            if (trailing != null) trailing,
          ],
        ),
        const SizedBox(height: 6),
        Divider(color: Colors.grey[200], thickness: 1),
      ],
    );
  }
}