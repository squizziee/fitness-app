import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/models/base/training_session.dart';
import 'package:flutter_fitness_app/repos/current_training_regiment.dart';
import 'package:flutter_fitness_app/services/session_service.dart';
import 'package:flutter_fitness_app/views/regiment_creation/common_widgets/app_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SetRegimentCalendarPage extends StatefulWidget {
  const SetRegimentCalendarPage({super.key});

  @override
  State<SetRegimentCalendarPage> createState() =>
      _SetRegimentCalendarPageState();
}

Widget _tagWidget(String text, Color backgroundColor) {
  return Container(
      margin: const EdgeInsets.only(top: 5),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(5))),
      child: Text(text.toUpperCase(),
          style: GoogleFonts.montserrat(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: Colors.white,
              height: 1)));
}

Widget _sessionWidget(BuildContext context, TrainingSession session,
    SessionService sessionService) {
  return GestureDetector(
    onTap: () {
      sessionService.openSessionByInstance(context, session);
      Navigator.of(context).pushNamed('/select_training_session');
    },
    child: Container(
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 10,
            ),
          ],
          color: session.exercises.isEmpty
              ? const Color(0xff151515)
              : Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(15.0))),
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 20.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (session.exercises.isEmpty) {
            return Text("Rest day",
                style: GoogleFonts.montserrat(
                    fontSize: 35,
                    fontWeight: FontWeight.w800,
                    height: 1,
                    color: Colors.white));
          }
          return Wrap(children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("Day #${session.dayInSchedule + 1}",
                  style: GoogleFonts.montserrat(
                      fontSize: 35, fontWeight: FontWeight.w800, height: 1)),
              _tagWidget(
                  "${session.exercises.length} exercises", Colors.blueAccent),
              _tagWidget(session.getGeneralMetricText(), Colors.black),
            ])
          ]);
        },
      ),
    ),
  );
}

class _SetRegimentCalendarPageState extends State<SetRegimentCalendarPage> {
  //Widget _sessionWidget() {

  //}
  final SessionService _sessionService = SessionService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBar(
            context,
            Provider.of<CurrentTrainingRegiment>(context).regiment!.name!,
            Provider.of<CurrentTrainingRegiment>(context)
                .regiment!
                .trainingType
                .toString()),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                child: Column(
                  children: Provider.of<CurrentTrainingRegiment>(context)
                              .regiment!
                              .cycleDurationInDays ==
                          null
                      ? [SizedBox()]
                      : List.generate(
                          Provider.of<CurrentTrainingRegiment>(context)
                              .regiment!
                              .cycleDurationInDays!, (index) {
                          var session =
                              Provider.of<CurrentTrainingRegiment>(context)
                                  .regiment!
                                  .schedule![index];
                          return _sessionWidget(
                              context, session, _sessionService);
                        }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
