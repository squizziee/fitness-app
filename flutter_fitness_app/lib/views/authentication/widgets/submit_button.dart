import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/models/user.dart';
import 'package:provider/provider.dart';

Future<void> updateFirstTimeStatus(BuildContext context) async {
  await Provider.of<AppUser>(context, listen: false).setFirstTimeUsing(true);
}

Widget submitButton(String text, VoidCallback callback, BuildContext context) {
  return ElevatedButton(onPressed: callback, child: Text(text));
}
