import 'package:donor/pages/controller/controller_donor.dart';
import 'package:donor/pages/controller/controller_request.dart';
import 'package:flutter/material.dart';

class ControllerPage extends StatefulWidget {
  const ControllerPage({super.key});

  @override
  State<ControllerPage> createState() => _ControllerPageState();
}

class _ControllerPageState extends State<ControllerPage> {
  int selectedIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Icon(
          Icons.bloodtype,
          size: 32,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.bloodtype), label: 'Donors'),
          BottomNavigationBarItem(
            icon: Icon(Icons.handshake),
            label: 'Requests',
          ),
        ],
        currentIndex: selectedIndex,
        onTap: onItemTapped,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey,
      ),
      body: IndexedStack(
        index: selectedIndex,
        children: [Donors(), RequestList()],
      ),
    );
  }
}
