import 'package:flutter/material.dart';

Widget submitButton(BuildContext context, VoidCallback callback, String text) {
  return ElevatedButton(onPressed: callback, child: Text(text));
}
