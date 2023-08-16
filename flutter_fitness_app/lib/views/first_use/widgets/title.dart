import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget title(String text) {
  return Text(text,
      textAlign: TextAlign.center,
      style: GoogleFonts.montserrat(
        fontSize: 38,
        fontWeight: FontWeight.w800,
      ));
}
