import 'package:flutter/material.dart';

Widget submitButton(BuildContext context, VoidCallback callback) {
  return ElevatedButton(onPressed: callback, child: const Text('Next'));
}
