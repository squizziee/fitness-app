import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/models/weight_training/weight_training_set.dart';
import 'package:flutter_fitness_app/repos/current_exercise.dart';
import 'package:flutter_fitness_app/models/weight_training/weight_exercise_type.dart';
import 'package:flutter_fitness_app/models/weight_training/weight_training_exercise.dart';
import 'package:flutter_fitness_app/services/custom_search_delegate.dart';
import 'package:flutter_fitness_app/services/load_exercise_list.dart';
import 'package:flutter_fitness_app/services/weight_exercise_service.dart';
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

  int setIndex = 0;

  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _repetitionsController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  void _clearControllers() {
    _weightController.text = "";
    _repetitionsController.text = "";
    _notesController.text = "";
  }

  Widget _title(BuildContext context) {
    var currentExercise = Provider.of<CurrentExercise>(context, listen: false)
        .exercise as WeightTrainingExercise;
    return Column(
      children: [
        Text('Exercise',
            style: GoogleFonts.montserrat(
                fontSize: 15, fontWeight: FontWeight.w700, height: 1)),
        Text(
            _exerciseService.isExerciseEmpty(context)
                ? 'New exercise'
                : currentExercise.exerciseType!.name,
            style: GoogleFonts.montserrat(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                height: 1,
                color: Colors.grey.shade500))
      ],
    );
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
      if (wset.setIndex <= setIndex) {
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
                                _exerciseService.removeLastSet(context);
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
                          _exerciseService.updateSetWeight(context, setIndex,
                              double.parse(_weightController.text));
                          _exerciseService.updateSetRepetitions(context,
                              setIndex, int.parse(_repetitionsController.text));
                          _exerciseService.updateSetNotes(
                              context, setIndex, _notesController.text);
                          setState(() {});
                          _clearControllers();
                          Navigator.pop(context, 'OK');
                        },
                        child: const Text('Save'),
                      )
                    ],
                  )),
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
                      _tagWidget('${(wset.weightInKilograms.toString())} kg',
                          Colors.black87),
                      _tagWidget('${(wset.repetitions.toString())} reps',
                          Colors.blueAccent),
                    ],
                  ),
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    child: Text(wset.notes))
              ],
            ),
          ),
        );
      } else {
        return const SizedBox();
      }
    });
  }

  Widget _tagWidget(String text, Color backgroundColor) {
    return Container(
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

  @override
  void initState() {
    super.initState();
    exerciseList = loadExerciseList();
  }

  @override
  Widget build(BuildContext context) {
    // if (exerciseIndex != -1) {
    //   currentExercise = Provider.of<CurrentTrainingRegiment>(context)
    //       .regiment
    //       .schedule[sessionIndex]
    //       .exercises[exerciseIndex] as WeightTrainingExercise;
    //   setIndex = currentExercise.sets.length;
    // }
    var currentExercise = Provider.of<CurrentExercise>(context, listen: false)
        .exercise as WeightTrainingExercise;
    setIndex = currentExercise.sets.length;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, 1),
          child:
              Container(height: 1, color: const Color.fromRGBO(0, 0, 0, 0.05)),
        ),
        title: _title(context),
        centerTitle: true,
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: const Color.fromRGBO(144, 238, 144, 1),
      //   shape: const CircleBorder(),
      //   heroTag: 'set_exercise_button',
      //   onPressed: () {
      //     var index =
      //         Provider.of<CurrentTrainingSession>(context, listen: false)
      //             .sessionIndex;
      //     if (Provider.of<CurrentTrainingSession>(context, listen: false)
      //             .exerciseIndex ==
      //         -1) {
      //       Provider.of<CurrentTrainingRegiment>(context, listen: false)
      //           .regiment
      //           .schedule[index]
      //           .exercises
      //           .add(currentExercise);
      //     }
      //     Navigator.of(context).pop();
      //   },
      //   child: const Icon(Icons.check),
      // ),
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
                                    .setExerciseType(context, type!));
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
                              child: Wrap(
                                spacing: 15,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: const BoxDecoration(
                                          color: Color.fromRGBO(0, 0, 0, .05),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(100))),
                                      height: 60,
                                      width: 60,
                                      child:
                                          currentExercise.exerciseType == null
                                              ? const Icon(Icons.search)
                                              : Image.network(
                                                  currentExercise
                                                      .exerciseType!.iconURL,
                                                  height: 20,
                                                  width: 20,
                                                )),
                                  Container(
                                    child: currentExercise.exerciseType == null
                                        ? Text('No exercise chosen',
                                            style: GoogleFonts.montserrat(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                                height: 1))
                                        : Wrap(
                                            crossAxisAlignment:
                                                WrapCrossAlignment.center,
                                            spacing: 6,
                                            children: [
                                                Text(
                                                    currentExercise
                                                        .exerciseType!.name,
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            height: 1)),
                                                _tagWidget(
                                                    currentExercise
                                                        .exerciseType!.bodyPart,
                                                    Colors.blueAccent),
                                                _tagWidget(
                                                    currentExercise
                                                        .exerciseType!.category,
                                                    Colors.black87),
                                              ]),
                                  ),
                                ],
                              )),
                        );
                      }
                    }),
              ],
            );
          }),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 100,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: Color.fromRGBO(0, 0, 0, .05), width: 1))),
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
                              _exerciseService.addSet(
                                  context,
                                  _notesController.text,
                                  int.parse(_repetitionsController.text),
                                  double.parse(_weightController.text),
                                  setIndex++);
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
