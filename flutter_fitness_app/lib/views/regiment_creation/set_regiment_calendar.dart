import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/repos/current_training_regiment.dart';
import 'package:flutter_fitness_app/services/session_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SetRegimentCalendarPage extends StatefulWidget {
  const SetRegimentCalendarPage({super.key});

  @override
  State<SetRegimentCalendarPage> createState() =>
      _SetRegimentCalendarPageState();
}

class _SetRegimentCalendarPageState extends State<SetRegimentCalendarPage> {
  //Widget _sessionWidget() {

  //}
  final SessionService _sessionService = SessionService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Column(children: [
                  Text(Provider.of<CurrentTrainingRegiment>(context)
                      .regiment!
                      .name!),
                  Text(Provider.of<CurrentTrainingRegiment>(context)
                      .regiment!
                      .trainingType
                      .toString())
                ]),
              ),
              Container(
                padding:
                    const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                child: Column(
                  children: List.generate(
                      Provider.of<CurrentTrainingRegiment>(context)
                          .regiment!
                          .cycleDurationInDays!, (index) {
                    return GestureDetector(
                      onTap: () {
                        //Navigator.of(context).push(MaterialPageRoute(builder: (context)
                        //  => SelectTrainingSessionPage(sessionIndex: index)));
                        _sessionService.openSession(context, index);
                        Navigator.of(context)
                            .pushNamed('/select_training_session');
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
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15.0))),
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
                              Column(children: [
                                Text("Day #${index + 1}",
                                    style: GoogleFonts.montserrat(
                                        fontSize: 35,
                                        fontWeight: FontWeight.w800,
                                        height: 1))
                              ])
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
