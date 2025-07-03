import 'package:donor/home/home.dart';
import 'package:donor/profile/donor_profile.dart';
import 'package:donor/search/search.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int selectedIndex = 0;
  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.water_drop),
              label: 'Home',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
          currentIndex: selectedIndex,
          onTap: onItemTapped,
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.grey,
        ),
        body: IndexedStack(
          index: selectedIndex, // Change this index to switch between pages
          children: [
            // Replace these with your actual pages
            PublicHome(),
            SearchPage(),
            DonorProfile(),
          ],
        ),
      ),
    );
  }
}
