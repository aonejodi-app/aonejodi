import 'package:app/Theme/theme-colors.dart';
import 'package:app/views/screens/main-page.dart';
import 'package:app/views/screens/match-user-page.dart';
import 'package:app/views/screens/user-profile-page.dart';
import 'package:flutter/material.dart';
import 'package:app/views/screens/advance-search-page.dart';
import 'package:app/views/screens/search-page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  late final List<Widget> _pages;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _pages = [
      MainPage(),
      SearchPage(),
      const MatchPage(),
      const AdvanceSearchPage(),
      UserProfile(),
    ];
  }

  void _onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        unselectedLabelStyle: const TextStyle(color: greyColorPlan),
        showUnselectedLabels: true,
        onTap: _onTap,
        selectedItemColor: Colors.pink,
        // Active icon color
        unselectedItemColor: Colors.grey,
        // Inactive icon color
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Matches',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Advance Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
