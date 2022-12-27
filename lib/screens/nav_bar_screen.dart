import 'package:flutter/material.dart';
import 'package:ieee_forms/screens/home_screen.dart';
import 'package:ieee_forms/screens/new_form_screen.dart';
import 'package:ieee_forms/screens/my_screen.dart';

class NavBarScreen extends StatefulWidget {
  const NavBarScreen({Key? key}) : super(key: key);

  @override
  State<NavBarScreen> createState() => _NavBarScreenState();
}

class _NavBarScreenState extends State<NavBarScreen> {

  int _selectedIndex = 0;
  static final List<Widget> _list = <Widget>[
    HomeScreen(),
    const NewFormScreen(),
    const ProfileScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _list.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
          label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.grid_view_outlined),
              label: 'Create Form'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outlined),
              label: 'Profile'),
        ],
        iconSize: 28,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}