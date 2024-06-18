import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget defaultDialog(
    {String title = "Default title",
    List<Widget>? content,
    List<Widget>? actions}) {
  return AlertDialog(
    clipBehavior: Clip.hardEdge,
    title: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: 0.5, color: Color.fromRGBO(0, 0, 0, .1)))),
        child: Text(
          title,
          style: GoogleFonts.montserrat(fontWeight: FontWeight.w700),
        )),
    titlePadding: EdgeInsets.zero,
    surfaceTintColor: Colors.transparent,
    backgroundColor: Colors.white,
    contentPadding: EdgeInsets.zero,
    actionsPadding: EdgeInsets.only(right: 10, top: 5, bottom: 5),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(0))),
    content: SingleChildScrollView(
      child: content == null ? SizedBox() : Column(children: content),
    ),
    actions: actions,
  );
}
