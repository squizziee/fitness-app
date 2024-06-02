import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/models/base/user.dart';
import 'package:provider/provider.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  UserCredential? userCredential;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> signOut(BuildContext context) async {
    var appUser = Provider.of<AppUser>(context, listen: false);

    for (var regiment in appUser.regiments!) {
      regiment.cancelNotifications();
    }

    for (var goal in appUser.goals!) {
      goal.cancelNotifications();
    }

    await _firebaseAuth.signOut();
  }
}
