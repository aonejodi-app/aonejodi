import 'package:app/Theme/theme-colors.dart';
import 'package:app/views/components/custom-appbar.dart';
import 'package:app/views/components/custom-drawer.dart';
import 'package:app/views/components/pink-button.dart';
import 'package:app/views/screens/match-by-userId/match-uid-screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SearchByIdPage extends StatefulWidget {
  const SearchByIdPage({super.key});

  @override
  State<SearchByIdPage> createState() => _SearchByIdPageState();
}

class _SearchByIdPageState extends State<SearchByIdPage> {
  final TextEditingController _userIdController = TextEditingController();

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
          'Search Matches',
          style: TextStyle(fontWeight: FontWeight.w500, color: whiteColor),
        ),
      ),
      drawer: CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Search Matches within \nyour Community', style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold
                ),),
              ],
            ),
            const SizedBox(height: 20,),
            TextField(
              controller: _userIdController,
              decoration: const InputDecoration(
                labelText: 'Enter User ID',
                border: OutlineInputBorder(),
              ),
            ),
            const Spacer(),
            
               PinkButton(text: 'Search', onTap: () {
                if (_userIdController.text.isNotEmpty) {
                  Get.to(() =>
                      UserProfileResultPage(userId: _userIdController.text));
                } else {
                  Get.snackbar('Error', 'Please enter a valid User ID');
                }
              }),
            
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _userIdController.dispose();
    super.dispose();
  }
}
