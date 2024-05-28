import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_app_serialization/app_user_serializer.dart';
import 'package:fitness_app_serialization/combat_training_firestore_serializer.dart';
import 'package:fitness_app_serialization/cycling_firestore_serializer.dart';
import 'package:fitness_app_serialization/firestore_serializer.dart';
import 'package:fitness_app_serialization/goal_firestore_serializer.dart';
import 'package:fitness_app_serialization/rowing_firestore_serializer.dart';
import 'package:fitness_app_serialization/running_firestore_serializer.dart';
import 'package:fitness_app_serialization/swimming_firestore_serializer.dart';
import 'package:fitness_app_serialization/weight_training_firestore_serializer.dart';
import 'package:flutter_fitness_app/models/combat_training/combat_training_session.dart';
import 'package:flutter_fitness_app/models/cycling/cycling_session.dart';
import 'package:flutter_fitness_app/models/goal.dart';
import 'package:flutter_fitness_app/models/rowing/rowing_session.dart';
import 'package:flutter_fitness_app/models/running/running_session.dart';
import 'package:flutter_fitness_app/models/swimming/swimming_session.dart';
import 'package:flutter_fitness_app/models/training_regiment.dart';
import 'package:flutter_fitness_app/models/training_session.dart';
import 'package:flutter_fitness_app/models/training_types.dart';
import 'package:flutter_fitness_app/models/user.dart';
import 'package:flutter_fitness_app/models/weight_training/weight_exercise_type.dart';
import 'package:flutter_fitness_app/models/weight_training/weight_training_session.dart';

class DatabaseService {
  static final Map<Type, FirestoreSerializer> _regimentSerializers = {
    WeightTraining: WeightTrainingFirestoreSerializer(),
    Swimming: SwimmingFirestoreSerializer(),
    Running: RunningFirestoreSerializer(),
    Cycling: CyclingFirestoreSerializer(),
    Rowing: RowingFirestoreSerializer(),
    CombatTraining: CombatTrainingFirestoreSerializer()
  };

  static final Map<Type, (String, FirestoreSerializer)> _sessionSerializers = {
    WeightTrainingSession: (
      "strength_training_sessions",
      WeightTrainingFirestoreSerializer()
    ),
    SwimmingSession: ("", SwimmingFirestoreSerializer()),
    RunningSession: ("", RunningFirestoreSerializer()),
    CyclingSession: ("", CyclingFirestoreSerializer()),
    RowingSession: ("", RowingFirestoreSerializer()),
    CombatTrainingSession: ("", CombatTrainingFirestoreSerializer())
  };

  Future<List<TrainingRegiment>> getUserRegiments(String userId) async {
    var db = FirebaseFirestore.instance;
    var user = (await db
            .collection("users")
            .where("user_uid", isEqualTo: userId)
            .get())
        .docs[0]
        .data();
    // var user = (await db.doc(userId).get()).data()!;
    FirestoreSerializer? serializer;

    // Final result to be stored here
    List<TrainingRegiment> regiments = [];
    // Iterate through all regiments
    if (user["regiments"] == null) {
      return regiments;
    }
    for (var regimentRef in user["regiments"]) {
      var regimentDoc = (await regimentRef.get()).data()!;
      if (getTrainingType(regimentDoc["training_type"]) is WeightTraining) {
        serializer = WeightTrainingFirestoreSerializer();
      }
      var regiment =
          await serializer!.deserializeRegiment(regimentDoc, regimentRef);
      regiments.add(regiment);
    }
    return regiments;
  }

  Future<List<Goal>> getUserGoals(String userId) async {
    var db = FirebaseFirestore.instance;
    var user = (await db
            .collection("users")
            .where("user_uid", isEqualTo: userId)
            .get())
        .docs[0]
        .data();

    var serializer = GoalFirestoreSerializer();

    List<Goal> goals = [];
    for (var goalRef in user["goals"]) {
      var goalDoc = (await goalRef.get()).data()!;
      var goal = await serializer.deserializeGoal(goalDoc, goalRef);
      goals.add(goal);
    }
    return goals;
  }

  Future<List<(TrainingSession, TrainingRegiment)>> getAllUserTrainingSessions(
      String userId) async {
    var regiments = await getUserRegiments(userId);
    List<(TrainingSession, TrainingRegiment)> result = [];
    for (var regiment in regiments) {
      for (var session in regiment.schedule!) {
        result.add((session, regiment));
      }
    }
    return result;
  }

  Future<List<(TrainingSession, TrainingRegiment)>> getUserTrainingSessions(
      String userId) async {
    var regiments = await getUserRegiments(userId);
    List<(TrainingSession, TrainingRegiment)> result = [];
    for (var regiment in regiments) {
      var currentDay = regiment.getCurrentDay();
      if (currentDay != -1) {
        result.add((regiment.schedule![currentDay], regiment));
      }
    }
    return result;
  }

  Future<void> postAppUser(AppUser user) async {
    var db = FirebaseFirestore.instance;
    var collection = db.collection("users");
    var doc =
        (await collection.where("user_uid", isEqualTo: user.userUID).get())
            .docs[0]
            .reference;

    // If the regiment is new, create Firestore doc for it and put it in object as a field
    await doc.set(AppUserSerializer().serialize(user));
  }

  // Works assuming all training sessions are posted already
  Future<void> postRegiment(TrainingRegiment regiment) async {
    var db = FirebaseFirestore.instance;
    FirestoreSerializer serializer =
        _regimentSerializers[regiment.trainingType.runtimeType]!;
    var collection = db.collection("regiments");
    var regimentDoc = regiment.id;
    if (regimentDoc == null) {
      regimentDoc = collection.doc();
      regiment.id = regimentDoc;
    }

    // If the regiment is new, create Firestore doc for it and put it in object as a field
    await regimentDoc.set(serializer.serializeRegiment(regiment));
  }

  Future<void> postSession(TrainingSession session) async {
    var db = FirebaseFirestore.instance;
    FirestoreSerializer serializer =
        _sessionSerializers[session.runtimeType]!.$2;
    var collection =
        db.collection(_sessionSerializers[session.runtimeType]!.$1);
    var sessionDoc = session.id;
    if (sessionDoc == null) {
      sessionDoc = collection.doc();
      session.id = sessionDoc;
    }

    var temp = serializer.serializeSession(session);
    // If the session is new, create Firestore doc for it and put it in object as a field
    await sessionDoc.set(temp);
  }

  Future<void> postGoal(Goal goal) async {
    var db = FirebaseFirestore.instance;
    var serializer = GoalFirestoreSerializer();
    var collection = db.collection("goals");
    var goalDoc = goal.id;
    if (goalDoc == null) {
      goalDoc = collection.doc();
      goal.id = goalDoc;
    }

    var temp = serializer.serializeGoal(goal);
    // If the session is new, create Firestore doc for it and put it in object as a field
    await goalDoc.set(temp);
  }

  TrainingType getTrainingType(String str) {
    if (str == "Weight training") {
      return WeightTraining();
    }
    throw Exception("No such training type");
  }

  Future<List<WeightExerciseType>> loadWeightExerciseList() async {
    var exerciseCollection =
        FirebaseFirestore.instance.collection('strength_exercises');
    var exerciseSnapshot = await exerciseCollection.get();
    List<WeightExerciseType> result = [];
    for (var doc in exerciseSnapshot.docs) {
      result.add(WeightExerciseType(
          name: doc['name'],
          bodyPart: doc['bodypart'],
          iconURL: doc['icon_url'],
          category: doc['category'],
          id: doc.reference));
    }
    return result;
  }
}
