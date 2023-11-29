import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spendwise/src/page/home_page.dart';
import 'package:spendwise/src/page/summary_page.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  void onTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List _widgetOptions = [
    HomePage(),
    SummaryPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: _selectedIndex,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.grey[700],
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          onTap: onTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.home,
                size: 20,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.bar_chart_outlined,
                size: 20,
              ),
              label: 'Summary',
            ),
          ]),
    );
  }
}
