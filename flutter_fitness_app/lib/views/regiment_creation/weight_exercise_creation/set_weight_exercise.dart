import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/models/weight_training/weight_training_set.dart';
import 'package:flutter_fitness_app/repos/current_exercise.dart';
import 'package:flutter_fitness_app/models/weight_training/weight_exercise_type.dart';
import 'package:flutter_fitness_app/models/weight_training/weight_training_exercise.dart';
import 'package:flutter_fitness_app/services/custom_search_delegate.dart';
import 'package:flutter_fitness_app/services/database_service.dart';
import 'package:flutter_fitness_app/services/weight_exercise_service.dart';
import 'package:flutter_fitness_app/views/regiment_creation/common_widgets/app_bar.dart';
import 'package:flutter_fitness_app/views/regiment_creation/common_widgets/dialog.dart';
import 'package:flutter_fitness_app/views/regiment_creation/common_widgets/tag_widget.dart';
import 'package:flutter_fitness_app/views/regiment_creation/weight_exercise_creation/set_editing_form.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SetWeightExercisePage extends StatefulWidget {
  const SetWeightExercisePage({super.key});

  @override
  State<SetWeightExercisePage> createState() => _SetWeightExercisePageState();
}

class _SetWeightExercisePageState extends State<SetWeightExercisePage> {
  Future<List<WeightExerciseType>>? exerciseList;

  final WeightExerciseService _exerciseService = WeightExerciseService();
  final DatabaseService _dbService = DatabaseService();

  Widget _setWidget(WeightTrainingSet wset) {
    return StatefulBuilder(builder: (context, setState) {
      return GestureDetector(
        onTap: () => showDialog<String>(
            context: context,
            builder: (context) => defaultDialog(title: "Edit set", content: [
                  SetEditingForm(
                    weightSet: wset,
                    isNewSet: false,
                  )
                ])),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                  bottom: BorderSide(
                      color: Color.fromRGBO(0, 0, 0, .05), width: 1))),
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(),
                child: Wrap(
                  spacing: 5,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      'Set ${(wset.setIndex + 1).toString()}',
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                          fontSize: 18),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    tagWidget('${(wset.weightInKilograms.toString())} kg',
                        Colors.black),
                    tagWidget('${(wset.repetitions.toString())} reps',
                        Theme.of(context).primaryColor),
                  ],
                ),
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Text(wset.notes))
            ],
          ),
        ),
      );
    });
  }

  Widget _addSetButton(BuildContext context) {
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
        onTap: () => showDialog<String>(
            context: context,
            builder: (context) => defaultDialog(title: "Add set", content: [
                  SetEditingForm(
                    weightSet: WeightTrainingSet(
                        weightInKilograms: 0,
                        repetitions: 0,
                        notes: '',
                        setIndex: 0),
                    isNewSet: true,
                  )
                ])),
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
  void initState() {
    super.initState();
    exerciseList = _dbService.loadWeightExerciseList();
  }

  @override
  Widget build(BuildContext context) {
    var currentExercise = Provider.of<CurrentExercise>(context, listen: false)
        .exercise as WeightTrainingExercise;
    return SafeArea(
        child: Scaffold(
      appBar: defaultAppBar(
          context,
          'Exercise',
          _exerciseService.isExerciseEmpty(context)
              ? 'New exercise'
              : currentExercise.exerciseType!.name),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StatefulBuilder(builder: (context, setState) {
            return Wrap(
              children: [
                FutureBuilder(
                    future: exerciseList,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return GestureDetector(
                            onTap: () async {
                              await showSearch(
                                      context: context,
                                      delegate:
                                          CustomSearchDelegate(snapshot.data))
                                  .then((type) => _exerciseService
                                      .setExerciseType(context, type));
                              setState(() {});
                            },
                            child: Container(
                                padding: const EdgeInsets.all(10),
                                width: MediaQuery.of(context).size.width,
                                decoration: const BoxDecoration(
                                    border: Border(
                                  bottom: BorderSide(
                                      color: Color.fromRGBO(0, 0, 0, 0.05),
                                      width: 1),
                                )),
                                child: Row(children: [
                                  Container(
                                      padding: EdgeInsets.all(20),
                                      child:
                                          currentExercise.exerciseType == null
                                              ? const Icon(Icons.search)
                                              : Image.network(
                                                  currentExercise
                                                      .exerciseType!.iconURL,
                                                  width: 50,
                                                )),
                                  Container(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      currentExercise.exerciseType == null
                                          ? Text('No exercise chosen',
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w600,
                                                  height: 1))
                                          : Container(
                                              child: Text(
                                                  currentExercise
                                                      .exerciseType!.name,
                                                  overflow: TextOverflow.fade,
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      height: 1))),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      currentExercise.exerciseType == null
                                          ? SizedBox()
                                          : Wrap(
                                              spacing: 5,
                                              children: [
                                                tagWidget(
                                                    currentExercise
                                                        .exerciseType!.bodyPart,
                                                    Colors.black),
                                                tagWidget(
                                                    currentExercise
                                                        .exerciseType!.category,
                                                    Theme.of(context)
                                                        .primaryColor),
                                              ],
                                            )
                                    ],
                                  ))
                                ])));
                      }
                    }),
              ],
            );
          }),
          _addSetButton(context),
          Expanded(
            child: ReorderableListView.builder(
                onReorder: (oldIndex, newIndex) {
                  _exerciseService
                      .reinsertSet(context, oldIndex, newIndex)
                      .then((value) => setState(
                            () {},
                          ));
                },
                itemCount: currentExercise.sets.length,
                itemBuilder: (context, index) {
                  return Container(
                      key: Key("$index"),
                      child: _setWidget(currentExercise.sets[index]));
                }),
          ),
        ],
      ),
    ));
  }
}
