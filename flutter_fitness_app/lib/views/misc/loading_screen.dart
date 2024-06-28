import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoadingScreen extends StatelessWidget {
  final String? message;

  const LoadingScreen({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/app_logo_transparent.png',
                width: 300,
              ),
              // CircularProgressIndicator(),
              // SizedBox(
              //   height: 70,
              // ),
              // Text(
              //   message == null ? "Loading your data..." : message!,
              //   style: GoogleFonts.montserrat(
              //       fontWeight: FontWeight.w600, fontSize: 15),
              // )
            ]),
      ),
    ));
  }
}
