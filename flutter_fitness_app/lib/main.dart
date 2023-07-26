import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/route_generator.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    int a = 10;
    return MultiProvider(
      providers: [
        Provider(
          create: (context) => a,
        ),
        ChangeNotifierProvider(create: (context) => ChangingValue())
      ],
      child: MaterialApp(
        title: 'Home Page',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('First page')),
        body: SafeArea(
            child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: Colors.red.shade50),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Immutable value: ${Provider.of<int>(context).toString()}',
                        style: const TextStyle(fontSize: 30),
                      ),
                      Text(
                        'Mutable value: ${Provider.of<ChangingValue>(context).value.toString()}',
                        style: const TextStyle(fontSize: 30),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "/second");
                          },
                          child: const Text("Go to second page"))
                    ],
                  ),
                ))));
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Second page')),
        body: SafeArea(
            child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Colors.red.shade50),
          child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                child: const Text("Increment value"),
                onPressed: () {
                  Provider.of<ChangingValue>(context, listen: false)
                      .increment();
                },
              )),
        )));
  }
}

class ChangingValue extends ChangeNotifier {
  int value = 69;
  void increment() {
    ++value;
    notifyListeners();
  }
}
