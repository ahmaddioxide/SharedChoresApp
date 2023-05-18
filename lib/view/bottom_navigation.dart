import 'package:flutter/material.dart';
import '../ui-components/theme.dart';
import '../view/home_screen.dart';
import '../view/profile_screen.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  int _selectedTab = 0;

  final List _pages = [
    const HomeScreen(),
    // const CalenderScreen(),
    const ProfileScreen(),
  ];
  _changeTab(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedTab],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 20,
        showUnselectedLabels: false,
        currentIndex: _selectedTab,
        onTap: (index) => _changeTab(index),
        selectedItemColor: CustomColorSwatch.pimary,
        unselectedItemColor: CustomColorSwatch.pimary[300],
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home_rounded,
                size: 30,
              ),
              label: "Home"),
          // BottomNavigationBarItem(
          //     icon: Icon(Icons.calendar_month_rounded,
          //     size: 30,
          //     ), label: "Calender"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person_2_rounded,
                size: 30,
              ),
              label: "Profile"),
        ],
      ),
    );
  }
}
