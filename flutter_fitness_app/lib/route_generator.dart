import 'main.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const FirstPage());
      case '/second':
        return MaterialPageRoute(builder: (_) => const SecondPage());
    }
    return MaterialPageRoute(builder: (_) => const FirstPage());
  }
}
