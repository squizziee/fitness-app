import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/models/base/training_regiment.dart';
import 'package:flutter_fitness_app/models/base/training_session.dart';
import 'package:flutter_fitness_app/models/base/training_types.dart';
import 'package:flutter_fitness_app/repos/current_training_session.dart';
import 'package:flutter_fitness_app/models/base/exercise.dart';
import 'package:flutter_fitness_app/repos/current_training_regiment.dart';
import 'package:flutter_fitness_app/services/exercise_service.dart';
import 'package:flutter_fitness_app/services/session_service.dart';
import 'package:flutter_fitness_app/services/weight_exercise_service.dart';
import 'package:flutter_fitness_app/views/misc/default_text_field.dart';
import 'package:flutter_fitness_app/views/regiment_creation/common_widgets/app_bar.dart';
import 'package:flutter_fitness_app/views/regiment_creation/common_widgets/dialog.dart';
import 'package:flutter_fitness_app/views/regiment_creation/common_widgets/tag_widget.dart';
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

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  Widget _infoBox(BuildContext context, TrainingRegiment regiment,
      TrainingSession session) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          border: Border(
              bottom:
                  BorderSide(width: 0.5, color: Color.fromRGBO(0, 0, 0, .1)))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 10),
              width: MediaQuery.of(context).size.width - 40 - 30,
              child: Text(
                session.name == "" ? "No name" : session.name,
                style: GoogleFonts.montserrat(
                    height: 1, fontWeight: FontWeight.w800, fontSize: 25),
              ),
            ),
            GestureDetector(
              onTap: () {
                _nameController.text = session.name;
                _notesController.text = session.notes;
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        clipBehavior: Clip.hardEdge,
                        title: Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 0.5,
                                        color: Color.fromRGBO(0, 0, 0, .1)))),
                            child: Text(
                              "Edit session",
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w700),
                            )),
                        titlePadding: EdgeInsets.zero,
                        surfaceTintColor: Colors.transparent,
                        backgroundColor: Colors.white,
                        contentPadding: EdgeInsets.zero,
                        actionsPadding:
                            EdgeInsets.only(right: 10, top: 5, bottom: 5),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(0))),
                        content: SingleChildScrollView(
                          child: Column(children: [
                            defaultTextField(
                                controller: _nameController,
                                placeholder: "Name"),
                            defaultTextField(
                                controller: _notesController,
                                placeholder: "Notes",
                                isMultiline: true),
                          ]),
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                _sessionService.setName(
                                    context, _nameController.text);
                                _sessionService.setNotes(
                                    context, _notesController.text);
                                setState(() {});
                                Navigator.of(context).pop();
                              },
                              child: Text("OK")),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("Cancel"))
                        ],
                      );
                    });
              },
              child: FaIcon(
                FontAwesomeIcons.pen,
                size: 16,
              ),
            ),
          ],
        ),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Container(
              width: 25,
              height: 25,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              child: FaIcon(
                regiment.trainingType!.getIconData(),
                size: 14,
                color: Colors.white,
              ),
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
              style: TextStyle(color: Theme.of(context).primaryColor),
            )
          ],
        ),
        SizedBox(height: 5),
        Wrap(
          spacing: 5,
          children: [
            // Container(
            //   width: 25,
            //   height: 25,
            //   alignment: Alignment.center,
            //   decoration: BoxDecoration(
            //       color: Colors.black,
            //       borderRadius: BorderRadius.all(Radius.circular(50))),
            //   child: FaIcon(
            //     FontAwesomeIcons.penFancy,
            //     size: 14,
            //     color: Colors.white,
            //   ),
            // ),
            Container(
              margin: EdgeInsets.only(top: 2),
              width: MediaQuery.of(context).size.width - 40 - 30,
              child: session.notes == ""
                  ? Text(
                      "No notes",
                      style: GoogleFonts.roboto(
                          fontSize: 14, color: Colors.black26),
                    )
                  : Text(session.notes,
                      style: GoogleFonts.roboto(fontSize: 14)),
            ),
          ],
        )
      ]),
    );
  }

  Widget _exercisePreview(Exercise exercise, BuildContext context, int index) {
    return StatefulBuilder(builder: (context, setState) {
      var session = Provider.of<CurrentTrainingSession>(context).session;
      if (session!.exercises.contains(exercise)) {
        return GestureDetector(
          onDoubleTap: () => showDialog<String>(
            context: context,
            builder: (context) => defaultDialog(
                title: 'Delete "${exercise.getExerciseTypeName()}"?',
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel')),
                  TextButton(
                      onPressed: () {
                        _sessionService
                            .removeExercise(context, exercise)
                            .then((value) => setState(
                                  () {},
                                ));
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Delete',
                        style: TextStyle(color: Colors.redAccent),
                      )),
                ]),
          ),
          onTap: () {
            _exerciseService!.openExercise(context, index);
            Navigator.of(context)
                .pushNamed('/set_exercise')
                .then((value) => setState(
                      () {},
                    ));
          },
          child: Container(
            padding: EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width,
            //height: 100,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                    bottom: BorderSide(
                        width: 0.5, color: Color.fromRGBO(0, 0, 0, .1)))),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 20),
                  child: Container(
                      decoration: const BoxDecoration(
                          //color: Color.fromRGBO(0, 0, 0, .05),
                          borderRadius: BorderRadius.all(Radius.circular(100))),
                      child: exercise.getImageUrl() == null
                          ? SizedBox(
                              width: 50,
                            )
                          : Image.network(
                              exercise.getImageUrl()!,
                              width: 50,
                            )),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 5),
                      width: MediaQuery.of(context).size.width - 40 - 50 - 20,
                      child: Text(
                        exercise.getExerciseTypeName(),
                        style: GoogleFonts.montserrat(
                            height: 1,
                            fontWeight: FontWeight.w800,
                            fontSize: 20),
                      ),
                    ),
                    Wrap(
                      spacing: 5,
                      children: [
                        tagWidget(exercise.getMainMetricText(), Colors.black,
                            textColor: Colors.white),
                        tagWidget(exercise.getSecondaryMetricText(),
                            Theme.of(context).primaryColor,
                            textColor: Colors.white),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      } else {
        return const SizedBox();
      }
    });
  }

  Widget _addExeciseButton(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom:
                  BorderSide(width: 0.5, color: Color.fromRGBO(0, 0, 0, .1)))),
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
            decoration: BoxDecoration(
                color: Colors.white,
                border:
                    Border.all(width: 0.5, color: Color.fromRGBO(0, 0, 0, .1)),
                borderRadius: BorderRadius.all(Radius.circular(50))),
            child: const FaIcon(
              FontAwesomeIcons.plus,
              size: 18,
            )),
      ),
    );
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
          appBar: defaultAppBar(context, "Training Session",
              'Day ${session!.dayInSchedule + 1} on ${regiment.name!}'),
          body: StatefulBuilder(builder: (contextm, setState) {
            return Column(children: [
              _infoBox(context, regiment, session),
              _addExeciseButton(context),
              Expanded(
                child: ReorderableListView.builder(
                    onReorder: (oldIndex, newIndex) {
                      _sessionService
                          .reinsertExercise(context, oldIndex, newIndex)
                          .then((value) => setState(
                                () {},
                              ));
                    },
                    itemCount: session.exercises.length,
                    itemBuilder: (context, index) {
                      if (index < session.exercises.length) {
                        return Container(
                          key: Key("$index"),
                          child: _exercisePreview(
                              session.exercises[index], context, index),
                        );
                      }
                      return SizedBox(key: Key("$index"));
                    }),
              ),
            ]);
          })),
    );
  }
}
