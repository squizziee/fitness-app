import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/models/exercise.dart';
import 'package:flutter_fitness_app/models/exercise_type.dart';

import 'package:flutter_fitness_app/models/training_regiment.dart';
import 'package:flutter_fitness_app/models/training_session.dart';
import 'package:flutter_fitness_app/models/training_types.dart';
import 'package:flutter_fitness_app/views/regiment_creation/numberSheet.dart';

class TestPage extends StatelessWidget {
  const TestPage();
  @override
  Widget build(BuildContext context) {
    TrainingRegiment trainingRegiment = TrainingRegiment();
    trainingRegiment.setCycleDurationInDays(59);
    trainingRegiment.setTrainingType(Swimming());
    TrainingSession tr1 = TrainingSession();
    TrainingSession tr2 = TrainingSession();
    TrainingSession tr3 = TrainingSession();
    tr1.dayInSchedule = 1;
    tr2.dayInSchedule = 2;
    tr3.dayInSchedule = 4;

    Exercise ex1 = Exercise();
    ExerciseType ext1 = ExerciseType();
    ext1.name = "БАЛЬШИЕ НОГИ";
    ex1.type = ext1;
    ex1.bodyPartBias = "CHEST";
    ex1.notes = "Важное упражнение";
    tr1.exercises.add(ex1);

    Exercise ex2 = Exercise();
    ExerciseType ext2 = ExerciseType();
    ext2.name = "Bench press";
    ex2.type = ext2;
    ex2.bodyPartBias = "CHEST";
    ex2.notes = "3*8/3'";
    tr1.exercises.add(ex2);

    trainingRegiment.addToSchedule(tr1);
    trainingRegiment.addToSchedule(tr2);
    trainingRegiment.addToSchedule(tr3);
    return Scaffold(
      appBar: AppBar(
        title: Text('My Page'),
      ),
      body: NumberedSheet(n: trainingRegiment), // Вставка NumberedSheet в body
    );
  }
}
