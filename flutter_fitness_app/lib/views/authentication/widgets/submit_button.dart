import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/models/base/user.dart';
import 'package:provider/provider.dart';

void updateFirstTimeStatus(BuildContext context) {
  Provider.of<AppUser>(context, listen: false);
}

Widget submitButton(String text, VoidCallback callback, BuildContext context) {
  return ElevatedButton(onPressed: callback, child: Text(text));
}
