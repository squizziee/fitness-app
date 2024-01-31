import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/views/regiment_creation/training_session_screen.dart';

class SessionTab extends StatefulWidget {
  const SessionTab({super.key});

  @override
  State<SessionTab> createState() => _SessionTabState();
}

class _SessionTabState extends State<SessionTab> {
  @override
  Widget build(BuildContext context) {
    return const TrainingSessionScreen(sessionIndex: 0);
  }
}
