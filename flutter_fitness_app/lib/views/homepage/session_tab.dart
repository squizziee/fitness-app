import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/models/training_session.dart';
import 'package:flutter_fitness_app/models/weight_training/weight_training_exercise.dart';
import 'package:flutter_fitness_app/services/regiment_fetching.dart';

class SessionTab extends StatefulWidget {
  const SessionTab({super.key});

  @override
  State<SessionTab> createState() => _SessionTabState();
}

class _SessionTabState extends State<SessionTab> {
  Future<TrainingSession>? session;
  @override
  void initState() {
    super.initState();
    session = DatabaseAPI.getTrainingSessionByID('Y8NYrdz4hLzfcPeOD7eR');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder<TrainingSession>(
          future: session,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView(
                children:
                    (snapshot.data!.exercises[0] as WeightTrainingExercise)
                        .sets
                        .map((e) => e.getWidget())
                        .toList());
          }),
    );
  }
}
