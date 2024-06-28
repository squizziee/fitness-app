import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/repos/current_exercise.dart';
import 'package:flutter_fitness_app/repos/current_goal.dart';
import 'package:flutter_fitness_app/repos/current_training_session.dart';
import 'package:flutter_fitness_app/repos/current_training_regiment.dart';
import 'package:flutter_fitness_app/models/base/user.dart';
import 'package:flutter_fitness_app/route_generator.dart';
import 'package:flutter_fitness_app/views/authentication/auth_widget_tree.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
// ignore: unused_import
import 'package:dcdg/dcdg.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  AwesomeNotifications().initialize(null, [
    NotificationChannel(
        channelGroupKey: "reminders",
        channelKey: "instant_notifications",
        channelName: "Basic instant notifications",
        channelDescription: 'whatever',
        defaultColor: const Color(0xffffc400),
        importance: NotificationImportance.High,
        ledColor: Colors.white),
    NotificationChannel(
        channelGroupKey: "reminders",
        channelKey: "scheduled_notifications",
        channelName: "Scheduled notifications",
        channelDescription: 'whatever',
        defaultColor: const Color.fromARGB(255, 0, 110, 255),
        importance: NotificationImportance.High,
        ledColor: Colors.white)
  ]);
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
      title: 'Manifold Fitness',
      theme: ThemeData(
        dividerColor: Colors.transparent,
        primaryColor: Color(0xffccb5b5),
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xffccb5b5)),
        buttonTheme:
            ButtonThemeData(buttonColor: Theme.of(context).primaryColor),
        useMaterial3: true,
      ),
      home: const AuthWidgetTree(),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
