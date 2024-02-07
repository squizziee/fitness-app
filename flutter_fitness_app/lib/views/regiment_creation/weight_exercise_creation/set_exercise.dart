import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/models/OpenedTrainingSession.dart';
import 'package:flutter_fitness_app/models/exercise.dart';
import 'package:flutter_fitness_app/models/exercise_type.dart';
import 'package:flutter_fitness_app/models/new_training_regiment.dart';
import 'package:flutter_fitness_app/models/weight_training/weight_training_exercise.dart';
import 'package:flutter_fitness_app/services/custom_search_delegate.dart';
import 'package:flutter_fitness_app/services/load_exercise_list.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class SetExercisePage extends StatefulWidget {
  const SetExercisePage({super.key});

  @override
  State<SetExercisePage> createState() => _SetExercisePageState();
}

class _SetExercisePageState extends State<SetExercisePage> {
  Future<List<ExerciseType>>? exerciseList;

  var currentExercise = WeightTrainingExercise();
  int setIndex = 0;

  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _repetitionsController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  void _clearControllers() {
    _weightController.text = "";
    _repetitionsController.text = "";
    _notesController.text = "";
  }

  Widget _weightField(String text) {
    _weightController.text = text;
    return TextField(
        controller: _weightController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: 'Weight',
          contentPadding:
              const EdgeInsets.only(left: 15, right: 10, top: 10, bottom: 10),
          filled: true,
          fillColor: const Color.fromARGB(31, 180, 180, 180),
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(50)),
        ));
  }

  Widget _repetitionsField(String text) {
    _repetitionsController.text = text;
    return TextField(
        controller: _repetitionsController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: 'Repetitions',
          contentPadding:
              const EdgeInsets.only(left: 15, right: 10, top: 10, bottom: 10),
          filled: true,
          fillColor: const Color.fromARGB(31, 180, 180, 180),
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(50)),
        ));
  }

  Widget _notesField(String text) {
    _notesController.text = text;
    return TextField(
        controller: _notesController,
        decoration: InputDecoration(
          labelText: 'Notes',
          contentPadding:
              const EdgeInsets.only(left: 15, right: 10, top: 10, bottom: 10),
          filled: true,
          fillColor: const Color.fromARGB(31, 180, 180, 180),
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(50)),
        ));
  }

  Widget _setWidget(WeightTrainingSet wset) {
    return StatefulBuilder(builder: (context, setState) {
      if (wset.setIndex < setIndex) {
        return GestureDetector(
          onLongPress: () => showDialog<String>(
              context: context,
              builder: (context) => AlertDialog(
                    title: const Text('Edit set'),
                    content: Column(
                      children: [
                        _weightField(wset.weightInKilograms.toString()),
                        const SizedBox(height: 10),
                        _repetitionsField(wset.repetitions.toString()),
                        const SizedBox(height: 10),
                        _notesField(wset.notes),
                      ],
                    ),
                    actions: <Widget>[
                      wset.setIndex == setIndex - 1
                          ? TextButton(
                              onPressed: () {
                                int sessionIndex =
                                    Provider.of<OpenedTrainingSession>(context,
                                            listen: false)
                                        .sessionIndex;
                                int exerciseIndex =
                                    Provider.of<OpenedTrainingSession>(context,
                                            listen: false)
                                        .exerciseIndex;
                                if (exerciseIndex == -1) {
                                  currentExercise.sets.remove(wset);
                                } else {
                                  (Provider.of<NewTrainingRegiment>(context,
                                                  listen: false)
                                              .regiment
                                              .schedule[sessionIndex]
                                              .exercises[exerciseIndex]
                                          as WeightTrainingExercise)
                                      .sets
                                      .remove(wset);
                                }
                                --setIndex;
                                setState(() {});
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                'Delete',
                                style: TextStyle(color: Colors.redAccent),
                              ),
                            )
                          : const SizedBox(),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          wset.weightInKilograms =
                              int.parse(_weightController.text);
                          wset.repetitions =
                              int.parse(_repetitionsController.text);
                          wset.notes = _notesController.text;
                          setState(() {});
                          _clearControllers();
                          Navigator.pop(context, 'OK');
                        },
                        child: const Text('Save'),
                      )
                    ],
                  )),
          child: Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            height: 100,
            child: wset.getWidget(),
          ),
        );
      } else {
        return const SizedBox();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    exerciseList = loadExerciseList();
  }

  @override
  Widget build(BuildContext context) {
    int sessionIndex = Provider.of<OpenedTrainingSession>(context).sessionIndex;
    int exerciseIndex =
        Provider.of<OpenedTrainingSession>(context).exerciseIndex;
    if (exerciseIndex != -1) {
      currentExercise = Provider.of<NewTrainingRegiment>(context)
          .regiment
          .schedule[sessionIndex]
          .exercises[exerciseIndex] as WeightTrainingExercise;
      setIndex = currentExercise.sets.length;
    }
    return SafeArea(
        child: Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(144, 238, 144, 1),
        shape: const CircleBorder(),
        heroTag: 'set_exercise_button',
        onPressed: () {
          var index = Provider.of<OpenedTrainingSession>(context, listen: false)
              .sessionIndex;
          if (Provider.of<OpenedTrainingSession>(context, listen: false)
                  .exerciseIndex ==
              -1) {
            Provider.of<NewTrainingRegiment>(context, listen: false)
                .regiment
                .schedule[index]
                .exercises
                .add(currentExercise);
          }
          Navigator.of(context).pop();
        },
        child: const Icon(Icons.check),
      ),
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
                        return FloatingActionButton(
                            child: const Icon(Icons.search),
                            onPressed: () async {
                              currentExercise.exerciseType = await showSearch(
                                  context: context,
                                  delegate:
                                      CustomSearchDelegate(snapshot.data));
                              setState(() {});
                            });
                      }
                    }),
                Text(currentExercise.exerciseType == null
                    ? 'No exercise chosen'
                    : currentExercise.exerciseType!.name),
              ],
            );
          }),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 100,
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () => showDialog<String>(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: const Text('Add new set'),
                        content: Column(
                          children: [
                            _weightField(""),
                            const SizedBox(height: 10),
                            _repetitionsField(""),
                            const SizedBox(height: 10),
                            _notesField(""),
                          ],
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              currentExercise.sets.add(WeightTrainingSet(
                                  weightInKilograms:
                                      int.parse(_weightController.text),
                                  repetitions:
                                      int.parse(_repetitionsController.text),
                                  notes: _notesController.text,
                                  setIndex: setIndex++));
                              _clearControllers();
                              Navigator.pop(context, 'OK');
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      )),
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
                itemCount: currentExercise.sets.length,
                itemBuilder: (context, index) {
                  return _setWidget(currentExercise.sets[index]);
                }),
          ),
        ],
      ),
    ));
  }
}
