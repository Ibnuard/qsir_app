import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qsir_app/presentation/pages/owner/home/home_page.dart';
import 'package:qsir_app/presentation/pages/owner/profile/profile_page.dart';
import 'package:qsir_app/presentation/pages/owner/statistics/statistics_page.dart';

class OwnerMainPage extends StatefulWidget {
  const OwnerMainPage({super.key});

  @override
  State<OwnerMainPage> createState() => _OwnerMainPageState();
}

class _OwnerMainPageState extends State<OwnerMainPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    StatisticsPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.chart_bar),
            label: 'Statistik',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.building_2_fill),
            label: 'Toko',
          ),
        ],
      ),
    );
  }
}
