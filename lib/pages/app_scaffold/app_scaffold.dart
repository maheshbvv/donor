import 'package:donor/pages/auth/signin/signin.dart';
import 'package:donor/pages/home/home.dart';
import 'package:donor/pages/profile/donor_profile.dart';
import 'package:donor/pages/search/search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppScaffold extends StatefulWidget {
  const AppScaffold({super.key});

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  int selectedIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = FirebaseAuth.instance.currentUser != null;

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.water_drop),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          isLoggedIn
              ? const BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                )
              : const BottomNavigationBarItem(
                  icon: Icon(Icons.login),
                  label: 'Login',
                ),
        ],
        currentIndex: selectedIndex,
        onTap: onItemTapped,
        selectedItemColor: Theme.of(context).colorScheme.primary, // ✅ Now works
        unselectedItemColor: Colors.grey,
      ),
      body: IndexedStack(
        index: selectedIndex,
        children: [
          PublicHome(),
          SearchPage(),
          isLoggedIn ? DonorProfile() : SignIn(),
        ],
      ),
    );
  }
}
