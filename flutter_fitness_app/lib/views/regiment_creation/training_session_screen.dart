import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/models/exercise.dart';
import 'package:flutter_fitness_app/models/training_regiment.dart';
import 'package:flutter_fitness_app/models/training_session.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class TrainingSessionScreen extends StatefulWidget {
  const TrainingSessionScreen({super.key});

  @override
  State<TrainingSessionScreen> createState() => _TrainingSessionScreenState();
}

class _TrainingSessionScreenState extends State<TrainingSessionScreen> {
  TrainingSession? session;
  TrainingRegiment? regiment;
  int indexOfSession = 0;

  Widget _title() {
    return Column(
      children: [
        Text('Training Session',
            style: GoogleFonts.montserrat(
                fontSize: 15, fontWeight: FontWeight.w700, height: 1)),
        Text(
            '$indexOfSession day on ${regiment == null ? "unnamed regiment" : regiment!.name}',
            style: GoogleFonts.montserrat(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                height: 1,
                color: Colors.grey.shade500))
      ],
    );
  }

  Widget _exercisePreview(Exercise exercise, BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: exercise.getExercisePreviewWidgetLayout(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: _title(),
          centerTitle: true,
        ),
        body: Column(children: [
          Container(
            padding: const EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width,
            //color: Colors.grey.shade100,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                session == null ? 'Unnamed session' : session!.name,
                style: GoogleFonts.montserrat(
                    fontSize: 22, fontWeight: FontWeight.w800, height: 1),
              ),
              const SizedBox(height: 10),
              Wrap(
                children: [
                  FaIcon(
                    regiment == null
                        ? FontAwesomeIcons.question
                        : regiment!.trainingType!.getIconData(),
                    size: 18,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(regiment == null
                          ? 'Undefined training type'
                          : regiment!.trainingType!.toString()
                      //style: const TextStyle(fontWeight: FontWeight.w900),
                      ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    '[${session == null ? 'no metric' : session!.getGeneralMetricText()}]',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  )
                ],
              ),
            ]),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: List.generate(
                  session == null ? 0 : session!.exercises.length, (index) {
                return Column(
                  children: [
                    _exercisePreview(session!.exercises[index], context),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                );
              }),
              /*child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: session == null ? 0 : session!.exercises.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      _exercisePreview(session!.exercises[index], context),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  );
                },
              ),*/
            ),
          )
        ]),
      ),
    );
  }
}
