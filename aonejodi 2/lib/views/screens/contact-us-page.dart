import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Theme/theme-colors.dart';
import '../../controllers/data-controller.dart'; // adjust the path
import 'package:flutter/services.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({Key? key}) : super(key: key);

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  final DataController dataController = Get.put(DataController());

  @override
  void initState() {
    super.initState();
    dataController.fetchContactInfo(); // fetch API data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: pinkColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: Colors.white),
          onPressed: () {
            Get.back();
          },
        ),
        centerTitle: true,
        title: const Text(
          'Contact Us',
          style: TextStyle(fontWeight: FontWeight.w500, color: whiteColor),
        ),
      ),
      body: Obx(() {
        if (dataController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              ContactInfoCard(
                icon: Icons.location_on,
                title: 'Office Address:',
                content: dataController.office_address,
              ),
              ContactInfoCard(
                icon: Icons.receipt,
                title: 'GST Number:',
                content: dataController.gst_number,
              ),
              ContactInfoCard(
                icon: Icons.phone,
                title: 'Phone Number:',
                content: dataController.phone,
              ),
              ContactInfoCard(
                icon: Icons.email,
                title: 'Email ID:',
                content: dataController.email,
              ),
              ContactInfoCard(
                icon: Icons.access_time,
                title: 'Office Timing:',
                content: dataController.office_timing,
              ),
            ],
          ),
        );
      }),
    );
  }
}

class ContactInfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;

  const ContactInfoCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.content,
  }) : super(key: key);

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$text copied to clipboard'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.pink, size: 30),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style:
                      const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          content,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.copy, color: Colors.grey, size: 20),
                        onPressed: () => _copyToClipboard(context, content),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
