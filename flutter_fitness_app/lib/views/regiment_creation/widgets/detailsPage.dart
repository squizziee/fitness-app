import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/models/training_session.dart';

class DetailsPage extends StatelessWidget {
  final TrainingSession training;

  const DetailsPage({super.key, required this.training});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Details of training ${training.name}')),
      body: Column(
        children: [
          Text('Exercises: ${training.exercises.length}'),
          Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: training.exercises.length,
              itemBuilder: (context, index) {
                final exercise = training.exercises[index];
                return ListTile(
                  title: Text(exercise.type.name),
                  subtitle: Text(exercise.notes),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
