import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/views/goal_creation/set_goal_page.dart';
import 'package:flutter_fitness_app/views/homepage/home_page.dart';
import 'package:flutter_fitness_app/views/authentication/login_page.dart';
import 'package:flutter_fitness_app/views/authentication/register_page.dart';
import 'package:flutter_fitness_app/views/regiment_creation/select_training_session.dart';
import 'package:flutter_fitness_app/views/regiment_creation/set_duration.dart';
import 'package:flutter_fitness_app/views/regiment_creation/set_name.dart';
import 'package:flutter_fitness_app/views/regiment_creation/set_regiment_calendar.dart';
import 'package:flutter_fitness_app/views/regiment_creation/set_type.dart';
import 'package:flutter_fitness_app/views/regiment_creation/training_session_screen.dart';
import 'package:flutter_fitness_app/views/regiment_creation/weight_exercise_creation/set_weight_exercise.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final args = settings.arguments;

    switch (settings.name) {
      case '/set_name':
        return MaterialPageRoute(builder: (_) => const SetNamePage());
      case '/set_type':
        return MaterialPageRoute(builder: (_) => const SetTypePage());
      case '/set_duration':
        return MaterialPageRoute(builder: (_) => const SetDurationPage());
      case '/set_regiment_calendar':
        return MaterialPageRoute(
            builder: (_) => const SetRegimentCalendarPage());
      case '/select_training_session':
        return MaterialPageRoute(
            builder: (_) => const SelectTrainingSessionPage());
      case '/training_session_screen':
        return MaterialPageRoute(builder: (_) => const TrainingSessionScreen());
      case '/set_goal':
        return MaterialPageRoute(builder: (_) => const SetGoalPage());
      case '/set_exercise':
        return MaterialPageRoute(builder: (_) => const SetWeightExercisePage());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case '/register':
        return MaterialPageRoute(builder: (_) => const RegisterPage());
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomePage());
    }
    return MaterialPageRoute(builder: (_) => const HomePage());
  }
}
