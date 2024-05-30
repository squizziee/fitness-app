import 'package:flutter/material.dart';

Widget entryField(BuildContext context, String placeholder,
    TextEditingController controller) {
  return TextField(
      controller: controller,
      toolbarOptions: ToolbarOptions(
          copy: false, paste: false, cut: false, selectAll: true),
      decoration: InputDecoration(
        labelText: placeholder,
        contentPadding:
            const EdgeInsets.only(left: 25, right: 20, top: 20, bottom: 20),
        filled: true,
        fillColor: const Color.fromARGB(31, 180, 180, 180),
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(50)),
      ));
}
