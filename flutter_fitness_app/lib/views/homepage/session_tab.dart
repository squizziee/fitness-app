import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/models/training_session.dart';
import 'package:flutter_fitness_app/models/weight_training/weight_training_exercise.dart';
import 'package:flutter_fitness_app/services/regiment_fetching.dart';
import 'package:flutter_fitness_app/views/regiment_creation/training_session_screen.dart';

class SessionTab extends StatefulWidget {
  const SessionTab({super.key});

  @override
  State<SessionTab> createState() => _SessionTabState();
}

class _SessionTabState extends State<SessionTab> {
  @override
  Widget build(BuildContext context) {
    return TrainingSessionScreen();
  }
}
