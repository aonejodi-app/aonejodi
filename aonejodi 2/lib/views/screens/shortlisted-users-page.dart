import 'package:app/Theme/theme-colors.dart';
import 'package:app/views/components/profile-card.dart';
import 'package:flutter/material.dart';

class ShortlistedUsers extends StatelessWidget {
  const ShortlistedUsers({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data
    final List<Map<String, dynamic>> dummyData = [
      {
        'imagePath': 'images/img.png',
        'name': 'John Doe',
        'age': '28',
        'caste': 'Brahmin',
        'occupation': 'Engineer',
        'education': 'B.Tech',
        'location': 'Delhi'
      },
      {
        'imagePath': 'images/img.png',
        'name': 'Jane Smith',
        'age': '26',
        'caste': 'Kshatriya',
        'occupation': 'Doctor',
        'education': 'MBBS',
        'location': 'Mumbai'
      },
      {
        'imagePath': 'images/profile.png',
        'name': 'Alice Johnson',
        'age': '30',
        'caste': 'Vaishya',
        'occupation': 'Teacher',
        'education': 'M.A.',
        'location': 'Bangalore'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: pinkColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: const Text(
          'Shortlisted',
          style: TextStyle(fontWeight: FontWeight.w500, color: whiteColor),
        ),
      ),
      body: ListView.builder(
        itemCount: dummyData.length,
        itemBuilder: (context, index) {
          final user = dummyData[index];
          return const Padding(
            padding:
                EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
            child: Center(child: Text("No Data available"),),
            // child: MatchProfileCard(
            //   imagePath: user['imagePath'],
            //   name: user['name'],
            //   age: user['age'].toString(),
            //   caste: user['caste'],
            //   occupation: user['occupation'],
            //   education: user['education'],
            //   location: user['location'],
            // ),
          );
        },
      ),
    );
  }
}
