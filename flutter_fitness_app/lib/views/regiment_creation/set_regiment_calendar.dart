import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/models/base/training_regiment.dart';
import 'package:flutter_fitness_app/models/base/training_session.dart';
import 'package:flutter_fitness_app/repos/current_training_regiment.dart';
import 'package:flutter_fitness_app/services/regiment_service.dart';
import 'package:flutter_fitness_app/services/session_service.dart';
import 'package:flutter_fitness_app/views/misc/default_text_field.dart';
import 'package:flutter_fitness_app/views/misc/string_cutter.dart';
import 'package:flutter_fitness_app/views/regiment_creation/common_widgets/app_bar.dart';
import 'package:flutter_fitness_app/views/regiment_creation/common_widgets/tag_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SetRegimentCalendarPage extends StatefulWidget {
  const SetRegimentCalendarPage({super.key});

  @override
  State<SetRegimentCalendarPage> createState() =>
      _SetRegimentCalendarPageState();
}

Widget _tagWidget(String text, Color backgroundColor) {
  return Container(
      margin: const EdgeInsets.only(top: 5),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(5))),
      child: Text(text.toUpperCase(),
          style: GoogleFonts.montserrat(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: Color(0xffffffff),
              height: 1)));
}

class _SetRegimentCalendarPageState extends State<SetRegimentCalendarPage> {
  final SessionService _sessionService = SessionService();
  final RegimentService _regimentService = RegimentService();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  Widget _infoBox(BuildContext context, TrainingRegiment regiment) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          border: Border(
              bottom:
                  BorderSide(width: 0.5, color: Color.fromRGBO(0, 0, 0, .1)))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 10),
              width: MediaQuery.of(context).size.width - 40 - 30,
              child: Text(
                regiment.name!,
                style: GoogleFonts.montserrat(
                    height: 1, fontWeight: FontWeight.w800, fontSize: 25),
              ),
            ),
            GestureDetector(
              onTap: () {
                _nameController.text = regiment.name!;
                _notesController.text =
                    regiment.notes == null ? "" : regiment.notes!;
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        clipBehavior: Clip.hardEdge,
                        title: Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 0.5,
                                        color: Color.fromRGBO(0, 0, 0, .1)))),
                            child: Text(
                              "Edit regiment",
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w700),
                            )),
                        titlePadding: EdgeInsets.zero,
                        surfaceTintColor: Colors.transparent,
                        backgroundColor: Colors.white,
                        contentPadding: EdgeInsets.zero,
                        actionsPadding:
                            EdgeInsets.only(right: 10, top: 5, bottom: 5),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(0))),
                        content: SingleChildScrollView(
                          child: Column(children: [
                            defaultTextField(
                                controller: _nameController,
                                placeholder: "Name"),
                            defaultTextField(
                                controller: _notesController,
                                placeholder: "Notes",
                                isMultiline: true),
                          ]),
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                _regimentService.setName(
                                    context, _nameController.text);
                                _regimentService.setNotes(
                                    context, _notesController.text);
                                setState(() {});
                                Navigator.of(context).pop();
                              },
                              child: Text("OK")),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("Cancel"))
                        ],
                      );
                    });
              },
              child: FaIcon(
                FontAwesomeIcons.pen,
                size: 16,
              ),
            )
          ],
        ),
        Container(
          width: MediaQuery.of(context).size.width - 40 - 30,
          child: regiment.notes == null || regiment.notes == ""
              ? Text(
                  "No notes",
                  style:
                      GoogleFonts.roboto(fontSize: 14, color: Colors.black26),
                )
              : Text(regiment.notes!, style: GoogleFonts.roboto(fontSize: 14)),
        )
      ]),
    );
  }

  Widget _sessionWidget(BuildContext context, TrainingSession session,
      SessionService sessionService) {
    var categories = session.getGeneralCategories();
    return GestureDetector(
      onTap: () {
        sessionService.openSessionByInstance(context, session);
        Navigator.of(context)
            .pushNamed('/select_training_session')
            .then((value) => setState(
                  () {},
                ));
      },
      child: Column(
        children: [
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  bottom: BorderSide(
                      width: 0.5, color: Color.fromRGBO(0, 0, 0, .1))),
            ),
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(20),
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (session.exercises.isEmpty) {
                  return Text("Rest day",
                      style: GoogleFonts.montserrat(
                          fontSize: 25,
                          fontWeight: FontWeight.w800,
                          height: 1,
                          color: Colors.black));
                }
                return Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width - 40,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                StringCutter.cut(
                                    "#${session.dayInSchedule + 1}. ${session.name == "" ? "No name" : session.name}",
                                    18),
                                style: GoogleFonts.montserrat(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w800,
                                    height: 1)),
                            Wrap(
                              spacing: 5,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                _tagWidget(
                                    "${session.exercises.length} exercises",
                                    Colors.black),
                                _tagWidget(session.getGeneralMetricText(),
                                    Theme.of(context).primaryColor)
                              ],
                            ),
                            SizedBox(height: 5),
                            Wrap(
                              spacing: 5,
                              children: [
                                Wrap(
                                    spacing: 5,
                                    children: List.generate(
                                        categories.length > 3
                                            ? 3
                                            : categories.length, (index) {
                                      return tagWidget(
                                          categories[index], Colors.black);
                                    })),
                                categories.length > 3
                                    ? tagWidget(
                                        "...", Theme.of(context).primaryColor)
                                    : SizedBox()
                              ],
                              // children: [
                              //   categories.isNotEmpty
                              //       ? tagWidget(categories[0], Colors.black,
                              //           textColor: Colors.white)
                              //       : const SizedBox(
                              //           height: 0,
                              //           width: 0,
                              //         ),
                              //   categories.length > 1
                              //       ? tagWidget(categories[1], Colors.black12,
                              //           textColor: Colors.black)
                              //       : const SizedBox(
                              //           height: 0,
                              //           width: 0,
                              //         ),
                              //   categories.length > 2
                              //       ? tagWidget(categories[2], Colors.black12,
                              //           textColor: Colors.black)
                              //       : const SizedBox(
                              //           height: 0,
                              //           width: 0,
                              //         ),
                              //   categories.length > 3
                              //       ? tagWidget("...", Colors.black12,
                              //           textColor: Colors.black)
                              //       : const SizedBox(
                              //           height: 0,
                              //           width: 0,
                              //         ),
                              //],
                            ),
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
                            translation: const Offset(0.4, -0.2),
                            child: Opacity(
                              opacity: .35,
                              child: Image.asset(
                                'assets/time.png',
                                height: 140,
                              ),
                            ),
                          ),
                        )
                      ]),
                    ),
                  ],
                );
              },
            ),
          ),
          // session.exercises.isEmpty
          //     ? SizedBox()
          //     : Container(
          //         padding: EdgeInsets.all(10),
          //         width: MediaQuery.of(context).size.width,
          //         decoration: BoxDecoration(
          //           color: Colors.white,
          //           border: Border(
          //               bottom: BorderSide(
          //                   width: 0.5, color: Color.fromRGBO(0, 0, 0, .1))),
          //         ),
          //         child: Wrap(
          //           spacing: 5,
          //           children: [
          //             categories.isNotEmpty
          //                 ? tagWidget(categories[0], Colors.black12,
          //                     textColor: Colors.black)
          //                 : const SizedBox(
          //                     height: 0,
          //                     width: 0,
          //                   ),
          //             categories.length > 1
          //                 ? tagWidget(categories[1], Colors.black12,
          //                     textColor: Colors.black)
          //                 : const SizedBox(
          //                     height: 0,
          //                     width: 0,
          //                   ),
          //             categories.length > 2
          //                 ? tagWidget(categories[2], Colors.black12,
          //                     textColor: Colors.black)
          //                 : const SizedBox(
          //                     height: 0,
          //                     width: 0,
          //                   ),
          //             categories.length > 3
          //                 ? tagWidget("...", Colors.black12,
          //                     textColor: Colors.black)
          //                 : const SizedBox(
          //                     height: 0,
          //                     width: 0,
          //                   ),
          //           ],
          //         ),
          //       )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: defaultAppBar(
            context,
            Provider.of<CurrentTrainingRegiment>(context).regiment!.name!,
            Provider.of<CurrentTrainingRegiment>(context)
                .regiment!
                .trainingType
                .toString()),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _infoBox(context,
                  Provider.of<CurrentTrainingRegiment>(context).regiment!),
              Container(
                // padding:
                //     const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                child: Column(
                  children: Provider.of<CurrentTrainingRegiment>(context)
                              .regiment!
                              .cycleDurationInDays ==
                          null
                      ? [SizedBox()]
                      : List.generate(
                          Provider.of<CurrentTrainingRegiment>(context)
                              .regiment!
                              .cycleDurationInDays!, (index) {
                          var session =
                              Provider.of<CurrentTrainingRegiment>(context)
                                  .regiment!
                                  .schedule![index];
                          return _sessionWidget(
                              context, session, _sessionService);
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
