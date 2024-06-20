import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

Widget routeBaseButton(
    BuildContext context, String baseRouteName, IconData faIcon, String text,
    {bool topBorder = true}) {
  return GestureDetector(
    onTap: () {
      Navigator.of(context).pushNamed(baseRouteName);
    },
    child: Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(35),
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(width: 0.5, color: Color.fromRGBO(0, 0, 0, .1)),
            top: BorderSide(
                width: topBorder ? 0.5 : 0.0,
                color: Color.fromRGBO(0, 0, 0, .1))),
      ),
      child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 10,
          alignment: WrapAlignment.center,
          children: [
            FaIcon(
              faIcon,
              size: 16,
            ),
            Text(
              text.toUpperCase(),
              style:
                  GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ]),
    ),
  );
}
