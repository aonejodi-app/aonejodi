import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Theme/theme-colors.dart';
import '../../controllers/data-controller.dart';
import 'package:flutter_html/flutter_html.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  final DataController dataController = Get.put(DataController());

  @override
  void initState() {
    super.initState();
    dataController.fetchAboutUs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'About us',
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
            data: dataController.aboutUs,
            style: {
              "body": Style(
                fontSize: FontSize(16),
                color: Colors.black87,
                lineHeight: LineHeight(1.5),
              ),
            },
          ),
        );
      }),
    );
  }
}
