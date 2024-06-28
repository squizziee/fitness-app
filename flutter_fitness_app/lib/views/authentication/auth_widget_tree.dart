import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/services/auth.dart';
import 'package:flutter_fitness_app/services/user_service.dart';
import 'package:flutter_fitness_app/views/authentication/login_page.dart';
import 'package:flutter_fitness_app/views/homepage/home_page.dart';
import 'package:flutter_fitness_app/views/misc/loading_screen.dart';

class AuthWidgetTree extends StatefulWidget {
  const AuthWidgetTree({super.key});

  @override
  State<AuthWidgetTree> createState() => _AuthWidgetTreeState();
}

class _AuthWidgetTreeState extends State<AuthWidgetTree> {
  final UserService _userService = UserService();

  Future<int>? userData;

  @override
  void initState() {
    super.initState();
    userData = _userService.loadUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: Auth().authStateChanges,
      builder: (context, authSnapshot) {
        return FutureBuilder(
            future: userData,
            builder: (context, snapshot) {
              if (authSnapshot.connectionState == ConnectionState.active) {
                if (authSnapshot.data == null) {
                  return const LoginPage();
                }
                if (snapshot.hasData && snapshot.data == 0) {
                  _userService.requestPermissions();
                  return const HomePage();
                }
              }
              return Center(
                child: LoadingScreen(
                  message: snapshot.error.toString(),
                ),
              );
            });
      },
    );
  }
}
