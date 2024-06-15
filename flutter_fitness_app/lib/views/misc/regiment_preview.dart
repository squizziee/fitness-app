import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/models/base/training_regiment.dart';
import 'package:flutter_fitness_app/models/base/training_types.dart';
import 'package:flutter_fitness_app/services/regiment_service.dart';
import 'package:flutter_fitness_app/views/misc/string_cutter.dart';
import 'package:flutter_fitness_app/views/regiment_creation/common_widgets/tag_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class RegimentPreview extends StatefulWidget {
  final TrainingRegiment? regiment;
  const RegimentPreview({super.key, this.regiment});

  @override
  State<RegimentPreview> createState() => _RegimentPreviewState();
}

class _RegimentPreviewState extends State<RegimentPreview> {
  final RegimentService _regimentService = RegimentService();
  var controlPanelVisible = false;
  String imageSrc = "";

  Widget _controlPanelOption(
      {BuildContext? context = null,
      IconData? icon = null,
      Color iconColor = Colors.black,
      Color color = Colors.white,
      bool isVisible = false,
      VoidCallback? callback = null}) {
    return isVisible
        ? GestureDetector(
            onTap: callback,
            child: Container(
                width: 55,
                height: 55,
                margin: EdgeInsets.only(right: 10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: color,
                    border: Border.all(
                        width: 0.5,
                        color: color == Colors.white
                            ? Color.fromRGBO(0, 0, 0, .1)
                            : Colors.transparent),
                    // boxShadow: [
                    //   BoxShadow(
                    //       color: Color.fromRGBO(0, 0, 0, .04),
                    //       spreadRadius: 10,
                    //       blurRadius: 10)
                    // ],
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                child: FaIcon(
                  icon,
                  size: 20,
                  color: iconColor,
                )))
        : SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    String imageSrc = "";
    if (widget.regiment!.trainingType is WeightTraining) {
      imageSrc = "assets/weight-plates.png";
    }
    String cardText = "";
    if (widget.regiment!.startDate == null) {
      cardText = "Not started";
    } else if (widget.regiment!.dayOfPause == -1) {
      cardText =
          "Day ${widget.regiment!.getCurrentDay() + 1} of ${widget.regiment!.cycleDurationInDays}";
    } else if (widget.regiment!.dayOfPause != -1) {
      cardText =
          "Paused on day ${widget.regiment!.dayOfPause + 1} of ${widget.regiment!.cycleDurationInDays}";
    }
    return GestureDetector(
      onTap: () {
        _regimentService.openRegiment(context, widget.regiment!);
        Navigator.of(context)
            .pushNamed("/set_regiment_calendar")
            .then((value) => setState(
                  () {},
                ));
      },
      onLongPress: () {
        controlPanelVisible = true;
        setState(() {
          controlPanelVisible = true;
        });
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
                      (widget.regiment!.getCurrentDay() + 1) /
                      widget.regiment!.cycleDurationInDays!,
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
                                  StringCutter.cut(widget.regiment!.name!, 18),
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 25),
                                ),
                                Wrap(
                                  spacing: 5,
                                  children: [
                                    tagWidget(cardText, Colors.black),
                                    widget.regiment!.getMainStatistic() == null
                                        ? const SizedBox()
                                        : tagWidget(
                                            widget.regiment!
                                                .getMainStatistic()!,
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
                  child: IgnorePointer(
                    ignoring: !controlPanelVisible,
                    child: AnimatedOpacity(
                      opacity: controlPanelVisible ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 200),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 95,
                        padding: EdgeInsets.all(15),
                        //color: Colors.white,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.center,
                            end: Alignment.centerRight,
                            colors: [
                              Colors.white,
                              Colors.white.withOpacity(0),
                            ],
                          ),
                        ),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Wrap(
                                children: [
                                  _controlPanelOption(
                                      context: context,
                                      icon: FontAwesomeIcons.play,
                                      isVisible:
                                          widget.regiment!.startDate == null,
                                      callback: () {
                                        setState(() {
                                          _regimentService.openRegiment(
                                              context, widget.regiment!);
                                          _regimentService
                                              .startRegiment(context);
                                        });
                                      }),
                                  _controlPanelOption(
                                      context: context,
                                      icon: FontAwesomeIcons.pause,
                                      isVisible: !widget.regiment!.isPaused() &&
                                          widget.regiment!.startDate != null,
                                      callback: () {
                                        setState(() {
                                          _regimentService.openRegiment(
                                              context, widget.regiment!);
                                          _regimentService
                                              .pauseRegiment(context);
                                        });
                                      }),
                                  _controlPanelOption(
                                      context: context,
                                      icon: FontAwesomeIcons.play,
                                      isVisible: widget.regiment!.isPaused(),
                                      callback: () {
                                        setState(() {
                                          _regimentService.openRegiment(
                                              context, widget.regiment!);
                                          _regimentService
                                              .resumeRegiment(context);
                                        });
                                      }),
                                  _controlPanelOption(
                                      context: context,
                                      icon: FontAwesomeIcons.stop,
                                      isVisible:
                                          widget.regiment!.startDate != null,
                                      callback: () {
                                        setState(() {
                                          _regimentService.openRegiment(
                                              context, widget.regiment!);
                                          _regimentService
                                              .stopRegiment(context);
                                        });
                                      }),
                                  _controlPanelOption(
                                      context: context,
                                      icon: FontAwesomeIcons.trash,
                                      color: Colors.redAccent,
                                      iconColor: Colors.white,
                                      isVisible: true,
                                      callback: () {
                                        setState(() {
                                          _regimentService.openRegiment(
                                              context, widget.regiment!);
                                          _regimentService
                                              .removeRegiment(context);
                                          Navigator.of(context)
                                              .pushReplacementNamed("/home");
                                        });
                                      }),
                                ],
                              ),
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      controlPanelVisible = false;
                                    });
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(left: 15),
                                    child: FaIcon(
                                      FontAwesomeIcons.xmark,
                                      color: Color.fromRGBO(0, 0, 0, .3),
                                    ),
                                  ))
                            ]),
                      ),
                    ),
                  )),
            ],
          )),
    );
  }
}
