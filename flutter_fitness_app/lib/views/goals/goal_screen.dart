import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/models/user.dart';
import 'package:provider/provider.dart';

class GoalScreen extends StatefulWidget {
  const GoalScreen({super.key});

  @override
  State<GoalScreen> createState() => _GoalScreenState();
}

class _GoalScreenState extends State<GoalScreen> {
  //final GoalService _goalService = GoalService();

  @override
  Widget build(BuildContext context) {
    var goals = Provider.of<AppUser>(context).goals;
    return SafeArea(
        child: Scaffold(
      body: Container(
          child: Expanded(
        child: ListView.builder(
            itemCount: goals!.length,
            itemBuilder: (context, index) {
              return Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(20),
                child: Column(children: [
                  Text(goals[index].exerciseName!),
                  Text(goals[index].deadline.toString()),
                ]),
              );
            }),
      )),
    ));
  }
}
