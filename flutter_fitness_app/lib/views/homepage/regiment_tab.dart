import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/models/base/training_regiment.dart';
import 'package:flutter_fitness_app/models/base/training_types.dart';
import 'package:flutter_fitness_app/models/base/user.dart';
import 'package:flutter_fitness_app/services/regiment_service.dart';
import 'package:flutter_fitness_app/views/misc/regiment_preview.dart';
import 'package:flutter_fitness_app/views/misc/route_base_button.dart';
import 'package:flutter_fitness_app/views/regiment_creation/common_widgets/tag_widget.dart';
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
    var controlPanelOpacity = 0.0;
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
        controlPanelOpacity = 1.0;
        setState(() {
          controlPanelOpacity = 1.0;
        });
        // showDialog(
        //   context: context,
        //   builder: (context) {
        //     return Dialog(
        //       child: Row(children: [
        //         regiment.startDate != null
        //             ? SizedBox()
        //             : ElevatedButton(
        //                 onPressed: () {
        //                   setState(() {
        //                     _regimentService.openRegiment(context, regiment);
        //                     _regimentService.startRegiment(context);
        //                   });
        //                   Navigator.of(context).pop();
        //                 },
        //                 child: const Text("Start")),
        //         regiment.isPaused()
        //             ? SizedBox()
        //             : ElevatedButton(
        //                 onPressed: () {
        //                   setState(() {
        //                     _regimentService.openRegiment(context, regiment);
        //                     _regimentService.pauseRegiment(context);
        //                   });
        //                   Navigator.of(context).pop();
        //                 },
        //                 child: const Text("Pause")),
        //         !regiment.isPaused()
        //             ? SizedBox()
        //             : ElevatedButton(
        //                 onPressed: () {
        //                   setState(() {
        //                     _regimentService.openRegiment(context, regiment);
        //                     _regimentService.resumeRegiment(context);
        //                   });
        //                   Navigator.of(context).pop();
        //                 },
        //                 child: const Text("Resume")),
        //         regiment.startDate == null
        //             ? SizedBox()
        //             : ElevatedButton(
        //                 onPressed: () {
        //                   setState(() {
        //                     _regimentService.openRegiment(context, regiment);
        //                     _regimentService.stopRegiment(context);
        //                   });
        //                   Navigator.of(context).pop();
        //                 },
        //                 child: const Text("Stop")),
        //         ElevatedButton(
        //             onPressed: () {
        //               setState(() {
        //                 _regimentService.openRegiment(context, regiment);
        //                 _regimentService.removeRegiment(context);
        //               });
        //               Navigator.of(context).pop();
        //             },
        //             child: const Text("Delete"))
        //       ]),
        //     );
        //   },
        // );
      },
      child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      width: 0.5, color: Color.fromRGBO(0, 0, 0, .1)))),
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                height: 150,
                child: Container(
                  width: MediaQuery.of(context).size.width *
                      (regiment.getCurrentDay() + 1) /
                      regiment.cycleDurationInDays!,
                  color: Color.fromRGBO(0, 0, 0, .05),
                ),
              ),
              Positioned(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
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
                                      fontWeight: FontWeight.w800,
                                      fontSize: 25),
                                ),
                                Wrap(
                                  spacing: 5,
                                  children: [
                                    tagWidget(cardText, Colors.black),
                                    regiment.getMainStatistic() == null
                                        ? const SizedBox()
                                        : tagWidget(
                                            regiment.getMainStatistic()!,
                                            Theme.of(context).primaryColor,
                                            textColor: Colors.white),
                                  ],
                                )
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
                ),
              ),
              Positioned(
                  left: 0,
                  top: 0,
                  child: AnimatedOpacity(
                    opacity: controlPanelOpacity,
                    duration: const Duration(milliseconds: 200),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 150,
                      color: Colors.black87,
                      child: Row(children: [
                        regiment.startDate != null
                            ? SizedBox()
                            : ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _regimentService.openRegiment(
                                        context, regiment);
                                    _regimentService.startRegiment(context);
                                  });
                                  Navigator.of(context).pop();
                                },
                                child: const Text("Start")),
                        regiment.isPaused()
                            ? SizedBox()
                            : ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _regimentService.openRegiment(
                                        context, regiment);
                                    _regimentService.pauseRegiment(context);
                                  });
                                  Navigator.of(context).pop();
                                },
                                child: const Text("Pause")),
                        !regiment.isPaused()
                            ? SizedBox()
                            : ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _regimentService.openRegiment(
                                        context, regiment);
                                    _regimentService.resumeRegiment(context);
                                  });
                                  Navigator.of(context).pop();
                                },
                                child: const Text("Resume")),
                        regiment.startDate == null
                            ? SizedBox()
                            : ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _regimentService.openRegiment(
                                        context, regiment);
                                    _regimentService.stopRegiment(context);
                                  });
                                  Navigator.of(context).pop();
                                },
                                child: const Text("Stop")),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _regimentService.openRegiment(
                                    context, regiment);
                                _regimentService.removeRegiment(context);
                              });
                              Navigator.of(context).pop();
                            },
                            child: const Text("Delete"))
                      ]),
                    ),
                  )),
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
              routeBaseButton(context, '/set_name', FontAwesomeIcons.plus,
                  "Add new regiment"),
              Container(
                  child: Expanded(
                child: ListView.builder(
                    itemCount: regiments!.length,
                    itemBuilder: (BuildContext context, int index) {
                      var regiment = regiments![index];
                      //return _regimentPreview(context, regiment);
                      return RegimentPreview(regiment: regiment);
                    }),
              ))
            ],
          )),
    );
  }
}
