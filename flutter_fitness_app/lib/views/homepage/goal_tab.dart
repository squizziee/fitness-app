import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/views/regiment_creation/weight_exercise_creation/weight_training_exercises_list_screen.dart';

class GoalTab extends StatefulWidget {
  const GoalTab({super.key});

  @override
  State<GoalTab> createState() => _GoalTabState();
}

class _GoalTabState extends State<GoalTab> {
  @override
  Widget build(BuildContext context) {
    return const WeightTrainingExercisesListScreen();
  }
}
