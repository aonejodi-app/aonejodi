import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Theme/theme-colors.dart';
import '../../../controllers/data-controller.dart';

import 'package:flutter_html/flutter_html.dart';

class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions({Key? key}) : super(key: key);

  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  final DataController dataController = Get.put(DataController());

  @override
  void initState() {
    super.initState();
    dataController.fetchTermsConditions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Terms And Conditions',
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
          // Yahan bottom padding badha kar 50 kar di gayi hai taaki neeche space mil jaye
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 50),
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