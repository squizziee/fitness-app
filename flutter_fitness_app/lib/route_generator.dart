import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/views/homepage/home_page.dart';
import 'package:flutter_fitness_app/views/authentication/login_page.dart';
import 'package:flutter_fitness_app/views/authentication/register_page.dart';
import 'package:flutter_fitness_app/views/regiment_creation/set_name.dart';
import 'package:flutter_fitness_app/views/regiment_creation/set_type.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final args = settings.arguments;

    switch (settings.name) {
      case '/set_name':
        return MaterialPageRoute(builder: (_) => const SetNamePage());
      case '/set_type':
        return MaterialPageRoute(builder: (_) => const SetTypePage());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case '/register':
        return MaterialPageRoute(builder: (_) => const RegisterPage());
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomePage());
    }
    return MaterialPageRoute(builder: (_) => const SetNamePage());
  }
}
