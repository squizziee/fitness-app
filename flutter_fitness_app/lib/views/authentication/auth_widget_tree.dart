import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/services/auth.dart';
import 'package:flutter_fitness_app/services/user_service.dart';
import 'package:flutter_fitness_app/views/authentication/register_page.dart';
import 'package:flutter_fitness_app/views/homepage/home_page.dart';

class AuthWidgetTree extends StatefulWidget {
  const AuthWidgetTree({super.key});

  @override
  State<AuthWidgetTree> createState() => _AuthWidgetTreeState();
}

class _AuthWidgetTreeState extends State<AuthWidgetTree> {
  final UserService _userService = UserService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          _userService.loadUserData(context);
          return snapshot.data != null
              ? const HomePage()
              : const RegisterPage();
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
