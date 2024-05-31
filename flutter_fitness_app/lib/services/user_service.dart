import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_app_serialization/app_user_serializer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/models/training_regiment.dart';
import 'package:flutter_fitness_app/models/training_session.dart';
import 'package:flutter_fitness_app/models/user.dart';
import 'package:flutter_fitness_app/services/auth.dart';
import 'package:flutter_fitness_app/services/database_service.dart';
import 'package:provider/provider.dart';

class UserService {
  final Auth _authService = Auth();
  final DatabaseService _dbService = DatabaseService();

  Future<int> loadUserData(BuildContext context) async {
    var appUser = Provider.of<AppUser>(context, listen: false);
    if (_authService.currentUser == null) {
      return 1;
    }
    appUser.userUID = _authService.currentUser!.uid;
    _handleUserExistence(context, appUser.userUID!);

    appUser.regiments = await _dbService.getUserRegiments(appUser.userUID!);

    for (var regiment in appUser.regiments!) {
      if (regiment.startDate != null) {
        regiment.cancelNotifications();
        regiment.startNotifications(regiment.dayOfPause == -1
            ? regiment.getCurrentDay()
            : regiment.dayOfPause);
      }
    }

    for (var goal in appUser.goals!) {
      if (goal.notificationId != null) {
        goal.cancelNotifications();
        goal.startNotifications();
      }
    }

    appUser.goals = await _dbService.getUserGoals(appUser.userUID!);
    return 0;
  }

  // Creates user document if not present already
  void _handleUserExistence(
      BuildContext context, String firebaseAuthUID) async {
    var db = FirebaseFirestore.instance;
    var collection = db.collection("users");
    var userQuery =
        await collection.where("user_uid", isEqualTo: firebaseAuthUID).get();
    if (userQuery.docs.isEmpty) {
      var newAppUserDoc = collection.doc();
      var appUser = Provider.of<AppUser>(context, listen: false);
      await newAppUserDoc.set(AppUserSerializer().serialize(appUser));
      // var user = userQuery.docs[0];
    }
  }

  Future removeAllUserRegiments(BuildContext context) async {
    var user = Provider.of<AppUser>(context, listen: false);
    user.regiments = [];
    await _dbService.removeAllUserRegiments(user);
  }

  List<(TrainingSession, TrainingRegiment)> getCurrentUserSessions(
      BuildContext context) {
    List<(TrainingSession, TrainingRegiment)> result = [];
    var user = Provider.of<AppUser>(context, listen: false);

    for (var regiment in user.regiments!) {
      if (regiment.getCurrentDay() != -1) {
        result.add((regiment.schedule![regiment.getCurrentDay()], regiment));
      }
    }

    return result;
  }

  Future removeAllUserGoals(BuildContext context) async {
    var user = Provider.of<AppUser>(context, listen: false);
    user.goals = [];
    await _dbService.removeAllUserGoals(user);
  }
}
