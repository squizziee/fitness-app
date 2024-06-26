import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

Widget defaultTextField(
    {String placeholder = "",
    required TextInputType inputType,
    required TextEditingController controller}) {
  return TextField(
    controller: controller,
    style: GoogleFonts.roboto(fontSize: 15, fontWeight: FontWeight.w500),
    keyboardType: inputType,
    maxLines: inputType == TextInputType.multiline ? null : 1,
    decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide:
                BorderSide(width: 0.5, color: Color.fromRGBO(0, 0, 0, .1))),
        enabledBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide:
                BorderSide(width: 0.5, color: Color.fromRGBO(0, 0, 0, .1))),
        labelText: placeholder,
        floatingLabelStyle: GoogleFonts.roboto(
            color: Colors.black, fontWeight: FontWeight.w600),
        contentPadding:
            EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        filled: true,
        fillColor: Color.fromRGBO(0, 0, 0, .0)),
  );
}

Widget formTextField(
    {String placeholder = "",
    bool isMultiline = false,
    required List<TextInputFormatter>? inputFormatters,
    required TextEditingController controller,
    required String? Function(String?)? validator}) {
  return TextFormField(
    validator: validator,
    inputFormatters: inputFormatters,
    controller: controller,
    style: GoogleFonts.roboto(fontSize: 15, fontWeight: FontWeight.w500),
    keyboardType: isMultiline ? TextInputType.multiline : TextInputType.text,
    maxLines: isMultiline ? null : 1,
    decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide:
                BorderSide(width: 0.5, color: Color.fromRGBO(0, 0, 0, .1))),
        enabledBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide:
                BorderSide(width: 0.5, color: Color.fromRGBO(0, 0, 0, .1))),
        labelText: placeholder,
        floatingLabelStyle: GoogleFonts.roboto(
            color: Colors.black, fontWeight: FontWeight.w600),
        contentPadding:
            EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        filled: true,
        fillColor: Color.fromRGBO(0, 0, 0, .0)),
  );
}
