import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/models/training_regiment.dart';
import 'package:flutter_fitness_app/models/training_session.dart';
import 'package:flutter_fitness_app/services/auth.dart';
import 'package:flutter_fitness_app/services/database_service.dart';
import 'package:flutter_fitness_app/services/regiment_service.dart';
import 'package:flutter_fitness_app/services/session_service.dart';

class SessionTab extends StatefulWidget {
  const SessionTab({super.key});

  @override
  State<SessionTab> createState() => _SessionTabState();
}

Widget _sessionWidget(
    BuildContext context,
    (TrainingSession, TrainingRegiment) session,
    RegimentService regimentService,
    SessionService sessionService) {
  return GestureDetector(
    onTap: () {
      regimentService.openRegiment(context, session.$2);
      sessionService.openSessionByInstance(context, session.$1);
      Navigator.of(context).pushNamed("/training_session_screen");
    },
    child: Container(
      color: Colors.amber,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(10),
      child: Column(children: [
        Text(session.$2.name!),
        Text(session.$1.name == "" ? "No name" : session.$1.name),
      ]),
    ),
  );
}

class _SessionTabState extends State<SessionTab> {
  Future<List<(TrainingSession, TrainingRegiment)>>? sessionsList;
  final RegimentService _regimentService = RegimentService();
  final SessionService _sessionService = SessionService();

  @override
  void initState() {
    super.initState();
    sessionsList =
        DatabaseService().getUserTrainingSessions(Auth().currentUser!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: FutureBuilder(
        future: sessionsList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: ((context, index) {
                  var session = snapshot.data![index];
                  return _sessionWidget(
                      context, session, _regimentService, _sessionService);
                }));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    ));
  }
}
