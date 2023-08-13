import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/services/auth.dart';
import 'package:flutter_fitness_app/views/auth_page.dart';
import 'package:flutter_fitness_app/views/home_page.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return HomePage();
        } else {
          return const AuthPage();
        }
      },
    );
  }
}
