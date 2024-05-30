import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

Widget _title(String top, String bottom) {
  return Column(
    children: [
      Text(top,
          style: GoogleFonts.montserrat(
              fontSize: 15, fontWeight: FontWeight.w700, height: 1)),
      Text(bottom,
          style: GoogleFonts.montserrat(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              height: 1,
              color: Colors.grey.shade500))
    ],
  );
}

PreferredSizeWidget appBar(
    BuildContext context, String topText, String bottomText) {
  return AppBar(
      title: _title(topText, bottomText),
      centerTitle: true,
      actions: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed("/home");
          },
          child: Container(
              padding: const EdgeInsets.only(right: 15),
              child: const FaIcon(
                FontAwesomeIcons.house,
                size: 16,
                color: Colors.black,
              )),
        )
      ],
      bottom: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 1),
        child: Container(height: 1, color: const Color.fromRGBO(0, 0, 0, 0.05)),
      ));
}
