import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/models/exercise.dart';
import 'package:flutter_fitness_app/models/exercise_type.dart';
import 'package:flutter_fitness_app/services/custom_search_delegate.dart';
import 'package:flutter_fitness_app/services/load_exercise_list.dart';

class SetExercisePage extends StatefulWidget {
  const SetExercisePage({super.key});

  @override
  State<SetExercisePage> createState() => _SetExercisePageState();
}

class _SetExercisePageState extends State<SetExercisePage> {
  Future<List<ExerciseType>>? exerciseList;
  
  ExerciseType? chosenExercise;

  @override
  void initState() {
    super.initState();
    exerciseList = loadExerciseList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: StatefulBuilder(
            builder:(context, setState) {
              return Wrap(
                children: [FutureBuilder(
                  future: exerciseList,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return FloatingActionButton(
                        child: const Icon(Icons.search),
                        onPressed:  () async {
                          chosenExercise = await showSearch(
                            context: context, 
                            delegate: CustomSearchDelegate(snapshot.data)
                          );
                          setState((){});
                        }
                      );
                    }
                  }
                ),
                Text(chosenExercise == null ? 'No exercise chosen' : chosenExercise!.name),
                ],
            );
            }
          ),
        )
    );
  }
}