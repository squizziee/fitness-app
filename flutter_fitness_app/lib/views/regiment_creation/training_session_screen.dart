import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/models/base/training_types.dart';
import 'package:flutter_fitness_app/repos/current_training_session.dart';
import 'package:flutter_fitness_app/models/base/exercise.dart';
import 'package:flutter_fitness_app/repos/current_training_regiment.dart';
import 'package:flutter_fitness_app/services/exercise_service.dart';
import 'package:flutter_fitness_app/services/session_service.dart';
import 'package:flutter_fitness_app/services/weight_exercise_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TrainingSessionScreen extends StatefulWidget {
  const TrainingSessionScreen({super.key});

  @override
  State<TrainingSessionScreen> createState() => _TrainingSessionScreenState();
}

class _TrainingSessionScreenState extends State<TrainingSessionScreen> {
  final SessionService _sessionService = SessionService();
  ExerciseService? _exerciseService;

  Widget _title(int sessionIndex, String regimentName) {
    return Column(
      children: [
        Text('Training Session',
            style: GoogleFonts.montserrat(
                fontSize: 15, fontWeight: FontWeight.w700, height: 1)),
        Text('Day ${sessionIndex + 1} on $regimentName',
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
      var session = Provider.of<CurrentTrainingSession>(context).session;
      if (session!.exercises.contains(exercise)) {
        return GestureDetector(
          onLongPress: () => showDialog<String>(
              context: context,
              builder: (context) => AlertDialog(
                    title: const Text('Confirmation'),
                    content: Text(
                        'Are you sure you want to delete "${exercise.getExerciseTypeName()}"?'),
                    actions: <Widget>[
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancel')),
                      TextButton(
                          onPressed: () {
                            _sessionService.removeExercise(context, exercise);
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
            _exerciseService!.openExercise(context, index);
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
            child: Text(exercise.getExerciseTypeName()),
          ),
        );
      } else {
        return const SizedBox();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var regiment = Provider.of<CurrentTrainingRegiment>(context).regiment;
    var session = Provider.of<CurrentTrainingSession>(context).session;

    if (regiment!.trainingType is WeightTraining) {
      _exerciseService = WeightExerciseService();
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: _title(session!.dayInSchedule, regiment.name!),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: Size(MediaQuery.of(context).size.width, 1),
            child: Container(
                height: 1, color: const Color.fromRGBO(0, 0, 0, 0.05)),
          ),
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
                          regiment.trainingType!.getIconData(),
                          size: 18,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(regiment.trainingType!.toString()
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
                  _exerciseService!.createAndOpenEmptyExercise(context);
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
                  itemCount: session.exercises.length,
                  itemBuilder: (context, index) {
                    return _exercisePreview(
                        session.exercises[index], context, index);
                  }),
            ),
          ]);
        }),
      ),
    );
  }
}
