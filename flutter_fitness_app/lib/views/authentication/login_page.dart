import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/services/auth.dart';
import 'package:flutter_fitness_app/views/authentication/widgets/entry_field.dart';
import 'package:flutter_fitness_app/views/authentication/widgets/submit_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? errorMessage = '';

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
          email: _controllerEmail.text, password: _controllerPassword.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Widget _errorMessage() {
    return Text(errorMessage == null ? "Error: $errorMessage" : "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: double.infinity,
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          entryField('Email', _controllerEmail, false),
          const SizedBox(
            height: 20,
          ),
          entryField('Password', _controllerPassword, true),
          const SizedBox(
            height: 20,
          ),
          _errorMessage(),
          submitButton('Log in', () async {
            await signInWithEmailAndPassword();
          }, context),
          const SizedBox(
            height: 10,
          ),
          Wrap(
            children: [
              const Text('Don`t have an account? '),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(context, "/register");
                },
                child: Text(
                  "Register",
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              )
            ],
          )
        ],
      ),
    ));
  }
}
