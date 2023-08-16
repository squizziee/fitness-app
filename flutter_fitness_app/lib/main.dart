import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/models/training_regiment.dart';
import 'package:flutter_fitness_app/route_generator.dart';
import 'package:flutter_fitness_app/views/first_use/set_name.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => TrainingRegiment())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Home Page',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: const SetNamePage(),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
