import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_app_serialization/app_user_serializer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/models/user.dart';
import 'package:flutter_fitness_app/services/auth.dart';
import 'package:flutter_fitness_app/services/database_service.dart';
import 'package:provider/provider.dart';

class UserService {
  final Auth _authService = Auth();
  final DatabaseService _dbService = DatabaseService();

  void loadUserData(BuildContext context) async {
    var appUser = Provider.of<AppUser>(context, listen: false);
    appUser.userUID = _authService.currentUser!.uid;
    _handleUserExistence(context, appUser.userUID!);

    appUser.regiments = await _dbService.getUserRegiments(appUser.userUID!);
    appUser.goals = await _dbService.getUserGoals(appUser.userUID!);
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
      var appUser = Provider.of<AppUser>(context);
      await newAppUserDoc.set(AppUserSerializer().serialize(appUser));
      // var user = userQuery.docs[0];
    }
  }
}
