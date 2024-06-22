import 'package:flutter/material.dart';

Widget positionedImage({required String imageSrc, double size = 140}) {
  return Container(
    width: 0,
    height: 0,
    child: Stack(clipBehavior: Clip.none, children: [
      Positioned(
        right: 0,
        top: 0,
        child: FractionalTranslation(
          translation: const Offset(0.4, -0.12),
          child: Opacity(
            opacity: .35,
            child: Image.asset(
              imageSrc,
              height: size,
            ),
          ),
        ),
      )
    ]),
  );
}
