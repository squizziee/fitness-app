import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/models/OpenedTrainingSession.dart';
import 'package:flutter_fitness_app/models/new_training_regiment.dart';
import 'package:flutter_fitness_app/views/regiment_creation/select_training_session.dart';
import 'package:flutter_fitness_app/views/regiment_creation/training_session_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SetRegimentCalendarPage extends StatefulWidget {
  const SetRegimentCalendarPage({super.key});

  @override
  State<SetRegimentCalendarPage> createState() => _SetRegimentCalendarPageState();
}

class _SetRegimentCalendarPageState extends State<SetRegimentCalendarPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Column(
                  children: [
                    Text(Provider.of<NewTrainingRegiment>(context).regiment.name),
                    Text(Provider.of<NewTrainingRegiment>(context).regiment.trainingType.toString())
                  ]
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                child: Column(
                  children: List.generate(
                    Provider.of<NewTrainingRegiment>(context).regiment.cycleDurationInDays,
                    (index) {
                      return GestureDetector(
                        onTap: () {
                            //Navigator.of(context).push(MaterialPageRoute(builder: (context) 
                            //  => SelectTrainingSessionPage(sessionIndex: index)));
                            Provider.of<OpenedTrainingSession>(context, listen: false).sessionIndex = index;
                            Navigator.of(context).pushNamed('/select_training_session');
                          },
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 5,
                                blurRadius: 10,
                              ),
                            ],
                            color: Colors.white,
                            borderRadius: const BorderRadius.all(Radius.circular(15.0))
                            ),
                          height: 150.0,
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.all(20),
                          margin: const EdgeInsets.only(bottom: 20.0),
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              return Wrap(children: [
                                // Image.network(
                                //   e.iconURL,
                                //   height: constraints.maxHeight,
                                // ),
                                Column(
                                  children: [
                                    Text("Day #${index+1}", 
                                      style: GoogleFonts.montserrat(
                                        fontSize: 35, 
                                        fontWeight: FontWeight.w800, height: 1
                                      )
                                    )
                                  ]
                                )
                              ]);
                            },
                          ),
                        ),
                      );
                    }),
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}