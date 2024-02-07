import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/models/OpenedTrainingSession.dart';
import 'package:flutter_fitness_app/models/new_training_regiment.dart';
import 'package:flutter_fitness_app/models/user.dart';
import 'package:flutter_fitness_app/route_generator.dart';
import 'package:flutter_fitness_app/views/authentication/auth_widget_tree.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => NewTrainingRegiment()),
    ChangeNotifierProvider(create: (context) => AppUser()),
    ChangeNotifierProvider(create: (context) => OpenedTrainingSession())
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
