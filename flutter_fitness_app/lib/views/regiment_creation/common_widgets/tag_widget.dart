import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget tagWidget(String text, Color backgroundColor,
    {Color textColor = Colors.white}) {
  return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, .05),
                spreadRadius: 3,
                blurRadius: 10)
          ],
          color: backgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(5))),
      child: Text(text.toUpperCase(),
          style: GoogleFonts.montserrat(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: textColor,
              height: 1)));
}
