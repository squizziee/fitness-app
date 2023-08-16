import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/views/first_use/set_name.dart';
import 'package:flutter_fitness_app/views/first_use/set_type.dart';
//import 'package:flutter_fitness_app/views/first_use/set_type.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/set_name':
        return MaterialPageRoute(builder: (_) => const SetNamePage());
      case '/set_type':
        return MaterialPageRoute(builder: (_) => const SetTypePage());
    }
    return MaterialPageRoute(builder: (_) => const SetNamePage());
  }
}
