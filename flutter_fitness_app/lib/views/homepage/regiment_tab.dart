import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/models/base/training_regiment.dart';
import 'package:flutter_fitness_app/models/base/training_types.dart';
import 'package:flutter_fitness_app/models/base/user.dart';
import 'package:flutter_fitness_app/services/regiment_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RegimentTab extends StatefulWidget {
  const RegimentTab({super.key});

  @override
  State<RegimentTab> createState() => _RegimentTabState();
}

Widget _addRegimentButton(BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.of(context).pushNamed('/set_name');
    },
    child: Container(
      padding: const EdgeInsets.all(30),
      width: double.infinity,
      decoration: const BoxDecoration(color: Color.fromARGB(31, 180, 180, 180)),
      child: Wrap(alignment: WrapAlignment.center, children: [
        const FaIcon(FontAwesomeIcons.plus),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            'Add new regiment'.toUpperCase(),
            style:
                GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        )
      ]),
    ),
  );
}

class _RegimentTabState extends State<RegimentTab> {
  List<TrainingRegiment>? regiments;
  final RegimentService _regimentService = RegimentService();
  @override
  void initState() {
    super.initState();
  }

  Widget _regimentPreview(BuildContext context, TrainingRegiment regiment) {
    String imageSrc = "";
    if (regiment.trainingType is WeightTraining) {
      imageSrc = "assets/weight-plates.png";
    }
    String cardText = "";
    if (regiment.startDate == null) {
      cardText = "Not started";
    } else if (regiment.dayOfPause == -1) {
      cardText =
          "Day ${regiment.getCurrentDay() + 1} of ${regiment.cycleDurationInDays}";
    } else if (regiment.dayOfPause != -1) {
      cardText =
          "Paused on day ${regiment.dayOfPause + 1} of ${regiment.cycleDurationInDays}";
    }
    return GestureDetector(
      onTap: () {
        _regimentService.openRegiment(context, regiment);
        Navigator.of(context)
            .pushNamed("/set_regiment_calendar")
            .then((value) => setState(
                  () {},
                ));
      },
      onLongPress: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Column(children: [
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _regimentService.openRegiment(context, regiment);
                        _regimentService.startRegiment(context);
                      });
                    },
                    child: const Text("Start")),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _regimentService.openRegiment(context, regiment);
                        _regimentService.pauseRegiment(context);
                      });
                    },
                    child: const Text("Pause")),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _regimentService.openRegiment(context, regiment);
                        _regimentService.resumeRegiment(context);
                      });
                    },
                    child: const Text("Resume")),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _regimentService.openRegiment(context, regiment);
                        _regimentService.stopRegiment(context);
                      });
                    },
                    child: const Text("Stop")),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _regimentService.openRegiment(context, regiment);
                        _regimentService.removeRegiment(context);
                      });
                    },
                    child: const Text("Delete"))
              ]),
            );
          },
        );
      },
      child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      width: 0.5, color: Color.fromRGBO(0, 0, 0, .1)))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: LinearProgressIndicator(
                    backgroundColor: Colors.white,
                    value: (regiment.getCurrentDay() + 1) /
                        regiment.cycleDurationInDays!),
              ),
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            regiment.name!,
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w800, fontSize: 25),
                          ),
                          Text(cardText,
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w500))
                        ]),
                  ),
                  Container(
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
                              height: 140,
                            ),
                          ),
                        ),
                      )
                    ]),
                  ),
                ],
              ),
            ],
          )),
      // child: Card(
      //   child: Column(mainAxisSize: MainAxisSize.max, children: [
      //     ListTile(
      //       leading: FaIcon(regiment.trainingType!.getIconData()),
      //       title: Text(regiment.name!),
      //       subtitle: Text(cardText),
      //     ),
      //     LinearProgressIndicator(
      //       value:
      //           (regiment.getCurrentDay() + 1) / regiment.cycleDurationInDays!,
      //     )
      //   ]),
      // ),
    );
  }

  @override
  Widget build(BuildContext context) {
    regiments = Provider.of<AppUser>(context).regiments;
    return SafeArea(
      child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              _addRegimentButton(context),
              Container(
                  child: Expanded(
                child: ListView.builder(
                    itemCount: regiments!.length,
                    itemBuilder: (BuildContext context, int index) {
                      var regiment = regiments![index];
                      return _regimentPreview(context, regiment);
                    }),
              ))
            ],
          )),
    );
  }
}
