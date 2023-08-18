import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  Future<void> signOut() async {
    await Auth().signOut();
  }

  Widget _userUID() {
    return Text(user?.email ?? 'User email');
  }

  Widget _signOutButton() {
    return ElevatedButton(
        onPressed: () async {
          await signOut();
          Navigator.of(context).pushNamed('/login');
        },
        child: const Text('Sign out'));
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
        currentIndex: _selectedIndex,
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
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [_userUID(), _signOutButton()],
        ),
      ),
    );
  }
}
