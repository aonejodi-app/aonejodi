import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Theme/theme-colors.dart';
import '../../../controllers/data-controller.dart';

import 'package:flutter_html/flutter_html.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  final DataController dataController = Get.put(DataController());

  @override
  void initState() {
    super.initState();
    dataController.fetchPrivacyPolicy();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Privacy Policy',
          style: TextStyle(
            color: pinkColor,
            fontSize: 22,
          ),
        ),
      ),
      body: Obx(() {
        if (dataController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Html(
            // Converts raw line breaks into HTML breaks so text won't bundle up
            data: dataController.aboutUs.replaceAll('\n', '<br>'),
            style: {
              "body": Style(
                fontSize: FontSize(16),
                color: Colors.black87,
                lineHeight: LineHeight(1.5),
              ),
              "p": Style(
                margin: Margins.only(bottom: 16), // Adds space between paragraphs
              ),
              "b": Style(
                margin: Margins.only(top: 14, bottom: 4),
                fontWeight: FontWeight.bold,
              ),
            },
          ),
        );
      }),
    );
  }
}