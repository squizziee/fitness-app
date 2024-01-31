import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/models/exercise.dart';
import 'package:flutter_fitness_app/models/new_training_regiment.dart';
import 'package:flutter_fitness_app/models/training_regiment.dart';
import 'package:flutter_fitness_app/models/training_session.dart';
import 'package:flutter_fitness_app/views/regiment_creation/weight_exercise_creation/set_exercise.dart';
import 'package:flutter_fitness_app/views/regiment_creation/weight_exercise_creation/weight_training_exercises_list_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TrainingSessionScreen extends StatefulWidget {
  const TrainingSessionScreen({super.key, required this.sessionIndex});

  final int sessionIndex;

  @override
  State<TrainingSessionScreen> createState() => _TrainingSessionScreenState();
}

class _TrainingSessionScreenState extends State<TrainingSessionScreen> {
  TrainingRegiment? regiment;

  Widget _title() {
    return Column(
      children: [
        Text('Training Session',
            style: GoogleFonts.montserrat(
                fontSize: 15, fontWeight: FontWeight.w700, height: 1)),
        Text(
            '${widget.sessionIndex + 1} day on ${regiment == null ? "unnamed regiment" : regiment!.name}',
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
    regiment = Provider.of<NewTrainingRegiment>(context).regiment;
    var session = regiment!.schedule[widget.sessionIndex];
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
                session.name,
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
                    '[${session.getGeneralMetricText()}]',
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
                  session.exercises.length, (index) {
                return Column(
                  children: [
                    _exercisePreview(session.exercises[index], context),
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
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 100,
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SetExercisePage()));
              },
              child: Container(
                height: 50,
                width: 50,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(100)), 
                  color: Color.fromRGBO(0, 0, 0, .05)
                ),
                child: const FaIcon(
                      FontAwesomeIcons.plus,
                      size: 18,
                    )),
            ),
          )
        ]),
      ),
    );
  }
}
