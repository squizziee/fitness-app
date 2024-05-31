// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_fitness_app/views/homepage/goal_tab.dart';
import 'package:flutter_fitness_app/views/homepage/profile_tab.dart';
import 'package:flutter_fitness_app/views/homepage/regiment_tab.dart';
import 'package:flutter_fitness_app/views/homepage/session_tab.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../services/auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final User? user = Auth().currentUser;
  int _selectedIndex = 0;
  List<Widget> tabs = [
    const RegimentTab(),
    const SessionTab(),
    const GoalTab(),
    const ProfileTab()
  ];

  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 12,
        iconSize: 22,
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.list),
            label: 'Regiments',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.personWalking),
            label: 'Sessions',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.bullseye),
            label: 'Goals',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.user),
            label: 'Profile',
          ),
        ],
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: tabs[_selectedIndex],
      ),
    );
  }
}
