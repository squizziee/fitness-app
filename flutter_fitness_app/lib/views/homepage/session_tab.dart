import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/models/training_regiment.dart';
import 'package:flutter_fitness_app/models/training_session.dart';
import 'package:flutter_fitness_app/services/regiment_service.dart';
import 'package:flutter_fitness_app/services/session_service.dart';
import 'package:flutter_fitness_app/services/user_service.dart';
import 'package:flutter_fitness_app/views/regiment_creation/common_widgets/tag_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class SessionTab extends StatefulWidget {
  const SessionTab({super.key});

  @override
  State<SessionTab> createState() => _SessionTabState();
}

Widget _sessionWidget(
    BuildContext context,
    (TrainingSession, TrainingRegiment) data,
    RegimentService regimentService,
    SessionService sessionService) {
  var session = data.$1;
  var regiment = data.$2;
  return GestureDetector(
    onTap: () {
      regimentService.openRegiment(context, regiment);
      sessionService.openSessionByInstance(context, session);
      Navigator.of(context).pushNamed("/training_session_screen");
    },
    child: Container(
      decoration: const BoxDecoration(
          border: Border(
              bottom:
                  BorderSide(width: 0.5, color: Color.fromRGBO(0, 0, 0, .1)))),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        width: 0.5, color: Color.fromRGBO(0, 0, 0, .1)))),
            padding: const EdgeInsets.all(15),
            child: Text(
              "Session #${session.dayInSchedule + 1} — ${session.name == "" ? "No name" : session.name}",
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w800, fontSize: 20),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(15),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Wrap(
                spacing: 5,
                children: [
                  tagWidget("${regiment.name} regiment", Colors.greenAccent,
                      textColor: Colors.black),
                  tagWidget(
                      "${session.dayInSchedule + 1} of ${regiment.cycleDurationInDays}",
                      Colors.black),
                ],
              ),
              const SizedBox(height: 2),
              tagWidget("${session.exercises.length} exercises", Colors.white10,
                  textColor: Colors.black),
              const SizedBox(height: 2),
              tagWidget(session.getGeneralMetricText(), Colors.white10,
                  textColor: Colors.black),
            ]),
          ),
        ],
      ),
    ),
  );
}

class _SessionTabState extends State<SessionTab> {
  List<(TrainingSession, TrainingRegiment)>? sessionsList;
  final RegimentService _regimentService = RegimentService();
  final SessionService _sessionService = SessionService();

  @override
  void initState() {
    super.initState();
    sessionsList = UserService().getCurrentUserSessions(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: ListView.builder(
                itemCount: sessionsList!.length,
                itemBuilder: ((context, index) {
                  var session = sessionsList![index];
                  return _sessionWidget(
                      context, session, _regimentService, _sessionService);
                }))));
  }
}
