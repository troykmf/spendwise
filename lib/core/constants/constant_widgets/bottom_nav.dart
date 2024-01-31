import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spendwise/new_youtube/my_form.dart';
import 'package:spendwise/src/page/home_page.dart';
import 'package:spendwise/src/page/summary_page.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;
  var pageViewList = [
    const HomePage(),
    const SummaryPage(),
    TransanctionScreen(),
  ];

  // static const List _widgetOptions = [
  //   HomePage(),
  //   SummaryPage(),
  // ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageViewList[_currentIndex],
      bottomNavigationBar: NavBar(
          selectedIndex: _currentIndex,
          onDestinationSelected: (int value) {
            setState(() {
              _currentIndex = value;
            });
          }),
    );
  }
}

class NavBar extends StatelessWidget {
  const NavBar(
      {super.key,
      required this.selectedIndex,
      required this.onDestinationSelected});
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      height: 45,
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
      destinations: const [
        NavigationDestination(
          icon: Icon(FontAwesomeIcons.house),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(FontAwesomeIcons.solidChartBar),
          label: 'Summary',
        ),
        NavigationDestination(
          icon: Icon(Icons.commute),
          label: 'Transaction',
        ),
      ],
    );
  }
}
