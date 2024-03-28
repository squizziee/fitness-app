import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/models/exercise_type.dart';
import 'package:flutter_fitness_app/services/load_exercise_list.dart';

class WeightTrainingExercisesListScreen extends StatefulWidget {
  const WeightTrainingExercisesListScreen({super.key});

  @override
  State<WeightTrainingExercisesListScreen> createState() =>
      _WeightTrainingExercisesListScreenState();
}

class _WeightTrainingExercisesListScreenState
    extends State<WeightTrainingExercisesListScreen> {
  ScrollController? controller;
  Future<List<WeightExerciseType>>? exercises;
  List<WeightExerciseType> shownExercises = [];
  AsyncSnapshot<List<WeightExerciseType>>? snapshotCopy;
  int step = 20;
  int lowBound = 0;
  int highBound = 20;
  final TextEditingController _controller = TextEditingController();

  Widget _searchField(BuildContext context, String placeholder,
      TextEditingController controller) {
    return TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: placeholder,
          contentPadding:
              const EdgeInsets.only(left: 25, right: 20, top: 20, bottom: 20),
          filled: true,
          fillColor: const Color.fromARGB(31, 180, 180, 180),
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(50)),
        ));
  }

  void loadChunk() {}

  void _scrollListener() {
    if (controller!.position.extentAfter < 500) {
      setState(() {
        for (int i = lowBound; i < highBound; i++) {
          shownExercises.add(snapshotCopy!.data![i]);
        }
        lowBound += step;
        highBound += step;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    exercises = loadExerciseList();
    controller = ScrollController()..addListener(_scrollListener);
  }

  Widget _exerciseWidget(WeightExerciseType e, BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(20),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Wrap(children: [
            Image.network(
              e.iconURL,
              height: constraints.maxHeight,
            ),
            Column(children: [Text(e.name), Text(e.category), Text(e.bodyPart)])
          ]);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            _searchField(context, 'Search for exercises...', _controller),
            Expanded(
              child: Container(
                child: FutureBuilder(
                    future: exercises,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        snapshotCopy = snapshot;
                        for (int i = lowBound; i < highBound; i++) {
                          shownExercises.add(snapshot.data![i]);
                        }
                        lowBound += step;
                        highBound += step;

                        return ListView.builder(
                          controller: controller,
                          itemBuilder: (context, index) {
                            return _exerciseWidget(
                                shownExercises[index], context);
                          },
                          itemCount: shownExercises.length,
                        );
                      }
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
