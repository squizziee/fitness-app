import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/repos/current_exercise.dart';
import 'package:flutter_fitness_app/repos/current_goal.dart';
import 'package:flutter_fitness_app/repos/current_training_session.dart';
import 'package:flutter_fitness_app/repos/current_training_regiment.dart';
import 'package:flutter_fitness_app/models/user.dart';
import 'package:flutter_fitness_app/route_generator.dart';
import 'package:flutter_fitness_app/services/notfication_service.dart';
import 'package:flutter_fitness_app/views/authentication/auth_widget_tree.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  tz.initializeTimeZones();
  await NotificationService().initNotification();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => AppUser()),
    ChangeNotifierProvider(create: (context) => CurrentTrainingRegiment()),
    ChangeNotifierProvider(create: (context) => CurrentTrainingSession()),
    ChangeNotifierProvider(create: (context) => CurrentExercise()),
    ChangeNotifierProvider(create: (context) => CurrentGoal()),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Home Page',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        buttonTheme:
            ButtonThemeData(buttonColor: Theme.of(context).primaryColor),
        useMaterial3: true,
      ),
      home: const AuthWidgetTree(),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
