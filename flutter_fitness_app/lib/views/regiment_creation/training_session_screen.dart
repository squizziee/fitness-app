import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/models/OpenedTrainingSession.dart';
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
  const TrainingSessionScreen({super.key});

  @override
  State<TrainingSessionScreen> createState() => _TrainingSessionScreenState();
}

class _TrainingSessionScreenState extends State<TrainingSessionScreen> {
  TrainingRegiment? regiment;

  int sessionIndex = -1;

  Widget _title(int index) {
    return Column(
      children: [
        Text('Training Session',
            style: GoogleFonts.montserrat(
                fontSize: 15, fontWeight: FontWeight.w700, height: 1)),
        Text(
            'Day ${index + 1} on ${regiment == null ? "unnamed regiment" : regiment!.name}',
            style: GoogleFonts.montserrat(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                height: 1,
                color: Colors.grey.shade500))
      ],
    );
  }

  Widget _exercisePreview(Exercise exercise, BuildContext context, int index) {
    return StatefulBuilder(builder: (context, setState) {
      if (regiment!.schedule[sessionIndex].exercises.contains(exercise)) {
        return GestureDetector(
          onLongPress: () => showDialog<String>(
              context: context,
              builder: (context) => AlertDialog(
                    title: const Text('Confirmation'),
                    content: Text(
                        'Are you sure you want to delete "${exercise.exerciseType!.name}"?'),
                    actions: <Widget>[
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancel')),
                      TextButton(
                          onPressed: () {
                            regiment!.schedule[sessionIndex].exercises
                                .remove(exercise);
                            setState(() {});
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'Delete',
                            style: TextStyle(color: Colors.redAccent),
                          )),
                    ],
                  )),
          onTap: () {
            Provider.of<OpenedTrainingSession>(context, listen: false)
                .exerciseIndex = index;
            Navigator.of(context)
                .pushNamed('/set_exercise')
                .then((value) => setState(
                      () {},
                    ));
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 100,
            decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: exercise.getExercisePreviewWidgetLayout(),
          ),
        );
      } else {
        return const SizedBox();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    sessionIndex =
        Provider.of<OpenedTrainingSession>(context, listen: false).sessionIndex;
    regiment = Provider.of<NewTrainingRegiment>(context).regiment;
    var session = regiment!.schedule[sessionIndex];
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: _title(sessionIndex),
          centerTitle: true,
        ),
        body: StatefulBuilder(builder: (context, setState) {
          return Column(children: [
            Container(
              padding: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width,
              //color: Colors.grey.shade100,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        )
                      ],
                    ),
                  ]),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  Provider.of<OpenedTrainingSession>(context, listen: false)
                      .exerciseIndex = -1;
                  Navigator.of(context)
                      .pushNamed('/set_exercise')
                      .then((value) => setState(
                            () {},
                          ));
                },
                child: Container(
                    height: 50,
                    width: 50,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        color: Color.fromRGBO(0, 0, 0, .05)),
                    child: const FaIcon(
                      FontAwesomeIcons.plus,
                      size: 18,
                    )),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: regiment!.schedule[sessionIndex].exercises.length,
                  itemBuilder: (context, index) {
                    return _exercisePreview(
                        regiment!.schedule[sessionIndex].exercises[index],
                        context,
                        index);
                  }),
            ),
          ]);
        }),
      ),
    );
  }
}
